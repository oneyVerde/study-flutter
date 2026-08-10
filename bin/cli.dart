import 'package:cli/cli.dart' as cli;
import 'dart:io';

const version = '0.0.1';

void main(List<String> arguments) {
  if (arguments.isEmpty || arguments.first == 'help') {
    printUsage();
  } else if (arguments.first == 'version') {
    print('Dartpedia CLI version $version');
  } else if (arguments.first == 'search') {
    // arguments.sublist(1): 첫번째 요소 이후 요소를 포함한 새 리스트 생성
    final inputArgs = arguments.length > 1 ? arguments.sublist(1) : null;
    searchWikipedia(inputArgs);
  } else {
    printUsage();
  }
}

void printUsage() {
  print(
    "The following commands are vaild: 'help', 'version', 'search <ARTICLE-TITLE>'",
  );
}

void searchWikipedia(List<String>? arguments) {
  final String articleTitle;
  if (arguments == null || arguments.isEmpty) {
    print('Please provide an article titile.');
    // await input and provide a default empty string if the input is null
    // null이 아닌 문자열임을 보장
    articleTitle = stdin.readLineSync() ?? '';
  } else {
    // join the arguments into a single string
    // 공백을 구분자로 사용하여 하나의
    articleTitle = arguments.join(' ');
  }
  print('Current article title: $articleTitle');
}
