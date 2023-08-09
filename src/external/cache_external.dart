import 'dart:io';

import '../domain/project_domain.dart';
import '../entity/project_dto.dart';

class CacheExternal implements ACacheExternal {
  final String _cacheLocation;
  final String _lastProject;

  CacheExternal(this._cacheLocation, this._lastProject);

  Future<List<String>> _readCache() async {
    final File file = File(_cacheLocation);
    if (!await file.exists()) {
      file.create();
    }

    final content = await file.readAsString();
    return content.split("\n");
  }

  _writeCache(List<String> content) async {
    final File file = File(_cacheLocation);
    await file.writeAsString(content.join("\n"));
  }

  @override
  Future<ProjectDTO> getLastProject() async {
    if (_lastProject != "") return ProjectDTO(_lastProject);

    final name = (await _readCache())[0];

    if (name == null || name == "") {
      return Future.error("NotFound");
    }

    return ProjectDTO(name);
  }

  @override
  setLastProject(String name) async {
    if (_lastProject == name) return;

    print("export RECENT_PROJECT=\"$name\"");

    final content = await _readCache();
    content[0] = name;
    await _writeCache(content);
  }
}
