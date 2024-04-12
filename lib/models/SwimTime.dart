import 'package:hive/hive.dart';

part 'SwimTime.g.dart';

@HiveType(typeId: 0)
class SwimTime extends HiveObject {
  @HiveField(0)
  String? tournamentName;

  @HiveField(1)
  String? dateTournament;

  @HiveField(2)
  String? poolSize;

  @HiveField(3)
  String? toSwim;

  @HiveField(4)
  String? time;
}
