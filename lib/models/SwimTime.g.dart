// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SwimTime.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SwimTimeAdapter extends TypeAdapter<SwimTime> {
  @override
  final int typeId = 0;

  @override
  SwimTime read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SwimTime()
      ..tournamentName = fields[0] as String?
      ..dateTournament = fields[1] as String?
      ..poolSize = fields[2] as String?
      ..toSwim = fields[3] as String?
      ..time = fields[4] as String?;
  }

  @override
  void write(BinaryWriter writer, SwimTime obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.tournamentName)
      ..writeByte(1)
      ..write(obj.dateTournament)
      ..writeByte(2)
      ..write(obj.poolSize)
      ..writeByte(3)
      ..write(obj.toSwim)
      ..writeByte(4)
      ..write(obj.time);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SwimTimeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
