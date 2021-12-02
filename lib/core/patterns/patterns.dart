class Patterns {
  static bool isValidJWT(String value) {
    return RegExp(r'^[A-Za-z0-9-_=]+\.[A-Za-z0-9-_=]+\.?[A-Za-z0-9-_.+/=]*$')
        .hasMatch(value);
  }
}
