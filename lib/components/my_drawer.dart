import 'package:flutter/material.dart';
import 'package:notes_app_2/components/my_drawer_tile.dart';
import 'package:notes_app_2/pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          // header
          const DrawerHeader(
              child: Icon(Icons.note_alt_rounded,
              size: 30,),
          ),

          // notes tile
        MyDrawerTile(
            title: "Notes",
            leading: const Icon(Icons.home_outlined),
            onTap: (){
              Navigator.pop(context);
            }
        ),

          // settings tile
          MyDrawerTile(
              title: "Settings",
              leading: const Icon(Icons.settings),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage()));

                  
              }
          ),
        ],
      ),
    );
  }
}
