import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qrreaderapp/src/pages/login_page.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
export 'package:qrreaderapp/src/providers/db_provider.dart';


class DBProvider{


  static Database _database; //Declaración de mi BD

  static final  DBProvider db= new DBProvider(); //objeto de la bd

  DBProvider();



 Future <Database> get database async{
    if(_database!=null)return _database; //Esto significa que si no existe la BD entonces se crea

    _database=await initDB(); //Llamo un método que me inicie la BD

    return _database;

   
  }

  

   initDB() async {//Iniciar la BD

     Directory documentsDirectory=await getApplicationDocumentsDirectory(); 

     final path =join(documentsDirectory.path, 'InventoryBarcode.db'); //Dirección de la base de datos y el nombre del archivo de la base de datos//


      return await openDatabase( //abre la bd
        path, 
        version: 1, //Esta version se aumenta si en mi BD hay un cambio
        onOpen: (db){

        },

        onCreate: (Database db, int version)async{ //Instancia y versión de la base de datos, hasta este momento ya está creada la base de datos

         await db.execute(  //Creación de las tablas
            
            'create table Docente('
           'idDocente varchar(50) primary key, '
           'nombres varchar(50),'
           'apellidos varchar(50),'
           'carnet varchar(15)' 
            ' );'
         );
         await db.execute(
            'create table Administrador('
           'idAdmin varchar(50) primary key, '
           'nombres varchar(50),'
           'apellidos varchar(50),'
           'carnet varchar(15),'
           'nomb_usuario varchar(60), '
           'pass varchar(100)'
            
            ' );'
         );

         await db.execute(
             'create table Equipo('
           'idEquipo varchar(20) primary key, '
           'nombre varchar(30), '
           'marca varchar(30), '
           'modelo varchar(30), '
           'idAdmin integer,'
           'foreign key(idAdmin) references Administrador(idAdmin)' 
            ' );'
         );

         await db.execute(
            'create table Prestamo('
           'idPrestamo integer primary key, '
           'aula varchar(20),'
           'nivel varchar(20),'
           'fecha_entrega datetime, '
           'fecha_uso datetime, '
           'hora_inicio datetime, '
           'hora_fin datetime, '
           'carrera varchar(30), '
           'asignatura varchar(30), '
           'idDocente varchar(50), '
           'idEquipo varchar(20), '
           'foreign key(idDocente) references Docente(idDocente), '
           'foreign key(idEquipo) references Equipo(idEquipo)'
            ' );'

         );

         await db.execute(
             'create table Detalle_Prestamo('
           'idDetalle_Prestamo integer primary key, '
           'idPrestamo integer, '
           'idEquipo integer, '
           'foreign key(idPrestamo) references Prestamo(idPrestamo), '
           'foreign key(idEquipo) references Prestamo(idEquipo)' 
            ' );'
         );
            
            await db.rawInsert(//insercion del usuario que accederá a la app
              'Insert into Administrador(idAdmin, nombres, apellidos, carnet, nomb_usuario, pass) values ("1212006650006Q","Yesenia", "Tellez", "1355620", "ytellez1309", "1234")'
              
            );


            
        }
        
        );

      

    }

    
    
}