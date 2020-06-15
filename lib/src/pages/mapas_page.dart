import 'package:flutter/material.dart';


class PrestamosPage extends StatelessWidget {
  const PrestamosPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: _lista(context),
    );
  }

 Widget _lista(context) {//lista de la funciones


      
      return ListView(
        
          padding: EdgeInsets.all(10.0),
          children: <Widget>[
              Column(

          children: <Widget>[

            ListTile(
              leading: Icon(Icons.add) ,
              trailing: Icon(Icons.keyboard_arrow_right),
              title: Text('Agregar un nuevo prestamo'),
              
              onTap: ()=>Navigator.pushReplacementNamed(context, 'nuevoprestamo'),//accion clic para cambiar de ventana
              ),
             

               ListTile(
              leading: Icon(Icons.edit) ,
              trailing: Icon(Icons.keyboard_arrow_right),
              title: Text('Editar un prestamo'),
              
              onTap: (){},
              ),

               ListTile(
              leading: Icon(Icons.format_list_bulleted) ,
              trailing: Icon(Icons.keyboard_arrow_right),
              title: Text('Mostrar prestamos'),
              
              onTap: ()=>Navigator.pushReplacementNamed(context, 'mostrarprestamo'),
              ),
          ]
          )
          ]
      );
      
     
  
  
  }
    
}