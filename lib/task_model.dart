import 'package:flutter/foundation.dart';

class Task {
  final String title;
  bool isComplete;

  Task({required this.title, this.isComplete = false});

  Task copyWith({String? title, bool? isComplete}) {
    return Task(
      title: title ?? this.title,
      isComplete: isComplete ?? this.isComplete,
    );
  }

  Map<String, dynamic> toMap() => {
        'title': title,
        'isComplete': isComplete,
      };

  factory Task.fromMap(Map<String, dynamic> map) => Task(
        title: map['title'] as String,
        isComplete: map['isComplete'] as bool,
      );


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Task &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          isComplete == other.isComplete;

  @override
  int get hashCode => title.hashCode ^ isComplete.hashCode;

  @override
  String toString() {
    return 'Task{title: $title, isComplete: $isComplete}';
  }
}
