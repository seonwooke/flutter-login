import 'package:flutter/material.dart';

class SnsLoginButton extends StatelessWidget {
  final String imageName;
  final void Function()? onTap;
  const SnsLoginButton({
    required this.imageName,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 48,
          width: 48,
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              width: 1,
              color: Colors.black,
            ),
          ),
          child: Image.asset(
            imageName,
            height: 24,
            width: 24,
          ),
        ),
      ),
    );
  }
}
