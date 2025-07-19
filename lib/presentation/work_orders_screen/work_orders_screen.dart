import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/work_order_card_widget.dart';
import './widgets/work_order_empty_state_widget.dart';
import './widgets/work_order_filter_tabs_widget.dart';
import './widgets/work_order_floating_action_widget.dart';
import './widgets/work_order_search_bar_widget.dart';

class WorkOrdersScreen extends StatefulWidget {
  const WorkOrdersScreen({super.key});

  @override
  State<WorkOrdersScreen> createState() => _WorkOrdersScreenState();
}

class _WorkOrdersScreenState extends State<WorkOrdersScreen>
    with TickerProviderStateMixin {
  int _selectedTabIndex = 0;
  String _searchQuery = '';
  late AnimationController _refreshController;

  // Mock data for work orders
  final List<Map<String, dynamic>> _allWorkOrders = [
    {
      "id": 1,
      "customerName": "Rajesh Kumar",
      "workType": "Rotavator Work",
      "location": "Village Rampur, Sector 12",
      "scheduledTime": "Today, 10:00 AM",
      "equipment": "John Deere 5310",
      "estimatedCost": "₹1,500",
      "priority": "urgent",
      "status": "active",
      "customerPhone": "+91 98765 43210",
      "notes": "Large field, estimated 3 hours work",
      "createdDate": "2025-01-19",
    },
    {
      "id": 2,
      "customerName": "Suresh Patel",
      "workType": "Transport Work",
      "location": "Grain Market, Highway Road",
      "scheduledTime": "Today, 2:00 PM",
      "equipment": "Tractor Trolley #1",
      "estimatedCost": "₹800",
      "priority": "today",
      "status": "pending",
      "customerPhone": "+91 87654 32109",
      "notes": "Transport wheat to market",
      "createdDate": "2025-01-19",
    },
    {
      "id": 3,
      "customerName": "Amit Singh",
      "workType": "Cultivator Work",
      "location": "Farm Plot 45, Village Greenfield",
      "scheduledTime": "Tomorrow, 8:00 AM",
      "equipment": "Sonalika Tractor",
      "estimatedCost": "₹1,200",
      "priority": "scheduled",
      "status": "pending",
      "customerPhone": "+91 76543 21098",
      "notes": "Pre-sowing cultivation required",
      "createdDate": "2025-01-18",
    },
    {
      "id": 4,
      "customerName": "Priya Sharma",
      "workType": "Rotavator Work",
      "location": "Agricultural College Road",
      "scheduledTime": "Yesterday, 3:00 PM",
      "equipment": "John Deere 5405",
      "estimatedCost": "₹2,000",
      "priority": "normal",
      "status": "completed",
      "customerPhone": "+91 65432 10987",
      "notes": "Completed successfully, payment received",
      "createdDate": "2025-01-17",
    },
    {
      "id": 5,
      "customerName": "Vikram Yadav",
      "workType": "Construction Support",
      "location": "New Housing Project, Phase 2",
      "scheduledTime": "Today, 4:00 PM",
      "equipment": "Concrete Mixer",
      "estimatedCost": "₹1,800",
      "priority": "urgent",
      "status": "active",
      "customerPhone": "+91 54321 09876",
      "notes": "Foundation work in progress",
      "createdDate": "2025-01-19",
    },
    {
      "id": 6,
      "customerName": "Deepak Verma",
      "workType": "Transport Work",
      "location": "Construction Site, Industrial Area",
      "scheduledTime": "Tomorrow, 11:00 AM",
      "equipment": "Pickup Vehicle",
      "estimatedCost": "₹600",
      "priority": "scheduled",
      "status": "pending",
      "customerPhone": "+91 43210 98765",
      "notes": "Material transport to site",
      "createdDate": "2025-01-18",
    },
  ];

  List<Map<String, dynamic>> get _filteredWorkOrders {
    List<Map<String, dynamic>> filtered = _allWorkOrders;

    // Filter by tab
    switch (_selectedTabIndex) {
      case 0: // Active
        filtered = filtered
            .where((order) => (order['status'] as String) == 'active')
            .toList();
        break;
      case 1: // Pending
        filtered = filtered
            .where((order) => (order['status'] as String) == 'pending')
            .toList();
        break;
      case 2: // Completed
        filtered = filtered
            .where((order) => (order['status'] as String) == 'completed')
            .toList();
        break;
    }

    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((order) {
        final customerName = (order['customerName'] as String).toLowerCase();
        final workType = (order['workType'] as String).toLowerCase();
        final location = (order['location'] as String).toLowerCase();
        final equipment = (order['equipment'] as String).toLowerCase();
        final query = _searchQuery.toLowerCase();

        return customerName.contains(query) ||
            workType.contains(query) ||
            location.contains(query) ||
            equipment.contains(query);
      }).toList();
    }

    return filtered;
  }

  List<Map<String, dynamic>> get _tabData {
    final activeCount = _allWorkOrders
        .where((order) => (order['status'] as String) == 'active')
        .length;
    final pendingCount = _allWorkOrders
        .where((order) => (order['status'] as String) == 'pending')
        .length;
    final completedCount = _allWorkOrders
        .where((order) => (order['status'] as String) == 'completed')
        .length;

    return [
      {'title': 'Active', 'count': activeCount},
      {'title': 'Pending', 'count': pendingCount},
      {'title': 'Completed', 'count': completedCount},
    ];
  }

  @override
  void initState() {
    super.initState();
    _refreshController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    _refreshController.forward();

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    _refreshController.reset();

    // Show success feedback
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Work orders updated successfully'),
          backgroundColor: AppTheme.lightTheme.colorScheme.primary,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
    }
  }

  void _handleVoiceSearch() {
    // Voice search implementation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Voice search activated - Say your command'),
        backgroundColor: AppTheme.lightTheme.colorScheme.secondary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  void _handleCreateOrder() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildCreateOrderBottomSheet(),
    );
  }

  void _handleQuickEntry() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.lightTheme.colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => _buildQuickEntryBottomSheet(),
    );
  }

  void _handleVoiceCommand() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Voice command ready - Speak your order details'),
        backgroundColor: AppTheme.lightTheme.colorScheme.secondary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Work Orders'),
        backgroundColor: AppTheme.lightTheme.colorScheme.primary,
        foregroundColor: AppTheme.lightTheme.colorScheme.onPrimary,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              // Filter options
              _showFilterOptions();
            },
            icon: CustomIconWidget(
              iconName: 'filter_list',
              color: AppTheme.lightTheme.colorScheme.onPrimary,
              size: 6.w,
            ),
          ),
          IconButton(
            onPressed: () {
              // More options
              _showMoreOptions();
            },
            icon: CustomIconWidget(
              iconName: 'more_vert',
              color: AppTheme.lightTheme.colorScheme.onPrimary,
              size: 6.w,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          WorkOrderSearchBarWidget(
            onSearchChanged: (query) {
              setState(() {
                _searchQuery = query;
              });
            },
            onVoiceSearch: _handleVoiceSearch,
          ),
          // Filter tabs
          WorkOrderFilterTabsWidget(
            selectedIndex: _selectedTabIndex,
            onTabChanged: (index) {
              setState(() {
                _selectedTabIndex = index;
              });
            },
            tabData: _tabData,
          ),
          // Work orders list
          Expanded(
            child: _filteredWorkOrders.isEmpty
                ? _buildEmptyState()
                : RefreshIndicator(
                    onRefresh: _handleRefresh,
                    color: AppTheme.lightTheme.colorScheme.primary,
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: _filteredWorkOrders.length,
                      itemBuilder: (context, index) {
                        final workOrder = _filteredWorkOrders[index];
                        return WorkOrderCardWidget(
                          workOrder: workOrder,
                          onTap: () => _navigateToWorkOrderDetail(workOrder),
                          onStartWork: () => _handleStartWork(workOrder),
                          onCallCustomer: () => _handleCallCustomer(workOrder),
                          onViewLocation: () => _handleViewLocation(workOrder),
                          onEdit: () => _handleEditOrder(workOrder),
                          onCancel: () => _handleCancelOrder(workOrder),
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
      floatingActionButton: WorkOrderFloatingActionWidget(
        onCreateOrder: _handleCreateOrder,
        onQuickEntry: _handleQuickEntry,
        onVoiceCommand: _handleVoiceCommand,
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildEmptyState() {
    String title, description, buttonText;

    switch (_selectedTabIndex) {
      case 0: // Active
        title = 'No Active Work Orders';
        description =
            'All work orders are either pending or completed. Start a new order to begin working.';
        buttonText = 'Create Work Order';
        break;
      case 1: // Pending
        title = 'No Pending Orders';
        description =
            'Great! All orders are either active or completed. Create new orders for upcoming work.';
        buttonText = 'Create Work Order';
        break;
      case 2: // Completed
        title = 'No Completed Orders';
        description =
            'Complete some work orders to see them here. Track your progress and earnings.';
        buttonText = 'View Active Orders';
        break;
      default:
        title = 'No Work Orders';
        description =
            'Start managing your agricultural work by creating your first order.';
        buttonText = 'Create First Order';
    }

    return WorkOrderEmptyStateWidget(
      title: title,
      description: description,
      buttonText: buttonText,
      onButtonPressed: _selectedTabIndex == 2
          ? () => setState(() => _selectedTabIndex = 0)
          : _handleCreateOrder,
      illustrationUrl:
          'https://images.unsplash.com/photo-1574943320219-553eb213f72d?w=500&h=300&fit=crop',
    );
  }

  Widget _buildCreateOrderBottomSheet() {
    return Container(
      height: 90.h,
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: EdgeInsets.only(top: 2.h),
            width: 12.w,
            height: 0.5.h,
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.outline,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // Header
          Padding(
            padding: EdgeInsets.all(4.w),
            child: Row(
              children: [
                Text(
                  'Create Work Order',
                  style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: CustomIconWidget(
                    iconName: 'close',
                    color: AppTheme.lightTheme.colorScheme.onSurface,
                    size: 6.w,
                  ),
                ),
              ],
            ),
          ),
          // Content
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Column(
                children: [
                  // Quick action buttons
                  Row(
                    children: [
                      Expanded(
                        child: _buildQuickActionCard(
                          'Rotavator Work',
                          'agriculture',
                          Colors.green,
                          () => Navigator.pop(context),
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Expanded(
                        child: _buildQuickActionCard(
                          'Transport',
                          'local_shipping',
                          Colors.blue,
                          () => Navigator.pop(context),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      Expanded(
                        child: _buildQuickActionCard(
                          'Construction',
                          'construction',
                          Colors.orange,
                          () => Navigator.pop(context),
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Expanded(
                        child: _buildQuickActionCard(
                          'Custom Work',
                          'build',
                          Colors.purple,
                          () => Navigator.pop(context),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  // Full form button
                  SizedBox(
                    width: double.infinity,
                    height: 6.h,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        // Navigate to full form
                      },
                      icon: CustomIconWidget(
                        iconName: 'edit',
                        color: AppTheme.lightTheme.colorScheme.primary,
                        size: 5.w,
                      ),
                      label: const Text('Create Detailed Order'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionCard(
      String title, String iconName, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 12.h,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomIconWidget(
              iconName: iconName,
              color: color,
              size: 8.w,
            ),
            SizedBox(height: 1.h),
            Text(
              title,
              style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickEntryBottomSheet() {
    return Container(
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
            'Quick Entry',
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 2.h),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Customer Name',
              hintText: 'Enter customer name',
            ),
          ),
          SizedBox(height: 2.h),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Work Type',
              hintText: 'Select work type',
            ),
          ),
          SizedBox(height: 2.h),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Location',
              hintText: 'Enter work location',
            ),
          ),
          SizedBox(height: 4.h),
          SizedBox(
            width: double.infinity,
            height: 6.h,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Create Order'),
            ),
          ),
          SizedBox(height: 2.h),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppTheme.lightTheme.colorScheme.surface,
      selectedItemColor: AppTheme.lightTheme.colorScheme.primary,
      unselectedItemColor: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
      currentIndex: 1, // Work Orders tab
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushReplacementNamed(context, '/equipment-dashboard');
            break;
          case 1:
            // Current screen
            break;
          case 2:
            Navigator.pushNamed(context, '/driver-management-screen');
            break;
          case 3:
            Navigator.pushNamed(context, '/construction-projects-screen');
            break;
          case 4:
            Navigator.pushNamed(context, '/reports-and-analytics-screen');
            break;
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: CustomIconWidget(
            iconName: 'dashboard',
            color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            size: 6.w,
          ),
          activeIcon: CustomIconWidget(
            iconName: 'dashboard',
            color: AppTheme.lightTheme.colorScheme.primary,
            size: 6.w,
          ),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: CustomIconWidget(
            iconName: 'assignment',
            color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            size: 6.w,
          ),
          activeIcon: CustomIconWidget(
            iconName: 'assignment',
            color: AppTheme.lightTheme.colorScheme.primary,
            size: 6.w,
          ),
          label: 'Work Orders',
        ),
        BottomNavigationBarItem(
          icon: CustomIconWidget(
            iconName: 'people',
            color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            size: 6.w,
          ),
          activeIcon: CustomIconWidget(
            iconName: 'people',
            color: AppTheme.lightTheme.colorScheme.primary,
            size: 6.w,
          ),
          label: 'Drivers',
        ),
        BottomNavigationBarItem(
          icon: CustomIconWidget(
            iconName: 'construction',
            color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            size: 6.w,
          ),
          activeIcon: CustomIconWidget(
            iconName: 'construction',
            color: AppTheme.lightTheme.colorScheme.primary,
            size: 6.w,
          ),
          label: 'Projects',
        ),
        BottomNavigationBarItem(
          icon: CustomIconWidget(
            iconName: 'analytics',
            color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            size: 6.w,
          ),
          activeIcon: CustomIconWidget(
            iconName: 'analytics',
            color: AppTheme.lightTheme.colorScheme.primary,
            size: 6.w,
          ),
          label: 'Reports',
        ),
      ],
    );
  }

  void _showFilterOptions() {
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
            Text(
              'Filter Options',
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 2.h),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'priority_high',
                color: Colors.red,
                size: 5.w,
              ),
              title: const Text('Urgent Orders'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'today',
                color: Colors.orange,
                size: 5.w,
              ),
              title: const Text('Today\'s Orders'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'agriculture',
                color: Colors.green,
                size: 5.w,
              ),
              title: const Text('Equipment Type'),
              onTap: () => Navigator.pop(context),
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }

  void _showMoreOptions() {
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
            Text(
              'More Options',
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 2.h),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'file_download',
                color: AppTheme.lightTheme.colorScheme.primary,
                size: 5.w,
              ),
              title: const Text('Export Orders'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'sync',
                color: AppTheme.lightTheme.colorScheme.primary,
                size: 5.w,
              ),
              title: const Text('Sync Data'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'settings',
                color: AppTheme.lightTheme.colorScheme.primary,
                size: 5.w,
              ),
              title: const Text('Settings'),
              onTap: () => Navigator.pop(context),
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }

  void _navigateToWorkOrderDetail(Map<String, dynamic> workOrder) {
    Navigator.pushNamed(context, '/work-order-detail-screen',
        arguments: workOrder);
  }

  void _handleStartWork(Map<String, dynamic> workOrder) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Started work for ${workOrder['customerName']}'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  void _handleCallCustomer(Map<String, dynamic> workOrder) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Calling ${workOrder['customerName']}...'),
        backgroundColor: AppTheme.lightTheme.colorScheme.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  void _handleViewLocation(Map<String, dynamic> workOrder) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening location: ${workOrder['location']}'),
        backgroundColor: AppTheme.lightTheme.colorScheme.secondary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  void _handleEditOrder(Map<String, dynamic> workOrder) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Editing order for ${workOrder['customerName']}'),
        backgroundColor: Colors.orange,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  void _handleCancelOrder(Map<String, dynamic> workOrder) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Work Order'),
        content: Text(
            'Are you sure you want to cancel the order for ${workOrder['customerName']}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content:
                      Text('Order cancelled for ${workOrder['customerName']}'),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              );
            },
            child: const Text('Yes, Cancel'),
          ),
        ],
      ),
    );
  }
}
