import 'package:dashboard/providers/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KPICardsWidget extends StatelessWidget {
  const KPICardsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
      builder: (context, kpiProvider, child) {
        if (kpiProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (kpiProvider.error != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error: ${kpiProvider.error}'),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => kpiProvider.fetchKpiData(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        } else if (kpiProvider.kpiData == null) {
          return const Center(child: Text('No data available'));
        }

        final data = kpiProvider.kpiData!;
        return LayoutBuilder(
          builder: (context, constraints) {
            final isWideScreen = constraints.maxWidth > 600;
            final outerPadding = isWideScreen ? 16.0 : 8.0;
            final spacing = isWideScreen ? 15.0 : 8.0;
            final cardWidth =
                ((constraints.maxWidth - 2 * outerPadding - spacing) / 2)
                    .clamp(120.0, 300.0);
            final valueFontSize = isWideScreen ? 26.0 : 22.0;
            final titleFontSize = isWideScreen ? 15.0 : 13.0;
            final iconSize = isWideScreen ? 28.0 : 24.0;
            final badgeSize = isWideScreen ? 18.0 : 16.0;

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: outerPadding),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: cardWidth),
                          child: _buildKPICard(
                            context,
                            title: 'Total Profit',
                            value: '\$${data.totalProfit}',
                            icon: Icons.trending_up,
                            gradientColors: const [
                              Color(0xFF4FC3F7),
                              Color(0xFF29B6F6),
                            ],
                            valueFontSize: valueFontSize,
                            titleFontSize: titleFontSize,
                            iconSize: iconSize,
                            badgeSize: badgeSize,
                            padding: isWideScreen ? 20 : 12,
                            width: cardWidth,
                          ),
                        ),
                      ),
                      SizedBox(width: spacing),
                      Flexible(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: cardWidth),
                          child: _buildKPICard(
                            context,
                            title: 'Hasil Penjualan',
                            value: '\$${data.totalSales}',
                            icon: Icons.sell,
                            gradientColors: const [
                              Color(0xFF66BB6A),
                              Color(0xFF4CAF50),
                            ],
                            valueFontSize: valueFontSize,
                            titleFontSize: titleFontSize,
                            iconSize: iconSize,
                            badgeSize: badgeSize,
                            padding: isWideScreen ? 20 : 12,
                            width: cardWidth,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: cardWidth),
                            child: _buildKPICard(
                              context,
                              title: 'Total Product',
                              value: '${data.totalProducts}',
                              icon: Icons.category,
                              gradientColors: const [
                                Color(0xFF4FC3F7),
                                Color(0xFF29B6F6),
                              ],
                              valueFontSize: valueFontSize,
                              titleFontSize: titleFontSize,
                              iconSize: iconSize,
                              badgeSize: badgeSize,
                              padding: isWideScreen ? 20 : 12,
                              width: cardWidth,
                            ),
                          ),
                        ),
                        SizedBox(width: spacing),
                        Flexible(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: cardWidth),
                            child: _buildKPICard(
                              context,
                              title: 'Total Negara Aktif',
                              value: '${data.activeCountries}',
                              icon: Icons.shopping_cart,
                              gradientColors: const [
                                Color(0xFF66BB6A),
                                Color(0xFF4CAF50),
                              ],
                              valueFontSize: valueFontSize,
                              titleFontSize: titleFontSize,
                              iconSize: iconSize,
                              badgeSize: badgeSize,
                              padding: isWideScreen ? 20 : 12,
                              width: cardWidth,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildKPICard(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required List<Color> gradientColors,
    required double valueFontSize,
    required double titleFontSize,
    required double iconSize,
    required double badgeSize,
    required double padding,
    required double width,
  }) {
    return Container(
      width: width,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E1E2E), Color(0xFF2A2A3A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
        border:
            Border.all(color: Colors.grey[400]!.withOpacity(0.3), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF33334D).withOpacity(0.5),
            blurRadius: 8,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: Colors.white, size: iconSize),
              Container(
                padding: EdgeInsets.all(padding * 0.3),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFD4AF37), Color(0xFFFFD700)],
                  ),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(Icons.arrow_upward,
                    color: Colors.black, size: badgeSize),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Text(
            value.isEmpty ? 'N/A' : value,
            style: TextStyle(
              color: Colors.white,
              fontSize: valueFontSize,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          Text(
            title.isEmpty ? 'Untitled' : title,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: titleFontSize,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}