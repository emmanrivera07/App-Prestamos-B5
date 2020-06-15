import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:qrreaderapp/src/providers/db_provider.dart';

class LoginPage extends StatelessWidget {


DBProvider _db=new DBProvider();

TextEditingController conNombUsuario= new TextEditingController();
TextEditingController conPassword= new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Stack(
        
        children: <Widget>[
          _crearFondo(context),
          _loginForm(context)
        ]
      ),

      
    
    );
    


    
  }

  Widget  _crearFondo(BuildContext context){

    final size =MediaQuery.of(context).size;

    final fondoMorado= Container(

      height: size.height*0.4,
      width: double.infinity,
      decoration:  BoxDecoration(

        gradient: LinearGradient(colors: <Color>[
          Color.fromRGBO(63, 63, 156, 1.0),
          Color.fromRGBO(90, 70, 178, 1.0)
        ]
        

        )
      ),

    ); 

    final circulo =Container(

      width:80.0,
      height:  80.0,

      decoration: BoxDecoration(
      borderRadius:  BorderRadius.circular(100.0),
      color:  Color.fromRGBO(255, 255, 255, 0.05)

      )
    );
    return Stack(

      children: <Widget>[
        fondoMorado,
        Positioned(
          top: 120.0,
          left: 30.0,
          child: circulo),

          Positioned(
          top: -10.0,
          left: 60.0,
          child: circulo),

          Positioned(
          top: 60.0,
          left: 250.0,
          child: circulo),

          Positioned(
          top: 250.0,
          left: 180.0,
          child: circulo),

          Positioned(
          top: 190.0,
          left: 250.0,
          child: circulo),

          Container(

            padding: EdgeInsets.only(top:80.0),

            child: Column(

              children: <Widget>[

                Icon(Icons.person_pin_circle, size:  100.0, color:  Colors.white),      
                SizedBox(height:  10.0, width:  double.infinity),
                Text('Yessenia Tellez', style: TextStyle(color: Colors.white, fontSize: 25.0))
                
              ],
            )
          )
          
        
      ]
    );
  }

  Widget _loginForm(BuildContext context){

    final size= MediaQuery.of(context).size;
    
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[

          SafeArea(
          child: Container(

            height: 180.0,
          )),
          Container(

            width:  size.width*0.85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding:  EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:  BorderRadius.circular(5.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black26,
                  blurRadius:  3.0,
                  offset:  Offset(0.0, 5.0),
                  spreadRadius: 3.0
                )
              ]
               
            ),

            child: Column(

              children: <Widget>[

                Text('Ingreso', style: TextStyle(fontSize: 20.0)),
                SizedBox(height: 60.0),
                _crearUsuario(),
                SizedBox(height: 60.0),
                _crearPassword(),
                SizedBox(height: 60.0),
                _crearBoton(context)

              ]
            )
          )
        ]
      ),
    );
  }


  Widget _crearUsuario(){

    return Container(

      child:TextField(
        controller:  conNombUsuario,
        
        keyboardType: TextInputType.text,
        decoration:  InputDecoration(
          icon: Icon(Icons.supervised_user_circle, color: Colors.deepPurple),
          labelText: 'Nombre usuario'

        ),

        
      )
    );
  }

    Widget _crearPassword(){

    return Container(

      child:TextField(
        controller:  conPassword,
        obscureText:  true,
        keyboardType: TextInputType.text,
      
        decoration:  InputDecoration(
          icon: Icon(Icons.lock_outline, color: Colors.deepPurple),
          labelText: 'Çontrasena',
          
        ),

        
      )
    );
  }

  Widget _crearBoton(context){

    return RaisedButton(
      child: Container(
        child: Text('Ingresar'),
        padding:  EdgeInsets.symmetric(horizontal: 80.0,vertical: 15.0),
        
      ),

      shape: RoundedRectangleBorder(
        borderRadius:  BorderRadius.circular(5.0)
          
        ),
        elevation:  0.0,
        color:  Colors.deepPurple,
        textColor: Colors.white,
      onPressed: ()=>mostrarAdmin(context)
      
      
    );
  }

 

  mostrarAdmin(context)async{
      String usuario;
      String pass;
      final db= await _db.database;
      usuario=conNombUsuario.text;
      pass=conPassword.text;
      
      
      final res= await db.rawQuery(
        
        'SELECT count(*) FROM Administrador where nomb_usuario="$usuario" and pass="$pass"'
        
        
      );
      final band=res[0]['count(*)'];
      print(
        '$band'
      );

      if(band==1){

        Navigator.pushReplacementNamed(context, 'home');

      }

      else{
        _mostrarAlerta(context);
      }
      return band;

      
    }

    
  void _mostrarAlerta(BuildContext context){
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context){
        return AlertDialog(

          title: Text('Alerta!'),
         
          content: Column(
            mainAxisSize: MainAxisSize.min,
            
            children: <Widget>[

              Text('El usuario o contraseña son incorrectas'),
              
            ],
            
          ),
          actions: <Widget>[
            FlatButton(onPressed: ()=>Navigator.of(context).pop(), child:Text('Ok'))
          ],
        );
      },
    );



  }

   mostrarInfoAdmin()async{
   final db= await _db.database;
    final res= await db.rawQuery(
        
        'SELECT * FROM Administrador '
        
        
      );
    final band=res[0]['nombres'];
   
     return band.toString();
} 
}