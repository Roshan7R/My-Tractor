import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late AnimationController _progressController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _progressAnimation;

  double _loadingProgress = 0.0;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startSplashSequence();
  }

  void _initializeAnimations() {
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _progressController = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    ));

    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _progressController,
      curve: Curves.easeInOut,
    ));
  }

  void _startSplashSequence() async {
    // Start fade animation
    _fadeController.forward();

    // Start scale animation after slight delay
    await Future.delayed(const Duration(milliseconds: 300));
    _scaleController.forward();

    // Start progress animation
    await Future.delayed(const Duration(milliseconds: 500));
    _progressController.forward();

    // Update loading progress
    _progressController.addListener(() {
      setState(() {
        _loadingProgress = _progressAnimation.value;
      });
    });

    // Navigate to dashboard after loading completes
    await Future.delayed(const Duration(milliseconds: 3000));
    if (mounted) {
      Navigator.pushReplacementNamed(context, AppRoutes.equipmentDashboard);
    }
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDarkMode
                ? [
                    AppTheme.backgroundDark,
                    AppTheme.primaryVariantDark.withValues(alpha: 0.3),
                    AppTheme.backgroundDark,
                  ]
                : [
                    AppTheme.backgroundLight,
                    AppTheme.primaryVariantLight.withValues(alpha: 0.1),
                    AppTheme.backgroundLight,
                  ],
          ),
        ),
        child: SafeArea(
          child: AnimatedBuilder(
            animation: _fadeAnimation,
            builder: (context, child) {
              return Opacity(
                opacity: _fadeAnimation.value,
                child: Column(
                  children: [
                    // Top spacer
                    SizedBox(height: 15.h),

                    // App Logo and Name Section
                    Expanded(
                      flex: 3,
                      child: AnimatedBuilder(
                        animation: _scaleAnimation,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _scaleAnimation.value,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // App Logo
                                Container(
                                  width: 25.w,
                                  height: 25.w,
                                  decoration: BoxDecoration(
                                    color: isDarkMode
                                        ? AppTheme.primaryDark
                                        : AppTheme.primaryLight,
                                    borderRadius: BorderRadius.circular(4.w),
                                    boxShadow: [
                                      BoxShadow(
                                        color: (isDarkMode
                                                ? AppTheme.primaryDark
                                                : AppTheme.primaryLight)
                                            .withValues(alpha: 0.3),
                                        blurRadius: 20,
                                        spreadRadius: 5,
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      'assets/images/img_app_logo.svg',
                                      width: 15.w,
                                      height: 15.w,
                                      colorFilter: ColorFilter.mode(
                                        isDarkMode
                                            ? AppTheme.onPrimaryDark
                                            : AppTheme.onPrimaryLight,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(height: 4.h),

                                // App Name with Glow Effect
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
                                        .displayMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          letterSpacing: 2.0,
                                        ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),

                                SizedBox(height: 2.h),

                                // Tagline
                                Text(
                                  'Agricultural Equipment Management',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        color: isDarkMode
                                            ? AppTheme.textSecondaryDark
                                            : AppTheme.textSecondaryLight,
                                        letterSpacing: 0.5,
                                      ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),

                    // Loading Section
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Loading Indicator
                          SizedBox(
                            width: 60.w,
                            child: Column(
                              children: [
                                // Progress Bar
                                Container(
                                  height: 4,
                                  decoration: BoxDecoration(
                                    color: (isDarkMode
                                            ? AppTheme.neutralBorderDark
                                            : AppTheme.neutralBorderLight)
                                        .withValues(alpha: 0.3),
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                  child: AnimatedBuilder(
                                    animation: _progressAnimation,
                                    builder: (context, child) {
                                      return LinearProgressIndicator(
                                        value: _progressAnimation.value,
                                        backgroundColor: Colors.transparent,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          isDarkMode
                                              ? AppTheme.primaryDark
                                              : AppTheme.primaryLight,
                                        ),
                                        minHeight: 4,
                                      );
                                    },
                                  ),
                                ),

                                SizedBox(height: 2.h),

                                // Loading Text with Percentage
                                AnimatedBuilder(
                                  animation: _progressAnimation,
                                  builder: (context, child) {
                                    return Text(
                                      'Loading... ${(_loadingProgress * 100).toInt()}%',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            color: isDarkMode
                                                ? AppTheme.textSecondaryDark
                                                : AppTheme.textSecondaryLight,
                                          ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Bottom Section with Version
                    Container(
                      padding: EdgeInsets.only(bottom: 4.h),
                      child: Column(
                        children: [
                          // Version Number
                          Text(
                            'Version 1.0.0',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: isDarkMode
                                          ? AppTheme.textSecondaryDark
                                              .withValues(alpha: 0.7)
                                          : AppTheme.textSecondaryLight
                                              .withValues(alpha: 0.7),
                                    ),
                          ),

                          SizedBox(height: 1.h),

                          // Agricultural Pattern Background (Optional)
                          Container(
                            width: 30.w,
                            height: 1,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  (isDarkMode
                                          ? AppTheme.primaryDark
                                          : AppTheme.primaryLight)
                                      .withValues(alpha: 0.3),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
