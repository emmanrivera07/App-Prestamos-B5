import 'package:flutter/material.dart';

class DocentePage extends StatefulWidget {
  DocentePage({Key key}) : super(key: key);

  @override
  _DocentePageState createState() => _DocentePageState();
}

class _DocentePageState extends State<DocentePage> {
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
              title: Text('Agregar un nuevo docente'),
              
              onTap: ()=>Navigator.pushReplacementNamed(context, 'nuevodocente'),
              ),
            

               ListTile(
              leading: Icon(Icons.edit) ,
              trailing: Icon(Icons.keyboard_arrow_right),
              title: Text('Editar un docente'),
              
              onTap: (){},
              ),

               ListTile(
              leading: Icon(Icons.format_list_bulleted) ,
              trailing: Icon(Icons.keyboard_arrow_right),
              title: Text('Mostrar docentes'),
              
              onTap: ()=>Navigator.pushReplacementNamed(context, 'mostrardocente'),
              ),
          ]
          )
          ]
      );
      
     
  
  
  }
}