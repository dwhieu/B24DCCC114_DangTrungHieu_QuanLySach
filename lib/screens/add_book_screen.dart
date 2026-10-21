import 'package:flutter/material.dart';
import '../models/book.dart';
import '../widgets/star_rating.dart';

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({super.key});

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final _titleCtrl = TextEditingController();
  final _authorCtrl = TextEditingController();
  final _noteCtrl = TextEditingController();

  String _genre = kGenres.first;
  ReadStatus _status = ReadStatus.unread;
  int _rating = 0;
  String? _titleError;
  String? _authorError;

  @override
  void dispose() {
    _titleCtrl.dispose();
    _authorCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  void _save() {
    final title = _titleCtrl.text.trim();
    final author = _authorCtrl.text.trim();
    setState(() {
      _titleError = title.isEmpty ? 'Tên sách không được để trống' : null;
      _authorError = author.isEmpty ? 'Tác giả không được để trống' : null;
    });
    if (_titleError != null || _authorError != null) return;

    final book = Book(
      title: title,
      author: author,
      genre: _genre,
      status: _status,
      rating: _rating,
      note: _noteCtrl.text.trim(),
    );
    Navigator.of(context).pop(book);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Đã thêm sách')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Thêm sách')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleCtrl,
              decoration: InputDecoration(
                labelText: 'Tên sách',
                errorText: _titleError,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _authorCtrl,
              decoration: InputDecoration(
                labelText: 'Tác giả',
                errorText: _authorError,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _genre,
              decoration: const InputDecoration(
                labelText: 'Thể loại',
                border: OutlineInputBorder(),
              ),
              items: kGenres
                  .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                  .toList(),
              onChanged: (v) => setState(() => _genre = v ?? _genre),
            ),
            const SizedBox(height: 16),
            const Text('Tình trạng đọc',
                style: TextStyle(fontWeight: FontWeight.bold)),
            RadioGroup<ReadStatus>(
              groupValue: _status,
              onChanged: (v) => setState(() => _status = v ?? _status),
              child: Column(
                children: ReadStatus.values
                    .map((s) => RadioListTile<ReadStatus>(
                          value: s,
                          title: Text(s.label),
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                        ))
                    .toList(),
              ),
            ),
            const SizedBox(height: 8),
            const Text('Đánh giá',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              children: [
                StarRating(
                    rating: _rating,
                    onChanged: (v) => setState(() => _rating = v)),
                const SizedBox(width: 12),
                Text('$_rating/5'),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _noteCtrl,
              keyboardType: TextInputType.multiline,
              minLines: 3,
              maxLines: 6,
              decoration: const InputDecoration(
                labelText: 'Ghi chú (không bắt buộc)',
                alignLabelWithHint: true,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _save,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text('Lưu sách'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
