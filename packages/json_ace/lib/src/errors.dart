/// Error handling for JSON ACE
///
/// This file contains the implementation of error handling for JSON ACE

/// Exception thrown during JSON conversion
class AceException implements Exception {
  /// Error message
  final String message;
  
  /// JSON path where the error occurred
  final String path;
  
  /// Expected type
  final String expectedType;
  
  /// Actual value
  final dynamic actualValue;
  
  /// Constructor for AceException
  AceException({
    required this.message,
    required this.path,
    required this.expectedType,
    required this.actualValue,
  });
  
  @override
  String toString() {
    return 'AceException: $message at $path. Expected $expectedType, got ${actualValue.runtimeType}: $actualValue';
  }
}

/// Detailed error information
class AceErrorDetails {
  /// JSON path where the error occurred
  final String path;
  
  /// Expected type
  final String expectedType;
  
  /// Actual value
  final dynamic actualValue;
  
  /// Suggested fix
  final String suggestedFix;
  
  /// Constructor for AceErrorDetails
  AceErrorDetails({
    required this.path,
    required this.expectedType,
    required this.actualValue,
    required this.suggestedFix,
  });
}
