// lib/models/bus.dart
class Bus {
  final int codBus;
  final String placa;
  final String? color;
  final String? brandin;
  final int? nroPasajero;
  final String? motor;
  final int? llantas;
  final bool? gps;
  final bool? gasolina;
  final bool? gas;
  final String? estadoFisico;
  final String? categoria;
  final String? fotoUrl;
  final String? qrCodigo;
  final String? codBarraCodigo;
  final bool? estadoRegistro;

  Bus({
    required this.codBus,
    required this.placa,
    this.color,
    this.brandin,
    this.nroPasajero,
    this.motor,
    this.llantas,
    this.gps,
    this.gasolina,
    this.gas,
    this.estadoFisico,
    this.categoria,
    this.fotoUrl,
    this.qrCodigo,
    this.codBarraCodigo,
    this.estadoRegistro,
  });

  factory Bus.fromJson(Map<String, dynamic> json) {
    // El backend devuelve los campos tal como están en BusDto (camelCase)
    return Bus(
      codBus: json['codBus'] ?? 0,
      placa: json['placa'] ?? '',
      color: json['color'],
      brandin: json['brandin'],
      nroPasajero: json['nroPasajero'],
      motor: json['motor'],
      llantas: json['llantas'],
      gps: json['gps'],
      gasolina: json['gasolina'],
      gas: json['gas'],
      estadoFisico: json['estadoFisico'],
      categoria: json['categoria'],
      fotoUrl: json['fotoUrl'],
      qrCodigo: json['qrCodigo'],
      codBarraCodigo: json['codBarraCodigo'],
      estadoRegistro: json['estadoRegistro'],
    );
  }
}
