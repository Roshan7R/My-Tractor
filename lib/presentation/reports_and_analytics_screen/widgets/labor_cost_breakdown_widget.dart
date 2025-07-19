import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class LaborCostBreakdownWidget extends StatefulWidget {
  const LaborCostBreakdownWidget({Key? key}) : super(key: key);

  @override
  State<LaborCostBreakdownWidget> createState() =>
      _LaborCostBreakdownWidgetState();
}

class _LaborCostBreakdownWidgetState extends State<LaborCostBreakdownWidget> {
  int touchedIndex = -1;

  final List<Map<String, dynamic>> laborData = [
    {
      "category": "Tractor Operators",
      "amount": 45000,
      "percentage": 35,
      "color": const Color(0xFF2E7D32),
      "workers": 8
    },
    {
      "category": "Field Workers",
      "amount": 32000,
      "percentage": 25,
      "color": const Color(0xFF558B2F),
      "workers": 12
    },
    {
      "category": "Construction Labor",
      "amount": 28000,
      "percentage": 22,
      "color": const Color(0xFF8D6E63),
      "workers": 6
    },
    {
      "category": "Maintenance Staff",
      "amount": 23000,
      "percentage": 18,
      "color": const Color(0xFFF57C00),
      "workers": 4
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Labor Cost Breakdown',
                style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.lightTheme.colorScheme.onSurface,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                decoration: BoxDecoration(
                  color: AppTheme.lightTheme.colorScheme.primary
                      .withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '₹1,28,000',
                  style: AppTheme.currencyTextStyle(isLight: true, fontSize: 14)
                      .copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppTheme.lightTheme.colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 3.h),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 25.h,
                  child: PieChart(
                    PieChartData(
                      pieTouchData: PieTouchData(
                        touchCallback: (FlTouchEvent event, pieTouchResponse) {
                          setState(() {
                            if (!event.isInterestedForInteractions ||
                                pieTouchResponse == null ||
                                pieTouchResponse.touchedSection == null) {
                              touchedIndex = -1;
                              return;
                            }
                            touchedIndex = pieTouchResponse
                                .touchedSection!.touchedSectionIndex;
                          });
                        },
                      ),
                      borderData: FlBorderData(show: false),
                      sectionsSpace: 2,
                      centerSpaceRadius: 8.w,
                      sections: laborData.asMap().entries.map((entry) {
                        final index = entry.key;
                        final data = entry.value;
                        final isTouched = index == touchedIndex;
                        final fontSize = isTouched ? 16.0 : 12.0;
                        final radius = isTouched ? 12.w : 10.w;

                        return PieChartSectionData(
                          color: data["color"] as Color,
                          value: (data["percentage"] as int).toDouble(),
                          title: '${data["percentage"]}%',
                          radius: radius,
                          titleStyle: AppTheme.lightTheme.textTheme.labelMedium
                              ?.copyWith(
                            fontSize: fontSize,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.lightTheme.colorScheme.onPrimary,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 4.w),
              Expanded(
                flex: 3,
                child: Column(
                  children: laborData.asMap().entries.map((entry) {
                    final index = entry.key;
                    final data = entry.value;
                    final isSelected = index == touchedIndex;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          touchedIndex = index;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 1.5.h),
                        padding: EdgeInsets.all(3.w),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? (data["color"] as Color).withValues(alpha: 0.1)
                              : AppTheme.lightTheme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: isSelected
                                ? data["color"] as Color
                                : AppTheme.lightTheme.colorScheme.outline
                                    .withValues(alpha: 0.2),
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 3.w,
                                  height: 3.w,
                                  decoration: BoxDecoration(
                                    color: data["color"] as Color,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: 2.w),
                                Expanded(
                                  child: Text(
                                    data["category"] as String,
                                    style: AppTheme
                                        .lightTheme.textTheme.titleSmall
                                        ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme
                                          .lightTheme.colorScheme.onSurface,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 0.5.h),
                            Text(
                              '₹${data["amount"]}',
                              style: AppTheme.currencyTextStyle(
                                      isLight: true, fontSize: 16)
                                  .copyWith(
                                fontWeight: FontWeight.w700,
                                color: data["color"] as Color,
                              ),
                            ),
                            Text(
                              '${data["workers"]} workers',
                              style: AppTheme.lightTheme.textTheme.bodySmall
                                  ?.copyWith(
                                color: AppTheme
                                    .lightTheme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
