import '../utils/http_methods.dart';
import 'colleague.dart';
import 'dart:math';

class ColleagueCollection {
  List<Colleague> _collection;

  ColleagueCollection(this._collection);

  ColleagueCollection.newEmpty() : _collection = List<Colleague>.empty();

  Future<void> fetchAll() async => {
    _collection = await fetchColleagues()
  };

  Colleague popRandom() => _collection.removeAt(Random().nextInt(_collection.length));

  int length() => _collection.length;

  bool isEmpty() => length() == 0;
}

/*
  ColleagueCollection.fetch_all() :
    this(List<Colleague>.empty())
  }
  */
