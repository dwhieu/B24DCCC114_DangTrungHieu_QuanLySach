import 'package:flutter/material.dart';
import '../models/book.dart';
import '../models/book_store.dart';
import '../widgets/star_rating.dart';
import 'add_book_screen.dart';
import 'book_detail_screen.dart';

class BookListScreen extends StatefulWidget {
  const BookListScreen({super.key});

  @override
  State<BookListScreen> createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  Future<void> _openAdd() async {
    final Book? newBook = await Navigator.of(context).push<Book>(
      MaterialPageRoute(builder: (_) => const AddBookScreen()),
    );
    if (newBook != null) {
      setState(() => books.add(newBook));
    }
  }

  Future<void> _openDetail(Book book) async {
    final result = await Navigator.of(context).push<String>(
      MaterialPageRoute(builder: (_) => BookDetailScreen(book: book)),
    );
    if (result == 'delete') books.remove(book);
    setState(() {});
  }

  Color _statusColor(ReadStatus s) {
    switch (s) {
      case ReadStatus.unread:
        return Colors.grey;
      case ReadStatus.reading:
        return Colors.orange;
      case ReadStatus.read:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    final total = books.length;
    final done = books.where((b) => b.status == ReadStatus.read).length;
    final notDone = total - done;

    return Scaffold(
      appBar: AppBar(title: const Text('Thư viện của tôi')),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _stat('Tổng số sách', total),
                _stat('Đã đọc', done),
                _stat('Chưa đọc xong', notDone),
              ],
            ),
          ),
          Expanded(
            child: books.isEmpty
                ? const Center(child: Text('Chưa có cuốn sách nào'))
                : ListView.builder(
                    itemCount: books.length,
                    itemBuilder: (context, i) {
                      final b = books[i];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        child: ListTile(
                          onTap: () => _openDetail(b),
                          title: Text(b.title,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold)),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${b.author} • ${b.genre}'),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Text(b.status.label,
                                      style: TextStyle(
                                          color: _statusColor(b.status),
                                          fontWeight: FontWeight.w600)),
                                  const SizedBox(width: 12),
                                  StarRating(rating: b.rating, size: 18),
                                ],
                              ),
                            ],
                          ),
                          trailing: const Icon(Icons.chevron_right),
                        ),
                      );
                    },
                  ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _openAdd,
                  icon: const Icon(Icons.add),
                  label: const Text('Thêm sách'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _stat(String label, int value) => Column(
        children: [
          Text('$value',
              style:
                  const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text(label),
        ],
      );
}
