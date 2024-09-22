import 'package:flutter/material.dart';
import 'color_codes.dart';
import 'package:flutter/services.dart'; // Necesario para SystemChrome

void main() {
  runApp(const ResistanceCalculatorApp());
}

class ResistanceCalculatorApp extends StatelessWidget {
  const ResistanceCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Cambiar el color de la barra de estado
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.redAccent, // Color para la barra de estado
      statusBarIconBrightness: Brightness.light, // Color de los iconos
    ));

    return MaterialApp(
      title: 'Resistencia por Código de Colores',
      theme: ThemeData(
        primarySwatch: Colors.yellow, // Estilo amarillo
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.yellow,
        ).copyWith(
          secondary: Colors.red, // Color secundario rojo
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.redAccent, // Color de la AppBar
          foregroundColor: Colors.white, // Color del texto e iconos de la AppBar
        ),

      ),
      home: const ResistanceCalculatorPage(),
    );
  }
}

class ResistanceCalculatorPage extends StatefulWidget {
  const ResistanceCalculatorPage({super.key});

  @override
  State<ResistanceCalculatorPage> createState() =>
      _ResistanceCalculatorPageState();
}

class _ResistanceCalculatorPageState extends State<ResistanceCalculatorPage> {
  // Número de bandas de la resistencia (por defecto 4)
  int _numberOfBands = 4;

  // Dropdown seleccionados
  ColorCode? _band1;
  ColorCode? _band2;
  ColorCode? _band3; // Solo para 5 y 6 bandas
  ColorCode? _multiplier;
  ColorCode? _tolerance;
  ColorCode? _tcr; // Sólo para la banda 6

  // Método para calcular el valor de la resistencia
  String _calculateResistance() {
    // Validar que los campos estén seleccionados
    if (_band1 == null || _band2 == null) {
      return "Selecciona todos los colores";
    }

    // Calculamos el valor de las primeras 2 o 3 bandas
    int value;
    if (_numberOfBands == 4) {
      // Valor para 4 bandas con decenas y unidades
      value = (_band1!.significantFigure! * 10) + _band2!.significantFigure!;
    } else if (_numberOfBands >= 5 && _band3 != null) {
      // Valor para 5 y 6 bandas con centenas, decenas y unidades
      value = (_band1!.significantFigure! * 100) +
          (_band2!.significantFigure! * 10) +
          _band3!.significantFigure!;
    } else {
      return "Selecciona todos los colores";
    }

    // Calculamos la resistencia usando el valor de las primeras 2 o 3 bandas multiplicado por el valor de la 4ta banda
    // Si no hay multiplicador, se multiplica por 1 por defecto
    double resistance = value * (_multiplier?.multiplier ?? 1.0);

    // Si la tolerancia fue elegida, la convertimos a un string
    String tolerance =
        _tolerance != null ? "+/- ${_tolerance!.tolerance}%" : "";

    // Si el coeficiente de temperatura fue elegido, lo convertimos a un String
    String tcr = _tcr != null ? "${_tcr!.tcr} ppm/°k" : "";

    // Convertimos la resistemncia a String con 2 decimales y concatenamos con la tolerancia y el coeficiente de temperatura
    return "${resistance.toStringAsFixed(2)}Ω $tolerance \n $tcr";
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final outputStyle = theme.textTheme.headlineMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    final String imageUrl = "assets/images/${_numberOfBands}bandas.png";

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de Resistencia'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 255, 255, 213),
              Color.fromARGB(255, 255, 167, 167)
            ], // Gradiente de colores
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Dropdown para seleccionar el número de bandas
              DropdownButton<int>(
                value: _numberOfBands,
                items: [4, 5, 6].map((int bands) {
                  return DropdownMenuItem<int>(
                    value: bands,
                    child: Text('$bands bandas'),
                  );
                }).toList(),
                onChanged: (int? newValue) {
                  setState(() {
                    _numberOfBands = newValue!;
                  });
                },
                isExpanded: true,
                hint: const Text('Selecciona el número de bandas'),
              ),
              const SizedBox(height: 16),

              // Bandas de colores
              _buildDropdown(
                'Banda 1',
                significantColorCodes,
                _band1,
                (newValue) {
                  setState(() {
                    _band1 = newValue;
                  });
                },
              ),
              const SizedBox(height: 16),

              _buildDropdown(
                'Banda 2',
                significantColorCodes,
                _band2,
                (newValue) {
                  setState(() {
                    _band2 = newValue;
                  });
                },
              ),
              const SizedBox(height: 16),

              if (_numberOfBands >= 5)
                Column(
                  children: [
                    _buildDropdown(
                      'Banda 3',
                      significantColorCodes,
                      _band3,
                      (newValue) {
                        setState(() {
                          _band3 = newValue;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                ),

              _buildDropdown(
                'Multiplicador',
                multiplierColorCodes,
                _multiplier,
                (newValue) {
                  setState(() {
                    _multiplier = newValue;
                  });
                },
              ),
              const SizedBox(height: 16),

              _buildDropdown(
                'Tolerancia',
                toleranceColorCodes,
                _tolerance,
                (newValue) {
                  setState(() {
                    _tolerance = newValue;
                  });
                },
              ),
              SizedBox(height: _numberOfBands == 6 ? 16.0 : 32.0),

              if (_numberOfBands == 6)
                Column(
                  children: [
                    _buildDropdown(
                      'TCR (Coeficiente de temperatura de resistencia)',
                      tcrColorCodes,
                      _tcr,
                      (newValue) {
                        setState(() {
                          _tcr = newValue;
                        });
                      },
                    ),
                    const SizedBox(height: 32),
                  ],
                ),

              // Mostrar el valor de la resistencia
              Text(
                _calculateResistance(),
                style: outputStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // Imágenes de los códigos
              Image.asset(
                imageUrl,
                height: 600,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 20),

              Image.asset(
                "assets/images/codigos.png",
                height: 600,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Función Widget para construir los Dropdowns de las bandas y evitar código repetido
  Widget _buildDropdown(
    String label,
    List<ColorCode> options,
    ColorCode? selectedValue,
    Function(ColorCode?) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        // Creamos el botón desplegable con los elementos de tipo ColorCode
        DropdownButton<ColorCode>(
          value: selectedValue,
          items: options.map((ColorCode code) {
            // Convertimos cada elemento de la lista options en un item del menú desplegable de opciones
            return DropdownMenuItem<ColorCode>(
              // Valor que se otorga al parámetro onChanged al momento de seleccionarse en la lista
              value: code,
              // Creamos una fila con el cuadro del color y el nombre
              child: Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    color: code.color,
                    margin: const EdgeInsets.only(right: 10),
                  ),
                  Text(code.colorName),
                ],
              ),
            );
            // Convertimos todos los DropdownMenuItem<ColorCode> a una lista para el parámetro items
          }).toList(),
          onChanged: (newValue) => onChanged(newValue),
          isExpanded: true,
          hint: const Text('Selecciona un color'),
        ),
      ],
    );
  }

}
