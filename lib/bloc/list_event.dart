import 'package:notes_bloc/note_model.dart';

class ListEvent {}

class AddNoteEvent extends ListEvent{
  NoteModel newNotes;
  AddNoteEvent({required this.newNotes});
}
class FetchNoteEvent extends ListEvent{}
class UpdateEvent extends ListEvent{
  NoteModel updateNotes;
  UpdateEvent({required this.updateNotes});
}
class DeleteEvent extends ListEvent{
  final int noteId;
  DeleteEvent({required this.noteId});

}