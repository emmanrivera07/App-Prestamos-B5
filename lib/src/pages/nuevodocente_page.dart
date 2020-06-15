import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:qrreaderapp/src/providers/db_provider.dart';

class NuevoDocentePAge extends StatefulWidget {
  NuevoDocentePAge({Key key}) : super(key: key);

  @override
  _NuevoDocentePAgeState createState() => _NuevoDocentePAgeState();
}

class _NuevoDocentePAgeState extends State<NuevoDocentePAge> {
 TextEditingController conIddocente=TextEditingController();

TextEditingController conNombres=TextEditingController();

TextEditingController conApellidos=TextEditingController();

TextEditingController conCarnet=TextEditingController();

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
      body:  _agregarDocente(context),//metodo de la vistas para agregar

      
      

   
      
      );
             

    
  }

  Widget _agregarDocente(context){

    return ListView(children: <Widget>[

  TextField(
        controller:  conIddocente,
        onTap: ()=>_scanQrDocente(conIddocente),
        keyboardType: TextInputType.text,
        decoration:  InputDecoration(
          icon: Icon(Icons.person, color: Colors.deepPurple),
          labelText: 'Id docente'

        ) ,
    ),
    Divider(),
       TextField(
        controller:  conNombres,
        
        keyboardType: TextInputType.text,
        decoration:  InputDecoration(
          icon: Icon(Icons.home, color: Colors.deepPurple),
          labelText: 'Nombres'

        ) ,
    ),
    Divider(),
    TextField(
        controller:  conApellidos,
        
        keyboardType: TextInputType.text,
        decoration:  InputDecoration(
          icon: Icon(Icons.star, color: Colors.deepPurple),
          labelText: 'Apellidos'

        ) ,
    ),

    Divider(),
    TextField(
        controller:  conCarnet,
        
        keyboardType: TextInputType.text,
        decoration:  InputDecoration(
          icon: Icon(Icons.perm_identity, color: Colors.deepPurple),
          labelText: 'Carnet'

        ) ,
    ),

   

    Divider(),


   
  
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
      onPressed: ()=>agregarDocente(context)
   
    
      
      
    ),

   
     ],
   ),


    ]);

     

  }



 
  

agregarDocente(context)async{// metodo para agregar el docente a la bd
final db= await _db.database;
String id=conIddocente.text;
String nombres=conNombres.text;
String apellidos=conApellidos.text;
String carnet=conCarnet.text;

  final res= await db.rawInsert(
        
        'insert into Docente(idDocente ,nombres, apellidos, carnet) values ("$id", "$nombres", "$apellidos", "$carnet")'
        
        
      );

     
      print(await db.query('Docente'));

    
      return print('$res') ;
}


Future _scanQrDocente(TextEditingController conIddocente) async {//scaneo de docente


try{

  conIddocente.text=await BarcodeScanner.scan();//almacena en la caja de texto la informacion
  String dato=conIddocente.text;
print('$dato');
}
catch(e){

  conIddocente.text=e.toString();
  
  
}


  }
}