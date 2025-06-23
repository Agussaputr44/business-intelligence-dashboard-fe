import 'package:dashboard/models/discount_band_model.dart';
import 'package:dashboard/models/kpi_data_model.dart';
import 'package:flutter/material.dart';
import 'package:dashboard/models/dashboard_model.dart';
import 'package:dashboard/models/sale_month.dart';
import 'package:dashboard/models/sales_country.dart';
import 'package:dashboard/models/market_segment_model.dart';
import 'package:dashboard/services/dashboard_service.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardProvider with ChangeNotifier {
  final DashboardService _apiService = DashboardService();

  DashboardData? _dashboardData;
  DashboardFilter _filter = DashboardFilter();
  bool _isLoading = false;
  List<SaleMonth> _salesByMonth = [];
  List<SaleCountry> _salesByCountry = [];
  List<MarketSegment> _marketSegments = [];
  List<DiscountBand> _discountBands = [];
  String? _error;
  String? _selectedMonth;
  String? _selectedCountry;

  KpiData? _kpiData;

  KpiData? get kpiData => _kpiData;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchKpiData() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _kpiData = await _apiService.fetchKpi();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  DashboardProvider() {
    _filter = DashboardFilter();
    fetchData();
    fetchSalesByMonth();
    fetchSalesByCountry();
    fetchMarketSegmentData();
    fetchDiscountBandProfit();
    fetchKpiData();
  }

  // GETTERS
  List<SaleMonth> get salesByMonth => _salesByMonth;
  List<SaleCountry> get salesByCountry => _salesByCountry;
  List<MarketSegment> get marketSegments => _marketSegments;
  List<DiscountBand> get discountBands => _discountBands;
  String? get selectedMonth => _selectedMonth;
  String? get selectedCountry => _selectedCountry;
  DashboardData? get dashboardData => _dashboardData;
  DashboardFilter get filter => _filter;

  List<PieChartSectionData> get marketSegmentByLevel {
    final totalSum = _marketSegments.fold<double>(
        0, (sum, segment) => sum + segment.totalSales);
    return _marketSegments
        .map((segment) => segment.toPieChartSectionData(totalSum))
        .toList();
  }

  List<PieChartSectionData> get discountBandByProfit {
    final totalSum =
        _discountBands.fold<double>(0, (sum, band) => sum + band.totalProfit);
    return _discountBands
        .map((band) => band.toPieChartSectionData(totalSum))
        .toList();
  }

  List<String> get availableCountries => _dashboardData?.countries ?? [];
  List<String> get availableYears => _dashboardData?.years ?? [];
  List<String> get availableProducts => _dashboardData?.products ?? [];
  List<String> get availableMonths => _dashboardData?.months ?? [];

  // ACTIONS
  Future<void> fetchData() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _dashboardData = await _apiService.fetchDashboardData();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchSalesByMonth() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _salesByMonth = await _apiService.fetchSalesByMonth();
      _selectedMonth = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchSalesByCountry() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _salesByCountry = await _apiService.fetchSalesByCountry();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchMarketSegmentData() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _marketSegments = await _apiService.fetchMarketSegmentData();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchDiscountBandProfit() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _discountBands = await _apiService.fetchDiscountBandProfit();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setSelectedMonth(String? month) {
    _selectedMonth = month;
    notifyListeners();
  }

  void setSelectedCountry(String? country) {
    _selectedCountry = country;
    notifyListeners();
  }

  void updateFilter({
    String? selectedCountry,
    String? selectedYear,
    String? selectedProduct,
    String? selectedMonth,
  }) {
    _filter = _filter.copyWith(
      selectedCountry: selectedCountry,
      selectedYear: selectedYear,
      selectedProduct: selectedProduct,
      selectedMonth: selectedMonth,
    );
    notifyListeners();
  }
}
