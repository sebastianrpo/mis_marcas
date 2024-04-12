import 'package:hive/hive.dart';
import 'package:mis_marcas/models/SwimTime.dart';

class Boxes{
  static Box<SwimTime> getSwimTimeBox() => Hive.box<SwimTime>('swimTimes');
}