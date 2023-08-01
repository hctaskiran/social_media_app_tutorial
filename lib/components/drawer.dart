

import 'package:flutter/material.dart';
import 'package:social_media_app_tutorial/components/list_tile.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key, required this.onProfileTap, required this.onSignOutTap,});
  final void Function()? onProfileTap;
  final void Function()? onSignOutTap;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
        // header
        DrawerHeader(
          child: Icon(
            Icons.person, 
            
            size: 64,
          ),
         ),
         // home listtile
         
         CustomListTile(
          
          icon: Icons.home, 
          text: 'HOME',
          onTap: () => Navigator.pop(context),
          ),

          // profile listtile
          CustomListTile(
            icon: Icons.person, 
            text: 'PROFILE', 
            onTap: onProfileTap
          ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: CustomListTile(
              icon: Icons.logout, 
              text: 'Log Out', 
              onTap: onSignOutTap
            ),
          ),
        ],
      ),
    );
  }
}

class customColors {
  final whiteColor = Colors.white;
  final grey900color = Colors.grey.shade900;
}