import 'package:flutter/material.dart';

class RegistrationButton extends StatelessWidget {
  const RegistrationButton(
      {super.key,
      required this.onTap,
      required this.title,
      required this.isLoading});
  final VoidCallback onTap;
  final String title;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          height: 40,
          width: double.infinity,
          child: isLoading == false
              ? Text(
                  title,
                  style: const TextStyle(
                      color: Color(0xff314f6a),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )
              : const CircularProgressIndicator(
                  color: Color(0xff314f6a),
                )),
    );
  }
}
