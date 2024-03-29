import 'package:flutter/material.dart';

import '../services/database.dart';

class Profile {
  String? id = '';
  String? name = '';
  String? platform = '';
  int score = 0;

  Profile({required this.id, this.name, required this.platform});

  Profile.fromMap(Map<String, dynamic> map)
      : id = map[columnId],
        name = map[columnName],
        platform = map[columnPlatform],
        score = map[columnScore];

  Map<String, dynamic> toMap() {
    return {
      columnId: id,
      columnName: name,
      columnPlatform: platform,
      columnScore: score
    };
  }

  @override
  String toString() {
    return 'Profile{id: $id, name: $name, platform: $platform, score: $score}';
  }
}

class GameItem {
  GameItem({required this.key, required this.color});

  final String key;
  final Color color;
}
