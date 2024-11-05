import 'dart:io';
import 'package:yaml/yaml.dart';

void main() {
  try {
    // Read pubspec.yaml
    final pubspecFile = File('pubspec.yaml');
    final pubspecContent = pubspecFile.readAsStringSync();
    final pubspec = loadYaml(pubspecContent);

    // Extract version
    final version = pubspec['version'] ?? '0.0.0';

    // Read CHANGELOG.md
    final changelogFile = File('CHANGELOG.md');

    // Create new changelog entry
    final newEntry = '''
## [$version] - ${DateTime.now().toIso8601String().split('T')[0]}

- TODO: Add release notes.
''';

    // Write new content (this will overwrite existing content)
    changelogFile.writeAsStringSync(newEntry.trim());
    print('CHANGELOG.md updated with version $version.');

    // Update SDK version file
    final sdkVersionFile = File('lib/utils/sdk_version.dart');
    final sdkVersionContent = '''
// This file is automatically generated. DO NOT EDIT BY HAND.

/// Current SDK version
const String sdkVersion = 'flutter-$version';
''';

    sdkVersionFile.writeAsStringSync(sdkVersionContent);
    print('sdk_version.dart updated with version $version.');
  } catch (e) {
    print('Error updating files: $e');
    exit(1);
  }
}
