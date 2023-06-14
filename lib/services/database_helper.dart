import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/contact.dart';

class DataBaseHelper {
  static const int _version = 1;
  static const String _dbName = "Contacts.db";

  static Future<Database> _openDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async => await db.execute(
            'CREATE TABLE Contact(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT, lastname TEXT, maternalsurname TEXT, number INTEGER, gender TEXT, civilstatus TEXT);'),
        version: _version);
  }

  static Future<int> addContact(Contact contact) async {
    final database = await _openDB();
    return await database.insert("Contact", contact.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateContact(Contact contact) async {
    final database = await _openDB();

    return await database.update("Contact", contact.toJson(),
        where: 'id = ?',
        whereArgs: [contact.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteContact(Contact contact) async {
    final database = await _openDB();
    return await database
        .delete("Contact", where: 'id = ?', whereArgs: [contact.id]);
  }

  static Future<List<Contact>?> getAllContacts() async {
    final database = await _openDB();
    final List<Map<String, dynamic>> maps = await database.query("Contact");

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(maps.length, (index) => Contact.fromJson(maps[index]));
  }
}
