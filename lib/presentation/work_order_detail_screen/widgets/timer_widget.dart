import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class TimerWidget extends StatefulWidget {
  final Map<String, dynamic> workOrder;
  final Function(bool isRunning, Duration elapsed) onTimerUpdate;

  const TimerWidget({
    Key? key,
    required this.workOrder,
    required this.onTimerUpdate,
  }) : super(key: key);

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  Timer? _timer;
  Duration _elapsed = Duration.zero;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    // Initialize with existing work hours if any
    final existingHours = widget.workOrder['actualHours'] as double? ?? 0.0;
    _elapsed = Duration(minutes: (existingHours * 60).round());
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    if (!_isRunning) {
      _isRunning = true;
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          _elapsed = _elapsed + const Duration(seconds: 1);
        });
        widget.onTimerUpdate(_isRunning, _elapsed);
      });
    }
  }

  void _stopTimer() {
    if (_isRunning) {
      _timer?.cancel();
      _isRunning = false;
      widget.onTimerUpdate(_isRunning, _elapsed);
    }
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _elapsed = Duration.zero;
      _isRunning = false;
    });
    widget.onTimerUpdate(_isRunning, _elapsed);
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String hours = twoDigits(duration.inHours);
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$hours:$minutes:$seconds';
  }

  double _calculateCost() {
    final hourlyRate = widget.workOrder['hourlyRate'] as double? ?? 1500.0;
    final hours = _elapsed.inMinutes / 60.0;
    return hours * hourlyRate;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          children: [
            Row(
              children: [
                CustomIconWidget(
                  iconName: 'timer',
                  color: AppTheme.lightTheme.primaryColor,
                  size: 6.w,
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: Text(
                    'Work Timer',
                    style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                  decoration: BoxDecoration(
                    color: _isRunning
                        ? Colors.green.withValues(alpha: 0.1)
                        : Colors.grey.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    _isRunning ? 'RUNNING' : 'STOPPED',
                    style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                      color: _isRunning ? Colors.green : Colors.grey[600],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.h),

            // Timer Display
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 3.h),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.primaryColor.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color:
                      AppTheme.lightTheme.primaryColor.withValues(alpha: 0.2),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    _formatDuration(_elapsed),
                    style: AppTheme.lightTheme.textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppTheme.lightTheme.primaryColor,
                      fontFamily: 'monospace',
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    'Current Cost: ₹${_calculateCost().toStringAsFixed(2)}',
                    style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                      color: AppTheme.lightTheme.colorScheme.secondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 3.h),

            // Control Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _isRunning ? _stopTimer : _startTimer,
                    icon: CustomIconWidget(
                      iconName: _isRunning ? 'pause' : 'play_arrow',
                      color: Colors.white,
                      size: 5.w,
                    ),
                    label: Text(
                      _isRunning ? 'Stop' : 'Start',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isRunning
                          ? Colors.red
                          : AppTheme.lightTheme.primaryColor,
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                    ),
                  ),
                ),
                SizedBox(width: 3.w),
                OutlinedButton.icon(
                  onPressed: _resetTimer,
                  icon: CustomIconWidget(
                    iconName: 'refresh',
                    color: AppTheme.lightTheme.primaryColor,
                    size: 5.w,
                  ),
                  label: Text(
                    'Reset',
                    style: TextStyle(fontSize: 14.sp),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
