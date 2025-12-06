import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../services/arrival_service.dart';

class QrScanScreen extends StatefulWidget {
  const QrScanScreen({super.key});

  @override
  State<QrScanScreen> createState() => _QrScanScreenState();
}

class _QrScanScreenState extends State<QrScanScreen> {
  bool _isProcessing = false;
  String? _lastScanned; // para evitar múltiples lecturas seguidas

  final MobileScannerController _controller = MobileScannerController(
    formats: [BarcodeFormat.qrCode],
    facing: CameraFacing.back,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleBarcode(BarcodeCapture capture) async {
    if (_isProcessing) return;

    final barcode = capture.barcodes.firstOrNull;
    if (barcode == null) return;

    final String? rawValue = barcode.rawValue;
    if (rawValue == null || rawValue.isEmpty) return;

    // Evitar que el mismo QR dispare varias veces seguido
    if (_lastScanned == rawValue) return;

    setState(() {
      _isProcessing = true;
      _lastScanned = rawValue;
    });

    try {
      // 1) Llamar al backend para registrar llegada
      final message = await ArrivalService.registerArrival(rawValue);

      if (!mounted) return;

      // 2) Mostrar diálogo de éxito
      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Llegada registrada'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(message),
              const SizedBox(height: 8),
              Text(
                'Dato QR:\n$rawValue',
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Aceptar'),
            ),
          ],
        ),
      );

      // Puedes volver atrás después de registrar, si quieres:
      // Navigator.of(context).pop();

    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al registrar llegada: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escanear QR - Llegada'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                MobileScanner(
                  controller: _controller,
                  onDetect: _handleBarcode,
                ),
                // Overlay para “enmarcar” el QR
                Center(
                  child: Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.white,
                        width: 3,
                      ),
                    ),
                  ),
                ),
                if (_isProcessing)
                  Container(
                    color: Colors.black45,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Instrucciones:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text('1. Apunta la cámara al código QR del bus.'),
                  Text(
                      '2. Cuando se lea el QR, se registrará la llegada con la fecha y hora actual.'),
                  SizedBox(height: 16),
                  Text(
                    'Uso recomendado para choferes o inspectores.',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
