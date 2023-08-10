class Users {
  int? id;
  String? firstName;
  String? lastName;
  String? maidenName;
  String? image;

  Users({
    this.id,
    this.firstName,
    this.lastName,
    this.maidenName,
    this.image,
  });

  factory Users.fromJson(Map<String, Object?> json) {
    return Users(
      id: json['id'] as int?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      maidenName: json['maidenName'] as String?,
      image: json['image'] as String?,
    );
  }

  static Users? Function(Map<String, Object?> json) convert() =>
      (Map<String, Object?> json) {
        return Users.fromJson(json);
      };

  static List<Users?>? Function(Map<String, Object?> json) convertList() =>
      (Map<String, Object?> json) {
        List<Object?> users = json["users"] as List<Object?>;
        return users.map((e) {
          if (e is Map<String, Object?>) {
            return convert()(e);
          } else {
            return null;
          }
        }).toList();
      };

  @override
  int get hashCode => Object.hash(
        firstName,
        lastName,
        maidenName,
        image,
      );

  @override
  bool operator ==(Object other) =>
      other is Users &&
      other.firstName == firstName &&
      other.lastName == lastName &&
      other.maidenName == maidenName &&
      other.image == image;

  @override
  String toString() {
    return "$runtimeType{id: $id, firstName: $firstName, "
        "lastName: $lastName, maidenName: $maidenName, image: $image}";
  }
}
