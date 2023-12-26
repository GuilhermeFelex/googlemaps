import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Controller extends ChangeNotifier{
  double lat = 0.0;
  double long = 0.0;
  String erro = '';


  Controller() {
    getPosicao();
  }

  getPosicao() async {
    try {
      Position posicao = await _posicaoAtual();
      lat = posicao.latitude;
      long = posicao.longitude;
    }catch(e){
      erro = e.toString();
    }
    notifyListeners();
  }

  Future<Position> _posicaoAtual() async {
    LocationPermission permissao;

    bool ativado = await Geolocator.isLocationServiceEnabled();
    if (! ativado) {
      return Future.error('Por favor, Habilite a localizacao');
    }

    permissao = await Geolocator.checkPermission();
    if (permissao == LocationPermission.denied) {
      permissao = await Geolocator.requestPermission();
      if (permissao == LocationPermission.denied) {
        return Future.error('Voce precisa autorizar o acesso a localizacao');
      }
    }
    
    if (permissao == LocationPermission.deniedForever) {
        return Future.error('Voce precisa autorizar o acesso a localizacao');
    }

    return await Geolocator.getCurrentPosition();

  }
} 