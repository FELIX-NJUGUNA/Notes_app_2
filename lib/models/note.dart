import 'package:isar/isar.dart';


// generate the file : run[dart run build_runner build]
part 'note.g.dart';


@Collection()
class Note{
  Id id = Isar.autoIncrement;
  late String text;
}
