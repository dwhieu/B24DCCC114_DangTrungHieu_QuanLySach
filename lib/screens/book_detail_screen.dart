import 'package:flutter/material.dart';
import '../models/book.dart';
import '../widgets/star_rating.dart';

class BookDetailScreen extends StatefulWidget {
  final Book book;
  const BookDetailScreen({super.key, required this.book});

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  Book get book => widget.book;

  Future<void> _confirmDelete() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Xóa sách'),
        content: Text('Bạn có chắc muốn xóa "${book.title}"?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Hủy')),
          TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Xóa')),
        ],
      ),
    );
    if (ok == true && mounted) Navigator.of(context).pop('delete');
  }

  @override
  Widget build(BuildContext context) {
    final isRead = book.status == ReadStatus.read;
    return Scaffold(
      appBar: AppBar(title: const Text('Chi tiết sách')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(book.title,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('${book.author} • ${book.genre}',
                style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 12),
            Chip(label: Text(book.status.label)),
            const SizedBox(height: 12),
            const Text('Đánh giá',
                style: TextStyle(fontWeight: FontWeight.bold)),
            StarRating(
              rating: book.rating,
              onChanged: (v) => setState(() => book.rating = v),
            ),
            const SizedBox(height: 16),
            const Text('Ghi chú',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(book.note.isEmpty ? '(Không có ghi chú)' : book.note),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: isRead
                    ? null
                    : () => setState(() => book.status = ReadStatus.read),
                icon: const Icon(Icons.check),
                label: const Text('Đánh dấu đã đọc'),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back),
                label: const Text('Quay lại'),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                style: FilledButton.styleFrom(backgroundColor: Colors.red),
                onPressed: _confirmDelete,
                icon: const Icon(Icons.delete),
                label: const Text('Xóa sách'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
