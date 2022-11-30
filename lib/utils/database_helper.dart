import 'dart:async';
import 'dart:async';
import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:task1/userpreferences.dart';
import 'package:task1/user.dart';

class DatabaseHelper
{
  static DatabaseHelper? _databaseHelper;
  static Database? _database;

  String profileTable = 'profile_table';
  String colPriority = 'priority';
  String name = 'name';
  String interest1 = 'interest1';
  String interest2 = 'interest2';
  String interest3 = 'interest3';
  String about = 'about';
  DatabaseHelper._createInstance();
  factory DatabaseHelper() => _databaseHelper = DatabaseHelper._createInstance();




  Future<Database> get database async => _database ??= await  initializeDatabase();


  Future<Database> initializeDatabase() async
  {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'profile.db';
    var profileDatabase = await openDatabase(path, version: 1,
      onCreate: _createDb
    );
    return profileDatabase;
  }

  void _createDb(Database db, int newVersion) async
  {
      await db.execute('CREATE TABLE $profileTable($name TEXT,$interest1 TEXT,$interest2 TEXT,$interest3 TEXT,$about TEXT)');

  }

  //Fetch Operation

      Future<List<Map<String, dynamic>>> getProfileMapList() async{
         Database db = await this.database;

         var result = await db.query(profileTable, orderBy: '$colPriority ASC');
         return result;
      }

      //Insert Operation

      Future<int> insertProfile(User user) async
      {
         Database db = await this.database;
         var result = await db.insert(profileTable, user.toMap());
         return result;
      }

      Future<int> updateProfile(User user) async
      {
        var db = await this.database;
          var result  = await db.update(profileTable, user.toMap());
          return result;
      }

      Future<int?> getCount() async
      {
        Database db = await this.database;
        List<Map<String,dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $profileTable');
        int? result  = Sqflite.firstIntValue(x);
        return result;
      }


}