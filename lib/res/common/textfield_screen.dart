import 'package:flutter/material.dart';

class TextFieldScreen extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final String? hintText;
  final Widget? suffixIcon;
  final int? maxlines;
  final int? minlines;

  const TextFieldScreen({
    Key? key,
    this.controller,
    this.textInputAction,
    this.hintText,
    this.suffixIcon,
    this.maxlines,
    this.minlines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 18,
      ),
      autocorrect: false,
      autofocus: true,
      textAlign: TextAlign.start,
      textInputAction: textInputAction ?? TextInputAction.done,
      maxLines: maxlines,
      minLines: minlines,
      decoration: InputDecoration(
        isDense: true,
        hintText: hintText ?? "",
        hintStyle: const TextStyle(fontSize: 17, color: Colors.white),
        fillColor: Colors.transparent,
        filled: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.white)),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(14),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xE0E53D15),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(14),
          ),
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
