import 'package:flutter/material.dart';
import 'package:pomodoro/store/pomodoro.store.dart';
import 'package:provider/provider.dart';

class EntradaTempo extends StatelessWidget {
  final String titulo;
  final int valor;
  final void Function() inc;
  final void Function() dec;

  const EntradaTempo(
      {Key key,
      @required this.titulo,
      @required this.valor,
      this.inc,
      this.dec})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<PomodoroStore>(context);
    return Column(
      children: [
        Text(
          this.titulo,
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Container(
              height: 55,
              width: 55,
              child: RaisedButton(
                color: store.estaTrabalhando() ? Colors.red : Colors.green,
                onPressed: dec,
                shape: CircleBorder(),
                child: Icon(
                  Icons.arrow_downward,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text('${this.valor}min'),
            SizedBox(
              width: 10,
            ),
            Container(
              height: 55,
              width: 55,
              child: RaisedButton(
                color: store.estaTrabalhando() ? Colors.red : Colors.green,
                onPressed: inc,
                shape: CircleBorder(),
                child: Icon(
                  Icons.arrow_upward,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
