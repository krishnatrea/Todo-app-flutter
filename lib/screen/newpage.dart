


import 'package:flutter/material.dart';
import 'package:todoapp/constants/uiconstants.dart';
import 'package:todoapp/screen/home.dart';

class NewPage extends StatelessWidget {
  const NewPage({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Image.network('https://image.freepik.com/free-vector/businessman-holding-pencil-big-complete-checklist-with-tick-marks_1150-35019.jpg'),
           Text(
            'Enjoy your day!',
            style: longtext,
          ),
           Text(
            "Tap to create your fast task.",
            style: longtext,
          ),

          const SizedBox(
            height: 40,
          ),
          ElevatedButton(
              onPressed: () async {
                Home.changeindex(context, 1);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(const Color(0xff2A2362).withOpacity(0.9)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "+ Create New Task",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              )),
        ],
      ),
    );
  }
}
