import 'package:fl_chart/fl_chart.dart';

class DashboardFilter {
  final String? selectedCountry;
  final String? selectedYear;
  final String? selectedProduct;
  final String? selectedMonth;

  DashboardFilter({
    this.selectedCountry,
    this.selectedYear,
    this.selectedProduct,
    this.selectedMonth,
  });

  DashboardFilter copyWith({
    String? selectedCountry,
    String? selectedYear,
    String? selectedProduct,
    String? selectedMonth,
  }) {
    return DashboardFilter(
      selectedCountry: selectedCountry ?? this.selectedCountry,
      selectedYear: selectedYear ?? this.selectedYear,
      selectedProduct: selectedProduct ?? this.selectedProduct,
      selectedMonth: selectedMonth ?? this.selectedMonth,
    );
  }
}

class DashboardData {
  final List<String> countries;
  final List<String> years;
  final List<String> products;
  final List<String> months;
  final Map<String, List<FlSpot>> productSalesTrends;
  final Map<String, List<FlSpot>> productQuarterlyTrends;
  final List<PieChartSectionData> marketSegmentByType;
  final List<PieChartSectionData> marketSegmentByLevel;
  final List<BarChartGroupData> salesByCountry;

  DashboardData({
    required this.countries,
    required this.years,
    required this.products,
    required this.months,
    required this.productSalesTrends,
    required this.productQuarterlyTrends,
    required this.marketSegmentByType,
    required this.marketSegmentByLevel,
    required this.salesByCountry,
  });
}