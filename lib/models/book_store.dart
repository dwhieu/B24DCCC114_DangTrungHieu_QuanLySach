import 'book.dart';

final List<Book> books = [
  Book(
    title: 'Lập trình Android cơ bản',
    author: 'Nguyễn Văn A',
    genre: 'Công nghệ',
    status: ReadStatus.reading,
    rating: 4,
    note: 'Sách nhập môn lập trình Android.',
  ),
  Book(
    title: 'Đắc nhân tâm',
    author: 'Dale Carnegie',
    genre: 'Kỹ năng sống',
    status: ReadStatus.read,
    rating: 5,
    note: 'Cuốn sách kinh điển về giao tiếp.',
  ),
  Book(
    title: 'Dế Mèn phiêu lưu ký',
    author: 'Tô Hoài',
    genre: 'Văn học',
    status: ReadStatus.unread,
    rating: 0,
  ),
];
