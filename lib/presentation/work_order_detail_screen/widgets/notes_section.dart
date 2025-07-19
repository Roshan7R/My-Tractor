import 'dart:io';

import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class NotesSection extends StatefulWidget {
  final Map<String, dynamic> workOrder;
  final Function(String notes, List<String> voiceMemos) onNotesUpdate;

  const NotesSection({
    Key? key,
    required this.workOrder,
    required this.onNotesUpdate,
  }) : super(key: key);

  @override
  State<NotesSection> createState() => _NotesSectionState();
}

class _NotesSectionState extends State<NotesSection> {
  final TextEditingController _notesController = TextEditingController();
  final AudioRecorder _audioRecorder = AudioRecorder();
  List<String> _voiceMemos = [];
  bool _isRecording = false;
  String? _currentRecordingPath;

  @override
  void initState() {
    super.initState();
    _notesController.text = widget.workOrder['notes'] as String? ?? '';
    _voiceMemos =
        List<String>.from(widget.workOrder['voiceMemos'] as List? ?? []);
  }

  @override
  void dispose() {
    _notesController.dispose();
    _audioRecorder.dispose();
    super.dispose();
  }

  Future<void> _startRecording() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        final String path =
            '${Directory.systemTemp.path}/voice_memo_${DateTime.now().millisecondsSinceEpoch}.wav';

        await _audioRecorder.start(
          const RecordConfig(encoder: AudioEncoder.wav),
          path: path,
        );

        setState(() {
          _isRecording = true;
          _currentRecordingPath = path;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Microphone permission required')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to start recording')),
      );
    }
  }

  Future<void> _stopRecording() async {
    try {
      final String? path = await _audioRecorder.stop();

      if (path != null) {
        setState(() {
          _voiceMemos.add(path);
          _isRecording = false;
          _currentRecordingPath = null;
        });

        widget.onNotesUpdate(_notesController.text, _voiceMemos);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Voice memo saved')),
        );
      }
    } catch (e) {
      setState(() {
        _isRecording = false;
        _currentRecordingPath = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to save recording')),
      );
    }
  }

  void _deleteVoiceMemo(int index) {
    setState(() {
      _voiceMemos.removeAt(index);
    });
    widget.onNotesUpdate(_notesController.text, _voiceMemos);
  }

  void _onNotesChanged() {
    widget.onNotesUpdate(_notesController.text, _voiceMemos);
  }

  String _formatDuration(String filePath) {
    // In a real implementation, you would get the actual duration
    // For now, returning a placeholder
    return '0:30';
  }

  @override
  Widget build(BuildContext context) {
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
                  iconName: 'note',
                  color: AppTheme.lightTheme.primaryColor,
                  size: 6.w,
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: Text(
                    'Notes & Voice Memos',
                    style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 3.h),

            // Text Notes
            TextField(
              controller: _notesController,
              onChanged: (_) => _onNotesChanged(),
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Add work notes, observations, or updates...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: Padding(
                  padding: EdgeInsets.all(3.w),
                  child: CustomIconWidget(
                    iconName: 'edit',
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    size: 5.w,
                  ),
                ),
              ),
            ),
            SizedBox(height: 3.h),

            // Voice Memos Section
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Voice Memos',
                    style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _isRecording ? _stopRecording : _startRecording,
                  icon: CustomIconWidget(
                    iconName: _isRecording ? 'stop' : 'mic',
                    color: Colors.white,
                    size: 4.w,
                  ),
                  label: Text(
                    _isRecording ? 'Stop' : 'Record',
                    style: TextStyle(fontSize: 12.sp),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isRecording
                        ? Colors.red
                        : AppTheme.lightTheme.primaryColor,
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),

            // Recording Indicator
            if (_isRecording)
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 2.h),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 3.w,
                      height: 3.w,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      'Recording in progress...',
                      style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

            // Voice Memos List
            if (_voiceMemos.isNotEmpty) ...[
              SizedBox(height: 2.h),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _voiceMemos.length,
                separatorBuilder: (context, index) => SizedBox(height: 1.h),
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.all(3.w),
                    decoration: BoxDecoration(
                      color: AppTheme.lightTheme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppTheme.lightTheme.colorScheme.outline
                            .withValues(alpha: 0.2),
                      ),
                    ),
                    child: Row(
                      children: [
                        CustomIconWidget(
                          iconName: 'play_arrow',
                          color: AppTheme.lightTheme.primaryColor,
                          size: 6.w,
                        ),
                        SizedBox(width: 3.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Voice Memo ${index + 1}',
                                style: AppTheme.lightTheme.textTheme.bodyMedium
                                    ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                'Duration: ${_formatDuration(_voiceMemos[index])}',
                                style: AppTheme.lightTheme.textTheme.bodySmall
                                    ?.copyWith(
                                  color: AppTheme
                                      .lightTheme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () => _deleteVoiceMemo(index),
                          icon: CustomIconWidget(
                            iconName: 'delete',
                            color: Colors.red,
                            size: 5.w,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],

            if (_voiceMemos.isEmpty && !_isRecording)
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 3.h),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Column(
                  children: [
                    CustomIconWidget(
                      iconName: 'mic_none',
                      color: Colors.grey[400]!,
                      size: 8.w,
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      'No voice memos recorded',
                      style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
