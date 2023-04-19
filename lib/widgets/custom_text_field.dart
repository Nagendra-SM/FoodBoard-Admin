import 'package:flutter/material.dart';
import 'package:foodboard_admin_application/utils/colors.dart';

class CustomTextField extends StatelessWidget {
  final String name;
  final TextEditingController controller;
  final String hint;
  final AutovalidateMode mode;

  final String? Function(String?)? valid;
  const CustomTextField({
    Key? key,
    required this.name,
    required this.controller,
    required this.hint,
    this.mode = AutovalidateMode.onUserInteraction,
    required this.valid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        autovalidateMode: mode,
        controller: controller,
        decoration: InputDecoration(
            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(width: 2, color: AppColors.darkOcean)),
            enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(width: 2, color: AppColors.lightOcean)),
            disabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(width: 2, color: AppColors.lightOcean)),
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(width: 2, color: AppColors.lightOcean)),
            labelText: name,
            hintText: hint,
            hintStyle: const TextStyle(color: AppColors.darkOcean),
            labelStyle: const TextStyle(color: AppColors.darkOcean)),
        validator: valid);
  }
}
