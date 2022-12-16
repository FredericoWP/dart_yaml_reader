// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

void main(List<String> arguments) {
  Yaml yaml = Yaml();
  yaml.readYAML("pubspec.yaml");
}

enum Type { node, child, coment, blank }

class Yaml {
  final Map<String, Object?> _map = {};
  String? lastTag;

  readYAML(String path) {
    File yaml = File(path);
    final lines = yaml.readAsLinesSync();
    _map.addEntries(readLines(lines).entries);
    print(_map);
  }

  Map<String, Object?> readLines(List<String> lines) {
    Map<String, Object?> map = {};

    for (var x = 0; x < lines.length; x++) {
      final type = typeLine(lines[x]);

      if (type == Type.node) {
        lastTag = lines[x].split(":")[0];

        map.addAll({
          lines[x].split(":")[0]:
              (x + 1 >= lines.length || typeLine(lines[x + 1]) != Type.child)
                  ? lines[x].split(":")[1]
                  : readLines(
                      [lines[x + 1]],
                    )
        });
      } else if (type == Type.child) {
        if (lastTag != lines[x].split(":")[0]) {
          map.addAll({lines[x].split(":")[0].trim(): lines[x].split(":")[1]});
          lastTag = lines[x].split(":")[0];
        }
      }
    }
    return map;
  }

  Type typeLine(String line) {
    if (line.isNotEmpty) {
      if (line.trim()[0] == "#") {
        return Type.coment;
      }
      if (line[0].trim() == '') {
        return Type.child;
      }
    } else {
      return Type.blank;
    }
    return Type.node;
  }
}
