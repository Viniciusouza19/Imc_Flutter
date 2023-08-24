import 'package:hive/hive.dart';

import 'imc.dart';

class ImcAdapter extends TypeAdapter<Imc> {
  @override
  int get typeId => 0; 

  @override
  Imc read(BinaryReader reader) {
    return Imc(
      id: reader.readInt(),
      height: reader.readInt(),
      weight: reader.readInt(), name: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, Imc imc) {
    writer.writeInt(imc.id);
    writer.writeInt(imc.height);
    writer.writeInt(imc.weight);
    writer.writeString(imc.name);

  }
}
