import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import '../../models/sales_country.dart';
import '../../providers/dashboard_provider.dart';

class SalesByCountryWidget extends StatelessWidget {
  const SalesByCountryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (provider.error != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error: ${provider.error}', style: const TextStyle(color: Colors.red)),
                ElevatedButton(
                  onPressed: () => provider.fetchSalesByCountry(),
                  child: const Text('Coba Lagi'),
                ),
              ],
            ),
          );
        }
        if (provider.salesByCountry.isEmpty) {
          return const Center(child: Text('No data available'));
        }

        // Filter berdasarkan DashboardFilter (hanya country saja)
        List<SaleCountry> filteredData = provider.salesByCountry.where((sale) {
          if (provider.filter.selectedCountry == null) return true;
          return sale.country == provider.filter.selectedCountry;
        }).toList();

        final maxSales = filteredData.isNotEmpty
            ? filteredData.map((e) => e.totalSales).reduce((a, b) => a > b ? a : b)
            : 0.0;
        final maxY = maxSales * 1.2;

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF1E1E2E), Color(0xFF2A2A3A)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF33334D).withOpacity(0.5),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Penjualan Berdasarkan Negara',
                style: TextStyle(
                  color: Color(0xFFD4AF37),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 250,
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: maxY == 0 ? 10 : maxY,
                    barTouchData: BarTouchData(enabled: false),
                    titlesData: FlTitlesData(
                      show: true,
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 38,
                          getTitlesWidget: (double value, TitleMeta meta) {
                            const style = TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            );
                            final int index = value.toInt();
                            if (index >= 0 && index < filteredData.length) {
                              return SideTitleWidget(
                                axisSide: meta.axisSide,
                                space: 8,
                                child: Transform.rotate(
                                  angle: -45 * 0.0174533,
                                  child: Text(
                                    filteredData[index].country,
                                    style: style,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                            }
                            return SideTitleWidget(
                              axisSide: meta.axisSide,
                              child: const Text('', style: style),
                            );
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          interval: maxY / 4,
                          getTitlesWidget: (double value, TitleMeta meta) {
                            return Text(
                              '${(value / 1000000).toStringAsFixed(1)}M',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border: Border.all(color: Colors.grey[700]!, width: 1),
                    ),
                    barGroups: filteredData
                        .asMap()
                        .entries
                        .map(
                          (entry) => BarChartGroupData(
                            x: entry.key,
                            barRods: [
                              BarChartRodData(
                                toY: entry.value.totalSales,
                                color: Colors.blue,
                                width: 20,
                              ),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}