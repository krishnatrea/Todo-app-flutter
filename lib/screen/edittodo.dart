import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoapp/bloc/todo_bloc.dart';
import 'package:todoapp/constants/uiconstants.dart';
import 'package:todoapp/models/todo.dart';
import 'package:uuid/uuid.dart';

class EditTodo extends StatelessWidget {
  EditTodo({Key? key, required this.tododata}) : super(key: key);
  Tododata tododata;
  TextEditingController title = TextEditingController();
  TextEditingController dis = TextEditingController();
  final uuid = const Uuid();
  @override
  Widget build(BuildContext context) {
    title.text = tododata.title;
    dis.text = tododata.description;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    size: 30.h,
                  ),
                ),
                Text(
                  'Note',
                  style: longtext,
                ),
                IconButton(
                  onPressed: () {
                    tododata.title = title.text;
                    tododata.description = dis.text;
                    BlocProvider.of<TodoBloc>(context).add(UpdattodoEvent(
                      tododata: tododata,
                    ));
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.done_rounded,
                    size: 30.h,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(20.h),
              child: Column(
                children: [
                  Container(
                    color: const Color(0xffFBFBFB),
                    child: TextField(
                      controller: title,
                      maxLines: 3,
                      minLines: 1,
                      autocorrect: false,
                      decoration: const InputDecoration(
                          hintText: "Enter a Title", border: InputBorder.none),
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  TextField(
                    controller: dis,
                    maxLines: 18,
                    minLines: 2,
                    autocorrect: false,
                    decoration: const InputDecoration(
                        hintText: "Enter a Description",
                        border: InputBorder.none),
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: 25.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
