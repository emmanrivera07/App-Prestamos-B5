import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:qrreaderapp/src/providers/db_provider.dart';

class MostarDocentePage extends StatefulWidget {
  MostarDocentePage({Key key}) : super(key: key);

  @override
  _MostarDocentePageState createState() => _MostarDocentePageState();
}

class _MostarDocentePageState extends State<MostarDocentePage> {
 TextEditingController texteliminar=new TextEditingController();
 DBProvider _db=new  DBProvider ();
  @override
  Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text('Prestamos'),
           leading:
          IconButton(
          icon: Icon(Icons.arrow_back), 
          onPressed:()=> Navigator.pushReplacementNamed(context, 'home'),
          )
           
       ),
       body: Column(
         children: <Widget>[

           Container(
             
        width: 900.0,
        height: 100.0,
        child: SingleChildScrollView(
        
         child: FutureBuilder<Widget>(
       future: mostrarDocente(),
       builder: (BuildContext context, AsyncSnapshot<Widget> snapshot){
         if(snapshot.hasData)
           return snapshot.data;

         return Container(
           
         child:Center(child: CircularProgressIndicator()));
       }
      ))
           ),
          Container(
            height: 400.0,
            width: 300.0,
            child:_elminar(context)
          )
           
         ],
       )

       
     );
   }



Future<Widget> mostrarDocente()async{


final db= await _db.database;

  final res= await db.rawQuery(

    'select * from Docente'
  );





final id=res[0]['idDocente'];
final nombres= res[0]['nombres'];
final apellidos= res[0]['apellidos'];
final carnet= res[0]['carnet'];



return Container(

  width: 80.0,
  height: 100.0,
  child:DataTable(
    headingRowHeight: 20.0,
    
      columns: <DataColumn>[

        DataColumn(label: Text('Id docente')),
        DataColumn(label: Text('Nombres')),
        DataColumn(label: Text('Apellidos')),
        DataColumn(label: Text('Carnet')),
       


        
      ], rows: <DataRow>[

        DataRow(cells: [

          DataCell(Text('$id')),
          DataCell(Text('$nombres')),
          DataCell(Text('$apellidos')),
          DataCell(Text('$carnet')),
       
        ].toList())
      ])
);

  }

  Widget _elminar(context){

    return ListView(children: <Widget>[
       TextField(
        controller:  texteliminar,
        onTap:()=> _scanQrDocente(texteliminar),
        keyboardType: TextInputType.text,
        decoration:  InputDecoration(
          icon: Icon(Icons.home, color: Colors.deepPurple),
          labelText: 'Id docente'
          

        ) ,
    ),
    Divider(),
    SizedBox(height: 50.0),
   Column(

     children: <Widget>[

        RaisedButton(
      child: Container(
        
        child: Text('Eliminar'),
        padding:  EdgeInsets.symmetric(horizontal: 0.0,vertical: 15.0),
        
      ),

      shape: RoundedRectangleBorder(
        borderRadius:  BorderRadius.circular(5.0)
          
        ),
        elevation:  0.0,
        color:  Colors.deepPurple,
        textColor: Colors.white,
      onPressed: ()=>eliminar()
   
    
      
      
    )
     ],
   )
    ]);
    
 }

 Future _scanQrDocente(TextEditingController conIddocente) async {


try{

  conIddocente.text=await BarcodeScanner.scan();
  String dato=conIddocente.text;
  
print('$dato');
}
catch(e){

  conIddocente.text=e.toString();
  
  
}


  }

eliminar()async{


final db= await _db.database;
String ideliminar=texteliminar.text;
  final res= await db.rawDelete(

    'delete from Docente where idDocente="$ideliminar"'
  );

  
  }

}