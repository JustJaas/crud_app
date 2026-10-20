class TaskValidator {
  static const int minTitleLength = 3;

  static String? validateTitle(String? value) {
    final String text = value?.trim() ?? '';
    if (text.isEmpty) {
      return 'El título es obligatorio';
    }
    if (text.length < minTitleLength) {
      return 'El título debe tener al menos $minTitleLength caracteres';
    }
    return null;
  }
}
