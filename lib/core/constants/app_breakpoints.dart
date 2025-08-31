class AppBreakpoints {
  static const double small = 700;
  static const double medium = 1100;

  static bool isSmall(double w) => w < small;
  static bool isMedium(double w) => w >= small && w < medium;
  static bool isLarge(double w) => w >= medium;
}
