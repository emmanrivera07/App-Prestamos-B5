import 'package:barcode_scan/barcode_scan.dart';//libreria para la funcion scanner
import 'package:flutter/material.dart';
import 'package:qrreaderapp/src/providers/db_provider.dart';

class MostrarEquipo extends StatefulWidget {
  MostrarEquipo({Key key}) : super(key: key);

  @override
  _MostrarEquipoState createState() => _MostrarEquipoState();
}

class idPrestamo{



}

class _MostrarEquipoState extends State<MostrarEquipo> {
  TextEditingController texteliminar=new TextEditingController();
 DBProvider _db=new  DBProvider ();
  @override
  Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text('Equipos'),
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
       future: mostrarEquipo(), //metodo vista de mostar los equipos
       builder: (BuildContext context, AsyncSnapshot<Widget> snapshot){
         if(snapshot.hasData)
           return snapshot.data;

         return Container(child: Center(
          child: CircularProgressIndicator()// sino no existe datos carga un loading
         ));
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


Future<Widget> mostrarEquipo()async{ //vista de la datatable que muestre los equipos


final db= await _db.database;

  final res= await db.rawQuery(

    'select * from Equipo '
  );





final id=res[1]['idEquipo'] ;
final nombre= res[1]['nombre'];
final marca= res[1]['marca'];
final modelo= res[1]['modelo'];
final admin= res[1]['idAdmin'];

final newListId=res.map((m)=>m['idPrestamo']).toList();
return Container(

  width: 80.0,
  height: 100.0,
  child:DataTable(
    headingRowHeight: 20.0,
    
      columns: <DataColumn>[

        DataColumn(label: Text('Id equipo')),
        DataColumn(label: Text('Nombre')),
        DataColumn(label: Text('Marca')),
        DataColumn(label: Text('Modelo')),
        DataColumn(label: Text('Id admin')),


        
      ], rows: <DataRow>[

        DataRow( selected: true,cells: [

          DataCell(Text('$id')),
          DataCell(Text('$nombre')),
          DataCell(Text('$marca')),
          DataCell(Text('$modelo')),
          DataCell(Text('$admin')),
 
        ].toList())
      ])
);

  }

  Widget _elminar(context){//vista eliminar

    return ListView(children: <Widget>[
       TextField(
        controller:  texteliminar,
        onTap:()=> _scanQrEquipo(texteliminar),
        keyboardType: TextInputType.text,
        decoration:  InputDecoration(
          icon: Icon(Icons.devices, color: Colors.deepPurple),
          labelText: 'Id equipo'

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
      onPressed: ()=>eliminar()// llamada de metodo eliminar para el evento click
   
    
      
      
    )
     ],
   )
    ]);
    
 }

  eliminar()async{//metodo de eliminar con un consulta a la bd


final db= await _db.database;
String ideliminar=texteliminar.text;
  final res= await db.rawDelete(

    'delete from Equipo where idEquipo="$ideliminar"'
  );

  
  }


Future _scanQrEquipo(TextEditingController conIdequipo) async {//metodo de scanneo del equipo


try{

  conIdequipo.text=await BarcodeScanner.scan();//aqui la informacion se imprimi en la caja de texto
  String dato=conIdequipo.text;
  
print('$dato');
}
catch(e){

  conIdequipo.text=e.toString();
  
  
}


  }

}


  
