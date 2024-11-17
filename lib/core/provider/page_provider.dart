import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class PageNotifier extends StateNotifier<bool> {
  PageNotifier() : super(false);

  void togglePage() {
    state = !state;
  }
}

final pageProvider = StateNotifierProvider<PageNotifier, bool>((ref) {
  return PageNotifier();
});

class Post {
  final String title;
  final String content;

  Post(this.title, this.content);
}

class PostNotifier extends StateNotifier<List<Post>> {
  PostNotifier() : super([]);

  void postBoard(String image, String title, String content) async {
    final url = Uri.https(
      'dearfam-1e2fe-default-rtdb.firebaseio.com/board.json',
    );
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
          {
            'image': image,
            'title': title,
            'content': content,
          },
        ),
      );
      if (response.statusCode == 200) {
        print('데이터가 성공적으로 업로드되었습니다.');
      } else {
        print('업로드 실패: ${response.statusCode} ${response.body}');
      }
    } catch (error) {
      print('오류 발생: $error');
    }
  }
}

final postProvider = StateNotifierProvider<PostNotifier, List<Post>>((ref) {
  return PostNotifier();
});

class FavoriteNotifier extends StateNotifier<bool> {
  FavoriteNotifier() : super(false);

  void toggleFavorite() {
    state = !state;
  }
}

final favoriteProvider = StateNotifierProvider<FavoriteNotifier, bool>((ref) {
  return FavoriteNotifier();
});
