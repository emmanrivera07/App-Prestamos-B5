import 'package:flutter/material.dart';

class EquiposPage extends StatelessWidget {
  const EquiposPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: _lista(context),
    );
  }

 Widget _lista(context) {


      
      return ListView(
        
          padding: EdgeInsets.all(10.0),
          children: <Widget>[
              Column(

          children: <Widget>[

            ListTile(
              leading: Icon(Icons.add) ,
              trailing: Icon(Icons.keyboard_arrow_right),
              title: Text('Agregar un nuevo equipo'),
              
              onTap: ()=>Navigator.pushReplacementNamed(context, 'nuevoequipo'),
              ),
              

               ListTile(
              leading: Icon(Icons.edit) ,
              trailing: Icon(Icons.keyboard_arrow_right),
              title: Text('Editar un equipo'),
              
              onTap: (){},
              ),

               ListTile(
              leading: Icon(Icons.format_list_bulleted) ,
              trailing: Icon(Icons.keyboard_arrow_right),
              title: Text('Mostrar equipo'),
              
              onTap: ()=>Navigator.pushReplacementNamed(context, 'mostrarequipo'),
              ),
          ]
          )
          ]
      );
      
     
  
  
  }
    
}