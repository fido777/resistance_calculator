import 'package:flutter/material.dart';

// Modelo de datos para el código de colores
class ColorCode {
  final String colorName;
  final Color color;
  final int? significantFigure; // Para las primeras bandas
  final double? multiplier; // Para la banda multiplicadora
  final double? tolerance; // Para la banda de tolerancia
  final int? tcr; // Para la banda 6 de temperatura

  ColorCode({
    required this.colorName,
    required this.color,
    this.significantFigure,
    this.multiplier,
    this.tolerance,
    this.tcr,
  });
}

// Lista de colores para las bandas significativas (primeras 2 o 3 bandas)
final List<ColorCode> significantColorCodes = [
  ColorCode(colorName: "Negro", color: Colors.black, significantFigure: 0),
  ColorCode(colorName: "Marrón", color: Colors.brown, significantFigure: 1),
  ColorCode(colorName: "Rojo", color: Colors.red, significantFigure: 2),
  ColorCode(colorName: "Naranja", color: Colors.orange, significantFigure: 3),
  ColorCode(colorName: "Amarillo", color: Colors.yellow, significantFigure: 4),
  ColorCode(colorName: "Verde", color: Colors.green, significantFigure: 5),
  ColorCode(colorName: "Azul", color: Colors.blue, significantFigure: 6),
  ColorCode(colorName: "Violeta", color: Colors.purple, significantFigure: 7),
  ColorCode(colorName: "Gris", color: Colors.grey, significantFigure: 8),
  ColorCode(colorName: "Blanco", color: Colors.white, significantFigure: 9),
];

// Lista de colores para la banda multiplicadora
final List<ColorCode> multiplierColorCodes = [
  ColorCode(colorName: "Negro", color: Colors.black, multiplier: 1),
  ColorCode(colorName: "Marrón", color: Colors.brown, multiplier: 10),
  ColorCode(colorName: "Rojo", color: Colors.red, multiplier: 100),
  ColorCode(colorName: "Naranja", color: Colors.orange, multiplier: 1000),
  ColorCode(colorName: "Amarillo", color: Colors.yellow, multiplier: 10000),
  ColorCode(colorName: "Verde", color: Colors.green, multiplier: 100000),
  ColorCode(colorName: "Azul", color: Colors.blue, multiplier: 1000000),
  ColorCode(colorName: "Violeta", color: Colors.purple, multiplier: 10000000),
  ColorCode(colorName: "Gris", color: Colors.grey, multiplier: 100000000),
  ColorCode(colorName: "Blanco", color: Colors.white, multiplier: 1000000000),
  ColorCode(colorName: "Dorado", color: Colors.amber, multiplier: 0.1),
  ColorCode(colorName: "Plateado", color: Colors.grey, multiplier: 0.01),
];

// Lista de colores para la banda de tolerancia
final List<ColorCode> toleranceColorCodes = [
  ColorCode(colorName: "Marrón", color: Colors.brown, tolerance: 1),
  ColorCode(colorName: "Rojo", color: Colors.red, tolerance: 2),
  ColorCode(colorName: "Dorado", color: Colors.amber, tolerance: 5),
  ColorCode(colorName: "Plateado", color: Colors.grey, tolerance: 10),
];

// Lista de colores para la banda de temperatura
final List<ColorCode> tcrColorCodes = [
  ColorCode(colorName: "Negro", color: Colors.black, tcr: 250),
  ColorCode(colorName: "Marrón", color: Colors.brown, tcr: 100),
  ColorCode(colorName: "Rojo", color: Colors.red, tcr: 50),
  ColorCode(colorName: "Naranja", color: Colors.orange, tcr: 15),
  ColorCode(colorName: "Amarillo", color: Colors.yellow, tcr: 25),
  ColorCode(colorName: "Verde", color: Colors.green, tcr: 20),
  ColorCode(colorName: "Azul", color: Colors.blue, tcr: 10),
  ColorCode(colorName: "Violeta", color: Colors.purple, tcr: 5),
  ColorCode(colorName: "Gris", color: Colors.grey, tcr: 1),
];
