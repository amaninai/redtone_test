class Course {
  String id;
  String title;
  String venue;
  String type;
  String description;
  String status;
  String duration;
  String location;
  String start;
  String end;
  String exam;
  String icon;
  String docs;
  String payment;

  Course({
    this.id = '',
    this.title = '',
    this.venue = '',
    this.type = '',
    this.description = '',
    this.status = '',
    this.duration = '',
    this.location = '',
    this.start = '',
    this.end = '',
    this.exam = '',
    this.icon = '',
    this.docs = '',
    this.payment = '',
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      title: json['title'],
      venue: json['venue'],
      type: json['type'],
      description: json['description'],
      status: json['status'],
      duration: json['duration'],
      location: json['location'],
      start: json['start'],
      end: json['end'],
      exam: json['exam'],
      icon: json['icon'],
      docs: json['docs'],
      payment: json['payment'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['venue'] = this.venue;
    data['type'] = this.type;
    data['description'] = this.description;
    data['status'] = this.status;
    data['duration'] = this.duration;
    data['location'] = this.location;
    data['start'] = this.start;
    data['end'] = this.end;
    data['exam'] = this.exam;
    data['icon'] = this.icon;
    data['docs'] = this.docs;
    data['payment'] = this.payment;
    return data;
  }
}
