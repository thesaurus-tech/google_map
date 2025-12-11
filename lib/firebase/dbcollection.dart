import 'dart:async';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

const String DbMasterPath = 'global_key/stay_on_test/';

enum kDbObjectStatus {
  unknown,
  added,
  modified,
  deleted,
  exists,
}

// this is the Wrapper object for all the protobuf objects
class DbObject<T> {
  late T data;
  kDbObjectStatus status = kDbObjectStatus.unknown;
  String documentId = '';
  String collectionPath = '';
  DbObject({required this.data, this.onUpdate});
  Function(T)? onUpdate;
}

// Collection of items in firebase, note that the behaviour of this class
// is undefined if the items inside a collection are not homogenous and of the same type.
// This class provides CRUD operations for specific data types , it is assumed that T is a protobuf generated
// class. Concrete classes should extend from this and implement the abstract mentods based on the datatype
abstract class DbCollection<T> extends ChangeNotifier {
  late final CollectionReference<Map<String, dynamic>> _collection;
  late final Stream<QuerySnapshot> _collectionStreamSnapshot;
  bool _firstRead = true;
  final String collectionPath; // the path of the collection.
  Map<String, DbObject<T>> _items = {};

  DbCollection({required this.collectionPath}) {
    _collection = FirebaseFirestore.instance.collection(collectionPath);
  }

  // handles _documents that arrive while listenting on the query snapshot
  void _handleDocuments(List<QueryDocumentSnapshot<Object?>> documents,
      Function(List<DbObject<T>>) onData) {
    List<DbObject<T>> items = [];
    for (var document in documents) {
      final data = document.data();
      var item = DbObject<T>(data: fromProto3Json(data!));
      item.documentId = document.id;
      item.collectionPath = collectionPath;
      item.status = kDbObjectStatus.exists;
      items.add(item);
    }
    _firstRead = false;
    onData(items);
  }

  // handles the changes in the snapshot, this will only run from the second time onwards
  void _handleDocumentChanges(List<DocumentChange<Object?>> documentChanges,
      Function(List<DbObject<T>>) onChanges) {
    List<DbObject<T>> items = [];
    for (var docChange in documentChanges) {
      var document = docChange.doc;

      final data = document.data();
      var item = DbObject<T>(data: fromProto3Json(data!));
      item.documentId = document.id;
      item.collectionPath = collectionPath;

      if (_firstRead) {
        item.status = kDbObjectStatus.exists;
      } else {
        switch (docChange.type) {
          case DocumentChangeType.added:
            item.status = kDbObjectStatus.added;
            break;
          case DocumentChangeType.modified:
            item.status = kDbObjectStatus.modified;
            break;
          case DocumentChangeType.removed:
            item.status = kDbObjectStatus.deleted;
            break;
          default:
            item.status = kDbObjectStatus.unknown;
            break;
        }
      }
      items.add(item);
    }
    _firstRead = false;
    onChanges(items);
  }

  // listens to the stream, should be called only once!!!
  void listen(
      {required Function(List<DbObject<T>>) onChanges,
      Query<Map<String, dynamic>>? query}) {
    if (query != null) {
      _collectionStreamSnapshot = query.snapshots();
    } else {
      _collectionStreamSnapshot = _collection.snapshots();
    }
    _collectionStreamSnapshot.listen(
      (event) {
        if (event.docChanges.isNotEmpty) {
          _handleDocumentChanges(event.docChanges, onChanges);
        }
      },
    );
  }

  // Creates a concrete object from a json string.
  // derive this in all classes to create a concrete object of the protobuf datatype
  T fromProto3Json(Object json);

  // Converts the object to a protobuf 3 compatible string so it could be
  // serialized in the db.
  // derive this in all classes to create a concrete object of the protobuf datatype
  String toProto3Json(T object);

  // creates a new item into the collection
  Future<bool> createItem(DbObject<T> item, {String? documentId}) async {
    // use future completer
    var completer = Completer<bool>();
    var jsonString = toProto3Json(item.data);
    Map<String, dynamic> newData = jsonDecode(jsonString);
    if (documentId != null) {
      _collection.doc(documentId).set(newData).then((value) {
        item.documentId = documentId;
        item.collectionPath = collectionPath;
        item.status = kDbObjectStatus.added;
        completer.complete(true);
      });
    } else {
      _collection.add(newData).then((document) {
        item.documentId = document.id;
        item.collectionPath = collectionPath;
        item.status = kDbObjectStatus.added;
        completer.complete(true);
      });
    }
    return completer.future;
  }

  // reads a specific item identified by the items id from the collection. this will never complete
  // if the document is not found in the collection. this also updates the item when its data changes
  Future<DbObject<T>?> readItem({required String documentId}) {
    // create a completer
    var completer = Completer<DbObject<T>?>();
    var docRef = _collection.doc(documentId);
    docRef.get().then((document) {
      if (document.exists) {
        final data = document.data();
        var item = DbObject<T>(data: fromProto3Json(data!));
        item.documentId = documentId;
        item.collectionPath = collectionPath;
        item.status = kDbObjectStatus.exists;
        completer.complete(item);
      } else {
        completer.complete(null);
      }
    });
    return completer.future;
  }

  // listens to updates on the document and modifies if the db changes the contents
  void listenItem(DbObject<T> object) {
    assert(object.documentId.isNotEmpty);
    assert(object.collectionPath == collectionPath);
    var docRef = _collection.doc(object.documentId);
    docRef.snapshots().listen((event) {
      final data = event.data();
      object.data = fromProto3Json(data!);
      print('${object.documentId} modified with new data ${data}');
      if (object.onUpdate != null) {
        object.onUpdate!(object.data);
      }
    });
  }

  // reads Items from the collection, this reads all the items from the collection, classes can override this
  // to only read based on some queries.
  // NOTE: This assumes all the items in the collection are of the same type, the behaviour of this method
  // is undefined if there are different types of documents in the collection.
  Future<List<DbObject<T>>> readItems() async {
    // create a future completer
    var completer = Completer<List<DbObject<T>>>();
    _collection.get().then((source) {
      List<DbObject<T>> items = [];

      for (var document in source.docs) {
        final data = document.data();
        var item = DbObject<T>(data: fromProto3Json(data));
        item.documentId = document.id;
        item.collectionPath = collectionPath;
        item.status = kDbObjectStatus.exists;
        items.add(item);
      }
      completer.complete(items);
    });
    return completer.future;
  }

  // updates the item in the collection, note that this will fail if the item is not in our collection
  // note that this just a basic sanity test to check if the object has a documentID and does not do
  // fine-grained check for the actual document with the id being present in the collection.
  Future<bool> updateItem(DbObject<T> item) async {
    assert(item.documentId.isNotEmpty);

    // create a completer
    var completer = Completer<bool>();
    var jsonString = toProto3Json(item.data);
    Map<String, dynamic> newData = jsonDecode(jsonString);
    _collection.doc(item.documentId).set(newData).then((value) {
      item.status = kDbObjectStatus.modified;
      completer.complete(true);
    });
    return completer.future;
  }

  // deletes the item from the collection, note that this will fail if the item is not in our collection
  // note that this just a basic sanity test to check if the object has a documentID and does not do
  // fine-grained check for the actual document with the id being preent in the collection.
  Future<bool> deleteItem(DbObject<T> item) async {
    assert(item.documentId.isNotEmpty);
    // create a completer
    var completer = Completer<bool>();
    _collection.doc(item.documentId).delete().then((value) {
      item.status = kDbObjectStatus.deleted;
      completer.complete(true);
    });
    return completer.future;
  }
}
