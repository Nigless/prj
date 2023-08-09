import 'dart:io';

import "package:path/path.dart" as path;

import '../src/controller/cli_controller.dart';
import '../src/domain/project_domain.dart';
import '../src/external/cache_external.dart';
import '../src/external/project_external.dart';

Future<void> main(List<String> arguments) async {
  const PROJECTS = String.fromEnvironment('PROJECTS');
  const CACHE = String.fromEnvironment('CACHE');
  const RECENT_PROJECT = String.fromEnvironment('RECENT_PROJECT');

  final cliController = CliController(ProjectDomain(
      ProjectExternal(PROJECTS), CacheExternal(CACHE, RECENT_PROJECT)));

  await cliController.cli(arguments);
}
