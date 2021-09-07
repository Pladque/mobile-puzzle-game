import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String value;

  const CustomInputField(this.value, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 3,
      height: 40,
      color: const Color.fromARGB(0, 15, 15, 15),
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: TextField(
        style: const TextStyle(color: Colors.white),
        readOnly: true,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(10.0),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
              width: 1.0,
            ),
          ),
        ),
        controller: TextEditingController(
          text: value,
        ),
      ),
    );
  }
}
