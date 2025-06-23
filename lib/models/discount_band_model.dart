import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DiscountBand {
  final String discountBand;
  final double totalProfit;
  final String color;

  DiscountBand({
    required this.discountBand,
    required this.totalProfit,
    required this.color,
  });

  factory DiscountBand.fromJson(Map<String, dynamic> json) {
    return DiscountBand(
      discountBand: (json['discount_band'] as String).trim(), // Trim spaces
      totalProfit: (json['total_profit'] as num).toDouble(),
      color: json['color'] as String,
    );
  }

  PieChartSectionData toPieChartSectionData(double totalSum) {
    final percentage = ((totalProfit / totalSum) * 100).toStringAsFixed(1);
    return PieChartSectionData(
      value: totalProfit,
      title: '$discountBand\n$percentage%',
      color: Color(int.parse(color.substring(1), radix: 16) + 0xFF000000),
      radius: 80,
      titleStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}