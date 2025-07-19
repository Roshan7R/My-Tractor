import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/add_work_order_bottom_sheet_widget.dart';
import './widgets/dashboard_header_widget.dart';
import './widgets/equipment_grid_widget.dart';
import './widgets/quick_actions_bottom_sheet_widget.dart';

class EquipmentDashboard extends StatefulWidget {
  const EquipmentDashboard({super.key});

  @override
  State<EquipmentDashboard> createState() => _EquipmentDashboardState();
}

class _EquipmentDashboardState extends State<EquipmentDashboard> {
  int _currentIndex = 0;

  // Mock data for equipment
  final List<Map<String, dynamic>> _equipmentList = [
    {
      "id": 1,
      "name": "John Deere 1",
      "type": "Tractor",
      "status": "Working",
      "operator": "Rajesh Kumar",
      "fuelLevel": 75.0,
      "imageUrl":
          "https://images.pexels.com/photos/2132250/pexels-photo-2132250.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "model": "5075E",
      "engineHours": 1250.5,
      "lastMaintenance": "2025-07-10",
    },
    {
      "id": 2,
      "name": "John Deere 2",
      "type": "Tractor",
      "status": "Idle",
      "operator": "Suresh Patel",
      "fuelLevel": 45.0,
      "imageUrl":
          "https://images.pexels.com/photos/2132250/pexels-photo-2132250.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "model": "5075E",
      "engineHours": 980.2,
      "lastMaintenance": "2025-07-05",
    },
    {
      "id": 3,
      "name": "Sonalika Tractor",
      "type": "Tractor",
      "status": "Maintenance",
      "operator": "Vikram Singh",
      "fuelLevel": 20.0,
      "imageUrl":
          "https://images.pexels.com/photos/1595108/pexels-photo-1595108.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "model": "DI 745 III",
      "engineHours": 1850.7,
      "lastMaintenance": "2025-07-15",
    },
    {
      "id": 4,
      "name": "Pickup Vehicle",
      "type": "Vehicle",
      "status": "Working",
      "operator": "Amit Sharma",
      "fuelLevel": 60.0,
      "imageUrl":
          "https://images.pexels.com/photos/1335077/pexels-photo-1335077.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "model": "Mahindra Bolero",
      "engineHours": 2100.3,
      "lastMaintenance": "2025-07-08",
    },
    {
      "id": 5,
      "name": "Concrete Mixer",
      "type": "Construction",
      "status": "Idle",
      "operator": "Ravi Yadav",
      "fuelLevel": 85.0,
      "imageUrl":
          "https://images.pexels.com/photos/1216589/pexels-photo-1216589.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "model": "CM-350",
      "engineHours": 750.8,
      "lastMaintenance": "2025-07-12",
    },
    {
      "id": 6,
      "name": "Rotavator",
      "type": "Implement",
      "status": "Working",
      "operator": "Manoj Gupta",
      "fuelLevel": 0.0,
      "imageUrl":
          "https://images.pexels.com/photos/2132250/pexels-photo-2132250.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "model": "RT-180",
      "engineHours": 650.4,
      "lastMaintenance": "2025-07-14",
    },
    {
      "id": 7,
      "name": "Cultivator",
      "type": "Implement",
      "status": "Idle",
      "operator": "Deepak Verma",
      "fuelLevel": 0.0,
      "imageUrl":
          "https://images.pexels.com/photos/2132250/pexels-photo-2132250.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "model": "CV-220",
      "engineHours": 420.1,
      "lastMaintenance": "2025-07-11",
    },
    {
      "id": 8,
      "name": "Tractor Trolley 1",
      "type": "Trolley",
      "status": "Working",
      "operator": "Santosh Kumar",
      "fuelLevel": 0.0,
      "imageUrl":
          "https://images.pexels.com/photos/1335077/pexels-photo-1335077.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "model": "TT-500",
      "engineHours": 1200.6,
      "lastMaintenance": "2025-07-09",
    },
    {
      "id": 9,
      "name": "Tractor Trolley 2",
      "type": "Trolley",
      "status": "Idle",
      "operator": "Ramesh Pal",
      "fuelLevel": 0.0,
      "imageUrl":
          "https://images.pexels.com/photos/1335077/pexels-photo-1335077.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "model": "TT-500",
      "engineHours": 980.3,
      "lastMaintenance": "2025-07-13",
    },
    {
      "id": 10,
      "name": "Bike 1",
      "type": "Vehicle",
      "status": "Working",
      "operator": "Ajay Singh",
      "fuelLevel": 40.0,
      "imageUrl":
          "https://images.pexels.com/photos/2116475/pexels-photo-2116475.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "model": "Hero Splendor",
      "engineHours": 15000.0,
      "lastMaintenance": "2025-07-16",
    },
    {
      "id": 11,
      "name": "Bike 2",
      "type": "Vehicle",
      "status": "Idle",
      "operator": "Sanjay Rao",
      "fuelLevel": 70.0,
      "imageUrl":
          "https://images.pexels.com/photos/2116475/pexels-photo-2116475.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "model": "Bajaj Pulsar",
      "engineHours": 12500.0,
      "lastMaintenance": "2025-07-17",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDarkMode ? AppTheme.backgroundDark : AppTheme.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            // Sticky Header
            DashboardHeaderWidget(
              farmName: "Green Valley Farm",
              currentDate: _getCurrentDate(),
              onNotificationTap: _handleNotificationTap,
              onVoiceCommandTap: _handleVoiceCommand,
            ),

            // Main Content
            Expanded(
              child: RefreshIndicator(
                onRefresh: _handleRefresh,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(height: 2.h),

                      // Equipment Grid
                      EquipmentGridWidget(
                        equipmentList: _equipmentList,
                        onEquipmentTap: _handleEquipmentTap,
                        onEquipmentLongPress: _handleEquipmentLongPress,
                      ),

                      SizedBox(height: 10.h), // Space for FAB
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor:
            isDarkMode ? AppTheme.surfaceDark : AppTheme.surfaceLight,
        selectedItemColor:
            isDarkMode ? AppTheme.primaryDark : AppTheme.primaryLight,
        unselectedItemColor: isDarkMode
            ? AppTheme.textSecondaryDark
            : AppTheme.textSecondaryLight,
        onTap: _handleBottomNavTap,
        items: [
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'dashboard',
              color: _currentIndex == 0
                  ? (isDarkMode ? AppTheme.primaryDark : AppTheme.primaryLight)
                  : (isDarkMode
                      ? AppTheme.textSecondaryDark
                      : AppTheme.textSecondaryLight),
              size: 24,
            ),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'assignment',
              color: _currentIndex == 1
                  ? (isDarkMode ? AppTheme.primaryDark : AppTheme.primaryLight)
                  : (isDarkMode
                      ? AppTheme.textSecondaryDark
                      : AppTheme.textSecondaryLight),
              size: 24,
            ),
            label: 'Work Orders',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'analytics',
              color: _currentIndex == 2
                  ? (isDarkMode ? AppTheme.primaryDark : AppTheme.primaryLight)
                  : (isDarkMode
                      ? AppTheme.textSecondaryDark
                      : AppTheme.textSecondaryLight),
              size: 24,
            ),
            label: 'Reports',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'person',
              color: _currentIndex == 3
                  ? (isDarkMode ? AppTheme.primaryDark : AppTheme.primaryLight)
                  : (isDarkMode
                      ? AppTheme.textSecondaryDark
                      : AppTheme.textSecondaryLight),
              size: 24,
            ),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'more_horiz',
              color: _currentIndex == 4
                  ? (isDarkMode ? AppTheme.primaryDark : AppTheme.primaryLight)
                  : (isDarkMode
                      ? AppTheme.textSecondaryDark
                      : AppTheme.textSecondaryLight),
              size: 24,
            ),
            label: 'More',
          ),
        ],
      ),

      // Floating Action Button
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddWorkOrderBottomSheet,
        backgroundColor:
            isDarkMode ? AppTheme.secondaryDark : AppTheme.secondaryLight,
        foregroundColor:
            isDarkMode ? AppTheme.onSecondaryDark : AppTheme.onSecondaryLight,
        icon: CustomIconWidget(
          iconName: 'add',
          color:
              isDarkMode ? AppTheme.onSecondaryDark : AppTheme.onSecondaryLight,
          size: 24,
        ),
        label: const Text('Add Work Order'),
      ),
    );
  }

  String _getCurrentDate() {
    final now = DateTime.now();
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return '${now.day} ${months[now.month - 1]} ${now.year}';
  }

  Future<void> _handleRefresh() async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    Fluttertoast.showToast(
      msg: "Equipment status updated",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void _handleNotificationTap() {
    Fluttertoast.showToast(
      msg: "3 new notifications",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void _handleVoiceCommand() {
    Fluttertoast.showToast(
      msg: "Voice command activated - Say your command",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void _handleEquipmentTap(Map<String, dynamic> equipment) {
    // Navigate to equipment detail screen with shared element transition
    Fluttertoast.showToast(
      msg: "Opening ${equipment['name']} details",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void _handleEquipmentLongPress(Map<String, dynamic> equipment) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => QuickActionsBottomSheetWidget(
        equipment: equipment,
        onViewDetails: () {
          Navigator.pop(context);
          _handleEquipmentTap(equipment);
        },
        onAssignWork: () {
          Navigator.pop(context);
          _showAddWorkOrderBottomSheet();
        },
        onMaintenanceLog: () {
          Navigator.pop(context);
          Fluttertoast.showToast(
            msg: "Opening maintenance log for ${equipment['name']}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
          );
        },
      ),
    );
  }

  void _showAddWorkOrderBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: AddWorkOrderBottomSheetWidget(
          equipmentList: _equipmentList,
          onCreateWorkOrder: _handleCreateWorkOrder,
        ),
      ),
    );
  }

  void _handleCreateWorkOrder(Map<String, dynamic> workOrderData) {
    final equipmentName = _equipmentList.firstWhere(
        (eq) => eq['id'].toString() == workOrderData['equipmentId'])['name'];

    Fluttertoast.showToast(
      msg: "Work order created for $equipmentName",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void _handleBottomNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        // Already on Dashboard
        break;
      case 1:
        Navigator.pushNamed(context, '/work-orders-screen');
        break;
      case 2:
        Navigator.pushNamed(context, '/reports-and-analytics-screen');
        break;
      case 3:
        Navigator.pushNamed(context, '/driver-management-screen');
        break;
      case 4:
        Navigator.pushNamed(context, '/construction-projects-screen');
        break;
    }
  }
}
