class CustomFunctions {
  static int getYearFromString(String? dateString) {
    try {
      if (dateString == null || dateString.isEmpty) {
        throw FormatException('Invalid date string');
      }

      DateTime date =
          DateTime.parse(dateString); // Parse the string into DateTime
      return date.year; // Return the year part
    } catch (e) {
      // Handle the error (for invalid date format or other errors)
      print('Error: Invalid date format or empty string');
      return -1; // Return a default value (or you can return null depending on your needs)
    }
  }
}
