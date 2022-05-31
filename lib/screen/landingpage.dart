import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todoapp/bloc/todo_bloc.dart';
import 'package:todoapp/constants/uiconstants.dart';
import 'package:todoapp/models/todo.dart';
import 'package:todoapp/screen/newpage.dart';
import 'package:todoapp/widget/todolistile.dart';
import 'package:dart_date/dart_date.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    DateTime date;
    return Column(
      children: [
        customAppbar(),
        Expanded(
          child: SizedBox(
            height: 496.h,
            child: Container(
              color: Colors.white,
              child: BlocBuilder<TodoBloc, TodoState>(
                  buildWhen: (previous, current) => true,
                  builder: (context, state) {
                    if (state is TodoInitialState) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is TodoListState) {
                      List<Tododata> todolist = [];
                      todolist = state.todolist
                        ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
                      List<Widget> listtiles = getList(todolist);
                      return listtiles.isNotEmpty
                          ? ListView(
                              children: listtiles,
                            )
                          : const NewPage();
                    }
                    return Container();
                  }),
            ),
          ),
        ),
      ],
    );
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    }
    return 'Good Evening';
  }

  List<Widget> getList(List<Tododata> todolist) {
    List<Widget> widgetlist = [];
    for (int i = 0; i < todolist.length; i++) {
      if (DateTime.now().day == todolist[i].createdAt.day) {
        widgetlist.add(TodoListTile(tododata: todolist[i]));
      }
    }
    return widgetlist;
  }

  Column customAppbar() {
    return Column(
      children: [
        SizedBox(
          height: 193.h,
          child: Container(
            color: const Color(0xffFBFBFB),
            padding: EdgeInsets.only(top: 51.h, left: 25.w),
            child: Column(children: [
              Row(
                children: [
                  SizedBox(
                    width: 190.w,
                    child: Text(greeting()+"\nHarshit Sharma", style: longtext, maxLines: 2),
                  ),
                  SizedBox(
                    width: 90.w,
                  ),
                  SizedBox(
                      height: 43.h,
                      width: 43.w,
                      child: Image.asset("assets/images/Group 2.png")),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  SizedBox(
                      height: 30.h,
                      width: 30.w,
                      child: Image.asset('assets/images/Calendar.png')),
                  SizedBox(
                    width: 20.w,
                  ),
                  SizedBox(
                    width: 86.w,
                    height: 36.h,
                    child: Material(
                      color: Colors.white,
                      elevation: 10.h,
                      borderRadius: BorderRadius.circular(22.13),
                      child: Center(
                          child: Text(
                        formatDate(DateTime.now(), ['dd', ' ', 'M']),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                    ),
                  )
                ],
              )
            ]),
          ),
        ),
      ],
    );
  }
}
