import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/dashboard_provider.dart';

class FiltersSectionWidget extends StatelessWidget {
  const FiltersSectionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DashboardProvider>(context);
    final data = provider.dashboardData;
    if (data == null) return const SizedBox.shrink();

    final countries = ['All', ...data.countries];
    final years = ['All', ...data.years];
    final products = ['All', ...data.products];
    final months = ['All', ...data.months];

    // Helper to ensure value always exists in items
    String _dropdownValue(String? selected, List<String> items) {
      if (selected == null) return 'All';
      return items.contains(selected) ? selected : 'All';
    }

    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width > 600 ? 16 : 12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E1E2E), Color(0xFF2A2A3A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF33334D).withOpacity(0.5),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWideScreen = constraints.maxWidth > 600;
          final fontScale = constraints.maxWidth / 400;
          final titleFontSize = (isWideScreen ? 20.0 : 16.0) * fontScale.clamp(0.8, 1.2);
          final dropdownFontSize = (isWideScreen ? 14.0 : 12.0) * fontScale.clamp(0.8, 1.2);
          final spacing = isWideScreen ? 10.0 : 8.0;
          final dropdownMaxWidth = isWideScreen ? constraints.maxWidth * 0.22 : constraints.maxWidth * 0.45;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Filters',
                style: TextStyle(
                  color: const Color(0xFFD4AF37),
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: spacing),
              isWideScreen
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: _buildDropdown(
                            context: context,
                            label: 'Country',
                            value: _dropdownValue(provider.filter.selectedCountry, countries),
                            items: countries,
                            onChanged: (value) => provider.updateFilter(
                              selectedCountry: value == 'All' ? null : value,
                            ),
                            fontSize: dropdownFontSize,
                            maxWidth: dropdownMaxWidth,
                          ),
                        ),
                        SizedBox(width: spacing),
                        Expanded(
                          child: _buildDropdown(
                            context: context,
                            label: 'Year',
                            value: _dropdownValue(provider.filter.selectedYear, years),
                            items: years,
                            onChanged: (value) => provider.updateFilter(
                              selectedYear: value == 'All' ? null : value,
                            ),
                            fontSize: dropdownFontSize,
                            maxWidth: dropdownMaxWidth,
                          ),
                        ),
                        SizedBox(width: spacing),
                        // Expanded(
                        //   child: _buildDropdown(
                        //     context: context,
                        //     label: 'Product',
                        //     value: _dropdownValue(provider.filter.selectedProduct, products),
                        //     items: products,
                        //     onChanged: (value) => provider.updateFilter(
                        //       selectedProduct: value == 'All' ? null : value,
                        //     ),
                        //     fontSize: dropdownFontSize,
                        //     maxWidth: dropdownMaxWidth,
                        //   ),
                        // ),
                        // SizedBox(width: spacing),
                        // Expanded(
                        //   child: _buildDropdown(
                        //     context: context,
                        //     label: 'Month',
                        //     value: _dropdownValue(provider.filter.selectedMonth, months),
                        //     items: months,
                        //     onChanged: (value) => provider.updateFilter(
                        //       selectedMonth: value == 'All' ? null : value,
                        //     ),
                        //     fontSize: dropdownFontSize,
                        //     maxWidth: dropdownMaxWidth,
                        //   ),
                        // ),
                      ],
                    )
                  : Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: _buildDropdown(
                                context: context,
                                label: 'Country',
                                value: _dropdownValue(provider.filter.selectedCountry, countries),
                                items: countries,
                                onChanged: (value) => provider.updateFilter(
                                  selectedCountry: value == 'All' ? null : value,
                                ),
                                fontSize: dropdownFontSize,
                                maxWidth: dropdownMaxWidth,
                              ),
                            ),
                            SizedBox(width: spacing),
                            Expanded(
                              child: _buildDropdown(
                                context: context,
                                label: 'Year',
                                value: _dropdownValue(provider.filter.selectedYear, years),
                                items: years,
                                onChanged: (value) => provider.updateFilter(
                                  selectedYear: value == 'All' ? null : value,
                                ),
                                fontSize: dropdownFontSize,
                                maxWidth: dropdownMaxWidth,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spacing),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: _buildDropdown(
                        //         context: context,
                        //         label: 'Product',
                        //         value: _dropdownValue(provider.filter.selectedProduct, products),
                        //         items: products,
                        //         onChanged: (value) => provider.updateFilter(
                        //           selectedProduct: value == 'All' ? null : value,
                        //         ),
                        //         fontSize: dropdownFontSize,
                        //         maxWidth: dropdownMaxWidth,
                        //       ),
                        //     ),
                        //     SizedBox(width: spacing),
                        //     Expanded(
                        //       child: _buildDropdown(
                        //         context: context,
                        //         label: 'Month',
                        //         value: _dropdownValue(provider.filter.selectedMonth, months),
                        //         items: months,
                        //         onChanged: (value) => provider.updateFilter(
                        //           selectedMonth: value == 'All' ? null : value,
                        //         ),
                        //         fontSize: dropdownFontSize,
                        //         maxWidth: dropdownMaxWidth,
                        //       ),
                        //     ),
                          // ],
                        // ),
                      ],
                    ),
              const SizedBox(height: 10),
              // Align(
              //   alignment: Alignment.centerRight,
              //   child: TextButton.icon(
              //     onPressed: () {
              //       provider.updateFilter(
              //         selectedCountry: "All",
              //         selectedYear: "All",
              //         selectedProduct: "All",
              //         selectedMonth: "All",
              //       );
              //     },
              //     icon: const Icon(Icons.clear, color: Colors.grey),
              //     label: const Text('Reset Filters', style: TextStyle(color: Colors.grey)),
              //   ),
              // ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDropdown({
    required BuildContext context,
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    required double fontSize,
    required double maxWidth,
  }) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth.clamp(100, 180)),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey[400], fontSize: fontSize),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[700]!),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFD4AF37)),
          ),
          filled: true,
          fillColor: Colors.transparent,
          contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        ),
        dropdownColor: const Color(0xFF2A2A3A),
        style: TextStyle(color: Colors.white, fontSize: fontSize),
        value: value,
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: TextStyle(fontSize: fontSize),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}