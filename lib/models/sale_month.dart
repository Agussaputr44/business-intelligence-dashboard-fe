class SaleMonth {
  final int year;
  final String monthName;
  final double totalSales;

  SaleMonth({
    required this.year,
    required this.monthName,
    required this.totalSales,
  });

  factory SaleMonth.fromJson(Map<String, dynamic> json) {
    return SaleMonth(
      year: json['year'] as int,
      monthName: json['month_name'] as String,
      totalSales: double.parse(json['total_sales'].toString()),
    );
  }
}