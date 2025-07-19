import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class WorkOrderCardWidget extends StatelessWidget {
  final Map<String, dynamic> workOrder;
  final VoidCallback? onTap;
  final VoidCallback? onStartWork;
  final VoidCallback? onCallCustomer;
  final VoidCallback? onViewLocation;
  final VoidCallback? onEdit;
  final VoidCallback? onCancel;

  const WorkOrderCardWidget({
    super.key,
    required this.workOrder,
    this.onTap,
    this.onStartWork,
    this.onCallCustomer,
    this.onViewLocation,
    this.onEdit,
    this.onCancel,
  });

  Color _getPriorityColor() {
    final priority = workOrder['priority'] as String? ?? 'normal';
    switch (priority.toLowerCase()) {
      case 'urgent':
        return Colors.red;
      case 'today':
        return Colors.orange;
      case 'scheduled':
        return Colors.green;
      default:
        return Colors.blue;
    }
  }

  String _getStatusText() {
    final status = workOrder['status'] as String? ?? 'pending';
    switch (status.toLowerCase()) {
      case 'active':
        return 'In Progress';
      case 'pending':
        return 'Pending';
      case 'completed':
        return 'Completed';
      default:
        return 'Unknown';
    }
  }

  Color _getStatusColor() {
    final status = workOrder['status'] as String? ?? 'pending';
    switch (status.toLowerCase()) {
      case 'active':
        return AppTheme.lightTheme.colorScheme.primary;
      case 'pending':
        return Colors.orange;
      case 'completed':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final customerName =
        workOrder['customerName'] as String? ?? 'Unknown Customer';
    final workType = workOrder['workType'] as String? ?? 'General Work';
    final location =
        workOrder['location'] as String? ?? 'Location not specified';
    final scheduledTime =
        workOrder['scheduledTime'] as String? ?? 'Time not set';
    final equipment =
        workOrder['equipment'] as String? ?? 'Equipment not assigned';
    final estimatedCost = workOrder['estimatedCost'] as String? ?? '₹0';

    return Dismissible(
      key: Key(workOrder['id'].toString()),
      background: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        decoration: BoxDecoration(
          color: Colors.green.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 6.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomIconWidget(
              iconName: 'play_arrow',
              color: Colors.green,
              size: 6.w,
            ),
            SizedBox(height: 0.5.h),
            Text(
              'Start Work',
              style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                color: Colors.green,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      secondaryBackground: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        decoration: BoxDecoration(
          color: Colors.red.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 6.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomIconWidget(
              iconName: 'edit',
              color: Colors.red,
              size: 6.w,
            ),
            SizedBox(height: 0.5.h),
            Text(
              'Edit',
              style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                color: Colors.red,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          onStartWork?.call();
        } else if (direction == DismissDirection.endToStart) {
          onEdit?.call();
        }
      },
      child: GestureDetector(
        onTap: onTap,
        onLongPress: () => _showContextMenu(context),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
          decoration: BoxDecoration(
            color: AppTheme.lightTheme.cardColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: IntrinsicHeight(
            child: Row(
              children: [
                // Priority indicator
                Container(
                  width: 1.w,
                  decoration: BoxDecoration(
                    color: _getPriorityColor(),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                  ),
                ),
                // Main content
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(4.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header row
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                customerName,
                                style: AppTheme.lightTheme.textTheme.titleMedium
                                    ?.copyWith(
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
                                color: _getStatusColor().withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                _getStatusText(),
                                style: AppTheme.lightTheme.textTheme.labelSmall
                                    ?.copyWith(
                                  color: _getStatusColor(),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.h),
                        // Work type and equipment
                        Row(
                          children: [
                            CustomIconWidget(
                              iconName: 'agriculture',
                              color: AppTheme.lightTheme.colorScheme.primary,
                              size: 4.w,
                            ),
                            SizedBox(width: 2.w),
                            Expanded(
                              child: Text(
                                '$workType • $equipment',
                                style: AppTheme.lightTheme.textTheme.bodyMedium
                                    ?.copyWith(
                                  color:
                                      AppTheme.lightTheme.colorScheme.primary,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.h),
                        // Location
                        Row(
                          children: [
                            CustomIconWidget(
                              iconName: 'location_on',
                              color: AppTheme
                                  .lightTheme.colorScheme.onSurfaceVariant,
                              size: 4.w,
                            ),
                            SizedBox(width: 2.w),
                            Expanded(
                              child: Text(
                                location,
                                style: AppTheme.lightTheme.textTheme.bodySmall,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.h),
                        // Time and cost
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  CustomIconWidget(
                                    iconName: 'schedule',
                                    color: AppTheme.lightTheme.colorScheme
                                        .onSurfaceVariant,
                                    size: 4.w,
                                  ),
                                  SizedBox(width: 2.w),
                                  Flexible(
                                    child: Text(
                                      scheduledTime,
                                      style: AppTheme
                                          .lightTheme.textTheme.bodySmall,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              estimatedCost,
                              style: AppTheme.currencyTextStyle(
                                isLight: true,
                                fontSize: 14.sp,
                              ).copyWith(
                                color: AppTheme.lightTheme.colorScheme.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.h),
                        // Action buttons
                        Row(
                          children: [
                            Expanded(
                              child: _buildActionButton(
                                context,
                                'Call',
                                'phone',
                                onCallCustomer,
                              ),
                            ),
                            SizedBox(width: 2.w),
                            Expanded(
                              child: _buildActionButton(
                                context,
                                'Location',
                                'map',
                                onViewLocation,
                              ),
                            ),
                            SizedBox(width: 2.w),
                            Expanded(
                              child: _buildActionButton(
                                context,
                                'Start',
                                'play_arrow',
                                onStartWork,
                                isPrimary: true,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String label,
    String iconName,
    VoidCallback? onPressed, {
    bool isPrimary = false,
  }) {
    return SizedBox(
      height: 5.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary
              ? AppTheme.lightTheme.colorScheme.primary
              : AppTheme.lightTheme.colorScheme.surface,
          foregroundColor: isPrimary
              ? AppTheme.lightTheme.colorScheme.onPrimary
              : AppTheme.lightTheme.colorScheme.onSurface,
          elevation: isPrimary ? 2 : 0,
          side: isPrimary
              ? null
              : BorderSide(
                  color: AppTheme.lightTheme.colorScheme.outline,
                  width: 1,
                ),
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomIconWidget(
              iconName: iconName,
              color: isPrimary
                  ? AppTheme.lightTheme.colorScheme.onPrimary
                  : AppTheme.lightTheme.colorScheme.onSurface,
              size: 3.5.w,
            ),
            SizedBox(width: 1.w),
            Flexible(
              child: Text(
                label,
                style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showContextMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.lightTheme.colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(4.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12.w,
              height: 0.5.h,
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.outline,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              'Work Order Actions',
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 2.h),
            _buildContextMenuItem(context, 'Duplicate Order', 'content_copy',
                () {
              Navigator.pop(context);
            }),
            _buildContextMenuItem(context, 'Reschedule', 'schedule', () {
              Navigator.pop(context);
            }),
            _buildContextMenuItem(context, 'Add Notes', 'note_add', () {
              Navigator.pop(context);
            }),
            _buildContextMenuItem(context, 'Cancel Order', 'cancel', () {
              Navigator.pop(context);
              onCancel?.call();
            }, isDestructive: true),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }

  Widget _buildContextMenuItem(
    BuildContext context,
    String title,
    String iconName,
    VoidCallback onTap, {
    bool isDestructive = false,
  }) {
    return ListTile(
      leading: CustomIconWidget(
        iconName: iconName,
        color: isDestructive
            ? Colors.red
            : AppTheme.lightTheme.colorScheme.onSurface,
        size: 5.w,
      ),
      title: Text(
        title,
        style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
          color: isDestructive
              ? Colors.red
              : AppTheme.lightTheme.colorScheme.onSurface,
        ),
      ),
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
