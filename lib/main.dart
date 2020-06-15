import 'package:flutter/material.dart';
import 'package:qrreaderapp/src/pages/direcciones_page.dart';
import 'package:qrreaderapp/src/pages/docente_page.dart';
import 'package:qrreaderapp/src/pages/home_page.dart';
import 'package:qrreaderapp/src/pages/login_page.dart';
import 'package:qrreaderapp/src/pages/mapas_page.dart';

import 'package:qrreaderapp/src/pages/mostrarPrestamo_page.dart';
import 'package:qrreaderapp/src/pages/mostrardocente_page.dart';
import 'package:qrreaderapp/src/pages/mostrarequipo_page.dart';
import 'package:qrreaderapp/src/pages/nuevoEquipo_page.dart';
import 'package:qrreaderapp/src/pages/nuevodocente_page.dart';
import 'package:qrreaderapp/src/pages/nuevoprestamo_page.dart';

 
void main() => runApp(MyApp());//corrida de la app
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QRScanner',
      initialRoute: 'login',//ruta inicial al cargar la app
      routes: {//rutas
        'home': (BuildContext context )=>HomePage(),
        'login':(BuildContext context)=>LoginPage(),
        'equipo':(BuildContext context)=>EquiposPage(),
        'docente':(BuildContext context)=>DocentePage(),
        'mapas':(BuildContext context)=>PrestamosPage(),
        'nuevoprestamo':(BuildContext context)=>NuevoPrestamoPage(),
        'mostrarprestamo':(BuildContext context)=>MostrarPrestamoPage(),
        'nuevoequipo':(BuildContext context )=>NuevoEquipoPage(),
        'mostrarequipo':(BuildContext context)=>MostrarEquipo(),
        'nuevodocente':(BuildContext context)=>NuevoDocentePAge(),
        'mostrardocente':(BuildContext context)=>MostarDocentePage()
      },
      theme: ThemeData(

        primaryColor: Colors.deepPurple
      ),

    
    );
  }
}