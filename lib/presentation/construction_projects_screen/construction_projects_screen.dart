import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/new_project_fab_widget.dart';
import './widgets/new_project_wizard_widget.dart';
import './widgets/project_card_widget.dart';
import './widgets/project_filter_widget.dart';
import './widgets/search_bar_widget.dart';

class ConstructionProjectsScreen extends StatefulWidget {
  const ConstructionProjectsScreen({Key? key}) : super(key: key);

  @override
  State<ConstructionProjectsScreen> createState() =>
      _ConstructionProjectsScreenState();
}

class _ConstructionProjectsScreenState extends State<ConstructionProjectsScreen>
    with TickerProviderStateMixin {
  String _selectedFilter = 'active';
  String _searchQuery = '';
  late AnimationController _fabAnimationController;
  late Animation<double> _fabAnimation;

  // Mock data for construction projects
  final List<Map<String, dynamic>> _allProjects = [
    {
      "id": 1,
      "name": "Green Valley Residential Complex",
      "location": "Sector 45, Gurgaon",
      "type": "residential",
      "description": "Modern 3BHK apartments with premium amenities",
      "totalBudget": 15000000.0,
      "spentAmount": 9500000.0,
      "completionPercentage": 65,
      "status": "on_track",
      "startDate": "2024-01-15T00:00:00.000Z",
      "endDate": "2024-12-30T00:00:00.000Z",
      "materialsNeeded": 8,
      "laborAssigned": 25,
      "materialEstimates": {
        "cement": 500,
        "steel": 12,
        "sand": 2000,
        "bricks": 50000
      },
      "createdAt": "2024-01-10T00:00:00.000Z"
    },
    {
      "id": 2,
      "name": "Tech Park Office Building",
      "location": "Cyber City, Bangalore",
      "type": "commercial",
      "description": "Modern office space with smart building features",
      "totalBudget": 25000000.0,
      "spentAmount": 18000000.0,
      "completionPercentage": 45,
      "status": "attention",
      "startDate": "2024-02-01T00:00:00.000Z",
      "endDate": "2025-01-15T00:00:00.000Z",
      "materialsNeeded": 12,
      "laborAssigned": 40,
      "materialEstimates": {
        "cement": 800,
        "steel": 20,
        "sand": 3500,
        "bricks": 75000
      },
      "createdAt": "2024-01-25T00:00:00.000Z"
    },
    {
      "id": 3,
      "name": "Highway Bridge Construction",
      "location": "NH-48, Rajasthan",
      "type": "infrastructure",
      "description": "4-lane highway bridge with modern engineering",
      "totalBudget": 50000000.0,
      "spentAmount": 35000000.0,
      "completionPercentage": 30,
      "status": "delayed",
      "startDate": "2023-10-01T00:00:00.000Z",
      "endDate": "2024-08-30T00:00:00.000Z",
      "materialsNeeded": 15,
      "laborAssigned": 60,
      "materialEstimates": {
        "cement": 1200,
        "steel": 35,
        "sand": 5000,
        "bricks": 0
      },
      "createdAt": "2023-09-20T00:00:00.000Z"
    },
    {
      "id": 4,
      "name": "Luxury Villa Project",
      "location": "Whitefield, Bangalore",
      "type": "residential",
      "description": "Premium villa with modern architecture and landscaping",
      "totalBudget": 8000000.0,
      "spentAmount": 8000000.0,
      "completionPercentage": 100,
      "status": "completed",
      "startDate": "2023-06-01T00:00:00.000Z",
      "endDate": "2024-01-30T00:00:00.000Z",
      "materialsNeeded": 6,
      "laborAssigned": 15,
      "materialEstimates": {
        "cement": 300,
        "steel": 8,
        "sand": 1200,
        "bricks": 30000
      },
      "createdAt": "2023-05-15T00:00:00.000Z"
    },
    {
      "id": 5,
      "name": "Shopping Mall Extension",
      "location": "MG Road, Pune",
      "type": "commercial",
      "description": "Extension of existing shopping mall with food court",
      "totalBudget": 12000000.0,
      "spentAmount": 2000000.0,
      "completionPercentage": 15,
      "status": "planning",
      "startDate": "2024-08-01T00:00:00.000Z",
      "endDate": "2025-03-30T00:00:00.000Z",
      "materialsNeeded": 10,
      "laborAssigned": 0,
      "materialEstimates": {
        "cement": 600,
        "steel": 15,
        "sand": 2500,
        "bricks": 60000
      },
      "createdAt": "2024-07-10T00:00:00.000Z"
    },
    {
      "id": 6,
      "name": "Industrial Warehouse",
      "location": "MIDC, Aurangabad",
      "type": "industrial",
      "description": "Large warehouse facility for manufacturing company",
      "totalBudget": 18000000.0,
      "spentAmount": 0.0,
      "completionPercentage": 0,
      "status": "planning",
      "startDate": "2024-09-15T00:00:00.000Z",
      "endDate": "2025-06-30T00:00:00.000Z",
      "materialsNeeded": 8,
      "laborAssigned": 0,
      "materialEstimates": {
        "cement": 400,
        "steel": 25,
        "sand": 1800,
        "bricks": 40000
      },
      "createdAt": "2024-07-19T00:00:00.000Z"
    }
  ];

  List<Map<String, dynamic>> _projects = [];

  @override
  void initState() {
    super.initState();
    _projects = List.from(_allProjects);
    _fabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fabAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fabAnimationController, curve: Curves.easeInOut),
    );
    _fabAnimationController.forward();
  }

  @override
  void dispose() {
    _fabAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          SearchBarWidget(
            searchQuery: _searchQuery,
            onSearchChanged: _handleSearchChanged,
            onVoiceSearch: _handleVoiceSearch,
          ),
          ProjectFilterWidget(
            selectedFilter: _selectedFilter,
            onFilterChanged: _handleFilterChanged,
            filterCounts: _getFilterCounts(),
          ),
          Expanded(
            child: _buildProjectsList(),
          ),
        ],
      ),
      floatingActionButton: AnimatedBuilder(
        animation: _fabAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _fabAnimation.value,
            child: NewProjectFabWidget(
              onPressed: _showNewProjectWizard,
            ),
          );
        },
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(
        'Construction Projects',
        style: AppTheme.lightTheme.appBarTheme.titleTextStyle,
      ),
      backgroundColor: AppTheme.lightTheme.appBarTheme.backgroundColor,
      foregroundColor: AppTheme.lightTheme.appBarTheme.foregroundColor,
      elevation: AppTheme.lightTheme.appBarTheme.elevation,
      centerTitle: AppTheme.lightTheme.appBarTheme.centerTitle,
      actions: [
        GestureDetector(
          onTap: _showCalculator,
          child: Padding(
            padding: EdgeInsets.only(right: 4.w),
            child: CustomIconWidget(
              iconName: 'calculate',
              color: AppTheme.lightTheme.appBarTheme.foregroundColor!,
              size: 6.w,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProjectsList() {
    final filteredProjects = _getFilteredProjects();

    if (filteredProjects.isEmpty) {
      return _buildEmptyState();
    }

    return RefreshIndicator(
      onRefresh: _handleRefresh,
      color: AppTheme.lightTheme.colorScheme.primary,
      child: ListView.builder(
        padding: EdgeInsets.only(bottom: 10.h),
        itemCount: filteredProjects.length,
        itemBuilder: (context, index) {
          final project = filteredProjects[index];
          return ProjectCardWidget(
            project: project,
            onTap: () => _navigateToProjectDetail(project),
            onAddMaterials: () => _handleAddMaterials(project),
            onLogHours: () => _handleLogHours(project),
            onUpdateProgress: () => _handleUpdateProgress(project),
            onEdit: () => _handleEditProject(project),
            onViewReports: () => _handleViewReports(project),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomIconWidget(
            iconName: 'construction',
            color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            size: 20.w,
          ),
          SizedBox(height: 2.h),
          Text(
            _searchQuery.isNotEmpty
                ? 'No projects found for "${_searchQuery}"'
                : 'No ${_selectedFilter} projects',
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 1.h),
          Text(
            _searchQuery.isNotEmpty
                ? 'Try adjusting your search terms'
                : 'Start by creating your first project',
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          if (_searchQuery.isEmpty && _selectedFilter == 'active') ...[
            SizedBox(height: 3.h),
            ElevatedButton.icon(
              onPressed: _showNewProjectWizard,
              icon: CustomIconWidget(
                iconName: 'add',
                color: AppTheme.lightTheme.colorScheme.onPrimary,
                size: 5.w,
              ),
              label: const Text('Create New Project'),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor:
          AppTheme.lightTheme.bottomNavigationBarTheme.backgroundColor,
      selectedItemColor:
          AppTheme.lightTheme.bottomNavigationBarTheme.selectedItemColor,
      unselectedItemColor:
          AppTheme.lightTheme.bottomNavigationBarTheme.unselectedItemColor,
      currentIndex: 4, // Construction Projects tab
      onTap: _handleBottomNavTap,
      items: [
        BottomNavigationBarItem(
          icon: CustomIconWidget(
            iconName: 'dashboard',
            color: AppTheme
                .lightTheme.bottomNavigationBarTheme.unselectedItemColor!,
            size: 6.w,
          ),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: CustomIconWidget(
            iconName: 'assignment',
            color: AppTheme
                .lightTheme.bottomNavigationBarTheme.unselectedItemColor!,
            size: 6.w,
          ),
          label: 'Work Orders',
        ),
        BottomNavigationBarItem(
          icon: CustomIconWidget(
            iconName: 'people',
            color: AppTheme
                .lightTheme.bottomNavigationBarTheme.unselectedItemColor!,
            size: 6.w,
          ),
          label: 'Drivers',
        ),
        BottomNavigationBarItem(
          icon: CustomIconWidget(
            iconName: 'construction',
            color:
                AppTheme.lightTheme.bottomNavigationBarTheme.selectedItemColor!,
            size: 6.w,
          ),
          label: 'Projects',
        ),
        BottomNavigationBarItem(
          icon: CustomIconWidget(
            iconName: 'analytics',
            color: AppTheme
                .lightTheme.bottomNavigationBarTheme.unselectedItemColor!,
            size: 6.w,
          ),
          label: 'Reports',
        ),
      ],
    );
  }

  List<Map<String, dynamic>> _getFilteredProjects() {
    List<Map<String, dynamic>> filtered = _projects;

    // Filter by status
    if (_selectedFilter != 'all') {
      if (_selectedFilter == 'active') {
        filtered = filtered
            .where((project) =>
                (project['status'] as String) == 'on_track' ||
                (project['status'] as String) == 'attention' ||
                (project['status'] as String) == 'delayed')
            .toList();
      } else if (_selectedFilter == 'planning') {
        filtered = filtered
            .where((project) => (project['status'] as String) == 'planning')
            .toList();
      } else if (_selectedFilter == 'completed') {
        filtered = filtered
            .where((project) => (project['status'] as String) == 'completed')
            .toList();
      }
    }

    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((project) {
        final name = (project['name'] as String).toLowerCase();
        final location = (project['location'] as String).toLowerCase();
        final status = (project['status'] as String).toLowerCase();
        final query = _searchQuery.toLowerCase();

        return name.contains(query) ||
            location.contains(query) ||
            status.contains(query);
      }).toList();
    }

    return filtered;
  }

  Map<String, int> _getFilterCounts() {
    return {
      'active': _projects
          .where((p) =>
              (p['status'] as String) == 'on_track' ||
              (p['status'] as String) == 'attention' ||
              (p['status'] as String) == 'delayed')
          .length,
      'planning':
          _projects.where((p) => (p['status'] as String) == 'planning').length,
      'completed':
          _projects.where((p) => (p['status'] as String) == 'completed').length,
    };
  }

  void _handleSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  void _handleVoiceSearch() {
    // Voice search implementation would go here
    // For now, show a toast message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Voice search activated'),
        backgroundColor: AppTheme.lightTheme.colorScheme.primary,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _handleFilterChanged(String filter) {
    setState(() {
      _selectedFilter = filter;
    });
  }

  Future<void> _handleRefresh() async {
    // Simulate network refresh
    await Future.delayed(const Duration(seconds: 1));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Projects refreshed'),
        backgroundColor: AppTheme.lightTheme.colorScheme.primary,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _showNewProjectWizard() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => NewProjectWizardWidget(
        onProjectCreated: _handleProjectCreated,
      ),
    );
  }

  void _handleProjectCreated(Map<String, dynamic> project) {
    setState(() {
      _projects.insert(0, project);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Project "${project['name']}" created successfully'),
        backgroundColor: AppTheme.lightTheme.colorScheme.primary,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _navigateToProjectDetail(Map<String, dynamic> project) {
    // Navigate to project detail screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening ${project['name']} details'),
        backgroundColor: AppTheme.lightTheme.colorScheme.primary,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _handleAddMaterials(Map<String, dynamic> project) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Add materials to ${project['name']}'),
        backgroundColor: AppTheme.lightTheme.colorScheme.primary,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _handleLogHours(Map<String, dynamic> project) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Log labor hours for ${project['name']}'),
        backgroundColor: AppTheme.lightTheme.colorScheme.primary,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _handleUpdateProgress(Map<String, dynamic> project) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Update progress for ${project['name']}'),
        backgroundColor: AppTheme.lightTheme.colorScheme.primary,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _handleEditProject(Map<String, dynamic> project) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Edit ${project['name']}'),
        backgroundColor: AppTheme.lightTheme.colorScheme.secondary,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _handleViewReports(Map<String, dynamic> project) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('View reports for ${project['name']}'),
        backgroundColor: AppTheme.lightTheme.colorScheme.secondary,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _showCalculator() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            CustomIconWidget(
              iconName: 'calculate',
              color: AppTheme.lightTheme.colorScheme.primary,
              size: 6.w,
            ),
            SizedBox(width: 2.w),
            const Text('Quick Calculator'),
          ],
        ),
        content: const Text(
            'Calculator functionality would be implemented here for quick quantity and cost calculations.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _handleBottomNavTap(int index) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/equipment-dashboard');
        break;
      case 1:
        Navigator.pushNamed(context, '/work-orders-screen');
        break;
      case 2:
        Navigator.pushNamed(context, '/driver-management-screen');
        break;
      case 3:
        // Current screen - do nothing
        break;
      case 4:
        Navigator.pushNamed(context, '/reports-and-analytics-screen');
        break;
    }
  }
}
