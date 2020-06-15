

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';

import 'package:qrreaderapp/src/providers/db_provider.dart';
class NuevoPrestamoPage extends StatefulWidget {


  @override
  _NuevoPrestamoPageState createState() => _NuevoPrestamoPageState();
}

class _NuevoPrestamoPageState extends State<NuevoPrestamoPage> {
TextEditingController conAula=TextEditingController();

TextEditingController conNivel=TextEditingController();

TextEditingController conFechaEntrega=TextEditingController();

TextEditingController conFechauso=TextEditingController();

TextEditingController conHoraInicio=TextEditingController();

TextEditingController conHoraFin=TextEditingController();

TextEditingController conAsignatura=TextEditingController();

TextEditingController conCarrera=TextEditingController();

TextEditingController conDocente=TextEditingController();

TextEditingController conEquipo=TextEditingController();

DBProvider _db=new DBProvider();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        
        title: Text('Nuevo prestamo') ,
        centerTitle: true,
        
       
        leading:
          IconButton(
          icon: Icon(Icons.arrow_back), 
          onPressed:()=> Navigator.pushReplacementNamed(context, 'home'),
          )
           
          
          
        
        
      ),
      extendBody: true,
      body:  _agregarPrestamo(context),//metodo de vista

      
      

   
      
      );
             

    
  }

  Widget _agregarPrestamo(context){

    return ListView(children: <Widget>[
       TextField(
        controller:  conAula,
        
        keyboardType: TextInputType.text,
        decoration:  InputDecoration(
          icon: Icon(Icons.home, color: Colors.deepPurple),
          labelText: 'Aula'

        ) ,
    ),
    Divider(),
    TextField(
        controller:  conNivel,
        
        keyboardType: TextInputType.text,
        decoration:  InputDecoration(
          icon: Icon(Icons.grade, color: Colors.deepPurple),
          labelText: 'Nivel'

        ) ,
    ),

    Divider(),
    TextField(
        controller:  conFechaEntrega,
        
        keyboardType: TextInputType.number,
        decoration:  InputDecoration(
          icon: Icon(Icons.date_range, color: Colors.deepPurple),
          labelText: 'Fecha de entrega'

        ) ,
    ),

    Divider(),
    TextField(
        controller:  conFechauso,
        
        keyboardType: TextInputType.number,
        decoration:  InputDecoration(
          icon: Icon(Icons.date_range, color: Colors.deepPurple),
          labelText: 'Fecha de uso'

        ) ,
    ),

    Divider(),
    TextField(
        controller:  conHoraInicio,
        
        keyboardType: TextInputType.text,
        decoration:  InputDecoration(
          icon: Icon(Icons.date_range, color: Colors.deepPurple),
          labelText: 'Hora de inicio'

        ) ,
    ),

    Divider(),
    TextField(
        controller:  conHoraFin,
        
        keyboardType: TextInputType.text,
        decoration:  InputDecoration(
          icon: Icon(Icons.date_range, color: Colors.deepPurple),
          labelText: 'Hora final'

        ) ,
    ),

    Divider(),
    TextField(
        controller:  conCarrera,
        
        keyboardType: TextInputType.text,
        decoration:  InputDecoration(
          icon: Icon(Icons.bookmark, color: Colors.deepPurple),
          labelText: 'Carrera'

        ) ,
    ),

    Divider(),
    TextField(
        controller:  conAsignatura,
        
        keyboardType: TextInputType.text,
        decoration:  InputDecoration(
          icon: Icon(Icons.book, color: Colors.deepPurple),
          labelText: 'Asignatura'

        ) ,
    ),

    Divider(),
TextField(
        controller:  conDocente,
        onTap: ()=>_scanQrDocente(conDocente),
        keyboardType: TextInputType.text,
        decoration:  InputDecoration(
          icon: Icon(Icons.book, color: Colors.deepPurple),
          labelText: 'Docente'

        ) ,
    ),

    Divider(),
    

        TextField(
        controller:  conEquipo,
        onTap: ()=>_scanQrEquipo(conEquipo),
        keyboardType: TextInputType.text,
        decoration:  InputDecoration(
          icon: Icon(Icons.devices, color: Colors.deepPurple),
          labelText: 'Equipo'
          
        ) ,
        
    ),
 
      
     
  
    SizedBox(height: 50.0),
   Column(

     children: <Widget>[

        RaisedButton(
      child: Container(
        
        child: Text('Guardar'),
        padding:  EdgeInsets.symmetric(horizontal: 0.0,vertical: 15.0),
        
      ),

      shape: RoundedRectangleBorder(
        borderRadius:  BorderRadius.circular(5.0)
          
        ),
        elevation:  0.0,
        color:  Colors.deepPurple,
        textColor: Colors.white,
      onPressed: ()=>agregarPrestamo(context)//llamada para agregar 
   
    
      
      
    ),

   
     ],
   ),


    ]);

     

  }





agregarPrestamo(context)async{//metodo de agregar a la bd
final db= await _db.database;
String aula=conAula.text;
String nivel=conNivel.text;
String fechaEntrega=conFechaEntrega.text;
String fechaUso=conFechauso.text;
String horaInicio=conHoraInicio.text;
String horaFin=conHoraFin.text;
String carrera=conCarrera.text;
String asignatura=conAsignatura.text;
String idDocente=conDocente.text;
String idEquipo=conEquipo.text;
  final res= await db.rawInsert(
        
        'insert into Prestamo(aula, nivel, fecha_entrega, fecha_uso, hora_inicio, hora_fin, carrera, asignatura, idDocente, idEquipo) values ("$aula", "$nivel", "$fechaEntrega", "$fechaUso", "$horaInicio", "$horaFin", "$carrera", "$asignatura", "$idDocente", "$idEquipo")'
        
        
      );

      print('insertado $res');
      print(await db.rawQuery('select * from Prestamo'));

   
      return print('$res') ;
}


  Future _scanQrEquipo(TextEditingController conEquipo) async {//scanneo


try{

  conEquipo.text=await BarcodeScanner.scan();
  String dato=conEquipo.text;
print('$dato');
}
catch(e){

  conEquipo.text=e.toString();
  
  
}


  }

Future _scanQrDocente(TextEditingController conDocente) async {


try{

  conDocente.text=await BarcodeScanner.scan();
  String dato=conDocente.text;
print('$dato');
}
catch(e){

  conDocente.text=e.toString();
  
  
}


  }
}