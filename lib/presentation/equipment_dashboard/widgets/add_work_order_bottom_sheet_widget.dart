import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class AddWorkOrderBottomSheetWidget extends StatefulWidget {
  final List<Map<String, dynamic>> equipmentList;
  final Function(Map<String, dynamic>) onCreateWorkOrder;

  const AddWorkOrderBottomSheetWidget({
    super.key,
    required this.equipmentList,
    required this.onCreateWorkOrder,
  });

  @override
  State<AddWorkOrderBottomSheetWidget> createState() =>
      _AddWorkOrderBottomSheetWidgetState();
}

class _AddWorkOrderBottomSheetWidgetState
    extends State<AddWorkOrderBottomSheetWidget> {
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _customerAddressController =
      TextEditingController();
  final TextEditingController _customerPhoneController =
      TextEditingController();
  final TextEditingController _workDescriptionController =
      TextEditingController();

  String? _selectedEquipment;
  String _selectedWorkType = 'Rotavator Work';
  final List<String> _workTypes = [
    'Rotavator Work',
    'Cultivator Work',
    'Transport Work',
    'Construction Work',
    'Other'
  ];

  @override
  void dispose() {
    _customerNameController.dispose();
    _customerAddressController.dispose();
    _customerPhoneController.dispose();
    _workDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: isDarkMode ? AppTheme.surfaceDark : AppTheme.surfaceLight,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle Bar
            Center(
              child: Container(
                width: 12.w,
                height: 0.5.h,
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? AppTheme.neutralBorderDark
                      : AppTheme.neutralBorderLight,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            SizedBox(height: 3.h),

            // Title
            Text(
              'Create Work Order',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),

            SizedBox(height: 3.h),

            // Work Type Selection
            Text(
              'Work Type',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            SizedBox(height: 1.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              decoration: BoxDecoration(
                border: Border.all(
                  color: isDarkMode
                      ? AppTheme.neutralBorderDark
                      : AppTheme.neutralBorderLight,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedWorkType,
                  isExpanded: true,
                  items: _workTypes.map((String workType) {
                    return DropdownMenuItem<String>(
                      value: workType,
                      child: Text(workType),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _selectedWorkType = newValue;
                      });
                    }
                  },
                ),
              ),
            ),

            SizedBox(height: 2.h),

            // Equipment Selection
            Text(
              'Select Equipment',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            SizedBox(height: 1.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              decoration: BoxDecoration(
                border: Border.all(
                  color: isDarkMode
                      ? AppTheme.neutralBorderDark
                      : AppTheme.neutralBorderLight,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedEquipment,
                  hint: const Text('Choose equipment'),
                  isExpanded: true,
                  items: widget.equipmentList.map((equipment) {
                    return DropdownMenuItem<String>(
                      value: equipment['id'].toString(),
                      child: Text(equipment['name'] as String),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedEquipment = newValue;
                    });
                  },
                ),
              ),
            ),

            SizedBox(height: 2.h),

            // Customer Name
            Text(
              'Customer Name',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            SizedBox(height: 1.h),
            TextField(
              controller: _customerNameController,
              decoration: const InputDecoration(
                hintText: 'Enter customer name',
              ),
            ),

            SizedBox(height: 2.h),

            // Customer Phone
            Text(
              'Customer Phone',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            SizedBox(height: 1.h),
            TextField(
              controller: _customerPhoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                hintText: 'Enter phone number',
              ),
            ),

            SizedBox(height: 2.h),

            // Customer Address
            Text(
              'Customer Address',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            SizedBox(height: 1.h),
            TextField(
              controller: _customerAddressController,
              maxLines: 2,
              decoration: const InputDecoration(
                hintText: 'Enter customer address',
              ),
            ),

            SizedBox(height: 2.h),

            // Work Description
            Text(
              'Work Description',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            SizedBox(height: 1.h),
            TextField(
              controller: _workDescriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'Describe the work to be done',
              ),
            ),

            SizedBox(height: 4.h),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                ),
                SizedBox(width: 4.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _createWorkOrder,
                    child: const Text('Create Order'),
                  ),
                ),
              ],
            ),

            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }

  void _createWorkOrder() {
    if (_selectedEquipment == null ||
        _customerNameController.text.trim().isEmpty ||
        _customerPhoneController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all required fields'),
        ),
      );
      return;
    }

    final workOrderData = {
      'equipmentId': _selectedEquipment,
      'workType': _selectedWorkType,
      'customerName': _customerNameController.text.trim(),
      'customerPhone': _customerPhoneController.text.trim(),
      'customerAddress': _customerAddressController.text.trim(),
      'workDescription': _workDescriptionController.text.trim(),
      'createdAt': DateTime.now(),
      'status': 'Pending',
      'rate': 1500.0, // ₹1500/hour default rate
    };

    widget.onCreateWorkOrder(workOrderData);
    Navigator.pop(context);
  }
}
