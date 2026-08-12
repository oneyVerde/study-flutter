import 'package:cli/cli.dart' as cli;
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:command_runner/command_runner.dart';

const version = '0.0.1';

void main(List<String> arguments) async {
  var runner = CommandRunner();
  await runner.run(arguments);
}

// Future<String> 타입: String 비동기 작업으로 미래에 결과를 생성할 것임을 나타냄
// async: 함수를 비동기 함수로 표시, await 함수 내부에서 asynchronous를 사용할 수 있도록 함
Future<String> getWikipediaArticle(String articleTitle) async {
  final url = Uri.https(
    'en.wikipedia.org', // Wikipedia API domain
    '/api/rest_v1/page/summary/$articleTitle', // API path for article summary
  );
  // 객체를 반환할 때까지 함수 실행을 일시 정지
  final response = await http.get(url);

  if (response.statusCode == 200) {
    return response.body;
  }

  return 'Error: Failed to fetch article "$articleTitle". Status code: ${response.statusCode}';
}

void printUsage() {
  print(
    "The following commands are vaild: 'help', 'version', 'wikipedia <ARTICLE-TITLE>'",
  );
}

// async는 await의 결과를 기다림
void searchWikipedia(List<String>? arguments) async {
  final String articleTitle;

  if (arguments == null || arguments.isEmpty) {
    print('Please provide an article titile.');

    final inputFromStdin = stdin.readLineSync();
    if (inputFromStdin == null || inputFromStdin.isEmpty) {
      print('No article title provided. Exiting.');
      return;
    }
    articleTitle = inputFromStdin;
  } else {
    articleTitle = arguments.join(' ');
  }
  print('Looking up articles about "$articleTitle". Please wait.');

  var articleContent = await getWikipediaArticle(articleTitle);
  print(articleContent);
}
