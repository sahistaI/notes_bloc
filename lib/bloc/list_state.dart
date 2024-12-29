import '../note_model.dart';

abstract class ListState {}

class NotesInitialState extends ListState{}
class NotesLoadingState extends ListState{}
class NotesLoadedState extends ListState{
List<NoteModel> notelist;
NotesLoadedState({required this.notelist});
}

class NotesErrorState extends ListState{

  String msgError;
  NotesErrorState({required this.msgError});

}
