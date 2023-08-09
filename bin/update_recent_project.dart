import 'dart:io';
import "package:path/path.dart" as path;

import '../src/external/cache_external.dart';

main() async {
  const PROJECTS = String.fromEnvironment('PROJECTS');
  const CACHE = String.fromEnvironment('CACHE');
  const RECENT_PROJECT = String.fromEnvironment('RECENT_PROJECT');

  final cache = CacheExternal(CACHE, RECENT_PROJECT);

  if (path.isWithin(PROJECTS, Directory.current.path)) {
    cache.setLastProject(
        Directory.current.path.replaceFirst(PROJECTS, "").split("/")[1]);
    return;
  }

  try {
    final name = (await cache.getLastProject()).name;
    cache.setLastProject(name);
  } catch (e) {}
}
