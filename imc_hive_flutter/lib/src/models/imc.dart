import 'package:imc_calculator/src/models/abstractImc.dart';

class Imc extends AbstractImc {
  int height;
  int weight;
  int id;
  String name;

  Imc({required this.height, required this.weight, required this.id, required this.name});

  @override
  double calculateImc() {
    double heightInMeters = this.height / 100;
    double calc = this.weight / (heightInMeters * heightInMeters);
    return calc;
  }
  
  @override
  String bmiClasifier() {
    double calc = calculateImc();
    if (calc < 16) {
      return 'Baixo peso Grau III';
    } else if (calc >= 16 && calc <= 16.99) {
      return 'Baixo peso Grau II';
    } else if (calc >= 17 && calc <= 18.49) {
      return 'Baixo peso Grau I';
    } else if (calc >= 18.5 && calc <= 24.99) {
      return 'Peso Ideal';
    } else if (calc >= 25 && calc <= 29.99) {
      return 'Sobrepeso';
    } else if (calc >= 30 && calc <= 34.99) {
      return 'Obesidade Grau I';
    } else if (calc >= 35 && calc <= 39.99) {
      return 'Obesidade Grau II';
    } else if (calc >= 40) {
      return 'Obesidade Grau III';
    }
    return 'Obesidade Grau III';
  }

  factory Imc.fromMap(Map<String, dynamic> map) {
    return Imc(
      id: map['id'],
      height: map['height'],
      weight: map['weight'],
      name: map['name'],
      
    );
  }
}
