import 'package:flutter/material.dart';

class BotaoCronometro extends StatelessWidget {
  final IconData icone;
  final Function() click;

  const BotaoCronometro({Key key, @required this.icone, this.click})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        height: 70,
        child: RaisedButton(
          shape: CircleBorder(),
          color: Colors.white,
          onPressed: click,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(
                  icone,
                  color: Colors.black,
                  size: 35,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
