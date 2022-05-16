import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({Key? key, required this.label, required this.onTap,}): super(key: key);

  final String label;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 90,
        height: 50,
        alignment: Alignment.center,
        child: Text(label,style: TextStyle(color: Colors.white,fontSize: 15),),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5)
        ),
      ),
    );
  }
}
