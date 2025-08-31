import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_portfolio/core/constants/app_breakpoints.dart';
import 'package:my_portfolio/features/projects/presentation/widgets/project_card.dart';
import 'package:my_portfolio/features/projects/state/projects_cubit.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  double _cardAspectForWidth(double w) {
    if (w < 420) return 0.58;
    if (AppBreakpoints.isSmall(w)) return 0.64;
    if (AppBreakpoints.isMedium(w)) return 0.74;
    return 0.74;
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    final w = MediaQuery.of(context).size.width;
    final isUltraSmall = w < 420;
    final isTiny = w < 360;
    final isSmall = AppBreakpoints.isSmall(w);
    final isMedium = AppBreakpoints.isMedium(w);
    final cross = isSmall ? 1 : (isMedium ? 2 : (w >= 1400 ? 4 : 3));

    return BlocBuilder<ProjectsCubit, ProjectsState>(
      builder: (context, state) {
        final filters = ProjectsCubit.filters;

        final Widget filtersWidget = isTiny
            ? DropdownButton<String>(
                value: state.filter,
                onChanged: (v) => context.read<ProjectsCubit>().setFilter(v ?? 'All'),
                items: filters.map((f) => DropdownMenuItem(value: f, child: Text(f))).toList(),
              )
            : _FiltersScroller(
                filters: filters,
                current: state.filter,
                onPick: (v) => context.read<ProjectsCubit>().setFilter(v),
              );

        final header = isUltraSmall
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Projects',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: t.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                      const SizedBox(width: 8),
                      _CountPill(count: state.visible.length),
                    ],
                  ),
                  const SizedBox(height: 8),
                  filtersWidget,
                ],
              )
            : Row(
                children: [
                  Text('Projects', style: t.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
                  const SizedBox(width: 10),
                  _CountPill(count: state.visible.length),
                  const SizedBox(width: 12),
                  Expanded(child: filtersWidget),
                ],
              );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            header,
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: state.visible.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: cross,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: _cardAspectForWidth(w),
              ),
              itemBuilder: (_, i) => ProProjectCard(project: state.visible[i]),
            ),
          ],
        );
      },
    );
  }
}

class _FiltersScroller extends StatelessWidget {
  const _FiltersScroller({required this.filters, required this.current, required this.onPick});
  final List<String> filters;
  final String current;
  final ValueChanged<String> onPick;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsetsDirectional.only(end: 4),
        itemCount: filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 6),
        itemBuilder: (context, i) {
          final f = filters[i];
          final selected = f == current;
          return FilterChip(
            selected: selected,
            showCheckmark: selected,
            label: Text(f, overflow: TextOverflow.ellipsis),
            visualDensity: const VisualDensity(horizontal: -2, vertical: -2),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onSelected: (_) => onPick(f),
          );
        },
      ),
    );
  }
}

class _CountPill extends StatelessWidget {
  const _CountPill({required this.count});
  final int count;
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: cs.primary.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: cs.outline.withValues(alpha: 0.25)),
      ),
      child: Text('$count', style: TextStyle(color: cs.onSurface)),
    );
  }
}
