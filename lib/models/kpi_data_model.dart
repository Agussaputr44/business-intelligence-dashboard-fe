class KpiData {
  final int activeCountries;
  final String totalSales;
  final String totalProfit;
  final int totalProducts;
  final String productsSold;

  KpiData({
    required this.activeCountries,
    required this.totalSales,
    required this.totalProfit,
    required this.totalProducts,
    required this.productsSold,
  });

 factory KpiData.fromJson(Map<String, dynamic> json) {
    return KpiData(
      activeCountries: json['active_countries'] as int, // Error if json['active_countries'] is "10"
      totalSales: json['total_sales'] as String,
      totalProfit: json['total_profit'] as String,
      totalProducts: json['total_products'] as int,
      productsSold: json['products_sold'] as String,
    );
  }
}