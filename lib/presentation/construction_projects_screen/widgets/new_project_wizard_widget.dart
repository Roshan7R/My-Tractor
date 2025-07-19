import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class NewProjectWizardWidget extends StatefulWidget {
  final Function(Map<String, dynamic>) onProjectCreated;

  const NewProjectWizardWidget({
    Key? key,
    required this.onProjectCreated,
  }) : super(key: key);

  @override
  State<NewProjectWizardWidget> createState() => _NewProjectWizardWidgetState();
}

class _NewProjectWizardWidgetState extends State<NewProjectWizardWidget> {
  final PageController _pageController = PageController();
  int _currentStep = 0;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _budgetController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String _selectedProjectType = 'residential';
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(const Duration(days: 90));

  final Map<String, double> _materialEstimates = {
    'cement': 0,
    'steel': 0,
    'sand': 0,
    'bricks': 0,
  };

  @override
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    _locationController.dispose();
    _budgetController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85.h,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          _buildHeader(),
          _buildStepIndicator(),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentStep = index;
                });
              },
              children: [
                _buildBasicInfoStep(),
                _buildMaterialEstimationStep(),
                _buildBudgetSetupStep(),
                _buildReviewStep(),
              ],
            ),
          ),
          _buildNavigationButtons(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color:
                AppTheme.lightTheme.colorScheme.shadow.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CustomIconWidget(
            iconName: 'construction',
            color: AppTheme.lightTheme.colorScheme.primary,
            size: 6.w,
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Text(
              'New Construction Project',
              style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: CustomIconWidget(
              iconName: 'close',
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              size: 6.w,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: Row(
        children: List.generate(4, (index) {
          final bool isActive = index <= _currentStep;

          return Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 0.5.h,
                    decoration: BoxDecoration(
                      color: isActive
                          ? AppTheme.lightTheme.colorScheme.primary
                          : AppTheme.lightTheme.colorScheme.outline
                              .withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                if (index < 3) SizedBox(width: 2.w),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildBasicInfoStep() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Project Information',
            style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 3.h),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Project Name',
              hintText: 'Enter project name',
            ),
          ),
          SizedBox(height: 2.h),
          TextField(
            controller: _locationController,
            decoration: const InputDecoration(
              labelText: 'Location',
              hintText: 'Enter project location',
            ),
          ),
          SizedBox(height: 2.h),
          DropdownButtonFormField<String>(
            value: _selectedProjectType,
            decoration: const InputDecoration(
              labelText: 'Project Type',
            ),
            items: const [
              DropdownMenuItem(
                  value: 'residential', child: Text('Residential')),
              DropdownMenuItem(value: 'commercial', child: Text('Commercial')),
              DropdownMenuItem(value: 'industrial', child: Text('Industrial')),
              DropdownMenuItem(
                  value: 'infrastructure', child: Text('Infrastructure')),
            ],
            onChanged: (value) {
              setState(() {
                _selectedProjectType = value!;
              });
            },
          ),
          SizedBox(height: 2.h),
          TextField(
            controller: _descriptionController,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: 'Description',
              hintText: 'Enter project description',
            ),
          ),
          SizedBox(height: 2.h),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => _selectDate(context, true),
                  child: Container(
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: AppTheme.lightTheme.colorScheme.outline),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Start Date',
                          style: AppTheme.lightTheme.textTheme.labelMedium,
                        ),
                        SizedBox(height: 0.5.h),
                        Text(
                          '${_startDate.day}/${_startDate.month}/${_startDate.year}',
                          style: AppTheme.lightTheme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: GestureDetector(
                  onTap: () => _selectDate(context, false),
                  child: Container(
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: AppTheme.lightTheme.colorScheme.outline),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'End Date',
                          style: AppTheme.lightTheme.textTheme.labelMedium,
                        ),
                        SizedBox(height: 0.5.h),
                        Text(
                          '${_endDate.day}/${_endDate.month}/${_endDate.year}',
                          style: AppTheme.lightTheme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMaterialEstimationStep() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Material Estimation',
            style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 3.h),
          ..._materialEstimates.keys.map((material) {
            return Padding(
              padding: EdgeInsets.only(bottom: 2.h),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      material.toUpperCase(),
                      style: AppTheme.lightTheme.textTheme.titleMedium,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: _getMaterialUnit(material),
                        hintText: '0',
                      ),
                      onChanged: (value) {
                        _materialEstimates[material] =
                            double.tryParse(value) ?? 0;
                      },
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          SizedBox(height: 2.h),
          Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.primary
                  .withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                CustomIconWidget(
                  iconName: 'info',
                  color: AppTheme.lightTheme.colorScheme.primary,
                  size: 5.w,
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: Text(
                    'Material estimates help calculate accurate project costs and track usage.',
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.lightTheme.colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBudgetSetupStep() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Budget Setup',
            style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 3.h),
          TextField(
            controller: _budgetController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Total Budget',
              hintText: 'Enter total project budget',
              prefixText: '₹ ',
            ),
          ),
          SizedBox(height: 3.h),
          Text(
            'Estimated Material Costs',
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 2.h),
          ..._materialEstimates.entries.map((entry) {
            final cost = _calculateMaterialCost(entry.key, entry.value);
            return Padding(
              padding: EdgeInsets.only(bottom: 1.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    entry.key.toUpperCase(),
                    style: AppTheme.lightTheme.textTheme.bodyMedium,
                  ),
                  Text(
                    '₹${cost.toStringAsFixed(0)}',
                    style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          Divider(height: 3.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Material Cost',
                style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '₹${_getTotalMaterialCost().toStringAsFixed(0)}',
                style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.lightTheme.colorScheme.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReviewStep() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Review Project',
            style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 3.h),
          _buildReviewItem('Project Name', _nameController.text),
          _buildReviewItem('Location', _locationController.text),
          _buildReviewItem('Type', _selectedProjectType.toUpperCase()),
          _buildReviewItem('Start Date',
              '${_startDate.day}/${_startDate.month}/${_startDate.year}'),
          _buildReviewItem(
              'End Date', '${_endDate.day}/${_endDate.month}/${_endDate.year}'),
          _buildReviewItem('Total Budget', '₹${_budgetController.text}'),
          _buildReviewItem('Material Cost',
              '₹${_getTotalMaterialCost().toStringAsFixed(0)}'),
          SizedBox(height: 2.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.primary
                  .withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ready to Create Project?',
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.lightTheme.colorScheme.primary,
                  ),
                ),
                SizedBox(height: 1.h),
                Text(
                  'Your project will be created with the above details. You can modify these later from the project settings.',
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 30.w,
            child: Text(
              label,
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value.isEmpty ? 'Not specified' : value,
              style: AppTheme.lightTheme.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color:
                AppTheme.lightTheme.colorScheme.shadow.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          if (_currentStep > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  _pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: const Text('Previous'),
              ),
            ),
          if (_currentStep > 0) SizedBox(width: 4.w),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                if (_currentStep < 3) {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                } else {
                  _createProject();
                }
              },
              child: Text(_currentStep < 3 ? 'Next' : 'Create Project'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate ? _startDate : _endDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
          if (_endDate.isBefore(_startDate)) {
            _endDate = _startDate.add(const Duration(days: 30));
          }
        } else {
          _endDate = picked;
        }
      });
    }
  }

  String _getMaterialUnit(String material) {
    switch (material) {
      case 'cement':
        return 'Bags';
      case 'steel':
        return 'Tons';
      case 'sand':
        return 'Cubic Feet';
      case 'bricks':
        return 'Pieces';
      default:
        return 'Units';
    }
  }

  double _calculateMaterialCost(String material, double quantity) {
    const Map<String, double> rates = {
      'cement': 400, // per bag
      'steel': 50000, // per ton
      'sand': 50, // per cubic feet
      'bricks': 8, // per piece
    };

    return (rates[material] ?? 0) * quantity;
  }

  double _getTotalMaterialCost() {
    return _materialEstimates.entries
        .map((entry) => _calculateMaterialCost(entry.key, entry.value))
        .fold(0, (sum, cost) => sum + cost);
  }

  void _createProject() {
    final project = {
      'id': DateTime.now().millisecondsSinceEpoch,
      'name': _nameController.text,
      'location': _locationController.text,
      'type': _selectedProjectType,
      'description': _descriptionController.text,
      'totalBudget': double.tryParse(_budgetController.text) ?? 0,
      'spentAmount': 0,
      'completionPercentage': 0,
      'status': 'planning',
      'startDate': _startDate.toIso8601String(),
      'endDate': _endDate.toIso8601String(),
      'materialsNeeded': _materialEstimates.values.where((v) => v > 0).length,
      'laborAssigned': 0,
      'materialEstimates': _materialEstimates,
      'createdAt': DateTime.now().toIso8601String(),
    };

    widget.onProjectCreated(project);
    Navigator.pop(context);
  }
}
