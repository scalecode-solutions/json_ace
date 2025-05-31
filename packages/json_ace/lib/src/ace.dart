/// Core implementation of the JSON ACE library
///
/// This file contains the main Ace class that provides the public API for the library

import 'package:json_son/json_son.dart' as json_son;
import 'package:json_ace_annotation/json_ace_annotation.dart';
import 'metrics.dart';
import 'errors.dart';

/// Main class for JSON ACE functionality
class Ace {
  /// Global configuration for JSON ACE
  static AceGlobalConfig _config = const AceGlobalConfig();
  
  /// Metrics collection for JSON ACE
  static final AceMetrics _metrics = AceMetrics();
  
  /// Get the current metrics
  static AceMetrics get metrics => _metrics;
  
  /// Configure JSON ACE globally
  static void configure({
    AceStrategy? defaultStrategy,
    bool? collectMetrics,
    bool? detailedMetrics,
    Duration? metricsRetention,
    bool? validateSchemas,
  }) {
    _config = _config.copyWith(
      defaultStrategy: defaultStrategy,
      collectMetrics: collectMetrics,
      detailedMetrics: detailedMetrics,
      metricsRetention: metricsRetention,
      validateSchemas: validateSchemas,
    );
  }
  
  /// Register a custom type converter
  static void registerType<T>({
    required dynamic Function(dynamic) fromJson,
    required dynamic Function(T) toJson,
  }) {
    // Implementation will use json_son as foundation and extend it
    // This is a placeholder for the actual implementation
  }
  
  /// Get detailed error information
  static AceErrorDetails getErrorDetails(Exception error) {
    // Implementation will provide detailed error information
    // This is a placeholder for the actual implementation
    return AceErrorDetails(
      path: 'unknown',
      expectedType: 'unknown',
      actualValue: 'unknown',
      suggestedFix: 'Check the input data',
    );
  }
  
  /// Debug view of the conversion process
  static AceDebugView debugView(dynamic jsonData, Type targetType) {
    // Implementation will provide a visual representation of the conversion process
    // This is a placeholder for the actual implementation
    return AceDebugView(
      visualTree: 'Debug visualization not yet implemented',
    );
  }
  
  /// Convert a value using the specified strategy
  static T? convert<T>(dynamic value, {AceStrategy? strategy}) {
    // Use json_son as the foundation for conversion
    strategy ??= _config.defaultStrategy;
    
    // This is a placeholder for the actual implementation
    // In the real implementation, we would use different strategies based on the strategy parameter
    try {
      if (T == int) {
        return json_son.JsonSon.toInt(value) as T?;
      } else if (T == double) {
        return json_son.JsonSon.toDouble(value) as T?;
      } else if (T == bool) {
        return json_son.JsonSon.toBool(value) as T?;
      } else if (T == String) {
        return json_son.JsonSon.toString(value) as T?;
      } else if (T == DateTime) {
        // Custom DateTime conversion would be implemented here
        return null;
      } else {
        // For complex types, we would use code generation
        return null;
      }
    } catch (e) {
      // Handle errors based on strategy
      return null;
    }
  }
}

/// Debug view of the conversion process
class AceDebugView {
  /// Visual representation of the conversion process
  final String visualTree;
  
  /// Constructor for AceDebugView
  AceDebugView({
    required this.visualTree,
  });
}
