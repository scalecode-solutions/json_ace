/// Metrics collection for JSON ACE
///
/// This file contains the implementation of metrics collection for JSON ACE

/// Metrics collection for JSON ACE
class AceMetrics {
  /// Map of class names to success counts
  final Map<String, int> _successCounts = {};
  
  /// Map of class names to failure counts
  final Map<String, int> _failureCounts = {};
  
  /// Map of class names to conversion times
  final Map<String, List<Duration>> _conversionTimes = {};
  
  /// Map of field paths to failure counts
  final Map<String, int> _fieldFailureCounts = {};
  
  /// Record a successful conversion
  void recordSuccess(String className, Duration conversionTime) {
    _successCounts[className] = (_successCounts[className] ?? 0) + 1;
    _conversionTimes[className] ??= [];
    _conversionTimes[className]!.add(conversionTime);
  }
  
  /// Record a failed conversion
  void recordFailure(String className, String? fieldPath) {
    _failureCounts[className] = (_failureCounts[className] ?? 0) + 1;
    
    if (fieldPath != null) {
      _fieldFailureCounts[fieldPath] = (_fieldFailureCounts[fieldPath] ?? 0) + 1;
    }
  }
  
  /// Get the success rate for a class
  double getSuccessRate(String className) {
    final successCount = _successCounts[className] ?? 0;
    final failureCount = _failureCounts[className] ?? 0;
    
    if (successCount + failureCount == 0) {
      return 0.0;
    }
    
    return successCount / (successCount + failureCount);
  }
  
  /// Get the average conversion time for a class
  Duration getAverageTime(String className) {
    final times = _conversionTimes[className];
    
    if (times == null || times.isEmpty) {
      return Duration.zero;
    }
    
    final totalMicroseconds = times.fold<int>(
      0, (sum, time) => sum + time.inMicroseconds);
    
    return Duration(microseconds: totalMicroseconds ~/ times.length);
  }
  
  /// Get the failure count for a field
  int getFailureCount(String fieldPath) {
    return _fieldFailureCounts[fieldPath] ?? 0;
  }
  
  /// Clear all metrics
  void clear() {
    _successCounts.clear();
    _failureCounts.clear();
    _conversionTimes.clear();
    _fieldFailureCounts.clear();
  }
}
