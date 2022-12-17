import 'package:flutter/material.dart';

Widget textFeild(
    {required String hint,
    required Color color,
    required Color colorSide,
    required IconData icon,
    bool obscure = false,
    TextInputType? type,
    required TextEditingController controller}) {
  return TextFormField(
    controller: controller,
    keyboardType: type,
    obscureText: obscure,
    decoration: InputDecoration(
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: colorSide)),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      hintText: hint,
      suffixIcon: Icon(
        icon,
        color: color,
      ),
    ),
  );
}

Widget button(
    {required String text,
    required Function() function,
    required Color color}) {
  return Container(
    width: double.infinity,
    child: Material(
      borderRadius: BorderRadius.circular(5),
      color: color,
      child: MaterialButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onPressed: function,
        child: Text(
          text,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
    ),
  );
}
