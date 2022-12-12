import 'dart:io';

void main(List<String> arguments) {
  Yaml.readYAML(r"C:\Users\RGTI\Desktop\yaml_reader\pubspec.yaml");
}

class Yaml {
  static readYAML(String path) {
    File yaml = File(path);
    final file = yaml.readAsStringSync();
    final lines = file.split('\n').toList();

    print(file);
    print(lines.toString());
  }
}
