import 'dart:io';
import 'package:path/path.dart' as path;

import '../domain/project_domain.dart';
import '../entity/project_dto.dart';

class ProjectExternal implements AProjectExternal {
  final String _projectsDir;

  ProjectExternal(this._projectsDir);

  @override
  createProject(String name) async {
    final projectDir = Directory(path.join(_projectsDir, name));
    if (await projectDir.exists()) return;

    projectDir.create();
    print("cd \"${projectDir.path}\";");
    print("git init;");
  }

  @override
  removeProject(String name) async {
    final projectDir = Directory(path.join(_projectsDir, name));
    if (!await projectDir.exists()) return;

    print("cd \"${this._projectsDir}\";");
    projectDir.delete(recursive: true);
  }

  @override
  openProject(String name) async {
    final projectPath = path.join(_projectsDir, name);

    print('cd $projectPath;');
  }

  @override
  Future<List<ProjectDTO>> getProjects() async {
    final dir = Directory(_projectsDir);
    final list = await dir.list().toList();

    final List<ProjectDTO> result = [];

    list.forEach((entity) {
      if (entity is Directory) {
        result.add(ProjectDTO(path.basename(entity.path)));
      }
    });

    return result;
  }
}
