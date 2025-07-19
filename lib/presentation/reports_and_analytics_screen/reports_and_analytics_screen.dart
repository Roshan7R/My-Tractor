import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/date_range_selector_widget.dart';
import './widgets/equipment_utilization_widget.dart';
import './widgets/export_share_widget.dart';
import './widgets/filter_options_widget.dart';
import './widgets/fuel_consumption_widget.dart';
import './widgets/labor_cost_breakdown_widget.dart';
import './widgets/metric_card_widget.dart';
import './widgets/revenue_chart_widget.dart';

class ReportsAndAnalyticsScreen extends StatefulWidget {
  const ReportsAndAnalyticsScreen({Key? key}) : super(key: key);

  @override
  State<ReportsAndAnalyticsScreen> createState() =>
      _ReportsAndAnalyticsScreenState();
}

class _ReportsAndAnalyticsScreenState extends State<ReportsAndAnalyticsScreen> {
  String selectedDateRange = 'Month';
  Map<String, dynamic> activeFilters = {
    'equipmentType': 'All',
    'operator': 'All',
    'project': 'All',
  };
  bool isOfflineMode = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
  }

  void _checkConnectivity() {
    // Simulate connectivity check
    setState(() {
      isOfflineMode = false; // Set to true to test offline mode
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      appBar: _buildAppBar(),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        color: AppTheme.lightTheme.colorScheme.primary,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isOfflineMode) _buildOfflineIndicator(),
              DateRangeSelectorWidget(
                selectedRange: selectedDateRange,
                onDateRangeChanged: _onDateRangeChanged,
              ),
              SizedBox(height: 3.h),
              _buildMetricsSection(),
              SizedBox(height: 3.h),
              RevenueChartWidget(selectedRange: selectedDateRange),
              SizedBox(height: 3.h),
              const EquipmentUtilizationWidget(),
              SizedBox(height: 3.h),
              const FuelConsumptionWidget(),
              SizedBox(height: 3.h),
              const LaborCostBreakdownWidget(),
              SizedBox(height: 3.h),
              FilterOptionsWidget(
                onFiltersChanged: _onFiltersChanged,
              ),
              SizedBox(height: 3.h),
              ExportShareWidget(
                onExportPDF: _exportPDF,
                onExportCSV: _exportCSV,
                onShare: _shareReport,
              ),
              SizedBox(height: 2.h),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showVoiceCommands,
        backgroundColor: AppTheme.lightTheme.colorScheme.secondary,
        foregroundColor: AppTheme.lightTheme.colorScheme.onSecondary,
        icon: CustomIconWidget(
          iconName: 'mic',
          color: AppTheme.lightTheme.colorScheme.onSecondary,
          size: 5.w,
        ),
        label: Text(
          'Voice Query',
          style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
            color: AppTheme.lightTheme.colorScheme.onSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppTheme.lightTheme.colorScheme.primary,
      foregroundColor: AppTheme.lightTheme.colorScheme.onPrimary,
      elevation: 0,
      centerTitle: true,
      title: Text(
        'Reports & Analytics',
        style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
          color: AppTheme.lightTheme.colorScheme.onPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        IconButton(
          onPressed: _showFilterBottomSheet,
          icon: CustomIconWidget(
            iconName: 'filter_list',
            color: AppTheme.lightTheme.colorScheme.onPrimary,
            size: 6.w,
          ),
        ),
        IconButton(
          onPressed: _showMoreOptions,
          icon: CustomIconWidget(
            iconName: 'more_vert',
            color: AppTheme.lightTheme.colorScheme.onPrimary,
            size: 6.w,
          ),
        ),
      ],
    );
  }

  Widget _buildOfflineIndicator() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(3.w),
      margin: EdgeInsets.only(bottom: 2.h),
      decoration: BoxDecoration(
        color: AppTheme.warningLight.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppTheme.warningLight.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          CustomIconWidget(
            iconName: 'wifi_off',
            color: AppTheme.warningLight,
            size: 5.w,
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Offline Mode',
                  style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.warningLight,
                  ),
                ),
                Text(
                  'Showing cached reports. Connect to sync latest data.',
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Key Metrics',
          style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppTheme.lightTheme.colorScheme.onSurface,
          ),
        ),
        SizedBox(height: 2.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              MetricCardWidget(
                title: 'Total Revenue',
                value: '₹3,45,000',
                subtitle: 'This month',
                iconName: 'account_balance_wallet',
                cardColor: AppTheme.lightTheme.colorScheme.surface,
                iconColor: AppTheme.successLight,
                trend: '+12%',
                isPositiveTrend: true,
              ),
              SizedBox(width: 3.w),
              MetricCardWidget(
                title: 'Equipment Utilization',
                value: '78%',
                subtitle: 'Average efficiency',
                iconName: 'agriculture',
                cardColor: AppTheme.lightTheme.colorScheme.surface,
                iconColor: AppTheme.lightTheme.colorScheme.primary,
                trend: '+5%',
                isPositiveTrend: true,
              ),
              SizedBox(width: 3.w),
              MetricCardWidget(
                title: 'Fuel Consumption',
                value: '1,245L',
                subtitle: 'Total this month',
                iconName: 'local_gas_station',
                cardColor: AppTheme.lightTheme.colorScheme.surface,
                iconColor: AppTheme.warningLight,
                trend: '+15%',
                isPositiveTrend: false,
              ),
              SizedBox(width: 3.w),
              MetricCardWidget(
                title: 'Profit Margin',
                value: '24%',
                subtitle: 'After all costs',
                iconName: 'trending_up',
                cardColor: AppTheme.lightTheme.colorScheme.surface,
                iconColor: AppTheme.successLight,
                trend: '+8%',
                isPositiveTrend: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _onDateRangeChanged(String range) {
    setState(() {
      selectedDateRange = range;
    });
    _showToast('Date range updated to $range');
  }

  void _onFiltersChanged(Map<String, dynamic> filters) {
    setState(() {
      activeFilters = filters;
    });
    _showToast('Filters applied successfully');
  }

  Future<void> _refreshData() async {
    setState(() {
      isLoading = true;
    });

    // Simulate data refresh
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });

    _showToast('Data refreshed successfully');
  }

  void _exportPDF() {
    _showToast('Generating PDF report...');
    // Simulate PDF generation
    Future.delayed(const Duration(seconds: 2), () {
      _showToast('PDF report generated successfully');
    });
  }

  void _exportCSV() {
    _showToast('Exporting CSV data...');
    // Simulate CSV export
    Future.delayed(const Duration(seconds: 1), () {
      _showToast('CSV data exported successfully');
    });
  }

  void _shareReport() {
    _showToast('Opening WhatsApp to share report...');
    // Simulate WhatsApp sharing
  }

  void _showVoiceCommands() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.lightTheme.colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(6.w),
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
            SizedBox(height: 3.h),
            Text(
              'Voice Commands',
              style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppTheme.lightTheme.colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 2.h),
            _buildVoiceCommand('Show revenue for this month'),
            _buildVoiceCommand('Equipment utilization report'),
            _buildVoiceCommand('Fuel consumption analysis'),
            _buildVoiceCommand('Export PDF report'),
            SizedBox(height: 3.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  _showToast('Listening for voice command...');
                },
                icon: CustomIconWidget(
                  iconName: 'mic',
                  color: AppTheme.lightTheme.colorScheme.onPrimary,
                  size: 5.w,
                ),
                label: Text(
                  'Start Voice Command',
                  style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.onPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVoiceCommand(String command) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(3.w),
      margin: EdgeInsets.only(bottom: 1.h),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          CustomIconWidget(
            iconName: 'record_voice_over',
            color: AppTheme.lightTheme.colorScheme.primary,
            size: 4.w,
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Text(
              '"$command"',
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurface,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.lightTheme.colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          padding: EdgeInsets.all(6.w),
          child: FilterOptionsWidget(
            onFiltersChanged: (filters) {
              _onFiltersChanged(filters);
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }

  void _showMoreOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.lightTheme.colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(6.w),
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
            SizedBox(height: 3.h),
            _buildOptionTile(
              iconName: 'settings',
              title: 'Report Settings',
              subtitle: 'Customize report preferences',
              onTap: () {
                Navigator.pop(context);
                _showToast('Opening report settings...');
              },
            ),
            _buildOptionTile(
              iconName: 'schedule',
              title: 'Schedule Reports',
              subtitle: 'Set up automatic report generation',
              onTap: () {
                Navigator.pop(context);
                _showToast('Opening schedule settings...');
              },
            ),
            _buildOptionTile(
              iconName: 'help_outline',
              title: 'Help & Support',
              subtitle: 'Learn about reports and analytics',
              onTap: () {
                Navigator.pop(context);
                _showToast('Opening help section...');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionTile({
    required String iconName,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(2.w),
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: CustomIconWidget(
          iconName: iconName,
          color: AppTheme.lightTheme.colorScheme.primary,
          size: 5.w,
        ),
      ),
      title: Text(
        title,
        style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: AppTheme.lightTheme.colorScheme.onSurface,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
          color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
        ),
      ),
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
    );
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppTheme.lightTheme.colorScheme.inverseSurface,
      textColor: AppTheme.lightTheme.colorScheme.onInverseSurface,
      fontSize: 14.0,
    );
  }
}
