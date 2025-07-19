import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/bottom_action_bar.dart';
import './widgets/customer_info_card.dart';
import './widgets/notes_section.dart';
import './widgets/payment_status_widget.dart';
import './widgets/progress_section.dart';
import './widgets/timer_widget.dart';
import './widgets/work_details_card.dart';

class WorkOrderDetailScreen extends StatefulWidget {
  const WorkOrderDetailScreen({Key? key}) : super(key: key);

  @override
  State<WorkOrderDetailScreen> createState() => _WorkOrderDetailScreenState();
}

class _WorkOrderDetailScreenState extends State<WorkOrderDetailScreen> {
  late Map<String, dynamic> workOrder;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeWorkOrder();
  }

  void _initializeWorkOrder() {
    workOrder = {
      "id": "WO-2025-001",
      "status": "In Progress",
      "customer": {
        "name": "Rajesh Kumar",
        "phone": "+91 9876543210",
        "email": "rajesh.kumar@email.com",
        "address": "Village Kharkhoda, Tehsil Sonipat, Haryana 131001",
      },
      "equipment": "John Deere 5050D Tractor",
      "operator": "Suresh Singh",
      "scheduledTime": "19/07/2025 08:00 AM",
      "estimatedHours": 6.0,
      "actualHours": 2.5,
      "hourlyRate": 1500.0,
      "workType": "Field Plowing",
      "progress": 40.0,
      "paymentStatus": "pending",
      "totalAmount": 9000.0,
      "paidAmount": 0.0,
      "notes":
          "Field condition is good. Started work at 8:15 AM. Customer requested extra care near the boundary.",
      "photos": [],
      "voiceMemos": [],
      "location": {
        "latitude": 28.9845,
        "longitude": 77.0674,
      },
      "createdAt": DateTime.now().subtract(const Duration(hours: 3)),
      "updatedAt": DateTime.now(),
    };
  }

  void _updateStatus() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update Work Status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: CustomIconWidget(
                  iconName: 'play_arrow',
                  color: Colors.green,
                  size: 6.w,
                ),
                title: const Text('Start Work'),
                onTap: () {
                  Navigator.pop(context);
                  _updateWorkOrderStatus('In Progress');
                },
              ),
              ListTile(
                leading: CustomIconWidget(
                  iconName: 'pause',
                  color: Colors.orange,
                  size: 6.w,
                ),
                title: const Text('Pause Work'),
                onTap: () {
                  Navigator.pop(context);
                  _updateWorkOrderStatus('Paused');
                },
              ),
              ListTile(
                leading: CustomIconWidget(
                  iconName: 'check_circle',
                  color: Colors.blue,
                  size: 6.w,
                ),
                title: const Text('Complete Work'),
                onTap: () {
                  Navigator.pop(context);
                  _updateWorkOrderStatus('Completed');
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _updateWorkOrderStatus(String newStatus) {
    setState(() {
      workOrder['status'] = newStatus;
      workOrder['updatedAt'] = DateTime.now();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Work status updated to $newStatus')),
    );
  }

  void _onTimerUpdate(bool isRunning, Duration elapsed) {
    setState(() {
      workOrder['actualHours'] = elapsed.inMinutes / 60.0;
      workOrder['totalAmount'] = (workOrder['actualHours'] as double) *
          (workOrder['hourlyRate'] as double);
    });
  }

  void _onProgressUpdate(double progress, List<String> photos) {
    setState(() {
      workOrder['progress'] = progress;
      workOrder['photos'] = photos;
    });
  }

  void _onPaymentStatusUpdate(String status) {
    setState(() {
      workOrder['paymentStatus'] = status;
      if (status == 'paid') {
        workOrder['paidAmount'] = workOrder['totalAmount'];
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Payment status updated to $status')),
    );
  }

  void _onNotesUpdate(String notes, List<String> voiceMemos) {
    setState(() {
      workOrder['notes'] = notes;
      workOrder['voiceMemos'] = voiceMemos;
    });
  }

  void _addPhotos() {
    // This will be handled by the ProgressSection widget
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Use the progress section to add photos')),
    );
  }

  void _recordVoice() {
    // This will be handled by the NotesSection widget
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text('Use the notes section to record voice memos')),
    );
  }

  void _generateInvoice() {
    setState(() {
      _isLoading = true;
    });

    // Simulate invoice generation
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invoice generated successfully'),
          action: SnackBarAction(
            label: 'View',
            onPressed: _viewInvoice,
          ),
        ),
      );
    });
  }

  void _viewInvoice() {
    // Handle invoice viewing
  }

  void _shareWorkOrder() {
    final customer = workOrder['customer'] as Map<String, dynamic>;
    final shareText = '''
Work Order: ${workOrder['id']}
Customer: ${customer['name']}
Equipment: ${workOrder['equipment']}
Status: ${workOrder['status']}
Progress: ${workOrder['progress'].toInt()}%
Total Amount: ₹${(workOrder['totalAmount'] as double).toStringAsFixed(2)}

Generated by My Tractor App
    ''';

    Share.share(shareText, subject: 'Work Order ${workOrder['id']}');
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return Colors.green;
      case 'in progress':
        return Colors.blue;
      case 'paused':
        return Colors.orange;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Work Order ${workOrder['id']}'),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 4.w),
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
            decoration: BoxDecoration(
              color: _getStatusColor(workOrder['status'] as String)
                  .withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: _getStatusColor(workOrder['status'] as String),
              ),
            ),
            child: Text(
              workOrder['status'] as String,
              style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                color: _getStatusColor(workOrder['status'] as String),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'edit':
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Edit functionality coming soon')),
                  );
                  break;
                case 'duplicate':
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Work order duplicated')),
                  );
                  break;
                case 'delete':
                  _showDeleteConfirmation();
                  break;
              }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: 'edit',
                child: Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'edit',
                      color: AppTheme.lightTheme.colorScheme.onSurface,
                      size: 5.w,
                    ),
                    SizedBox(width: 2.w),
                    const Text('Edit'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'duplicate',
                child: Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'copy',
                      color: AppTheme.lightTheme.colorScheme.onSurface,
                      size: 5.w,
                    ),
                    SizedBox(width: 2.w),
                    const Text('Duplicate'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'delete',
                      color: Colors.red,
                      size: 5.w,
                    ),
                    SizedBox(width: 2.w),
                    const Text('Delete'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: AppTheme.lightTheme.primaryColor,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'Generating invoice...',
                    style: AppTheme.lightTheme.textTheme.bodyMedium,
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  CustomerInfoCard(workOrder: workOrder),
                  WorkDetailsCard(workOrder: workOrder),
                  TimerWidget(
                    workOrder: workOrder,
                    onTimerUpdate: _onTimerUpdate,
                  ),
                  ProgressSection(
                    workOrder: workOrder,
                    onProgressUpdate: _onProgressUpdate,
                  ),
                  PaymentStatusWidget(
                    workOrder: workOrder,
                    onPaymentStatusUpdate: _onPaymentStatusUpdate,
                  ),
                  NotesSection(
                    workOrder: workOrder,
                    onNotesUpdate: _onNotesUpdate,
                  ),
                  SizedBox(height: 20.h), // Space for bottom action bar
                ],
              ),
            ),
      bottomNavigationBar: BottomActionBar(
        workOrder: workOrder,
        onUpdateStatus: _updateStatus,
        onAddPhotos: _addPhotos,
        onRecordVoice: _recordVoice,
        onGenerateInvoice: _generateInvoice,
        onShare: _shareWorkOrder,
      ),
    );
  }

  void _showDeleteConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Work Order'),
          content: const Text(
              'Are you sure you want to delete this work order? This action cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Work order deleted')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
