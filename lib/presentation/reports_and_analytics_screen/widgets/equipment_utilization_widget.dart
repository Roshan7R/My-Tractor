import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class EquipmentUtilizationWidget extends StatelessWidget {
  const EquipmentUtilizationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> equipmentData = [
      {
        "name": "John Deere 5310",
        "utilization": 85,
        "status": "Active",
        "hours": "142h",
        "efficiency": "High"
      },
      {
        "name": "John Deere 3028",
        "utilization": 72,
        "status": "Active",
        "hours": "98h",
        "efficiency": "Medium"
      },
      {
        "name": "Sonalika DI-60",
        "utilization": 68,
        "status": "Maintenance",
        "hours": "87h",
        "efficiency": "Medium"
      },
      {
        "name": "Rotavator",
        "utilization": 91,
        "status": "Active",
        "hours": "156h",
        "efficiency": "High"
      },
      {
        "name": "Cultivator",
        "utilization": 45,
        "status": "Idle",
        "hours": "34h",
        "efficiency": "Low"
      },
    ];

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
                'Equipment Utilization',
                style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.lightTheme.colorScheme.onSurface,
                ),
              ),
              CustomIconWidget(
                iconName: 'agriculture',
                color: AppTheme.lightTheme.colorScheme.primary,
                size: 6.w,
              ),
            ],
          ),
          SizedBox(height: 3.h),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: equipmentData.length,
            separatorBuilder: (context, index) => SizedBox(height: 2.h),
            itemBuilder: (context, index) {
              final equipment = equipmentData[index];
              final utilization = equipment["utilization"] as int;
              final efficiency = equipment["efficiency"] as String;

              Color efficiencyColor;
              switch (efficiency) {
                case "High":
                  efficiencyColor = AppTheme.successLight;
                  break;
                case "Medium":
                  efficiencyColor = AppTheme.warningLight;
                  break;
                default:
                  efficiencyColor = AppTheme.errorLight;
              }

              return Container(
                padding: EdgeInsets.all(3.w),
                decoration: BoxDecoration(
                  color: AppTheme.lightTheme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppTheme.lightTheme.colorScheme.outline
                        .withValues(alpha: 0.2),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            equipment["name"] as String,
                            style: AppTheme.lightTheme.textTheme.titleMedium
                                ?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppTheme.lightTheme.colorScheme.onSurface,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 2.w, vertical: 0.5.h),
                          decoration: BoxDecoration(
                            color: efficiencyColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            efficiency,
                            style: AppTheme.lightTheme.textTheme.labelSmall
                                ?.copyWith(
                              color: efficiencyColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h),
                    Row(
                      children: [
                        Text(
                          '${utilization}%',
                          style: AppTheme.lightTheme.textTheme.titleSmall
                              ?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppTheme.lightTheme.colorScheme.primary,
                          ),
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          '• ${equipment["hours"]} this month',
                          style:
                              AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                            color: AppTheme
                                .lightTheme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h),
                    LinearProgressIndicator(
                      value: utilization / 100,
                      backgroundColor: AppTheme.lightTheme.colorScheme.outline
                          .withValues(alpha: 0.2),
                      valueColor:
                          AlwaysStoppedAnimation<Color>(efficiencyColor),
                      minHeight: 6,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
