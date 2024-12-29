import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_bloc/add_page.dart';
import 'package:notes_bloc/bloc/list_bloc.dart';
import 'package:notes_bloc/bloc/list_event.dart';
import 'package:notes_bloc/bloc/list_state.dart';

import 'note_model.dart';

class ListPage extends StatefulWidget{


  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {

  List<NoteModel> mlist =[];

  @override
  void initState(){
    super.initState();
    context.read<ListBloc>().add(FetchNoteEvent());
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text("My Notes"),
    ),
  body: BlocBuilder<ListBloc,ListState>(
    builder: (context,state){
      return updateDataAccToStat(state);
    },
  ),
    floatingActionButton: FloatingActionButton(
      onPressed: (){
     Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPage()));
     context.read<ListBloc>().add(FetchNoteEvent());
      },
      child: Icon(Icons.add),
    ),
  );
  }

  Widget updateDataAccToStat(ListState state){
    if(state is NotesLoadingState){
      return Center(child: CircularProgressIndicator(),);
    } else if (state is NotesErrorState){
      return Center(child: Text("${state.msgError}"),);
    } else if (state is NotesLoadedState){
      mlist = state.notelist;
      return mlist.isNotEmpty ? ListView.builder(
          itemCount: mlist.length,
          itemBuilder: (context,index){
          return ListTile(
            leading: Text("${index+1}",style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold)),
            title: Text(state.notelist[index].title,style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold)),
            subtitle: Text(state.notelist[index].desc,style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold)),
            trailing: SizedBox(width: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(onPressed: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPage(
                     isUpdate: true,
                     id: state.notelist[index].id,
                     title: state.notelist[index].title,
                     desc: state.notelist[index].desc,
                   )));

                  }, icon:Icon(Icons.edit),color: Colors.indigo,),
                  IconButton(onPressed: (){
                    context.read<ListBloc>().add(DeleteEvent(noteId: index));


                  }, icon:Icon(Icons.delete),color: Colors.red,),
                ],
              ),
            ),
          );

          }) :Center(
        child: Text("No Notes Yet"),
      );
    }
    else {
      return Container();
    }
  }


}