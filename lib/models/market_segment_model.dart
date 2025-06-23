import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MarketSegment {
  final String segment;
  final double totalSales;
  final String color;

  MarketSegment({
    required this.segment,
    required this.totalSales,
    required this.color,
  });

  factory MarketSegment.fromJson(Map<String, dynamic> json) {
    return MarketSegment(
      segment: json['segment'] as String,
      totalSales: (json['total_sales'] as num).toDouble(),
      color: json['color'] as String,
    );
  }

  PieChartSectionData toPieChartSectionData(double totalSum) {
    final percentage = ((totalSales / totalSum) * 100).toStringAsFixed(1);
    return PieChartSectionData(
      value: totalSales,
      title: '$segment\n$percentage%',
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