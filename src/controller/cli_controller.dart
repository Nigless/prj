import 'dart:io';

import '../entity/project_dto.dart';
import '../lib/echo.dart';

abstract class AProjectDomain {
  make(String name);
  remove(String name);
  open(String name);
  openLast();
  Future<List<ProjectDTO>> list();
}

class CliController {
  final Map<String, Function(List<String>)> _routes = {};
  final AProjectDomain _projectDomain;

  CliController(this._projectDomain) {
    _routes["mk"] = this.make;
    _routes["rm"] = this.remove;
    _routes["ls"] = this.list;
    _routes["cd"] = this.open;
  }

  cli(List<String> args) async {
    if (args.isEmpty) {
      noCommand();
      return;
    }

    final name = args[0];

    final route = _routes[name];

    if (route == null) {
      echo("unknown command");
      return;
    }

    echo(await route(args.skip(1).toList()));
  }

  Future<String> noCommand() async {
    await _projectDomain.openLast();
    return "";
  }

  Future<String> make(List<String> args) async {
    if (args.isEmpty) {
      return "no prj name";
    }

    await _projectDomain.make(args[0]);
    return "";
  }

  Future<String> remove(List<String> args) async {
    if (args.isEmpty) {
      return "no prj name";
    }

    await _projectDomain.remove(args[0]);
    return "";
  }

  Future<String> open(List<String> args) async {
    if (args.isEmpty) {
      return "no prj name";
    }

    await _projectDomain.open(args[0]);
    return "";
  }

  Future<String> list(List<String> args) async {
    final list = await _projectDomain.list();
    return list.map((p) => p.name).join("\\n");
  }
}
