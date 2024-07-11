import 'package:flutter/material.dart';


class MyNoteSettings extends StatelessWidget {
  void Function()? onEditTap;
  void Function()? onDelTap;
  MyNoteSettings({super.key, required this.onEditTap, required this.onDelTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // edit option
        GestureDetector(
          onTap: (){
            Navigator.pop(context);
            onEditTap!;
          },
          child: Container(
            height: 50,
            color: Theme.of(context).colorScheme.background,
            child: Center(
                child: Text("Edit",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                fontWeight: FontWeight.bold
              ),
             ),
            ),
          ),
        ),

        // delete option
        GestureDetector(
          onTap: (){
            Navigator.pop(context);
            onDelTap!;
          },
          child: Container(
            height: 50,
            color: Theme.of(context).colorScheme.background,
            child: Center(
                child: Text("Delete",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.bold
                  ),
                ),
            ),
          ),
        ),

      ],
    );
  }
}
