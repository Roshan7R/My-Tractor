import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/add_driver_form_widget.dart';
import './widgets/driver_card_widget.dart';
import './widgets/driver_filter_widget.dart';
import './widgets/driver_search_widget.dart';
import './widgets/driver_stats_widget.dart';

class DriverManagementScreen extends StatefulWidget {
  const DriverManagementScreen({Key? key}) : super(key: key);

  @override
  State<DriverManagementScreen> createState() => _DriverManagementScreenState();
}

class _DriverManagementScreenState extends State<DriverManagementScreen> {
  String _searchQuery = '';
  String _selectedFilter = 'all';
  bool _isMapView = false;

  // Mock driver data
  List<Map<String, dynamic>> _drivers = [
    {
      "id": 1,
      "name": "Rajesh Kumar",
      "phone": "+91 9876543210",
      "license": "DL-1420110012345",
      "profilePhoto":
          "https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png",
      "status": "available",
      "currentAssignment": "No Assignment",
      "todayHours": "0.0",
      "experience": "5-10 years",
      "shift": "Day Shift",
      "joinDate": "2023-01-15",
      "address": "Village Rampur, Dist. Meerut, UP",
    },
    {
      "id": 2,
      "name": "Suresh Singh",
      "phone": "+91 9876543211",
      "license": "DL-1420110012346",
      "profilePhoto":
          "https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png",
      "status": "on_duty",
      "currentAssignment": "John Deere 5050D",
      "todayHours": "6.5",
      "experience": "10+ years",
      "shift": "Day Shift",
      "joinDate": "2022-08-20",
      "address": "Sector 12, Noida, UP",
    },
    {
      "id": 3,
      "name": "Amit Sharma",
      "phone": "+91 9876543212",
      "license": "DL-1420110012347",
      "profilePhoto":
          "https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png",
      "status": "assigned",
      "currentAssignment": "Sonalika DI-745",
      "todayHours": "4.2",
      "experience": "2-5 years",
      "shift": "Flexible",
      "joinDate": "2023-06-10",
      "address": "Ghaziabad, UP",
    },
    {
      "id": 4,
      "name": "Vikram Yadav",
      "phone": "+91 9876543213",
      "license": "DL-1420110012348",
      "profilePhoto":
          "https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png",
      "status": "off_duty",
      "currentAssignment": "No Assignment",
      "todayHours": "8.0",
      "experience": "10+ years",
      "shift": "Night Shift",
      "joinDate": "2021-12-05",
      "address": "Faridabad, Haryana",
    },
    {
      "id": 5,
      "name": "Ravi Gupta",
      "phone": "+91 9876543214",
      "license": "DL-1420110012349",
      "profilePhoto":
          "https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png",
      "status": "available",
      "currentAssignment": "No Assignment",
      "todayHours": "0.0",
      "experience": "1-2 years",
      "shift": "Day Shift",
      "joinDate": "2024-01-20",
      "address": "Gurugram, Haryana",
    },
    {
      "id": 6,
      "name": "Manoj Verma",
      "phone": "+91 9876543215",
      "license": "DL-1420110012350",
      "profilePhoto":
          "https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png",
      "status": "on_duty",
      "currentAssignment": "Pickup Vehicle",
      "todayHours": "3.8",
      "experience": "5-10 years",
      "shift": "Flexible",
      "joinDate": "2023-03-15",
      "address": "Delhi NCR",
    },
  ];

  List<Map<String, dynamic>> get _filteredDrivers {
    List<Map<String, dynamic>> filtered = _drivers;

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((driver) {
        final name = driver['name']?.toString().toLowerCase() ?? '';
        final assignment =
            driver['currentAssignment']?.toString().toLowerCase() ?? '';
        final status = driver['status']?.toString().toLowerCase() ?? '';
        final query = _searchQuery.toLowerCase();

        return name.contains(query) ||
            assignment.contains(query) ||
            status.contains(query);
      }).toList();
    }

    // Apply status filter
    if (_selectedFilter != 'all') {
      filtered = filtered.where((driver) {
        final status = driver['status']?.toString().toLowerCase() ?? '';
        return status == _selectedFilter;
      }).toList();
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Driver Management',
          style: AppTheme.lightTheme.appBarTheme.titleTextStyle,
        ),
        backgroundColor: AppTheme.lightTheme.appBarTheme.backgroundColor,
        foregroundColor: AppTheme.lightTheme.appBarTheme.foregroundColor,
        elevation: AppTheme.lightTheme.appBarTheme.elevation,
        centerTitle: AppTheme.lightTheme.appBarTheme.centerTitle,
        actions: [
          IconButton(
            onPressed: _toggleMapView,
            icon: CustomIconWidget(
              iconName: _isMapView ? 'list' : 'map',
              color: AppTheme.lightTheme.appBarTheme.foregroundColor!,
              size: 6.w,
            ),
          ),
          IconButton(
            onPressed: () => _navigateToScreen('/equipment-dashboard'),
            icon: CustomIconWidget(
              iconName: 'dashboard',
              color: AppTheme.lightTheme.appBarTheme.foregroundColor!,
              size: 6.w,
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshDrivers,
        color: AppTheme.lightTheme.colorScheme.primary,
        child: Column(
          children: [
            // Driver Statistics
            DriverStatsWidget(drivers: _drivers),

            // Search bar
            DriverSearchWidget(
              onSearchChanged: (query) {
                setState(() {
                  _searchQuery = query;
                });
              },
              onVoiceSearch: _handleVoiceSearch,
            ),

            // Filter tabs
            DriverFilterWidget(
              selectedFilter: _selectedFilter,
              onFilterChanged: (filter) {
                setState(() {
                  _selectedFilter = filter;
                });
              },
            ),

            SizedBox(height: 2.h),

            // Driver list
            Expanded(
              child: _isMapView ? _buildMapView() : _buildListView(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddDriverForm,
        backgroundColor:
            AppTheme.lightTheme.floatingActionButtonTheme.backgroundColor,
        foregroundColor:
            AppTheme.lightTheme.floatingActionButtonTheme.foregroundColor,
        icon: CustomIconWidget(
          iconName: 'add',
          color: AppTheme.lightTheme.floatingActionButtonTheme.foregroundColor!,
          size: 6.w,
        ),
        label: Text(
          'Add Driver',
          style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
            color:
                AppTheme.lightTheme.floatingActionButtonTheme.foregroundColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildListView() {
    if (_filteredDrivers.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomIconWidget(
              iconName: 'search_off',
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              size: 15.w,
            ),
            SizedBox(height: 2.h),
            Text(
              'No drivers found',
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              'Try adjusting your search or filter',
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.only(bottom: 20.h),
      itemCount: _filteredDrivers.length,
      itemBuilder: (context, index) {
        final driver = _filteredDrivers[index];
        return DriverCardWidget(
          driver: driver,
          onTap: () => _navigateToDriverDetail(driver),
          onCall: () => _callDriver(driver),
          onAssignEquipment: () => _assignEquipment(driver),
          onViewSchedule: () => _viewSchedule(driver),
          onEditProfile: () => _editProfile(driver),
          onAttendance: () => _viewAttendance(driver),
        );
      },
    );
  }

  Widget _buildMapView() {
    return Container(
      margin: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomIconWidget(
            iconName: 'map',
            color: AppTheme.lightTheme.colorScheme.primary,
            size: 15.w,
          ),
          SizedBox(height: 2.h),
          Text(
            'Map View',
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            'Driver locations will be displayed here',
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 3.h),
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                _isMapView = false;
              });
            },
            icon: CustomIconWidget(
              iconName: 'list',
              color: AppTheme.lightTheme.colorScheme.onPrimary,
              size: 5.w,
            ),
            label: Text('Switch to List View'),
          ),
        ],
      ),
    );
  }

  void _toggleMapView() {
    setState(() {
      _isMapView = !_isMapView;
    });
  }

  Future<void> _refreshDrivers() async {
    // Simulate network refresh
    await Future.delayed(const Duration(seconds: 1));

    // Update driver statuses randomly for demo
    setState(() {
      for (var driver in _drivers) {
        if (driver['status'] == 'available') {
          // Randomly assign some available drivers
          if (DateTime.now().millisecond % 3 == 0) {
            driver['status'] = 'on_duty';
            driver['currentAssignment'] = 'John Deere 5050D';
            driver['todayHours'] = '2.5';
          }
        }
      }
    });
  }

  void _handleVoiceSearch() {
    // Voice search implementation would go here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Voice search activated'),
        backgroundColor: AppTheme.lightTheme.colorScheme.primary,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showAddDriverForm() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => AddDriverFormWidget(
        onDriverAdded: (newDriver) {
          setState(() {
            _drivers.add(newDriver);
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Driver ${newDriver['name']} added successfully'),
              backgroundColor: AppTheme.lightTheme.colorScheme.primary,
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
      ),
    );
  }

  void _navigateToDriverDetail(Map<String, dynamic> driver) {
    // Navigate to driver detail screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening details for ${driver['name']}'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _callDriver(Map<String, dynamic> driver) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Calling ${driver['name']} at ${driver['phone']}'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _assignEquipment(Map<String, dynamic> driver) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Assign Equipment'),
        content: Text('Assign equipment to ${driver['name']}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                driver['status'] = 'assigned';
                driver['currentAssignment'] = 'John Deere 5050D';
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Equipment assigned to ${driver['name']}'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: Text('Assign'),
          ),
        ],
      ),
    );
  }

  void _viewSchedule(Map<String, dynamic> driver) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Viewing schedule for ${driver['name']}'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _editProfile(Map<String, dynamic> driver) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Editing profile for ${driver['name']}'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _viewAttendance(Map<String, dynamic> driver) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Viewing attendance for ${driver['name']}'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _navigateToScreen(String route) {
    Navigator.pushNamed(context, route);
  }
}
