import 'package:flutter/material.dart';
import 'package:googlemaps/controller.dart';
import 'package:provider/provider.dart';

class MapPage extends StatelessWidget{
  MapPage({Key? key}) : super(key: key);
  
  
    @override
    Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Meu local'),
      ),
      
      body: ChangeNotifierProvider<Controller>(
        create: (context) => Controller(),
        child: Builder(builder: (context){
          final local= context.watch<Controller>();

          String mensagem = local.erro == ''
            ? 'Latitude: ${local.lat} / Longitude: ${local.long}'
            : local.erro;

          return Center(child: Text(mensagem));
        }),
      ),
    );
  }
}