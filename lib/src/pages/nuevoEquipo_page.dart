import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:qrreaderapp/src/providers/db_provider.dart';

class NuevoEquipoPage extends StatefulWidget {
  NuevoEquipoPage({Key key}) : super(key: key);

  @override
  _NuevoEquipoPageState createState() => _NuevoEquipoPageState();
}

class _NuevoEquipoPageState extends State<NuevoEquipoPage> {

  TextEditingController conId=TextEditingController();
 TextEditingController conNombre=TextEditingController();

TextEditingController conMarca=TextEditingController();

TextEditingController conModelo=TextEditingController();

TextEditingController conIdadmin=TextEditingController();

DBProvider _db=new DBProvider();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        
        title: Text('Nuevo equipo') ,
        centerTitle: true,
        
       
        leading:
          IconButton(
          icon: Icon(Icons.arrow_back), 
          onPressed:()=> Navigator.pushReplacementNamed(context, 'home'),
          )
           
          
          
        
        
      ),
      extendBody: true,
      body:  _agregarEquipo(context),//metodo de vista de agregar equipos

      
      

   
      
      );
             

    
  }

  Widget _agregarEquipo(context){

    return ListView(children: <Widget>[
         TextField(
        controller:  conId,
        onTap: ()=>_scanQrEquipo(conId),
        keyboardType: TextInputType.text,
        decoration:  InputDecoration(
          icon: Icon(Icons.devices, color: Colors.deepPurple),
          labelText: 'Id equipo'

        ) ,
    ),
    Divider(),
       TextField(
        controller:  conNombre,
        
        keyboardType: TextInputType.text,
        decoration:  InputDecoration(
          icon: Icon(Icons.devices, color: Colors.deepPurple),
          labelText: 'Nombre'

        ) ,
    ),
    Divider(),
    TextField(
        controller:  conMarca,
        
        keyboardType: TextInputType.text,
        decoration:  InputDecoration(
          icon: Icon(Icons.star, color: Colors.deepPurple),
          labelText: 'Marca'

        ) ,
    ),

    Divider(),
    TextField(
        controller:  conModelo,
        
        keyboardType: TextInputType.text,
        decoration:  InputDecoration(
          icon: Icon(Icons.view_module, color: Colors.deepPurple),
          labelText: 'Modelo'

        ) ,
    ),

   

    Divider(),
TextField(
        controller:  conIdadmin,
        onTap: ()=>_scanQrAdmin(conIdadmin),
        keyboardType: TextInputType.text,
        decoration:  InputDecoration(
          icon: Icon(Icons.person, color: Colors.deepPurple),
          labelText: 'Administrador'

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
      onPressed: ()=>agregarEquipo(context)
   
    
      
      
    ),

   
     ],
   ),


    ]);

     

  }



 
 
agregarEquipo(context)async{//metodo de insertar equipos a la bd
final db= await _db.database;
String id=conId.text;
String nombre=conNombre.text;
String marca=conMarca.text;
String modelo=conModelo.text;
String admin=conIdadmin.text;

  final res= await db.rawInsert(
        
        'insert into Equipo( idEquipo, nombre, marca, modelo, idAdmin) values ("$id","$nombre", "$marca", "$modelo", "$admin")'
        
        
      );

      print('insertado $res');
      print(await db.query('Equipo'));

    
      return print('$res') ;
}



Future _scanQrAdmin(TextEditingController conIdamin) async {


try{

  conIdadmin.text=await BarcodeScanner.scan();//almacena la informacion en el texto
  String dato=conIdamin.text;
print('$dato');
}
catch(e){

  conIdadmin.text=e.toString();
  
  
}


  }

  Future _scanQrEquipo(TextEditingController conIdamin) async {


try{

  conId.text=await BarcodeScanner.scan();
  String dato=conId.text;
print('$dato');
}
catch(e){

  conId.text=e.toString();
  
  
}


  }
}