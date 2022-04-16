import '../services/database.dart';

class Profile {
  String? id;
  String? name;
  String? platform;

  Profile({required this.id, this.name, required this.platform});

  Profile.fromMap(Map<String, dynamic> map)
      : id = map[columnId],
        name = map[columnName],
        platform = map[columnPlatform];

  Map<String, dynamic> toMap() {
    return {columnId: id, columnName: name, columnPlatform: platform};
  }

  @override
  String toString() {
    return 'Profile{id: $id, name: $name, platform: $platform}';
  }
}
