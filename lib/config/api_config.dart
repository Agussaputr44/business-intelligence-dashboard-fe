class ApiConfig {
  static const String baseUrl = 'https://fancy-quick-lacewing.ngrok-free.app/api/v1';
  static const String salesByMonth = '/sales-by-month';
  // static const String salesByProduct = '/sales-by-product';
  static const String salesByCountry= '/sales-by-country';
  static const String salesByMarketSegment = '/sales-by-segment';
  static const String profitByDiscountBand = '/profit-by-discount-band';
  static const String kpi = '/kpi';

  static String buildUrl(String endpoint) => '$baseUrl$endpoint';
}