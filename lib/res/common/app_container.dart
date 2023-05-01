import 'package:flutter/material.dart';

class AppContainer extends StatelessWidget {
  final String? hintText;
  final bool? isData;
  const AppContainer({Key? key, this.hintText, this.isData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 55,
      // height: MediaQuery.of(context).size.height / 12,
      // width: MediaQuery.of(context).size.width / 1,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        hintText ?? "",
        style: TextStyle(
          color: isData! ? Colors.black : const Color(0xFFFFFFFF),
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
