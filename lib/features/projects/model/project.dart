class Project {
  const Project({
    required this.title,
    required this.description,
    required this.tags,
    required this.repoUrl,
    required this.demoUrl,
    required this.imageUrls,
  });

  final String title;
  final String description;
  final List<String> tags;
  final String repoUrl;
  final String demoUrl;
  final List<String> imageUrls;
}
