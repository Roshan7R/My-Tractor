import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class WorkOrderFloatingActionWidget extends StatefulWidget {
  final VoidCallback? onCreateOrder;
  final VoidCallback? onQuickEntry;
  final VoidCallback? onVoiceCommand;

  const WorkOrderFloatingActionWidget({
    super.key,
    this.onCreateOrder,
    this.onQuickEntry,
    this.onVoiceCommand,
  });

  @override
  State<WorkOrderFloatingActionWidget> createState() =>
      _WorkOrderFloatingActionWidgetState();
}

class _WorkOrderFloatingActionWidgetState
    extends State<WorkOrderFloatingActionWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });

    if (_isExpanded) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Voice command button
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform.scale(
              scale: _animation.value,
              child: Opacity(
                opacity: _animation.value,
                child: _isExpanded
                    ? Container(
                        margin: EdgeInsets.only(bottom: 2.h),
                        child: _buildSecondaryFAB(
                          'Voice Command',
                          'mic',
                          AppTheme.lightTheme.colorScheme.secondary,
                          widget.onVoiceCommand,
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            );
          },
        ),
        // Quick entry button
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform.scale(
              scale: _animation.value,
              child: Opacity(
                opacity: _animation.value,
                child: _isExpanded
                    ? Container(
                        margin: EdgeInsets.only(bottom: 2.h),
                        child: _buildSecondaryFAB(
                          'Quick Entry',
                          'flash_on',
                          Colors.orange,
                          widget.onQuickEntry,
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            );
          },
        ),
        // Main FAB
        FloatingActionButton(
          onPressed: _isExpanded ? widget.onCreateOrder : _toggleExpanded,
          backgroundColor: AppTheme.lightTheme.colorScheme.primary,
          foregroundColor: AppTheme.lightTheme.colorScheme.onPrimary,
          elevation: 4,
          child: AnimatedRotation(
            turns: _isExpanded ? 0.125 : 0,
            duration: const Duration(milliseconds: 300),
            child: CustomIconWidget(
              iconName: _isExpanded ? 'close' : 'add',
              color: AppTheme.lightTheme.colorScheme.onPrimary,
              size: 6.w,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSecondaryFAB(
    String label,
    String iconName,
    Color backgroundColor,
    VoidCallback? onPressed,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Label
        Container(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
          decoration: BoxDecoration(
            color: AppTheme.lightTheme.colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            label,
            style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(width: 2.w),
        // Button
        FloatingActionButton.small(
          onPressed: onPressed,
          backgroundColor: backgroundColor,
          foregroundColor: Colors.white,
          elevation: 2,
          child: CustomIconWidget(
            iconName: iconName,
            color: Colors.white,
            size: 5.w,
          ),
        ),
      ],
    );
  }
}
