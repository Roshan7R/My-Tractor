import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class DriverStatsWidget extends StatelessWidget {
  final List<Map<String, dynamic>> drivers;

  const DriverStatsWidget({
    Key? key,
    required this.drivers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stats = _calculateStats();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildStatItem(
            icon: 'people',
            label: 'Total',
            value: stats['total'].toString(),
            color: AppTheme.lightTheme.colorScheme.primary,
          ),
          _buildDivider(),
          _buildStatItem(
            icon: 'check_circle',
            label: 'Available',
            value: stats['available'].toString(),
            color: AppTheme.lightTheme.colorScheme.primary,
          ),
          _buildDivider(),
          _buildStatItem(
            icon: 'work',
            label: 'On Duty',
            value: stats['onDuty'].toString(),
            color: const Color(0xFFF57C00),
          ),
          _buildDivider(),
          _buildStatItem(
            icon: 'cancel',
            label: 'Off Duty',
            value: stats['offDuty'].toString(),
            color: AppTheme.lightTheme.colorScheme.error,
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required String icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Expanded(
      child: Column(
        children: [
          CustomIconWidget(
            iconName: icon,
            color: color,
            size: 6.w,
          ),
          SizedBox(height: 1.h),
          Text(
            value,
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          Text(
            label,
            style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 1,
      height: 8.h,
      color: AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.3),
      margin: EdgeInsets.symmetric(horizontal: 2.w),
    );
  }

  Map<String, int> _calculateStats() {
    int total = drivers.length;
    int available = 0;
    int onDuty = 0;
    int offDuty = 0;

    for (final driver in drivers) {
      final status = driver['status']?.toString().toLowerCase() ?? '';
      switch (status) {
        case 'available':
          available++;
          break;
        case 'assigned':
        case 'on_duty':
          onDuty++;
          break;
        case 'unavailable':
        case 'off_duty':
          offDuty++;
          break;
      }
    }

    return {
      'total': total,
      'available': available,
      'onDuty': onDuty,
      'offDuty': offDuty,
    };
  }
}
