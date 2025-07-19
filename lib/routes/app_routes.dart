import 'package:flutter/material.dart';

import '../presentation/about_screen/about_screen.dart';
import '../presentation/construction_projects_screen/construction_projects_screen.dart';
import '../presentation/driver_management_screen/driver_management_screen.dart';
import '../presentation/equipment_dashboard/equipment_dashboard.dart';
import '../presentation/reports_and_analytics_screen/reports_and_analytics_screen.dart';
import '../presentation/settings_screen/settings_screen.dart';
import '../presentation/splash_screen/splash_screen.dart';
import '../presentation/work_order_detail_screen/work_order_detail_screen.dart';
import '../presentation/work_orders_screen/work_orders_screen.dart';

class AppRoutes {
  // TODO: Add your routes here
  static const String initial = '/';
  static const String splashScreen = '/splash-screen';
  static const String equipmentDashboard = '/equipment-dashboard';
  static const String driverManagementScreen = '/driver-management-screen';
  static const String workOrderDetailScreen = '/work-order-detail-screen';
  static const String workOrdersScreen = '/work-orders-screen';
  static const String constructionProjectsScreen =
      '/construction-projects-screen';
  static const String reportsAndAnalyticsScreen =
      '/reports-and-analytics-screen';
  static const String aboutScreen = '/about-screen';
  static const String settingsScreen = '/settings-screen';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => const SplashScreen(),
    splashScreen: (context) => const SplashScreen(),
    equipmentDashboard: (context) => const EquipmentDashboard(),
    driverManagementScreen: (context) => const DriverManagementScreen(),
    workOrderDetailScreen: (context) => const WorkOrderDetailScreen(),
    workOrdersScreen: (context) => const WorkOrdersScreen(),
    constructionProjectsScreen: (context) => const ConstructionProjectsScreen(),
    reportsAndAnalyticsScreen: (context) => const ReportsAndAnalyticsScreen(),
    aboutScreen: (context) => const AboutScreen(),
    settingsScreen: (context) => const SettingsScreen(),
    // TODO: Add your other routes here
  };
}
