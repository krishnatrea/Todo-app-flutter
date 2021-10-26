import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todoapp/bloc/todo_bloc.dart';
import 'package:todoapp/constants/uiconstants.dart';
import 'package:todoapp/models/todo.dart';
import 'package:todoapp/screen/edittodo.dart';


class TodoListTile extends StatelessWidget {
  TodoListTile({Key? key, required this.tododata}):super(key: key);

  Tododata tododata ;
  @override
  Widget build(BuildContext context) {
    log(tododata.title);
    return Padding(
        padding: EdgeInsets.all(12.h),
        child: Material(
          elevation: 5,
          borderRadius: BorderRadius.circular(5.h),
          child: ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => EditTodo(tododata: tododata)) );
            },
            leading: Text(formatDate(
                tododata.createdAt, ['HH', ':', "nn"])),
            title: Text(
              tododata.title,
              style: tododata.done == 0 ?  titletext : doneText,
            ),
            subtitle: Text(
              tododata.description,
              style: tododata.done == 0 ?  titletext.copyWith(
                color: Colors.black38,
              ) : doneText.copyWith(
                color: Colors.black38,
              ), 
            ),
            trailing: SizedBox(
              width: 100.h,
              child: Row(
                
                children: [
                   IconButton(
                    onPressed: () {
                       if(tododata.done == 1){
                        tododata.done = 0;
                      }else {
                        tododata.done = 1;
                      }
                      BlocProvider.of<TodoBloc>(context).add(UpdattodoEvent(tododata: tododata));
                    },
                    icon: tododata.done == 0 ? const Icon(
                      Icons.done_rounded,
                      color: Colors.green,
                    ) : const Icon(
                      Icons.redo_outlined,
                      color: Colors.blue,
                    )  ,
                  ),
                  IconButton(
                    onPressed: () {
                      BlocProvider.of<TodoBloc>(context).add(DeltodoEvent(tododata: tododata));
                    },
                    icon: const Icon(
                      Icons.delete_outline_rounded,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
  }
}