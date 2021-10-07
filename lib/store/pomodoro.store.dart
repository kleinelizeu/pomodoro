import 'dart:async';

import 'package:mobx/mobx.dart';
part 'pomodoro.store.g.dart';

class PomodoroStore = _PomodoroStore with _$PomodoroStore;

enum TipoIntervalo {
  TRABALHO,
  DESCANSO,
}

abstract class _PomodoroStore with Store {
  Timer cronometro;
  @observable
  TipoIntervalo tipoIntervalo = TipoIntervalo.TRABALHO;

  @observable
  bool iniciado = false;

  @observable
  int minutos = 2;

  @observable
  int segundos = 0;
  @observable
  int tempoTrabalho = 2;

  @observable
  int tempoDescanso = 1;

  @action
  void iniciar() {
    iniciado = true;

    cronometro = Timer.periodic(Duration(milliseconds: 100), (timer) {
      if (minutos == 0 && segundos == 0) {
        _trocarTipoIntervalo();
      } else if (segundos == 0) {
        segundos = 59;
        minutos--;
      } else {
        segundos--;
      }
    });
  }

  @action
  void parar() {
    iniciado = false;
    cronometro.cancel();
  }

  @action
  void reiniciar() {
    iniciado = false;
    minutos = estaTrabalhando() ? tempoTrabalho : tempoDescanso;
    segundos = 0;
    // parar();
    cronometro.cancel();
  }

  @action
  void incrementarTempoTrabalho() {
    if (estaTrabalhando()) {
      reiniciar();
    }
    tempoTrabalho++;
  }

  @action
  void decrementarTempoTrabalho() {
    if (estaTrabalhando()) {
      reiniciar();
    }
    tempoTrabalho--;
  }

  @action
  void incrementarTempoDescanso() {
    if (estaDescansando()) {
      reiniciar();
    }
    tempoDescanso++;
  }

  @action
  void decrementarTempoDescanso() {
    if (estaDescansando()) {
      reiniciar();
    }
    tempoDescanso--;
  }

  bool estaTrabalhando() {
    return tipoIntervalo == TipoIntervalo.TRABALHO;
  }

  bool estaDescansando() {
    return tipoIntervalo == TipoIntervalo.DESCANSO;
  }

  void _trocarTipoIntervalo() {
    if (estaTrabalhando()) {
      tipoIntervalo = TipoIntervalo.DESCANSO;
      minutos = tempoDescanso;
    } else {
      tipoIntervalo = TipoIntervalo.TRABALHO;
      minutos = tempoTrabalho;
    }
    segundos = 0;
  }
}
