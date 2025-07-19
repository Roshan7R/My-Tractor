import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class SettingsItemWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String icon;
  final VoidCallback onTap;
  final bool showArrow;
  final bool isDestructive;

  const SettingsItemWidget({
    super.key,
    required this.title,
    this.subtitle,
    required this.icon,
    required this.onTap,
    this.showArrow = true,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: EdgeInsets.only(bottom: 1.h),
      decoration: BoxDecoration(
        color: isDarkMode ? AppTheme.cardDark : AppTheme.cardLight,
        borderRadius: BorderRadius.circular(3.w),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? AppTheme.shadowDark : AppTheme.shadowLight,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(3.w),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(3.w),
          child: Padding(
            padding: EdgeInsets.all(4.w),
            child: Row(
              children: [
                // Icon
                Container(
                  padding: EdgeInsets.all(2.5.w),
                  decoration: BoxDecoration(
                    color: isDestructive
                        ? (isDarkMode
                                ? AppTheme.errorDark
                                : AppTheme.errorLight)
                            .withValues(alpha: 0.1)
                        : (isDarkMode
                                ? AppTheme.primaryDark
                                : AppTheme.primaryLight)
                            .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(2.w),
                  ),
                  child: CustomIconWidget(
                    iconName: icon,
                    color: isDestructive
                        ? (isDarkMode
                            ? AppTheme.errorDark
                            : AppTheme.errorLight)
                        : (isDarkMode
                            ? AppTheme.primaryDark
                            : AppTheme.primaryLight),
                    size: 20,
                  ),
                ),

                SizedBox(width: 4.w),

                // Title and Subtitle
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: isDestructive
                                  ? (isDarkMode
                                      ? AppTheme.errorDark
                                      : AppTheme.errorLight)
                                  : (isDarkMode
                                      ? AppTheme.textPrimaryDark
                                      : AppTheme.textPrimaryLight),
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      if (subtitle != null) ...[
                        SizedBox(height: 0.5.h),
                        Text(
                          subtitle!,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: isDarkMode
                                        ? AppTheme.textSecondaryDark
                                        : AppTheme.textSecondaryLight,
                                  ),
                        ),
                      ],
                    ],
                  ),
                ),

                // Arrow Icon
                if (showArrow)
                  CustomIconWidget(
                    iconName: 'chevron_right',
                    color: isDarkMode
                        ? AppTheme.textSecondaryDark
                        : AppTheme.textSecondaryLight,
                    size: 16,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
