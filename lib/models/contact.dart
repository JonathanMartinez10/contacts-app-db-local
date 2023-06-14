class Contact {
  final String name;
  final String lastname;
  final String maternalsurname;
  final int? number;
  final String gender;
  final String civilstatus;
  final int? id;

  //Constructor
  const Contact(
      {required this.name,
      required this.lastname,
      required this.maternalsurname,
      required this.number,
      required this.gender,
      required this.civilstatus,
      required this.id});

  //Convierte un Map a un obj Contact
  //Factory indica que una función puede retornar una instancia de una clase
  // sin tener que crear una nueva instancia cada vez que es llamada.
  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
      id: json['id'],
      name: json['name'],
      lastname: json['lastname'],
      maternalsurname: json['maternalsurname'],
      number: json['number'],
      gender: json['gender'],
      civilstatus: json['civilstatus']);

  //Convierte un obj Contact a un un Map<String, Dynamic>
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'lastname': lastname,
        'maternalsurname': maternalsurname,
        'number': number,
        'gender': gender,
        'civilstatus': civilstatus
      };
}
