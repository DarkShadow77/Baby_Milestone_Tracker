import 'package:babylid/utils/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nb_utils/nb_utils.dart';

class RefillDropdown extends StatelessWidget {
  const RefillDropdown({
    Key? key,
    required this.text,
    this.onPressed,
  }) : super(key: key);

  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 55.h,
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: 10.w,
          vertical: 10.h,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.black,
          border: Border.all(
            color: AppColors.black,
            width: 2,
          ),
          boxShadow: const [
            BoxShadow(
              offset: Offset(1, 2),
              spreadRadius: 0,
              blurRadius: 2,
              color: AppColors.grey03,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            10.width,
            Expanded(
              flex: 7,
              child: Text(
                text,
                maxLines: 1,
                style: TextStyle(
                  color: AppColors.grey1,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            30.width,
            Expanded(
              flex: 1,
              child: Icon(
                Ionicons.caret_down_outline,
                color: AppColors.subWhite4,
                size: 15.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RefillTextField extends StatelessWidget {
  const RefillTextField({
    Key? key,
    this.focused = false,
    required this.error,
    required this.hintText,
    required this.node,
    required this.controller,
    required this.textInputAction,
    this.textInputType = TextInputType.number,
    this.textCapitalization = TextCapitalization.words,
    this.number = true,
    this.fieldLength = 12,
    this.onChanged,
    this.initialValue,
  }) : super(key: key);

  final bool focused;
  final bool error;
  final bool number;
  final String hintText;
  final String? initialValue;
  final FocusNode node;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final TextEditingController controller;
  final TextCapitalization textCapitalization;
  final int fieldLength;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.h,
      width: double.infinity,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 10.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.black,
        border: Border.all(
          color: AppColors.black,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(1, 2),
            spreadRadius: 0,
            blurRadius: 2,
            color: focused
                ? AppColors.orange.withOpacity(.5)
                : error
                    ? AppColors.red.withOpacity(.7)
                    : AppColors.grey03,
          ),
        ],
      ),
      child: TextFormField(
        initialValue: initialValue,
        focusNode: node,
        controller: controller,
        cursorColor: AppColors.subWhite4,
        textInputAction: textInputAction,
        keyboardType: textInputType,
        textCapitalization: textCapitalization,
        style: TextStyle(
          color: AppColors.grey1,
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
        ),
        inputFormatters: [
          if (number) ...[
            LengthLimitingTextInputFormatter(fieldLength),
          ]
        ],
        decoration: InputDecoration(
          border: InputBorder.none,
          filled: true,
          fillColor: AppColors.black,
          hintText: hintText,
          hintStyle: TextStyle(
            color: AppColors.grey1.withOpacity(.6),
            fontSize: 20.sp,
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
