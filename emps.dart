// To parse this JSON data, do
//
//     final pets = petsFromJson(jsonString);

import 'dart:convert';

Emp empFromJson(String str) => Emp.fromJson(json.decode(str));

String empToJson(Emp data) => json.encode(data.toJson());

class Emp {
  Emp({
    required this.data,
  });

  final List<Datum> data;

  factory Emp.fromJson(Map<String, dynamic> json) => Emp(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.profile_image,
    
  });

  final int id;
  final String name;  
  final String username;
  final String email;
  final String profile_image;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        profile_image: json["profile_image"],
        
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name, 
        "username": username,
        "email": email,
        "profile_image": profile_image,
       
      };
}
