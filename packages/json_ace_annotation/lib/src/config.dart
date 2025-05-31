/// Global configuration for JSON ACE
/// 
/// This class provides global configuration options for JSON ACE

import 'strategies.dart';

/// Global configuration for JSON ACE
class AceGlobalConfig {
  /// Default strategy to use when none is specified
  final AceStrategy defaultStrategy;
  
  /// Whether to collect metrics by default
  final bool collectMetrics;
  
  /// Whether to use detailed metrics
  final bool detailedMetrics;
  
  /// How long to retain metrics
  final Duration metricsRetention;
  
  /// Whether to validate schemas by default
  final bool validateSchemas;
  
  /// Constructor for AceGlobalConfig
  const AceGlobalConfig({
    this.defaultStrategy = AceStrategy.flexible,
    this.collectMetrics = false,
    this.detailedMetrics = false,
    this.metricsRetention = const Duration(days: 1),
    this.validateSchemas = false,
  });
  
  /// Create a copy of this configuration with the given changes
  AceGlobalConfig copyWith({
    AceStrategy? defaultStrategy,
    bool? collectMetrics,
    bool? detailedMetrics,
    Duration? metricsRetention,
    bool? validateSchemas,
  }) {
    return AceGlobalConfig(
      defaultStrategy: defaultStrategy ?? this.defaultStrategy,
      collectMetrics: collectMetrics ?? this.collectMetrics,
      detailedMetrics: detailedMetrics ?? this.detailedMetrics,
      metricsRetention: metricsRetention ?? this.metricsRetention,
      validateSchemas: validateSchemas ?? this.validateSchemas,
    );
  }
}
