import 'package:flutter/material.dart';

/// Tương đương RatingBar: 0..5 sao, bấm để chọn (bấm lại sao đang chọn -> giảm 1).
class StarRating extends StatelessWidget {
  final int rating;
  final ValueChanged<int>? onChanged; // null => chỉ đọc
  final double size;

  const StarRating({
    super.key,
    required this.rating,
    this.onChanged,
    this.size = 32,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        final filled = i < rating;
        return GestureDetector(
          onTap: onChanged == null
              ? null
              : () => onChanged!(rating == i + 1 ? i : i + 1),
          child: Icon(
            filled ? Icons.star : Icons.star_border,
            color: Colors.amber,
            size: size,
          ),
        );
      }),
    );
  }
}
