import 'package:notes_bloc/db_helper.dart';

class NoteModel {

  int? id;
  String title;
  String desc;

  NoteModel({
  this.id,
    required this.title,
    required this.desc

  });

  factory NoteModel.fromMap(Map<String,dynamic> map){

    return NoteModel(
    id: map[DbHelper.NOTE_COLUMN_ID],
    title: map[DbHelper.NOTE_COLUMN_TITLE],
    desc: map[DbHelper.NOTE_COLUMN_DESC],
  );

  }

  Map<String,dynamic> toMap(){
  return{

    DbHelper.NOTE_COLUMN_TITLE: title,
    DbHelper.NOTE_COLUMN_DESC: desc,

  };
  }



}