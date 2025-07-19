import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class PaymentStatusWidget extends StatelessWidget {
  final Map<String, dynamic> workOrder;
  final Function(String status) onPaymentStatusUpdate;

  const PaymentStatusWidget({
    Key? key,
    required this.workOrder,
    required this.onPaymentStatusUpdate,
  }) : super(key: key);

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'paid':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'overdue':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'paid':
        return Icons.check_circle;
      case 'pending':
        return Icons.schedule;
      case 'overdue':
        return Icons.warning;
      default:
        return Icons.help;
    }
  }

  void _showPaymentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update Payment Status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.check_circle, color: Colors.green),
                title: const Text('Mark as Paid'),
                onTap: () {
                  Navigator.pop(context);
                  onPaymentStatusUpdate('paid');
                },
              ),
              ListTile(
                leading: Icon(Icons.schedule, color: Colors.orange),
                title: const Text('Mark as Pending'),
                onTap: () {
                  Navigator.pop(context);
                  onPaymentStatusUpdate('pending');
                },
              ),
              ListTile(
                leading: Icon(Icons.warning, color: Colors.red),
                title: const Text('Mark as Overdue'),
                onTap: () {
                  Navigator.pop(context);
                  onPaymentStatusUpdate('overdue');
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final paymentStatus = workOrder['paymentStatus'] as String;
    final totalAmount = workOrder['totalAmount'] as double? ?? 0.0;
    final paidAmount = workOrder['paidAmount'] as double? ?? 0.0;
    final remainingAmount = totalAmount - paidAmount;

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CustomIconWidget(
                  iconName: 'payment',
                  color: AppTheme.lightTheme.primaryColor,
                  size: 6.w,
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: Text(
                    'Payment Status',
                    style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => _showPaymentDialog(context),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                    decoration: BoxDecoration(
                      color:
                          _getStatusColor(paymentStatus).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: _getStatusColor(paymentStatus),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _getStatusIcon(paymentStatus),
                          color: _getStatusColor(paymentStatus),
                          size: 4.w,
                        ),
                        SizedBox(width: 1.w),
                        Text(
                          paymentStatus.toUpperCase(),
                          style: AppTheme.lightTheme.textTheme.labelSmall
                              ?.copyWith(
                            color: _getStatusColor(paymentStatus),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 3.h),

            // Payment Details
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppTheme.lightTheme.colorScheme.outline
                      .withValues(alpha: 0.2),
                ),
              ),
              child: Column(
                children: [
                  _buildPaymentRow(
                      'Total Amount', '₹${totalAmount.toStringAsFixed(2)}'),
                  SizedBox(height: 1.h),
                  _buildPaymentRow(
                      'Paid Amount', '₹${paidAmount.toStringAsFixed(2)}'),
                  SizedBox(height: 1.h),
                  Divider(
                      color: AppTheme.lightTheme.colorScheme.outline
                          .withValues(alpha: 0.3)),
                  SizedBox(height: 1.h),
                  _buildPaymentRow(
                    'Remaining Amount',
                    '₹${remainingAmount.toStringAsFixed(2)}',
                    isHighlight: true,
                  ),
                ],
              ),
            ),
            SizedBox(height: 2.h),

            // Payment Actions
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // Generate invoice functionality
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Invoice generated successfully')),
                      );
                    },
                    icon: CustomIconWidget(
                      iconName: 'receipt',
                      color: AppTheme.lightTheme.primaryColor,
                      size: 4.w,
                    ),
                    label: Text(
                      'Generate Invoice',
                      style: TextStyle(fontSize: 12.sp),
                    ),
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Record payment functionality
                      _showPaymentDialog(context);
                    },
                    icon: CustomIconWidget(
                      iconName: 'add',
                      color: Colors.white,
                      size: 4.w,
                    ),
                    label: Text(
                      'Record Payment',
                      style: TextStyle(fontSize: 12.sp),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentRow(String label, String amount,
      {bool isHighlight = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            fontWeight: isHighlight ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
        Text(
          amount,
          style: AppTheme.currencyTextStyle(
            isLight: true,
            fontSize: isHighlight ? 16 : 14,
          ).copyWith(
            fontWeight: isHighlight ? FontWeight.w700 : FontWeight.w500,
            color: isHighlight ? AppTheme.lightTheme.primaryColor : null,
          ),
        ),
      ],
    );
  }
}
