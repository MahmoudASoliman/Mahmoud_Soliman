import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_portfolio/features/projects/model/project.dart';
import 'package:my_portfolio/features/projects/data/assets_data.dart';

class ProjectsState {
  final List<Project> all;
  final String filter; // All, Flutter, Firebase, ...
  const ProjectsState({required this.all, required this.filter});

  List<Project> get visible {
    if (filter == 'All') return all;
    return all.where((p) => p.tags.map((e) => e.toLowerCase()).contains(filter.toLowerCase())).toList();
  }

  ProjectsState copyWith({List<Project>? all, String? filter}) =>
      ProjectsState(all: all ?? this.all, filter: filter ?? this.filter);
}

class ProjectsCubit extends Cubit<ProjectsState> {
  ProjectsCubit() : super(const ProjectsState(all: [], filter: 'All'));

  static const filters = ['All', 'Flutter', 'Firebase', 'AI-OCR', 'Maps', 'SQLite', 'REST', 'Responsive'];

  void loadInitial() {
    emit(ProjectsState(all: AssetsData.projects, filter: 'All'));
  }

  void setFilter(String f) => emit(state.copyWith(filter: f));
}
