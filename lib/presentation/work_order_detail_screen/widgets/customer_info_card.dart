import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/app_export.dart';

class CustomerInfoCard extends StatelessWidget {
  final Map<String, dynamic> workOrder;

  const CustomerInfoCard({
    Key? key,
    required this.workOrder,
  }) : super(key: key);

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    }
  }

  Future<void> _openWhatsApp(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'https',
      host: 'wa.me',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    }
  }

  Future<void> _openMaps(String address) async {
    final Uri launchUri = Uri(
      scheme: 'https',
      host: 'maps.google.com',
      queryParameters: {'q': address},
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final customer = workOrder['customer'] as Map<String, dynamic>;

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
                  iconName: 'person',
                  color: AppTheme.lightTheme.primaryColor,
                  size: 6.w,
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: Text(
                    'Customer Information',
                    style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 3.h),

            // Customer Name
            Text(
              customer['name'] as String,
              style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 1.h),

            // Contact Information
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Phone: ${customer['phone']}',
                        style: AppTheme.lightTheme.textTheme.bodyMedium,
                      ),
                      SizedBox(height: 0.5.h),
                      Text(
                        'Email: ${customer['email']}',
                        style: AppTheme.lightTheme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () =>
                          _makePhoneCall(customer['phone'] as String),
                      icon: CustomIconWidget(
                        iconName: 'phone',
                        color: AppTheme.lightTheme.primaryColor,
                        size: 6.w,
                      ),
                      style: IconButton.styleFrom(
                        backgroundColor: AppTheme.lightTheme.primaryColor
                            .withValues(alpha: 0.1),
                        padding: EdgeInsets.all(2.w),
                      ),
                    ),
                    SizedBox(width: 2.w),
                    IconButton(
                      onPressed: () =>
                          _openWhatsApp(customer['phone'] as String),
                      icon: CustomIconWidget(
                        iconName: 'chat',
                        color: Colors.green,
                        size: 6.w,
                      ),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.green.withValues(alpha: 0.1),
                        padding: EdgeInsets.all(2.w),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 2.h),

            // Address with Map Button
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomIconWidget(
                  iconName: 'location_on',
                  color: AppTheme.lightTheme.colorScheme.secondary,
                  size: 5.w,
                ),
                SizedBox(width: 2.w),
                Expanded(
                  child: Text(
                    customer['address'] as String,
                    style: AppTheme.lightTheme.textTheme.bodyMedium,
                  ),
                ),
                TextButton.icon(
                  onPressed: () => _openMaps(customer['address'] as String),
                  icon: CustomIconWidget(
                    iconName: 'map',
                    color: AppTheme.lightTheme.primaryColor,
                    size: 4.w,
                  ),
                  label: Text(
                    'Navigate',
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
