import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:redtone_test/models/drawerModel.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);
  final name = 'Minah Filzah';
  final email = 'minahfilzah@redtone.com';
  final image = 'assets/images/user.png';

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView(
          children: <Widget>[
            buildProfile(
              context,
              image: image,
              name: name,
              email: email,
            ),
            Column(
              children: [
                Divider(color: Colors.black54),
                const SizedBox(height: 24.0),
                buildDrawerItem(
                  context,
                  item: DrawerItem.courses,
                  text: 'Courses',
                  icon: Icons.assignment,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDrawerItem(
    BuildContext context, {
    required DrawerItem item,
    required String text,
    required IconData icon,
  }) {
    final provider = Provider.of<DrawerProvider>(context);
    final currentItem = provider.drawerItem;
    final isSelected = item == currentItem;

    return Material(
      color: Colors.transparent,
      child: ListTile(
        selected: isSelected,
        selectedTileColor: Colors.black12,
        leading: Icon(icon),
        title: Text(
          text,
          style: TextStyle(fontSize: 16.0),
        ),
        onTap: () => selectItem(context, item),
      ),
    );
  }

  void selectItem(BuildContext context, DrawerItem item) {
    final provider = Provider.of<DrawerProvider>(context, listen: false);
    provider.setDrawerItem(item);
  }

  Widget buildProfile(
    BuildContext context, {
    required String image,
    required String name,
    required String email,
  }) =>
      Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => selectItem(context, DrawerItem.profile),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30.0,
                  backgroundImage: AssetImage(image),
                ),
                SizedBox(width: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      email,
                      style: TextStyle(fontSize: 12.0),
                    ),
                  ],
                ),
                Spacer(),
                Icon(Icons.keyboard_arrow_right),
              ],
            ),
          ),
        ),
      );
}
