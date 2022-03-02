class OnfidoConfigException implements Exception {
  const OnfidoConfigException(this.message);

  final String message;
}

class OnfidoConfigMissingTokenException extends OnfidoConfigException {
  const OnfidoConfigMissingTokenException() : super('SDK token is missing');
}

class OnfidoConfigInvalidJWTTokenException extends OnfidoConfigException {
  const OnfidoConfigInvalidJWTTokenException()
      : super('SDK token is not valid JWT');
}

class OnfidoConfigInvalidFlowStepsException extends OnfidoConfigException {
  const OnfidoConfigInvalidFlowStepsException()
      : super(
            "Flow steps doesn't include either captureDocument options or captureFace options");
}
