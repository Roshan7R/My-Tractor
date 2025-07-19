import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/app_export.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDarkMode ? AppTheme.backgroundDark : AppTheme.backgroundLight,
      appBar: AppBar(
        title: const Text('About'),
        centerTitle: true,
        elevation: 2,
        backgroundColor:
            isDarkMode ? AppTheme.surfaceDark : AppTheme.surfaceLight,
        foregroundColor:
            isDarkMode ? AppTheme.onSurfaceDark : AppTheme.onSurfaceLight,
        leading: IconButton(
          icon: CustomIconWidget(
            iconName: 'arrow_back',
            color:
                isDarkMode ? AppTheme.onSurfaceDark : AppTheme.onSurfaceLight,
            size: 24,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Column(
            children: [
              SizedBox(height: 4.h),

              // App Logo and Name Section
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(6.w),
                decoration: BoxDecoration(
                  color: isDarkMode ? AppTheme.cardDark : AppTheme.cardLight,
                  borderRadius: BorderRadius.circular(3.w),
                  boxShadow: [
                    BoxShadow(
                      color: isDarkMode
                          ? AppTheme.shadowDark
                          : AppTheme.shadowLight,
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // App Logo
                    Container(
                      width: 20.w,
                      height: 20.w,
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? AppTheme.primaryDark
                            : AppTheme.primaryLight,
                        borderRadius: BorderRadius.circular(3.w),
                        boxShadow: [
                          BoxShadow(
                            color: (isDarkMode
                                    ? AppTheme.primaryDark
                                    : AppTheme.primaryLight)
                                .withValues(alpha: 0.3),
                            blurRadius: 15,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/images/img_app_logo.svg',
                          width: 12.w,
                          height: 12.w,
                          colorFilter: ColorFilter.mode(
                            isDarkMode
                                ? AppTheme.onPrimaryDark
                                : AppTheme.onPrimaryLight,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 3.h),

                    // App Name
                    ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: isDarkMode
                            ? [
                                AppTheme.primaryDark,
                                AppTheme.secondaryDark,
                              ]
                            : [
                                AppTheme.primaryLight,
                                AppTheme.secondaryLight,
                              ],
                      ).createShader(bounds),
                      child: Text(
                        'My Tractor',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 1.0,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    SizedBox(height: 1.h),

                    // Version
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 4.w,
                        vertical: 1.h,
                      ),
                      decoration: BoxDecoration(
                        color: (isDarkMode
                                ? AppTheme.primaryDark
                                : AppTheme.primaryLight)
                            .withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(2.w),
                        border: Border.all(
                          color: isDarkMode
                              ? AppTheme.primaryDark
                              : AppTheme.primaryLight,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        'Version 1.0.0',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: isDarkMode
                                  ? AppTheme.primaryDark
                                  : AppTheme.primaryLight,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 4.h),

              // App Description Section
              _buildInfoCard(
                context,
                isDarkMode,
                title: 'About the App',
                content:
                    'My Tractor is a comprehensive agricultural equipment management system designed to help farmers and agricultural businesses efficiently track, monitor, and manage their machinery and equipment.',
                icon: 'info',
              ),

              SizedBox(height: 3.h),

              // Credits Section
              _buildInfoCard(
                context,
                isDarkMode,
                title: 'Credits',
                content: 'Created with ❤️ by Roshan & Papun',
                icon: 'favorite',
                isCredits: true,
              ),

              SizedBox(height: 3.h),

              // Owner Information Section
              _buildInfoCard(
                context,
                isDarkMode,
                title: 'Owner',
                content: 'Ramesh',
                icon: 'person',
                isOwner: true,
              ),

              SizedBox(height: 3.h),

              // Management Section
              _buildInfoCard(
                context,
                isDarkMode,
                title: 'Management',
                content: 'Professionally managed by Mansingh',
                icon: 'business_center',
                isManagement: true,
              ),

              SizedBox(height: 3.h),

              // Additional Information Section
              _buildInfoCard(
                context,
                isDarkMode,
                title: 'Features',
                content:
                    '• Equipment tracking and monitoring\n• Work order management\n• Maintenance scheduling\n• Driver management\n• Reports and analytics\n• Real-time notifications',
                icon: 'featured_play_list',
              ),

              SizedBox(height: 3.h),

              // Contact and Legal Section
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: isDarkMode ? AppTheme.cardDark : AppTheme.cardLight,
                  borderRadius: BorderRadius.circular(3.w),
                  boxShadow: [
                    BoxShadow(
                      color: isDarkMode
                          ? AppTheme.shadowDark
                          : AppTheme.shadowLight,
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Contact Support
                    _buildActionTile(
                      context,
                      isDarkMode,
                      title: 'Contact Support',
                      icon: 'contact_support',
                      onTap: () => _launchEmail(),
                    ),

                    Divider(
                      color: isDarkMode
                          ? AppTheme.neutralBorderDark
                          : AppTheme.neutralBorderLight,
                      height: 3.h,
                    ),

                    // Privacy Policy
                    _buildActionTile(
                      context,
                      isDarkMode,
                      title: 'Privacy Policy',
                      icon: 'privacy_tip',
                      onTap: () => _showPrivacyPolicy(context),
                    ),

                    Divider(
                      color: isDarkMode
                          ? AppTheme.neutralBorderDark
                          : AppTheme.neutralBorderLight,
                      height: 3.h,
                    ),

                    // Terms of Service
                    _buildActionTile(
                      context,
                      isDarkMode,
                      title: 'Terms of Service',
                      icon: 'gavel',
                      onTap: () => _showTermsOfService(context),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 4.h),

              // Copyright Section
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(4.w),
                child: Text(
                  '© 2025 My Tractor. All rights reserved.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: isDarkMode
                            ? AppTheme.textSecondaryDark.withValues(alpha: 0.7)
                            : AppTheme.textSecondaryLight
                                .withValues(alpha: 0.7),
                      ),
                  textAlign: TextAlign.center,
                ),
              ),

              SizedBox(height: 4.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context,
    bool isDarkMode, {
    required String title,
    required String content,
    required String icon,
    bool isCredits = false,
    bool isOwner = false,
    bool isManagement = false,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: isDarkMode ? AppTheme.cardDark : AppTheme.cardLight,
        borderRadius: BorderRadius.circular(3.w),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? AppTheme.shadowDark : AppTheme.shadowLight,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  color: (isDarkMode
                          ? AppTheme.primaryDark
                          : AppTheme.primaryLight)
                      .withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(2.w),
                ),
                child: CustomIconWidget(
                  iconName: icon,
                  color:
                      isDarkMode ? AppTheme.primaryDark : AppTheme.primaryLight,
                  size: 20,
                ),
              ),
              SizedBox(width: 3.w),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isDarkMode
                          ? AppTheme.textPrimaryDark
                          : AppTheme.textPrimaryLight,
                    ),
              ),
            ],
          ),

          SizedBox(height: 2.h),

          // Content
          if (isCredits)
            Row(
              children: [
                Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: 16,
                ),
                SizedBox(width: 2.w),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: isDarkMode
                                ? AppTheme.textPrimaryDark
                                : AppTheme.textPrimaryLight,
                          ),
                      children: [
                        const TextSpan(text: 'Created with '),
                        const TextSpan(text: '❤️'),
                        const TextSpan(text: ' by '),
                        TextSpan(
                          text: 'Roshan & Papun',
                          style: TextStyle(
                            color: isDarkMode
                                ? AppTheme.primaryDark
                                : AppTheme.primaryLight,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          else if (isOwner)
            Row(
              children: [
                Container(
                  width: 8.w,
                  height: 8.w,
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? AppTheme.accentEarthDark
                        : AppTheme.accentEarthLight,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      'R',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: Text(
                    content,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: isDarkMode
                              ? AppTheme.textPrimaryDark
                              : AppTheme.textPrimaryLight,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ],
            )
          else if (isManagement)
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: isDarkMode
                          ? [AppTheme.primaryDark, AppTheme.secondaryDark]
                          : [AppTheme.primaryLight, AppTheme.secondaryLight],
                    ),
                    borderRadius: BorderRadius.circular(2.w),
                  ),
                  child: Text(
                    'PROFESSIONAL',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: Text(
                    content,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: isDarkMode
                              ? AppTheme.textPrimaryDark
                              : AppTheme.textPrimaryLight,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
              ],
            )
          else
            Text(
              content,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: isDarkMode
                        ? AppTheme.textPrimaryDark
                        : AppTheme.textPrimaryLight,
                    height: 1.5,
                  ),
            ),
        ],
      ),
    );
  }

  Widget _buildActionTile(
    BuildContext context,
    bool isDarkMode, {
    required String title,
    required String icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(2.w),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 1.5.h),
        child: Row(
          children: [
            CustomIconWidget(
              iconName: icon,
              color: isDarkMode
                  ? AppTheme.textSecondaryDark
                  : AppTheme.textSecondaryLight,
              size: 20,
            ),
            SizedBox(width: 4.w),
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: isDarkMode
                          ? AppTheme.textPrimaryDark
                          : AppTheme.textPrimaryLight,
                    ),
              ),
            ),
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
    );
  }

  void _launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'support@mytractor.com',
      query: 'subject=My Tractor App Support Request',
    );

    try {
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      }
    } catch (e) {
      // Handle error silently or show toast
    }
  }

  void _showPrivacyPolicy(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Privacy Policy'),
          content: const SingleChildScrollView(
            child: Text(
              'We value your privacy and are committed to protecting your personal information. This app collects minimal data necessary for equipment management functionality. No personal data is shared with third parties without your consent.',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showTermsOfService(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Terms of Service'),
          content: const SingleChildScrollView(
            child: Text(
              'By using My Tractor app, you agree to use it responsibly for agricultural equipment management. The app is provided as-is without warranties. Users are responsible for data accuracy and equipment safety.',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
