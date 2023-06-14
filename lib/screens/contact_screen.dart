import 'package:contacts_app/services/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/contact.dart';

class ContactScreen extends StatelessWidget {
  final Contact? contact;
  const ContactScreen({this.contact, super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> genderOptions = ['Masculino', 'Femenino', 'No Binario'];
    final List<String> civilStatusOptions = [
      'Soltero/a',
      'Casado/a',
      'Divorciado/a',
      'Viudo/a'
    ];
    String? selectedGender;
    String? selectedCivilStatus;

    final nameController = TextEditingController();
    final lastnameController = TextEditingController();
    final maternalsurnameController = TextEditingController();
    final numberController = TextEditingController();
    //final genderController = TextEditingController();
    //final civilstatusController = TextEditingController();

    if (contact != null) {
      nameController.text = contact!.name;
      lastnameController.text = contact!.lastname;
      maternalsurnameController.text = contact!.maternalsurname;
      numberController.text = contact!.number.toString();
      selectedGender = contact!.gender;
      selectedCivilStatus = contact!.civilstatus;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
            contact == null ? 'Agrega un Nuevo Contacto' : 'Editar Contacto'),
        centerTitle: true,
      ),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 40, right: 40, top: 40),
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  textInputAction: TextInputAction.done,
                  textCapitalization: TextCapitalization.words,
                  maxLines: 1,
                  decoration: const InputDecoration(
                    labelText: 'Tu nombre',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 0.75,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                TextFormField(
                  controller: lastnameController,
                  textInputAction: TextInputAction.done,
                  textCapitalization: TextCapitalization.words,
                  maxLines: 1,
                  decoration: const InputDecoration(
                      labelText: 'Primer apellido',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 0.75,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      )),
                ),
                const SizedBox(
                  height: 40,
                ),
                TextFormField(
                  controller: maternalsurnameController,
                  textInputAction: TextInputAction.done,
                  textCapitalization: TextCapitalization.words,
                  maxLines: 1,
                  decoration: const InputDecoration(
                      labelText: 'Segundo apellido',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 0.75,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      )),
                ),
                const SizedBox(
                  height: 40,
                ),
                TextFormField(
                  controller: numberController,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10)
                  ],
                  decoration: InputDecoration(
                      labelText: 'Numero de telefono',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      )),
                ),
                const SizedBox(
                  height: 40,
                ),
                // TextFormField(

                DropdownButtonFormField(
                  decoration: InputDecoration(
                    labelText: 'Género',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  value: selectedGender,
                  onChanged: (newValue) {
                    selectedGender = newValue;
                  },
                  items: genderOptions.map((gender) {
                    return DropdownMenuItem(
                      value: gender,
                      child: Text(gender),
                    );
                  }).toList(),
                ),

                const SizedBox(
                  height: 40,
                ),

                DropdownButtonFormField(
                  decoration: const InputDecoration(
                    labelText: 'Estado civil',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 0.75,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                  value: selectedCivilStatus,
                  onChanged: (String? newValue) {
                    selectedCivilStatus = newValue!;
                  },
                  items: civilStatusOptions
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),

                const SizedBox(
                  height: 30,
                ),
                //const Spacer(),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton.icon(
                      icon: contact == null
                          ? const Icon(
                              Icons.save,
                              color: Colors.white,
                            )
                          : const Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 40),
                          backgroundColor: Colors.indigo),
                      onPressed: () async {
                        final name = nameController.value.text;
                        final lastname = lastnameController.value.text;
                        final maternalsurname =
                            maternalsurnameController.value.text;
                        final number = int.parse(numberController.value.text);
                        final gender = selectedGender;
                        final civilstatus = selectedCivilStatus;

                        if (name.isEmpty ||
                            lastname.isEmpty ||
                            maternalsurname.isEmpty ||
                            number == 0 ||
                            gender == null ||
                            civilstatus == null) {
                          return;
                        }

                        final Contact model = Contact(
                            name: name,
                            lastname: lastname,
                            maternalsurname: maternalsurname,
                            number: number,
                            gender: gender,
                            civilstatus: civilstatus,
                            id: contact?.id);

                        if (contact == null) {
                          await DataBaseHelper.addContact(model);
                        } else {
                          await DataBaseHelper.updateContact(model);
                        }

                        //ignore: use_build_context_synchronously
                        Navigator.pop(context);
                      },
                      label: Text(
                        contact == null ? 'Guardar' : 'Editar',
                        style:
                            const TextStyle(fontSize: 24, color: Colors.white),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
