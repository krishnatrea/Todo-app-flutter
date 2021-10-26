import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoapp/bloc/todo_bloc.dart';
import 'package:todoapp/constants/uiconstants.dart';
import 'package:todoapp/models/todo.dart';
import 'package:todoapp/screen/home.dart';
import 'package:uuid/uuid.dart';

class AddTodo extends StatelessWidget {
   AddTodo({Key? key }) : super(key: key);
   TextEditingController title = TextEditingController();
   TextEditingController dis = TextEditingController();
  final uuid = const Uuid();
  @override
  Widget build(BuildContext context) {
    return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => 
                    Home.changeindex(context, 0),
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
                    Tododata tododata = Tododata(
                    catagory: " ",
                    createdAt: DateTime.now(),
                    deleted: 0,
                    done: 0,
                    description: dis.text,
                    title: title.text,
                    id: uuid.v1()
                    );
                    BlocProvider.of<TodoBloc>(context).add(AddtodoEvent(tododata: tododata,));
                    dis.clear();
                    title.clear();
                     Home.changeindex(context, 0);
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
    );
  }
}
