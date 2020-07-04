import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';


class Note {
  final String id;
  String title;
  String content;
  Color color;
  Notestate state;
  final DateTime createdAt;
  DateTime modifiedAt;

  Note({
    this.id,
    this.title,
    this.content,
    this.color,
    this.state,
    DateTime createdAt,
    DateTime modifiedAt,
  }) : this.createdAt = createdAt ?? DateTime.now(),
    this.modifiedAt = modifiedAt ?? DateTime.now();


    static List<Note> fromQuery(QuerySnapshot snapshot) => snapshot != null ? toNotes(snapshot) : [];

    enum Notestate {
      unspecified,
      pinned,
      archived,
      deleted,
    }

    List<Note> toNotes(QuerySnapshot snapshot) => query.documents.
}