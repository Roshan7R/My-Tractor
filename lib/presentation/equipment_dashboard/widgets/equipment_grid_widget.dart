import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import './equipment_card_widget.dart';

class EquipmentGridWidget extends StatelessWidget {
  final List<Map<String, dynamic>> equipmentList;
  final Function(Map<String, dynamic>) onEquipmentTap;
  final Function(Map<String, dynamic>) onEquipmentLongPress;

  const EquipmentGridWidget({
    super.key,
    required this.equipmentList,
    required this.onEquipmentTap,
    required this.onEquipmentLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _getCrossAxisCount(context),
          childAspectRatio: 0.75,
          crossAxisSpacing: 2.w,
          mainAxisSpacing: 2.w,
        ),
        itemCount: equipmentList.length,
        itemBuilder: (context, index) {
          final equipment = equipmentList[index];
          return EquipmentCardWidget(
            equipment: equipment,
            onTap: () => onEquipmentTap(equipment),
            onLongPress: () => onEquipmentLongPress(equipment),
          );
        },
      ),
    );
  }

  int _getCrossAxisCount(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 900) {
      return 3; // Tablets
    } else if (screenWidth > 600) {
      return 2; // Large phones
    } else {
      return 2; // Regular phones
    }
  }
}
