class SaleCountry {
  final String country;
  final double totalSales;

  SaleCountry({
    required this.country,
    required this.totalSales,
  });

  factory SaleCountry.fromJson(Map<String, dynamic> json) {
    return SaleCountry(
      country: json['country'] as String,
      totalSales: double.parse(json['total_sales'].toString()),
    );
  }
}