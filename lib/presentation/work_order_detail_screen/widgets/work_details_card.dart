import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class WorkDetailsCard extends StatelessWidget {
  final Map<String, dynamic> workOrder;

  const WorkDetailsCard({
    Key? key,
    required this.workOrder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CustomIconWidget(
                  iconName: 'work',
                  color: AppTheme.lightTheme.primaryColor,
                  size: 6.w,
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: Text(
                    'Work Details',
                    style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 3.h),

            // Equipment Assigned
            _buildDetailRow(
              'Equipment',
              workOrder['equipment'] as String,
              'agriculture',
            ),
            SizedBox(height: 2.h),

            // Operator Name
            _buildDetailRow(
              'Operator',
              workOrder['operator'] as String,
              'person_outline',
            ),
            SizedBox(height: 2.h),

            // Scheduled Time
            _buildDetailRow(
              'Scheduled Time',
              workOrder['scheduledTime'] as String,
              'schedule',
            ),
            SizedBox(height: 2.h),

            // Estimated Duration
            _buildDetailRow(
              'Estimated Duration',
              '${workOrder['estimatedHours']} hours',
              'timer',
            ),
            SizedBox(height: 2.h),

            // Hourly Rate
            _buildDetailRow(
              'Hourly Rate',
              '₹${workOrder['hourlyRate']}/hour',
              'currency_rupee',
            ),
            SizedBox(height: 2.h),

            // Work Type
            _buildDetailRow(
              'Work Type',
              workOrder['workType'] as String,
              'category',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, String iconName) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomIconWidget(
          iconName: iconName,
          color: AppTheme.lightTheme.colorScheme.secondary,
          size: 5.w,
        ),
        SizedBox(width: 3.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                ),
              ),
              SizedBox(height: 0.5.h),
              Text(
                value,
                style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
