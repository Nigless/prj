import 'package:path/path.dart' as path;

import '../controller/cli_controller.dart';
import '../entity/project_dto.dart';

abstract class AProjectExternal {
  createProject(String path);
  removeProject(String path);
  openProject(String name);
  Future<List<ProjectDTO>> getProjects();
}

abstract class ABashExternal {
  createGitRepo(String path);
}

abstract class ACacheExternal {
  Future<ProjectDTO> getLastProject();
  setLastProject(String name);
}

class ProjectDomain implements AProjectDomain {
  final AProjectExternal _projectExternal;
  final ACacheExternal _cacheExternal;

  ProjectDomain(this._projectExternal, this._cacheExternal);

  @override
  make(String name) async {
    await _projectExternal.createProject(name);
  }

  @override
  remove(String name) async {
    await _projectExternal.removeProject(name);
  }

  @override
  open(String name) async {
    await _projectExternal.openProject(name);
  }

  @override
  openLast() async {
    try {
      final project = await _cacheExternal.getLastProject();
      _projectExternal.openProject(project.name);
    } catch (e) {}
  }

  @override
  Future<List<ProjectDTO>> list() async {
    return _projectExternal.getProjects();
  }
}
