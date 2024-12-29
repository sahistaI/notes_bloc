import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_bloc/bloc/list_event.dart';
import 'package:notes_bloc/bloc/list_state.dart';
import 'package:notes_bloc/db_helper.dart';
import 'package:notes_bloc/note_model.dart';

class ListBloc extends Bloc<ListEvent,ListState>{

  DbHelper dbHelper =DbHelper.getInstance();

  ListBloc():super(NotesInitialState()){

    on<AddNoteEvent>((event,emit)async{
      emit(NotesLoadingState());
      bool check = await dbHelper.addNote(event.newNotes);
      if(check){
      List<NoteModel> notes = await dbHelper.fetchNotes();
      emit(NotesLoadedState(notelist: notes));
      }

    });

    on<FetchNoteEvent>((event,emit) async{
      emit(NotesLoadingState());
      List<NoteModel> mData = await dbHelper.fetchNotes();
      emit(NotesLoadedState(notelist: mData));
    });

    on<UpdateEvent>((event,emit)async{
      emit(NotesLoadingState());
      bool check = await dbHelper.UpdateNote(updateNote:event.updateNotes);
      if(check){
        List<NoteModel> upNotes = await dbHelper.fetchNotes();
        emit(NotesLoadedState(notelist: upNotes));
      }
    });

    on<DeleteEvent>((event,emit)async{
      emit(NotesLoadingState());
      bool check = await dbHelper.deleteNotes(id:event.noteId);
      if(check){
        List<NoteModel> delNotes = await dbHelper.fetchNotes();
        emit(NotesLoadedState(notelist: delNotes));
      }


    });


  }




}
