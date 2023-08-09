import 'dart:io';

import '../domain/project_domain.dart';

class BashExternal implements ABashExternal {
  @override
  createGitRepo(String path) async {
    await Process.start("git", ["init", path], runInShell: true);
  }
}
