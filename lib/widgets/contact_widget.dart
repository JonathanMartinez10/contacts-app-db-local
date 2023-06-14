import 'package:flutter/material.dart';
import 'package:contacts_app/models/contact.dart';

class ContactWidget extends StatelessWidget {
  final Contact contact;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const ContactWidget(
      {required this.contact,
      required this.onTap,
      required this.onLongPress,
      super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: onLongPress,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: ListTile(
                leading: CircleAvatar(
                  child: Text(
                    contact.name[0],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      contact.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    Text(contact.number.toString())
                  ],
                ),
                trailing: const SizedBox(
                  width: 30,
                  child: Row(
                    children: [Icon(Icons.edit)],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
