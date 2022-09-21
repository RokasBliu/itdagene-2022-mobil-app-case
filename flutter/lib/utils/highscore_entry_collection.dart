import 'dart:collection';
import 'dart:convert';
import 'package:itverket_itdagene_flutter/utils/highscore_entry.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

const highscoreFilename = "highscores1.txt";

class HighscoreEntryCollection {
  Map<String, HighscoreEntry> entries;

  HighscoreEntryCollection(this.entries);

  HighscoreEntryCollection.empty() : entries = {};

  static Future<String> _path() async {
    var directory = await getApplicationDocumentsDirectory();
    var directoryPath = directory.path;
    var filePath = "$directoryPath/$highscoreFilename";
    return filePath;
  }

  static Future<File> _file() async {
    return File(await _path());
  }

  Future<void> save() async {
    var string_list = List.empty(growable: true);
    entries.forEach((key, value) {
      var name = value.name;
      var score = value.score;
      string_list.add("$name,$score");
    });
    var string = string_list.join("\n");
    var file = await _file();
    file.writeAsString(string, mode: FileMode.write);
  }

  static Future<HighscoreEntryCollection> load() async {
    var file = await _file();
    if (!await file.exists()) {
      return HighscoreEntryCollection.empty();
    }
    var fileContent = await file.readAsString();
    var map = Map<String, HighscoreEntry>();
    var lines = fileContent.split("\n");
    if (lines.isEmpty) {
      return HighscoreEntryCollection.empty();
    }
    lines.forEach((element) {
      var elements = element.split(",");
      var name = elements[0];
      var score = int.parse(elements[1]);
      var highscoreEntry = HighscoreEntry(name, score);
      map[name] = highscoreEntry;
    });
    return HighscoreEntryCollection(map);
  }

  void addEntry(HighscoreEntry highscoreEntry) {
    var entry =
        entries[highscoreEntry.name] ?? HighscoreEntry(highscoreEntry.name, 0);
    entry.score += highscoreEntry.score;
    entries[highscoreEntry.name] = entry;
  }

  Future<void> addEntryAndSave(HighscoreEntry highscoreEntry) {
    addEntry(highscoreEntry);
    return save();
  }

  static Future<void> loadAddThenSave(HighscoreEntry highscoreEntry) async {
    var collection = await HighscoreEntryCollection.load();
    collection.addEntry(highscoreEntry);
    await collection.save();
    /*
    HighscoreEntryCollection.load().then((collection) {
      collection.addEntry(highscoreEntry);
      collection.save();
    })
    */
  }

  Set<HighscoreEntry> asSet() {
    return Set.from(entries.values);
  }
}
