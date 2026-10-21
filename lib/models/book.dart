enum ReadStatus { unread, reading, read }

extension ReadStatusLabel on ReadStatus {
  String get label {
    switch (this) {
      case ReadStatus.unread:
        return 'Chưa đọc';
      case ReadStatus.reading:
        return 'Đang đọc';
      case ReadStatus.read:
        return 'Đã đọc';
    }
  }
}

const List<String> kGenres = [
  'Văn học',
  'Khoa học',
  'Công nghệ',
  'Kỹ năng sống',
  'Khác',
];

class Book {
  String title;
  String author;
  String genre;
  ReadStatus status;
  int rating;
  String note;

  Book({
    required this.title,
    required this.author,
    required this.genre,
    this.status = ReadStatus.unread,
    this.rating = 0,
    this.note = '',
  });
}
