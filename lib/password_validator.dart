class PasswordValidator {
  String passwordValidator(val) {
    if (val.isEmpty) {
      return 'A password is required';
    } else if (val.length < 6) {
      return 'should be more than 6 characters';
    } else if (val.length > 15) {
      return 'should not be more than 15 characters';
    } else {
      return null;
    }
  }
}
