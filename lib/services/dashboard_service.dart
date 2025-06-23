import 'dart:convert';
import 'package:dashboard/config/api_config.dart';
import 'package:dashboard/models/dashboard_model.dart';
import 'package:dashboard/models/discount_band_model.dart';
import 'package:dashboard/models/kpi_data_model.dart';
import 'package:dashboard/models/sale_month.dart';
import 'package:dashboard/models/sales_country.dart';
import 'package:dashboard/models/market_segment_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DashboardService {
  get titleStyle => null;

  Future<List<SaleCountry>> fetchSalesByCountry() async {
    try {
      final response = await http.get(Uri.parse(ApiConfig.buildUrl(ApiConfig.salesByCountry)));
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List<dynamic> salesData = jsonData['data'];
        return salesData.map((sale) => SaleCountry.fromJson(sale)).toList();
      } else {
        throw Exception('Failed to load sales by country: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  Future<List<SaleMonth>> fetchSalesByMonth() async {
    try {
      final response = await http.get(
        Uri.parse(ApiConfig.buildUrl(ApiConfig.salesByMonth)),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'ngrok-skip-browser-warning': 'true',
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw Exception('Request timed out');
      });

      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        if (response.body.startsWith('<!DOCTYPE')) {
          throw Exception('Received HTML instead of JSON. Check ngrok or endpoint.');
        }
        final jsonData = json.decode(response.body);
        if (jsonData['status'] != 'success') {
          throw Exception('API error: ${jsonData['message'] ?? 'Unknown error'}');
        }
        final List<dynamic> salesData = jsonData['data'];
        return salesData.map((sale) => SaleMonth.fromJson(sale)).toList();
      } else {
        throw Exception('Failed to load sales by month: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching sales by month: $e');
      rethrow;
    }
  }

   Future<KpiData> fetchKpi() async {
    try {
      final response = await http.get(
        Uri.parse(ApiConfig.buildUrl(ApiConfig.kpi)),
        headers: {
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData['status'] == 'success') {
          return KpiData.fromJson(jsonData['data']);
        } else {
          throw Exception('API error: ${jsonData['message'] ?? 'Unknown error'}');
        }
      } else {
        throw Exception('Failed to load KPI data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching KPI data: $e');
    }
  }

  Future<List<MarketSegment>> fetchMarketSegmentData() async {
    try {
      final response = await http.get(
        Uri.parse(ApiConfig.buildUrl(ApiConfig.salesByMarketSegment)),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'ngrok-skip-browser-warning': 'true',
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw Exception('Request timed out');
      });

      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData['status'] != 'success') {
          throw Exception('API error: ${jsonData['message'] ?? 'Unknown error'}');
        }
        final List<dynamic> segmentData = jsonData['data'];
        return segmentData.map((segment) => MarketSegment.fromJson(segment)).toList();
      } else {
        throw Exception('Failed to load market segment data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching market segment data: $e');
      rethrow;
    }
  }

  Future<List<DiscountBand>> fetchDiscountBandProfit() async {
    try {
      final response = await http.get(
        Uri.parse(ApiConfig.buildUrl(ApiConfig.profitByDiscountBand)),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'ngrok-skip-browser-warning': 'true',
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw Exception('Request timed out');
      });

      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData['status'] != 'success') {
          throw Exception('API error: ${jsonData['message'] ?? 'Unknown error'}');
        }
        final List<dynamic> discountData = jsonData['data'];
        return discountData.map((discount) => DiscountBand.fromJson(discount)).toList();
      } else {
        throw Exception('Failed to load discount band profit: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching discount band profit: $e');
      rethrow;
    }
  }

  Future<DashboardData> fetchDashboardData() async {
    await Future.delayed(Duration(seconds: 1));

    return DashboardData(
      countries: [
        'Canada',
        'France',
        'Germany',
        'Mexico',
        'United States of America',
      ],
      years: ['2013', '2014'],
      products: ['Amarilla', 'Carretera', 'Montana', 'Paseo', 'Velo', 'VTT'],
      months: [
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December',
      ],
      productSalesTrends: {
        'Amarilla': [
          FlSpot(0, 2.5),
          FlSpot(1, 1.8),
          FlSpot(2, 3.2),
          FlSpot(3, 2.1),
          FlSpot(4, 3.8),
          FlSpot(5, 2.9),
        ],
        'Carretera': [
          FlSpot(0, 1.8),
          FlSpot(1, 2.2),
          FlSpot(2, 4.5),
          FlSpot(3, 3.1),
          FlSpot(4, 2.8),
          FlSpot(5, 3.5),
        ],
        'Montana': [
          FlSpot(0, 3.1),
          FlSpot(1, 2.5),
          FlSpot(2, 5.2),
          FlSpot(3, 4.8),
          FlSpot(4, 3.2),
          FlSpot(5, 4.1),
        ],
        'Paseo': [
          FlSpot(0, 2.8),
          FlSpot(1, 3.5),
          FlSpot(2, 2.2),
          FlSpot(3, 4.2),
          FlSpot(4, 3.9),
          FlSpot(5, 3.1),
        ],
      },
      productQuarterlyTrends: {
        'Amarilla': [
          FlSpot(0, 1.5),
          FlSpot(1, 2.2),
          FlSpot(2, 3.8),
          FlSpot(3, 4.1),
        ],
        'Carretera': [
          FlSpot(0, 2.0),
          FlSpot(1, 2.8),
          FlSpot(2, 4.2),
          FlSpot(3, 3.5),
        ],
        'Montana': [
          FlSpot(0, 1.8),
          FlSpot(1, 3.0),
          FlSpot(2, 4.5),
          FlSpot(3, 5.0),
        ],
        'Paseo': [
          FlSpot(0, 2.5),
          FlSpot(1, 3.2),
          FlSpot(2, 3.9),
          FlSpot(3, 4.8),
        ],
      },
      marketSegmentByType: [
        PieChartSectionData(
          color: Color(0xFF4FC3F7),
          value: 45,
          title: 'Government\n45%',
          radius: 80,
          titleStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        PieChartSectionData(
          color: Color(0xFF66BB6A),
          value: 30,
          title: 'Small Business\n30%',
          radius: 80,
          titleStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        PieChartSectionData(
          color: Color(0xFF9C27B0),
          value: 15,
          title: 'Enterprise\n15%',
          radius: 80,
          titleStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        PieChartSectionData(
          color: Color(0xFFFF9800),
          value: 10,
          title: 'Midmarket\n10%',
          radius: 80,
          titleStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
      marketSegmentByLevel: [], // Will be populated by provider
      salesByCountry: [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(
              toY: 25,
              gradient: LinearGradient(
                colors: [Color(0xFF4FC3F7), Color(0xFF29B6F6)],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
              width: 20,
              borderRadius: BorderRadius.circular(6),
            ),
          ],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
              toY: 24.5,
              gradient: LinearGradient(
                colors: [Color(0xFF4FC3F7), Color(0xFF29B6F6)],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
              width: 20,
              borderRadius: BorderRadius.circular(6),
            ),
          ],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(
              toY: 24,
              gradient: LinearGradient(
                colors: [Color(0xFF4FC3F7), Color(0xFF29B6F6)],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
              width: 20,
              borderRadius: BorderRadius.circular(6),
            ),
          ],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
              toY: 22.5,
              gradient: LinearGradient(
                colors: [Color(0xFF4FC3F7), Color(0xFF29B6F6)],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
              width: 20,
              borderRadius: BorderRadius.circular(6),
            ),
          ],
        ),
        BarChartGroupData(
          x: 4,
          barRods: [
            BarChartRodData(
              toY: 20.5,
              gradient: LinearGradient(
                colors: [Color(0xFF4FC3F7), Color(0xFF29B6F6)],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
              width: 20,
              borderRadius: BorderRadius.circular(6),
            ),
          ],
        ),
      ],
    );
  }
}