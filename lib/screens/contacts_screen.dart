import 'package:contacts_app/screens/contact_screen.dart';
import 'package:contacts_app/services/database_helper.dart';
import 'package:contacts_app/widgets/contact_widget.dart';
import 'package:flutter/material.dart';

import '../models/contact.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: const Text('Contactos'),
          centerTitle: true,
        ),
        body: FutureBuilder<List<Contact>?>(
          future: DataBaseHelper.getAllContacts(),
          builder: (context, AsyncSnapshot<List<Contact>?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (snapshot.hasData) {
              if (snapshot.data != null) {
                return ListView.builder(
                  itemBuilder: (context, index) => ContactWidget(
                      contact: snapshot.data![index],
                      onTap: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ContactScreen(
                                      contact: snapshot.data![index],
                                    )));
                        setState(() {});
                      },
                      onLongPress: () async {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                title: const Text(
                                    'Estas seguro de que quieres eliminar este contacto?'),
                                actions: [
                                  ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.red)),
                                    onPressed: () async {
                                      await DataBaseHelper.deleteContact(
                                          snapshot.data![index]);
                                      // ignore: use_build_context_synchronously
                                      Navigator.pop(context);
                                      setState(() {});
                                    },
                                    child: const Text(
                                      'SI',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.indigo)),
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('NO',
                                          style:
                                              TextStyle(color: Colors.white))),
                                ],
                              );
                            });
                      }),
                  itemCount: snapshot.data!.length,
                );
              }
              return const Center(
                child: Text('Sin contactos aun'),
              );
            }
            return const SizedBox.shrink();
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ContactScreen()));
            setState(() {});
          },
          child: const Icon(Icons.add),
        ));
  }
}
