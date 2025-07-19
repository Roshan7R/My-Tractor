import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class BottomActionBar extends StatelessWidget {
  final Map<String, dynamic> workOrder;
  final VoidCallback onUpdateStatus;
  final VoidCallback onAddPhotos;
  final VoidCallback onRecordVoice;
  final VoidCallback onGenerateInvoice;
  final VoidCallback onShare;

  const BottomActionBar({
    Key? key,
    required this.workOrder,
    required this.onUpdateStatus,
    required this.onAddPhotos,
    required this.onRecordVoice,
    required this.onGenerateInvoice,
    required this.onShare,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Primary Actions Row
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: onUpdateStatus,
                    icon: CustomIconWidget(
                      iconName: 'update',
                      color: Colors.white,
                      size: 4.w,
                    ),
                    label: Text(
                      'Update Status',
                      style: TextStyle(fontSize: 12.sp),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                    ),
                  ),
                ),
                SizedBox(width: 2.w),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onGenerateInvoice,
                    icon: CustomIconWidget(
                      iconName: 'receipt',
                      color: AppTheme.lightTheme.primaryColor,
                      size: 4.w,
                    ),
                    label: Text(
                      'Invoice',
                      style: TextStyle(fontSize: 12.sp),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),

            // Secondary Actions Row
            Row(
              children: [
                Expanded(
                  child: _buildActionButton(
                    onPressed: onAddPhotos,
                    icon: 'add_a_photo',
                    label: 'Photos',
                  ),
                ),
                SizedBox(width: 2.w),
                Expanded(
                  child: _buildActionButton(
                    onPressed: onRecordVoice,
                    icon: 'mic',
                    label: 'Voice Note',
                  ),
                ),
                SizedBox(width: 2.w),
                Expanded(
                  child: _buildActionButton(
                    onPressed: onShare,
                    icon: 'share',
                    label: 'Share',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required VoidCallback onPressed,
    required String icon,
    required String label,
  }) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: CustomIconWidget(
        iconName: icon,
        color: AppTheme.lightTheme.primaryColor,
        size: 4.w,
      ),
      label: Text(
        label,
        style: TextStyle(
          fontSize: 11.sp,
          color: AppTheme.lightTheme.primaryColor,
        ),
      ),
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 1.5.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
            color: AppTheme.lightTheme.primaryColor.withValues(alpha: 0.3),
          ),
        ),
      ),
    );
  }
}
