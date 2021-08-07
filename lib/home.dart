import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'widgets/my_panter.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _marcadores = {

  };
  _onMapCreated (GoogleMapController googleMapController){
    _controller.complete(googleMapController);
  }
 _movimentoCamera () async{
  GoogleMapController googleMapController = await _controller.future;
  googleMapController.animateCamera(
    CameraUpdate.newCameraPosition(
      CameraPosition(
          target: LatLng(-23.562436, -46.655005),
          zoom: 16,
          tilt: 45,
          bearing: -30,
      )
    )
  );
 }
  /*int valorSelecioando = 0;
  List <Widget> _opcoesWidget = [
    Text("Widget 2"),
    Text("Widget 2"),
    Text("Widget 3"),
  ];

  void setandoTela (int valor) {
    setState(() {
      this.valorSelecioando = valor;
    });
  } */

  _carregarMarcadores (){
    Marker marcador  = Marker(
        markerId: MarkerId(
          "casa"
        ),
      position: LatLng (-23.502436, -46.655005),
    );
    setState(() {
      this._marcadores.add(marcador);
    });

  }
  @override
  void initState() {
    _carregarMarcadores();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Center(child: Text("Mapas e Geolocalização"))
      ),
      body: Container(
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: LatLng(-23.502436, -46.655005)
          ),
          onMapCreated: _onMapCreated,
          markers: _marcadores,

        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _movimentoCamera,
        child: Icon(
          Icons.done
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,


    );
  }
}
