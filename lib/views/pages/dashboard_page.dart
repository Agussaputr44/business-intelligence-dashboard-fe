import 'package:dashboard/providers/dashboard_provider.dart';
import 'package:dashboard/views/widgets/discount_band_by_profit_widget.dart.dart';
import 'package:dashboard/views/widgets/filters_section_widget.dart';
import 'package:dashboard/views/widgets/header_widget.dart';
import 'package:dashboard/views/widgets/kpi_cards_widget.dart';
import 'package:dashboard/views/widgets/market_segment_widget.dart';
import 'package:dashboard/views/widgets/sales_by_country_widget.dart';
import 'package:dashboard/views/widgets/sales_by_month.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DashboardProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D1A),
      body: SafeArea(
        child: provider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : provider.error != null
                ? Center(child: Text('Error: ${provider.error}', style: const TextStyle(color: Colors.white)))
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        HeaderWidget(),
                        SizedBox(height: 20),
                        KPICardsWidget(),
                        SizedBox(height: 20),
                        FiltersSectionWidget(),
                        SizedBox(height: 20),
                        // SizedBox(height: 20),
                        // ProductTrendSectionWidget(),
                        SalesByCountryWidget(),
                        SizedBox(height: 20),
                        SalesByMonthWidget(),
                        SizedBox(height: 20),
                        MarketSegmentWidget(),
                        SizedBox(height: 20),
                        DiscountBandByProfitWidget(),
                        
                      ],
                    ),
                  ),
      ),
    );
  }
}