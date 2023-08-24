import 'dart:math';
import 'package:flutter/material.dart';
import 'package:imc_calculator/src/models/imc.dart';
import 'package:imc_calculator/src/pages/history.dart';
import '../components/modal_botton_sheet_custom.dart';
import '../database/connection.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IMC Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeImcPage(),
    );
  }
}

class HomeImcPage extends StatefulWidget {
  const HomeImcPage({Key? key}) : super(key: key);

  @override
  _HomeImcPageState createState() => _HomeImcPageState();
}

class _HomeImcPageState extends State<HomeImcPage> {
  ValueNotifier<String> displayImc =
      ValueNotifier<String>('Informe seus dados');
  int height = 160;
  int weight = 70;
  String name = '';

  bool checkValues() {
    return height != 0 && weight != 0 && name.isNotEmpty;
  }

  Future<void> addImcToHistory(Imc imc) async {
    await Connection.addImc(imc);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IMC CALCULATOR'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              width: double.maxFinite,
              height: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey[200],
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
              alignment: Alignment.center,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Calcular IMC',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Informe seus dados abaixo:',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  labelText: 'Nome',
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    weight = int.tryParse(value) ?? 0;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  labelText: 'Peso',
                  suffix: Text('KG',),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                      child: Text(
                        'Altura: ${height / 100} metros',
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),
                      )),
                  SliderTheme(
                    data: SliderThemeData(
                      trackHeight: 4.0,
                      activeTrackColor: Colors.blue,
                      inactiveTrackColor: Colors.grey,
                      thumbColor: Colors.blue,
                      overlayColor: Colors.blue.withAlpha(50),
                      thumbShape:
                          RoundSliderThumbShape(enabledThumbRadius: 10.0),
                      overlayShape:
                          RoundSliderOverlayShape(overlayRadius: 20.0),
                    ),
                    child: Slider(
                      value: height.toDouble(),
                      min: 30,
                      max: 300,
                      onChanged: (newValue) {
                        setState(() {
                          height = newValue.toInt();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (checkValues()) {
                  Imc imc = Imc(
                    height: height,
                    weight: weight,
                    id: Random().nextInt(999999),
                    name: name,
                  );

                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return DicasBottomSheet(
                        calculatedImc: imc.calculateImc(),
                        bmiClassification: imc.bmiClasifier(),
                      );
                    },
                  );

                  addImcToHistory(imc);
                }
              },
              style: ElevatedButton.styleFrom(
                shadowColor: Colors.grey[200],
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Calcular', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
