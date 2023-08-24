import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final String name;
  final String bmiInfo;
  final String bmiClassification;

  const ResultPage({
    required this.name,
    required this.bmiInfo,
    required this.bmiClassification,
  });

  String getDicas() {
    if (bmiClassification.contains('Baixo peso Grau III')) {
      return 'Dicas para melhorar sua saúde:\n\n'
          '1. Procure um médico para avaliar sua situação.\n'
          '2. Mantenha uma dieta balanceada e rica em nutrientes.\n'
          '3. Busque orientação profissional para ganho de peso saudável.';
    } else if (bmiClassification.contains('Baixo peso Grau II')) {
      return 'Dicas para melhorar sua saúde:\n\n'
          '1. Consulte um profissional de saúde para avaliar sua situação.\n'
          '2. Busque uma alimentação mais calórica e nutritiva.\n'
          '3. Considere praticar atividades físicas para fortalecer seus músculos.';
    } else if (bmiClassification.contains('Baixo peso Grau I')) {
      return 'Dicas para melhorar sua saúde:\n\n'
          '1. Mantenha uma dieta balanceada e variada.\n'
          '2. Pratique exercícios para melhorar sua resistência física.\n'
          '3. Consulte um profissional para monitorar seu ganho de peso.';
    } else if (bmiClassification.contains('Magreza')) {
      return 'Dicas para melhorar sua saúde:\n\n'
          '1. Busque uma dieta equilibrada com alimentos nutritivos.\n'
          '2. Pratique atividades físicas para ganhar força e energia.\n'
          '3. Consulte um médico ou nutricionista para orientações.';
    } else if (bmiClassification.contains('Peso Ideal')) {
      return 'Parabéns pela sua saúde!\n\n'
          'Continue mantendo hábitos saudáveis para preservar seu bem-estar.';
    } else if (bmiClassification.contains('Sobrepeso')) {
      return 'Dicas para melhorar sua saúde:\n\n'
          '1. Equilibre a ingestão de calorias.\n'
          '2. Aumente a atividade física.\n'
          '3. Evite excesso de alimentos ricos em açúcares e gorduras.';
    } else if (bmiClassification.contains('Obesidade Grau I')) {
      return 'Dicas para melhorar sua saúde:\n\n'
          '1. Adote uma alimentação saudável e controlada.\n'
          '2. Pratique exercícios físicos regularmente.\n'
          '3. Consulte um profissional de saúde para orientações.';
    } else if (bmiClassification.contains('Obesidade Grau II')) {
      return 'Dicas para melhorar sua saúde:\n\n'
          '1. Procure orientação médica para avaliar riscos.\n'
          '2. Estabeleça metas de perda de peso com profissionais.\n'
          '3. Mantenha uma rotina de alimentação e exercícios.';
    } else if (bmiClassification.contains('Obesidade Grau III')) {
      return 'Dicas para melhorar sua saúde:\n\n'
          '1. Busque apoio médico para cuidados intensivos.\n'
          '2. Considere tratamentos multidisciplinares.\n'
          '3. Adote hábitos saudáveis de forma gradual e segura.';
    }
    return 'Dicas para melhorar sua saúde:\n\n'
        'Consulte um profissional de saúde para orientações específicas.';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nome: $name', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text('Informações Adicionais', style: const TextStyle(fontSize: 14)),
                Text(bmiInfo, style: const TextStyle(fontSize: 14)),
                Text('Classificação:', style: const TextStyle(fontSize: 14)),
                Text(bmiClassification, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(
                  getDicas(),
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
