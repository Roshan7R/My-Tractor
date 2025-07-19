import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class EquipmentCardWidget extends StatelessWidget {
  final Map<String, dynamic> equipment;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const EquipmentCardWidget({
    super.key,
    required this.equipment,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final String status = equipment['status'] as String;
    final double fuelLevel = (equipment['fuelLevel'] as num).toDouble();

    Color statusColor = _getStatusColor(status, isDarkMode);

    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        margin: EdgeInsets.all(1.5.w),
        decoration: BoxDecoration(
          color: isDarkMode ? AppTheme.cardDark : AppTheme.cardLight,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: isDarkMode ? AppTheme.shadowDark : AppTheme.shadowLight,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Equipment Image
            Container(
              height: 20.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                color: isDarkMode
                    ? AppTheme.neutralBorderDark
                    : AppTheme.neutralBorderLight,
              ),
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                child: CustomImageWidget(
                  imageUrl: equipment['imageUrl'] as String,
                  width: double.infinity,
                  height: 20.h,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(3.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Equipment Name and Status
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          equipment['name'] as String,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.w, vertical: 0.5.h),
                        decoration: BoxDecoration(
                          color: statusColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: statusColor, width: 1),
                        ),
                        child: Text(
                          status,
                          style:
                              Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: statusColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 1.h),

                  // Operator Name
                  Row(
                    children: [
                      CustomIconWidget(
                        iconName: 'person',
                        color: isDarkMode
                            ? AppTheme.textSecondaryDark
                            : AppTheme.textSecondaryLight,
                        size: 16,
                      ),
                      SizedBox(width: 1.w),
                      Expanded(
                        child: Text(
                          equipment['operator'] as String,
                          style: Theme.of(context).textTheme.bodySmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 1.5.h),

                  // Fuel Level
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Fuel Level',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            '${fuelLevel.toInt()}%',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                        ],
                      ),
                      SizedBox(height: 0.5.h),
                      Container(
                        height: 0.8.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: isDarkMode
                              ? AppTheme.neutralBorderDark
                              : AppTheme.neutralBorderLight,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: fuelLevel / 100,
                          child: Container(
                            decoration: BoxDecoration(
                              color: _getFuelLevelColor(fuelLevel, isDarkMode),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status, bool isDarkMode) {
    switch (status.toLowerCase()) {
      case 'working':
        return isDarkMode ? AppTheme.successDark : AppTheme.successLight;
      case 'idle':
        return isDarkMode ? AppTheme.warningDark : AppTheme.warningLight;
      case 'maintenance':
        return isDarkMode ? AppTheme.errorDark : AppTheme.errorLight;
      default:
        return isDarkMode
            ? AppTheme.textSecondaryDark
            : AppTheme.textSecondaryLight;
    }
  }

  Color _getFuelLevelColor(double fuelLevel, bool isDarkMode) {
    if (fuelLevel > 50) {
      return isDarkMode ? AppTheme.successDark : AppTheme.successLight;
    } else if (fuelLevel > 20) {
      return isDarkMode ? AppTheme.warningDark : AppTheme.warningLight;
    } else {
      return isDarkMode ? AppTheme.errorDark : AppTheme.errorLight;
    }
  }
}
