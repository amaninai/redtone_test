class Profile {
  String label;
  String start;
  String end;
  Status status;

  Profile({
    this.label = '',
    this.start = '',
    this.end = '',
    required this.status,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    Status statusCourse = Status.fromJson(json['status']);

    return Profile(
      label: json['label'],
      start: json['start'],
      end: json['end'],
      status: statusCourse,
    );
  }
}

class Status {
  var progress;
  List<PersonalCourse> personalCourse;

  Status({
    this.progress = 0,
    required this.personalCourse,
  });

  factory Status.fromJson(Map<String, dynamic> json) {
    final courses = json['courses'] as List;

    List<PersonalCourse> listCourses =
        courses.map((i) => PersonalCourse.fromJson(i)).toList();

    return Status(
      progress: json['progress'],
      personalCourse: listCourses,
    );
  }
}

class PersonalCourse {
  String id;
  String title;
  String description;
  String duration;
  String start;
  String end;
  String? status;
  String? payment;

  PersonalCourse({
    this.id = '',
    this.title = '',
    this.description = '',
    this.duration = '',
    this.start = '',
    this.end = '',
    this.status,
    this.payment,
  });

  factory PersonalCourse.fromJson(Map<String, dynamic> json) {
    return PersonalCourse(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      duration: json['duration'],
      start: json['start'],
      end: json['end'],
      status: json['status'] ?? 'Unavailable',
      payment: json['payment'] ?? 'Unavailable',
    );
  }
}
