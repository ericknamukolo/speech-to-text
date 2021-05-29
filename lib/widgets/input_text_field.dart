import 'package:flutter/material.dart';
import 'package:speech_to_text_conversion/constants.dart';

class InputTextField extends StatelessWidget {
  InputTextField(
      {this.hint,
      this.icon,
      this.input,
      this.type,
      this.obs,
      this.eye,
      this.eyeClick,
      this.validator});
  final IconData icon;
  final String hint;
  final Function input;
  final TextInputType type;
  final bool obs;
  final IconData eye;
  final Function eyeClick;
  final Function validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      obscureText: obs,
      keyboardType: type,
      style: kTextStytle.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      onChanged: input,
      decoration: InputDecoration(
        errorStyle: kTextStytle.copyWith(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Colors.red,
        ),
        icon: Icon(
          icon,
          size: 40,
        ),
        suffixIcon: GestureDetector(
          onTap: eyeClick,
          child: Icon(eye),
        ),
        hintText: hint,
        hintStyle: kTextStytle.copyWith(
            fontSize: 20, color: Colors.grey, fontWeight: FontWeight.bold),
        filled: true,
        border: InputBorder.none,
      ),
    );
  }
}
