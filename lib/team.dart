// To parse this JSON data, do
//
//     final teams = teamsFromJson(jsonString);

import 'dart:convert';

List<Team> teamFromJson(String str) => List<Team>.from(json.decode(str).map((x) => Team.fromJson(x)));

List<Team> teamFromListMap(List<Map<String, dynamic>> json) => List<Team>.from(json.map((x) => Team.fromJson(x)));

String teamToJson(List<Team> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Team {
  int? id;
  DateTime? createdAt;
  String? name;
  int? points;
  String? avatarURL;
  String? storyURL;

  Team({
    this.id,
    this.createdAt,
    this.name,
    this.points,
  });

  factory Team.fromJson(Map<String, dynamic> json) => Team(
    id: json["id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    name: json["name"],
    points: json["points"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt?.toIso8601String(),
    "name": name,
    "points": points,
  };
}
