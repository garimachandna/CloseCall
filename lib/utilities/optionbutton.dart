import 'package:flutter/material.dart';

class OptionButton extends StatelessWidget {
  final String data;
  final void Function() onPressed;
  final Color backgroundColour = Color.fromRGBO(48, 43, 99, 1);

  OptionButton({required this.data, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        margin: EdgeInsets.only(bottom: 30.0),
        child: SizedBox(
          width: 266,
          height: 50,
          child: Material(
            elevation: 5.0,
            color: backgroundColour.withAlpha(0),
            borderRadius: BorderRadius.circular(20.0),
            child: OutlinedButton(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  child: Flexible(
                    child: Text(data,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontFamily: 'Raleway',
                        )),
                  ),
                ),
              ),
              onPressed: onPressed,
            ),
          ),
        ),
      ),
    );
  }
}
