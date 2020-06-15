

import 'package:flutter/material.dart';

import 'package:qrreaderapp/src/providers/db_provider.dart';


 class MostrarPrestamoPage extends StatelessWidget {
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
       future: mostrar(),//metodo mostrar 
       builder: (BuildContext context, AsyncSnapshot<Widget> snapshot){
         if(snapshot.hasData)
           return snapshot.data;

         return Container(child:Center(child: CircularProgressIndicator()));
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




Future<Widget> mostrar()async{//metodo mostrar en la datatable


final db= await _db.database;

  final res= await db.rawQuery(

    'select * from Prestamo '
  );





final id=res[0]['idPrestamo'];
final aula= res[0]['aula'];
final nivel= res[0]['nivel'];
final fechaentrega= res[0]['fecha_entrega'];
final fechauso= res[0]['fecha_uso'];
final horainicio= res[0]['hora_inicio'];
final horafin= res[0]['hora_fin'];
final carrera= res[0]['carrera'];
final asignatura= res[0]['asignatura'];
final idDocente= res[0]['idDocente'];
final idEquipo= res[0]['idEquipo'];


    final newList=res.map((m)=>m['idPrestamo']).toList();

return Container(

  width: 80.0,
  height: 100.0,
  child:DataTable(
    headingRowHeight: 20.0,
    
      columns: <DataColumn>[

        DataColumn(label: Text('Id prestamo')),
        DataColumn(label: Text('Aula')),
        DataColumn(label: Text('Nivel')),
        DataColumn(label: Text('FEcha entrega')),
        DataColumn(label: Text('FEcha uso')),
        DataColumn(label: Text('Hora inicio')),
        DataColumn(label: Text('Hora fin')),
        DataColumn(label: Text('Carrera')),
        DataColumn(label: Text('Asignatura')),
        DataColumn(label: Text('Id docente')),
        DataColumn(label: Text('Id Equipo')),

        
      ], rows: <DataRow>[

        DataRow( selected: true,cells: [

          DataCell(Text('$id')),
          DataCell(Text('$aula')),
          DataCell(Text('$nivel')),
          DataCell(Text('$fechaentrega')),
          DataCell(Text('$fechauso')),
          DataCell(Text('$horainicio')),
          DataCell(Text('$horafin')),
          DataCell(Text('$carrera')),
          DataCell(Text('$asignatura')),
          DataCell(Text('$idDocente')),
          DataCell(Text('$idEquipo')),
          
        ].toList())
      ])
);

  }

  Widget _elminar(context){

    return ListView(children: <Widget>[
       TextField(
        controller:  texteliminar,
        
        keyboardType: TextInputType.text,
        decoration:  InputDecoration(
          icon: Icon(Icons.home, color: Colors.deepPurple),
          labelText: 'Id prestamo'

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

  eliminar()async{//metodo eliminar prestamo


final db= await _db.database;
String ideliminar=texteliminar.text;
  final res= await db.rawDelete(

    'delete from Prestamo where idPrestamo=$ideliminar '
  );

  
  }


 
 }      
           
               




  


  
