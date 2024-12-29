import 'package:notes_bloc/note_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper{

  DbHelper._();

  static DbHelper getInstance() =>DbHelper._();

  Database? mDB;
  static final String TABLE_NOTE = "blocnote";
  static final String NOTE_COLUMN_ID = "n_id";
  static final String NOTE_COLUMN_TITLE = "n_title";
  static final String NOTE_COLUMN_DESC = "n_desc";

  Future<Database> initDB() async{
  mDB =mDB ?? await openDB();
  print("Open DB!!!");
  return mDB!;
  }

  Future<Database> openDB() async {
  var dirPath = await getApplicationDocumentsDirectory();
  var dbPath =join(dirPath.path,"blocnotes.db");

  return openDatabase(dbPath, version: 1, onCreate: (db, version){
  print("DB Created..!!");
  db.execute("create table $TABLE_NOTE ( $NOTE_COLUMN_ID integer primary key autoincrement, $NOTE_COLUMN_TITLE text, $NOTE_COLUMN_DESC text)");
  });
  }

  // Insert

  Future<bool> addNote(NoteModel addnote) async{

    Database db = await initDB();
    int rowsEffected = await db.insert(TABLE_NOTE, addnote.toMap());
    return rowsEffected>0;
  }

  // Select

  Future<List<NoteModel>>fetchNotes()async{
    Database db = await initDB();
    List<NoteModel> mNotes=[];
    List<Map<String,dynamic>> allNotes = await db.query(TABLE_NOTE);

    for(Map<String,dynamic> eachData in allNotes){
      NoteModel eachNote = NoteModel.fromMap(eachData);
      mNotes.add(eachNote);
    }
    return mNotes;
  }

  // Update

  Future<bool> UpdateNote({required NoteModel updateNote})async{

    Database db = await initDB();
    int rowsEffected = await db.update(TABLE_NOTE, updateNote.toMap(),
      where: "$NOTE_COLUMN_ID =?", whereArgs: [updateNote.id]
    );
    return rowsEffected>0;
  }
  // delete

  Future<bool> deleteNotes({required int id}) async{
    Database db = await initDB();
    int rowsEffected = await db.delete(TABLE_NOTE, where: "$NOTE_COLUMN_ID = ?", whereArgs: ['$id'] );
    return rowsEffected>0;
  }







}