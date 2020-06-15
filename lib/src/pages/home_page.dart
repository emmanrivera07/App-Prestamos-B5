

import 'package:flutter/material.dart';



import 'package:qrreaderapp/src/pages/direcciones_page.dart';
import 'package:qrreaderapp/src/pages/docente_page.dart';
import 'package:qrreaderapp/src/pages/mapas_page.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';




class HomePage extends StatefulWidget {
  

  
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String result="Esta es la pagina de mapas";


 
Future _scanQr() async {


String futurestring="";

try{

  futurestring=await BarcodeScanner.scan();

}
catch(e){

  futurestring=e.toString();
}

   print('Este Es el mensaje del codigo $futurestring');

   
  }

int currentIndex=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        
        title: Text('Inventory Barcode') ,
        centerTitle: true,
        
       
        actions: <Widget>[

          IconButton(
          icon: Icon(Icons.close), 
          onPressed:()=> _mostrarAlerta(context)) 
        ],
        
      ),
      body:    
      _callPage(currentIndex),
      bottomNavigationBar: _crearBottomNavigationBar(),
     

     
      
    );
  }

  Widget _crearbottomnavigator(){


    return BottomNavigationBar(
      currentIndex: 0,
      onTap: (index){},
      items:[

        BottomNavigationBarItem(
          icon: Icon(Icons.filter_list),
          title: Text('Préstamos')
          ),

          BottomNavigationBarItem(
          icon: Icon(Icons.devices),
          title: Text('Equipos')
          ),
          
      ]
      
      );
  }

  

  Widget _callPage(int paginaActual){

    switch(paginaActual){

      case 0: return PrestamosPage();
      case 1: return EquiposPage();
      case 2: return DocentePage();

      default: return PrestamosPage();

    }

  }

  Widget _crearBottomNavigationBar(){


    return BottomNavigationBar(
      currentIndex: currentIndex,
    items: [

      BottomNavigationBarItem(
        icon: Icon(Icons.library_books),
        title: Text('Préstamos')      
        ),

      BottomNavigationBarItem(
        icon: Icon(Icons.devices),
        title: Text('Equipos')      
        ),
        BottomNavigationBarItem( 
          icon: Icon(Icons.person),
          title: Text('Docentes')
          )

    ],
    onTap: (index){

      setState(() {
        currentIndex=index;
      });
    });

  }

  void _mostrarAlerta(BuildContext context){
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context){
        return AlertDialog(

          title: Icon(Icons.error_outline, size: 50.0,), titlePadding: EdgeInsets.only(right:200.0, top: 20.0),

          
        
          content: Column(
            mainAxisSize: MainAxisSize.min,
            
            children: <Widget>[
              
              Text('Desea cerrar sesion?') ,
              
            ],
            
          ),
          actions:  <Widget>[
                  
                 FlatButton(onPressed: ()=>Navigator.pushReplacementNamed(context, 'login'),
                  child: Text('Ok')),  

                 FlatButton(onPressed: ()=>Navigator.of(context).pop(),
                  child: Text('Cancelar'))
                ],
        );
      },
    );
  }
}