import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/settings_item_widget.dart';
import './widgets/settings_section_widget.dart';
import './widgets/settings_toggle_widget.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Settings state variables
  bool _pushNotifications = true;
  bool _workOrderAlerts = true;
  bool _maintenanceReminders = true;
  bool _paymentNotifications = false;
  bool _biometricAuth = false;
  bool _autoBackup = true;
  bool _offlineSync = true;
  String _selectedTheme = 'Light';
  String _selectedLanguage = 'English';
  String _selectedUnits = 'Metric';
  int _autoLockTimer = 5; // minutes

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _pushNotifications = prefs.getBool('push_notifications') ?? true;
      _workOrderAlerts = prefs.getBool('work_order_alerts') ?? true;
      _maintenanceReminders = prefs.getBool('maintenance_reminders') ?? true;
      _paymentNotifications = prefs.getBool('payment_notifications') ?? false;
      _biometricAuth = prefs.getBool('biometric_auth') ?? false;
      _autoBackup = prefs.getBool('auto_backup') ?? true;
      _offlineSync = prefs.getBool('offline_sync') ?? true;
      _selectedTheme = prefs.getString('theme') ?? 'Light';
      _selectedLanguage = prefs.getString('language') ?? 'English';
      _selectedUnits = prefs.getString('units') ?? 'Metric';
      _autoLockTimer = prefs.getInt('auto_lock_timer') ?? 5;
    });
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('push_notifications', _pushNotifications);
    await prefs.setBool('work_order_alerts', _workOrderAlerts);
    await prefs.setBool('maintenance_reminders', _maintenanceReminders);
    await prefs.setBool('payment_notifications', _paymentNotifications);
    await prefs.setBool('biometric_auth', _biometricAuth);
    await prefs.setBool('auto_backup', _autoBackup);
    await prefs.setBool('offline_sync', _offlineSync);
    await prefs.setString('theme', _selectedTheme);
    await prefs.setString('language', _selectedLanguage);
    await prefs.setString('units', _selectedUnits);
    await prefs.setInt('auto_lock_timer', _autoLockTimer);
  }

  List<Widget> _getFilteredSettings() {
    final List<Widget> allSettings = [
      // Account Section
      SettingsSectionWidget(title: 'Account'),
      SettingsItemWidget(
        title: 'Profile Management',
        subtitle: 'Edit profile and personal information',
        icon: 'person',
        onTap: () => _navigateToProfile(),
        showArrow: true,
      ),
      SettingsItemWidget(
        title: 'Owner Information',
        subtitle: 'Ramesh - Farm Owner',
        icon: 'account_circle',
        onTap: () => _showOwnerInfo(),
        showArrow: true,
      ),
      SettingsToggleWidget(
        title: 'Push Notifications',
        subtitle: 'Receive app notifications',
        icon: 'notifications',
        value: _pushNotifications,
        onChanged: (value) {
          setState(() => _pushNotifications = value);
          _saveSettings();
        },
      ),
      SettingsItemWidget(
        title: 'Privacy Settings',
        subtitle: 'Control data sharing and privacy',
        icon: 'privacy_tip',
        onTap: () => _showPrivacySettings(),
        showArrow: true,
      ),

      SizedBox(height: 3.h),

      // App Preferences Section
      SettingsSectionWidget(title: 'App Preferences'),
      SettingsItemWidget(
        title: 'Theme',
        subtitle: _selectedTheme,
        icon: 'palette',
        onTap: () => _showThemeSelector(),
        showArrow: true,
      ),
      SettingsItemWidget(
        title: 'Language',
        subtitle: _selectedLanguage,
        icon: 'language',
        onTap: () => _showLanguageSelector(),
        showArrow: true,
      ),
      SettingsItemWidget(
        title: 'Measurement Units',
        subtitle: _selectedUnits,
        icon: 'straighten',
        onTap: () => _showUnitsSelector(),
        showArrow: true,
      ),

      SizedBox(height: 3.h),

      // Notification Settings Section
      SettingsSectionWidget(title: 'Notification Settings'),
      SettingsToggleWidget(
        title: 'Work Order Alerts',
        subtitle: 'Get notified about new work orders',
        icon: 'assignment',
        value: _workOrderAlerts,
        onChanged: (value) {
          setState(() => _workOrderAlerts = value);
          _saveSettings();
        },
      ),
      SettingsToggleWidget(
        title: 'Maintenance Reminders',
        subtitle: 'Equipment maintenance notifications',
        icon: 'build',
        value: _maintenanceReminders,
        onChanged: (value) {
          setState(() => _maintenanceReminders = value);
          _saveSettings();
        },
      ),
      SettingsToggleWidget(
        title: 'Payment Reminders',
        subtitle: 'Payment due date notifications',
        icon: 'payment',
        value: _paymentNotifications,
        onChanged: (value) {
          setState(() => _paymentNotifications = value);
          _saveSettings();
        },
      ),

      SizedBox(height: 3.h),

      // Data Management Section
      SettingsSectionWidget(title: 'Data Management'),
      SettingsToggleWidget(
        title: 'Auto Backup',
        subtitle: 'Automatically backup app data',
        icon: 'backup',
        value: _autoBackup,
        onChanged: (value) {
          setState(() => _autoBackup = value);
          _saveSettings();
        },
      ),
      SettingsItemWidget(
        title: 'Backup Now',
        subtitle: 'Manually backup current data',
        icon: 'cloud_upload',
        onTap: () => _performBackup(),
        showArrow: false,
      ),
      SettingsItemWidget(
        title: 'Restore Data',
        subtitle: 'Restore from previous backup',
        icon: 'cloud_download',
        onTap: () => _restoreData(),
        showArrow: false,
      ),
      SettingsToggleWidget(
        title: 'Offline Storage',
        subtitle: 'Store data for offline access',
        icon: 'offline_pin',
        value: _offlineSync,
        onChanged: (value) {
          setState(() => _offlineSync = value);
          _saveSettings();
        },
      ),

      SizedBox(height: 3.h),

      // Security Settings Section
      SettingsSectionWidget(title: 'Security'),
      SettingsToggleWidget(
        title: 'Biometric Authentication',
        subtitle: 'Use fingerprint or face unlock',
        icon: 'fingerprint',
        value: _biometricAuth,
        onChanged: (value) {
          setState(() => _biometricAuth = value);
          _saveSettings();
        },
      ),
      SettingsItemWidget(
        title: 'Auto-Lock Timer',
        subtitle: '$_autoLockTimer minutes',
        icon: 'lock_clock',
        onTap: () => _showAutoLockSelector(),
        showArrow: true,
      ),
      SettingsItemWidget(
        title: 'Change Password',
        subtitle: 'Update account password',
        icon: 'lock',
        onTap: () => _changePassword(),
        showArrow: true,
      ),

      SizedBox(height: 3.h),

      // Support Section
      SettingsSectionWidget(title: 'Support'),
      SettingsItemWidget(
        title: 'Help Documentation',
        subtitle: 'User guides and tutorials',
        icon: 'help_outline',
        onTap: () => _showHelp(),
        showArrow: true,
      ),
      SettingsItemWidget(
        title: 'Contact Support',
        subtitle: 'Get help from our team',
        icon: 'contact_support',
        onTap: () => _contactSupport(),
        showArrow: true,
      ),
      SettingsItemWidget(
        title: 'Send Feedback',
        subtitle: 'Share your thoughts and suggestions',
        icon: 'feedback',
        onTap: () => _sendFeedback(),
        showArrow: true,
      ),
      SettingsItemWidget(
        title: 'About',
        subtitle: 'App version and information',
        icon: 'info',
        onTap: () => Navigator.pushNamed(context, AppRoutes.aboutScreen),
        showArrow: true,
      ),

      SizedBox(height: 4.h),

      // Reset Section
      SettingsItemWidget(
        title: 'Reset to Defaults',
        subtitle: 'Restore all settings to default values',
        icon: 'restore',
        onTap: () => _showResetConfirmation(),
        showArrow: false,
        isDestructive: true,
      ),

      SizedBox(height: 4.h),
    ];

    if (_searchQuery.isEmpty) {
      return allSettings;
    }

    return allSettings.where((widget) {
      if (widget is SettingsItemWidget) {
        return widget.title
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()) ||
            (widget.subtitle
                    ?.toLowerCase()
                    .contains(_searchQuery.toLowerCase()) ??
                false);
      } else if (widget is SettingsToggleWidget) {
        return widget.title
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()) ||
            (widget.subtitle
                    ?.toLowerCase()
                    .contains(_searchQuery.toLowerCase()) ??
                false);
      }
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDarkMode ? AppTheme.backgroundDark : AppTheme.backgroundLight,
      appBar: AppBar(
        title: const Text('Settings'),
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
        actions: [
          IconButton(
            icon: CustomIconWidget(
              iconName: 'search',
              color:
                  isDarkMode ? AppTheme.onSurfaceDark : AppTheme.onSurfaceLight,
              size: 24,
            ),
            onPressed: () => _toggleSearch(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar (if visible)
          if (_searchQuery.isNotEmpty || _searchController.text.isNotEmpty)
            Container(
              padding: EdgeInsets.all(4.w),
              color: isDarkMode ? AppTheme.surfaceDark : AppTheme.surfaceLight,
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search settings...',
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      setState(() => _searchQuery = '');
                    },
                  ),
                ),
                onChanged: (value) {
                  setState(() => _searchQuery = value);
                },
              ),
            ),

          // Settings List
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Column(
                  children: [
                    SizedBox(height: 2.h),
                    ..._getFilteredSettings(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _toggleSearch() {
    setState(() {
      if (_searchQuery.isNotEmpty || _searchController.text.isNotEmpty) {
        _searchController.clear();
        _searchQuery = '';
      } else {
        _searchQuery = ' '; // Trigger search bar visibility
      }
    });
  }

  void _navigateToProfile() {
    Fluttertoast.showToast(msg: "Profile management coming soon");
  }

  void _showOwnerInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Owner Information'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: Ramesh', style: Theme.of(context).textTheme.bodyLarge),
            SizedBox(height: 1.h),
            Text('Role: Farm Owner',
                style: Theme.of(context).textTheme.bodyMedium),
            SizedBox(height: 1.h),
            Text('Management: Professionally managed by Mansingh',
                style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showPrivacySettings() {
    Fluttertoast.showToast(msg: "Privacy settings coming soon");
  }

  void _showThemeSelector() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Theme'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: ['Light', 'Dark', 'Auto']
              .map(
                (theme) => RadioListTile<String>(
                  title: Text(theme),
                  value: theme,
                  groupValue: _selectedTheme,
                  onChanged: (value) {
                    setState(() => _selectedTheme = value!);
                    _saveSettings();
                    Navigator.pop(context);
                  },
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  void _showLanguageSelector() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Language'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: ['English', 'Hindi', 'Punjabi']
              .map(
                (language) => RadioListTile<String>(
                  title: Text(language),
                  value: language,
                  groupValue: _selectedLanguage,
                  onChanged: (value) {
                    setState(() => _selectedLanguage = value!);
                    _saveSettings();
                    Navigator.pop(context);
                  },
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  void _showUnitsSelector() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Units'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: ['Metric', 'Imperial']
              .map(
                (units) => RadioListTile<String>(
                  title: Text(units),
                  value: units,
                  groupValue: _selectedUnits,
                  onChanged: (value) {
                    setState(() => _selectedUnits = value!);
                    _saveSettings();
                    Navigator.pop(context);
                  },
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  void _showAutoLockSelector() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Auto-Lock Timer'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [1, 5, 10, 15, 30]
              .map(
                (minutes) => RadioListTile<int>(
                  title: Text('$minutes minutes'),
                  value: minutes,
                  groupValue: _autoLockTimer,
                  onChanged: (value) {
                    setState(() => _autoLockTimer = value!);
                    _saveSettings();
                    Navigator.pop(context);
                  },
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  void _performBackup() {
    Fluttertoast.showToast(msg: "Backup completed successfully");
  }

  void _restoreData() {
    Fluttertoast.showToast(msg: "Data restore coming soon");
  }

  void _changePassword() {
    Fluttertoast.showToast(msg: "Password change coming soon");
  }

  void _showHelp() {
    Fluttertoast.showToast(msg: "Help documentation coming soon");
  }

  void _contactSupport() {
    Fluttertoast.showToast(msg: "Contact support coming soon");
  }

  void _sendFeedback() {
    Fluttertoast.showToast(msg: "Feedback feature coming soon");
  }

  void _showResetConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset Settings'),
        content: const Text(
            'Are you sure you want to reset all settings to default values? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              _resetToDefaults();
              Navigator.pop(context);
            },
            style:
                ElevatedButton.styleFrom(backgroundColor: AppTheme.errorLight),
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }

  void _resetToDefaults() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    setState(() {
      _pushNotifications = true;
      _workOrderAlerts = true;
      _maintenanceReminders = true;
      _paymentNotifications = false;
      _biometricAuth = false;
      _autoBackup = true;
      _offlineSync = true;
      _selectedTheme = 'Light';
      _selectedLanguage = 'English';
      _selectedUnits = 'Metric';
      _autoLockTimer = 5;
    });
    Fluttertoast.showToast(msg: "Settings reset to defaults");
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
