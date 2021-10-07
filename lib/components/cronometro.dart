import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pomodoro/components/botao_cronometro.dart';
import 'package:pomodoro/store/pomodoro.store.dart';
import 'package:provider/provider.dart';

class Cronometro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final store = Provider.of<PomodoroStore>(context);
    return Observer(builder: (_) {
      return Container(
        decoration: BoxDecoration(
            gradient: store.estaTrabalhando()
                ? LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                        Colors.redAccent,
                        Colors.black,
                      ])
                : LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                        Colors.green,
                        Colors.black,
                      ])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              store.estaTrabalhando() ? "Mantenha o Foco" : "Hora de Relaxar",
              style: TextStyle(
                fontSize: 40,
                color: Colors.white,
              ),
            ),
            Stack(
              children: [
                Image.asset(
                  "assets/pomodoro.png",
                ),
                Positioned(
                  top: 180,
                  left: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          color: Colors.black45,
                          child: Text(
                            "${store.minutos.toString().padLeft(2, '0')}",
                            style: TextStyle(
                              fontSize: 90,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        " ",
                        style: TextStyle(
                          fontSize: 100,
                          color: Colors.white,
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          color: Colors.black45,
                          child: Text(
                            "${store.segundos.toString().padLeft(2, '0')}",
                            style: TextStyle(
                              fontSize: 90,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                !store.iniciado
                    ? BotaoCronometro(
                        icone: Icons.play_arrow,
                        click: store.iniciar,
                      )
                    : BotaoCronometro(
                        icone: Icons.stop,
                        click: store.parar,
                      ),
                BotaoCronometro(
                  icone: Icons.refresh,
                  click: store.reiniciar,
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
