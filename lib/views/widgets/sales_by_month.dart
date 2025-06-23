import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import '../../providers/dashboard_provider.dart';
import 'package:dashboard/models/sale_month.dart'; // Pastikan impor ini benar

class SalesByMonthWidget extends StatelessWidget {
  const SalesByMonthWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
      builder: (context, provider, child) {
        print('Consumer rebuilt: ${provider.salesByMonth}');
        print('Filters: ${provider.filter.toString()}');

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
                  onPressed: () => provider.fetchSalesByMonth(),
                  child: const Text('Coba Lagi'),
                ),
              ],
            ),
          );
        }
        if (provider.salesByMonth.isEmpty) {
          return const Center(child: Text('No data available'));
        }

        // Terapkan filtering berdasarkan DashboardFilter
        List<SaleMonth> filteredData = provider.salesByMonth.where((sale) {
          // Jika semua filter null, kembalikan true (tidak ada filtering)
          if (provider.filter.selectedCountry == null &&
              provider.filter.selectedYear == null &&
              provider.filter.selectedProduct == null &&
              provider.filter.selectedMonth == null) {
            return true;
          }

          bool matches = true;


          // Filter berdasarkan selectedYear
          if (provider.filter.selectedYear != null) {
            matches &= sale.year.toString() == provider.filter.selectedYear;
          }


          return matches;
        }).toList();

        print('Filtered Data: $filteredData');

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
                'Tren Penjualan Bulanan',
                style: TextStyle(
                  color: Color(0xFFD4AF37),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 250,
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: true,
                      getDrawingHorizontalLine: (value) {
                        return FlLine(
                          color: Colors.grey[700]!,
                          strokeWidth: 0.5,
                        );
                      },
                      getDrawingVerticalLine: (value) {
                        return FlLine(
                          color: Colors.grey[700]!,
                          strokeWidth: 0.5,
                        );
                      },
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          interval: 1,
                          getTitlesWidget: (value, meta) {
                            const style = TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              overflow: TextOverflow.ellipsis,
                            );
                            final index = value.toInt();
                            if (index >= 0 && index < filteredData.length) {
                              return SideTitleWidget(
                                axisSide: meta.axisSide,
                                space: 8,
                                child: Transform.rotate(
                                  angle: -45 * 0.0174533,
                                  child: Text(
                                    '${filteredData[index].year} - ${filteredData[index].monthName}',
                                    style: style,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                            }
                            return const SideTitleWidget(
                              axisSide: AxisSide.bottom,
                              child: Text('', style: style),
                            );
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          interval: maxY / 4,
                          getTitlesWidget: (value, meta) {
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
                    minX: 0,
                    maxX: filteredData.length.toDouble() - 1,
                    minY: 0,
                    maxY: maxY == 0 ? 10 : maxY,
                    lineBarsData: [
                      LineChartBarData(
                        spots: filteredData.toList().asMap().entries.map((entry) {
                          return FlSpot(entry.key.toDouble(), entry.value.totalSales);
                        }).toList(),
                        isCurved: true,
                        color: const Color(0xFFD4AF37),
                        barWidth: 2,
                        dotData: FlDotData(
                          show: true,
                          getDotPainter: (spot, percent, bar, index) => FlDotCirclePainter(
                            radius: 3,
                            color: const Color(0xFFD4AF37),
                            strokeWidth: 1,
                            strokeColor: Colors.black,
                          ),
                        ),
                        belowBarData: BarAreaData(show: false),
                      ),
                    ],
                    lineTouchData: LineTouchData(enabled: false),
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