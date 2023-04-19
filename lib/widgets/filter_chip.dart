import 'package:flutter/material.dart';

import 'package:foodboard_admin_application/utils/colors.dart';
import 'package:foodboard_admin_application/widgets/big_text.dart';

class FilterChipWidget extends StatefulWidget {
  final String chipName;
  Function(bool, String) onSelected;
  FilterChipWidget({
    Key? key,
    required this.chipName,
    required this.onSelected,
  }) : super(key: key);

  @override
  _FilterChipWidgetState createState() => _FilterChipWidgetState();
}

class _FilterChipWidgetState extends State<FilterChipWidget> {
  var _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: BigText(
        text: widget.chipName,
        size: 14,
        fontWeight: FontWeight.w500,
        color: _isSelected == true ? Colors.white : AppColors.lightOcean,
      ),
      labelStyle: const TextStyle(
        color: Colors.black,
      ),
      selected: _isSelected,
      padding: const EdgeInsets.all(5),
      showCheckmark: false,
      backgroundColor: Colors.transparent,
      shape: const StadiumBorder(side: BorderSide(color: AppColors.oceanShade)),
      onSelected: (isSelected) {
        setState(() {
          _isSelected = isSelected;
          bool isChecked = _isSelected;
          widget.onSelected(isChecked, widget.chipName);
        });
      },
      selectedColor: AppColors.lightOcean,
    );
  }
}
