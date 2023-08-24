import 'package:flutter/material.dart';
import 'package:imc_calculator/src/database/connection.dart';
import '../components/modal_botton_sheet_custom.dart';
import '../models/imc.dart';

class HistoriPage extends StatefulWidget {
  const HistoriPage({Key? key}) : super(key: key);

  @override
  State<HistoriPage> createState() => _HistoriPageState();
}

class _HistoriPageState extends State<HistoriPage> {
  List<Imc> imcs = [];

  Future<void> init() async {
    await Connection.init();
    setState(() {
      imcs = Connection.imcBox.values.toList();
    });
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    Connection.closeBox();
    super.dispose();
  }

  Color getCircleColor(double calculatedImc) {
    if (calculatedImc < 18.5) {
      return Colors.blue; 
    } else if (calculatedImc < 25) {
      return Colors.green; 
    } else if (calculatedImc < 30) {
      return Colors.orange; 
    } else {
      return Colors.red; 
    }
  }

  void _showDicasBottomSheet(
      BuildContext context, double calculatedImc, String bmiClassification) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return DicasBottomSheet(
            calculatedImc: calculatedImc, bmiClassification: bmiClassification);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HISTÓRICO DE IMCS'),
      ),
      body: imcs.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: imcs.length,
              itemBuilder: (context, index) {
                final imc = imcs[index];
                final double calculatedImc = imc.calculateImc();
                final String bmiClassification = imc.bmiClasifier();
                final Color circleColor = getCircleColor(calculatedImc);

                return GestureDetector(
                  onTap: () {
                    _showDicasBottomSheet(
                        context, calculatedImc, bmiClassification);
                  },
                  child: Container(
                    margin: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.grey[200], 
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[400]!,
                          offset: const Offset(4, 4),
                          blurRadius: 10,
                        ),
                        const BoxShadow(
                          color: Colors.white,
                          offset: Offset(-4, -4),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Flexible(
                          flex: 3,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Nome: ${imc.name}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    const Spacer(),
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: circleColor,
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: circleColor.withOpacity(0.5),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Text(
                                          calculatedImc.toStringAsFixed(1),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  'Altura: ${imc.height.toString()} cm',
                                  style: const TextStyle(fontSize: 14),
                                ),
                                Text(
                                  'Peso: ${imc.weight.toString()} kg',
                                  style: const TextStyle(fontSize: 14),
                                ),
                                Text(
                                  'IMC: ${calculatedImc.toStringAsFixed(2)}',
                                  style: const TextStyle(fontSize: 14),
                                ),
                                const Text(
                                  'Classificação:',
                                  style: TextStyle(fontSize: 14),
                                ),
                                Text(
                                  bmiClassification,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
