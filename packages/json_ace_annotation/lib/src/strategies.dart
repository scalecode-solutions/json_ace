/// Strategy classes for JSON ACE
/// 
/// These strategies define how JSON values are converted to Dart types

/// Base class for conversion strategies
abstract class AceStrategy {
  /// Strategy name
  final String name;
  
  /// Constructor for AceStrategy
  const AceStrategy(this.name);
  
  /// Strict conversion strategy - only accepts exact type matches
  static const AceStrategy strict = _StrictStrategy();
  
  /// Flexible conversion strategy - attempts to convert between types
  static const AceStrategy flexible = _FlexibleStrategy();
  
  /// Null-safe conversion strategy - handles null values gracefully
  static const AceStrategy nullSafe = _NullSafeStrategy();
  
  /// Validation strategy - validates values against constraints
  static const AceStrategy validation = _ValidationStrategy();
  
  /// Strict with fallbacks strategy - tries strict first, then falls back to flexible
  static const AceStrategy strictWithFallbacks = _StrictWithFallbacksStrategy();
  
  /// High card strategy - strict conversion with high priority
  static const AceStrategy highCard = _HighCardStrategy();
  
  /// Wild card strategy - extremely flexible conversion
  static const AceStrategy wildCard = _WildCardStrategy();
  
  /// Compose multiple strategies
  static AceStrategy compose(List<AceStrategy> strategies) {
    return _CompositeStrategy(strategies);
  }
}

/// Strict conversion strategy implementation
class _StrictStrategy extends AceStrategy {
  const _StrictStrategy() : super('strict');
}

/// Flexible conversion strategy implementation
class _FlexibleStrategy extends AceStrategy {
  const _FlexibleStrategy() : super('flexible');
}

/// Null-safe conversion strategy implementation
class _NullSafeStrategy extends AceStrategy {
  const _NullSafeStrategy() : super('null_safe');
}

/// Validation strategy implementation
class _ValidationStrategy extends AceStrategy {
  const _ValidationStrategy() : super('validation');
}

/// Strict with fallbacks strategy implementation
class _StrictWithFallbacksStrategy extends AceStrategy {
  const _StrictWithFallbacksStrategy() : super('strict_with_fallbacks');
}

/// High card strategy implementation (card game themed)
class _HighCardStrategy extends AceStrategy {
  const _HighCardStrategy() : super('high_card');
}

/// Wild card strategy implementation (card game themed)
class _WildCardStrategy extends AceStrategy {
  const _WildCardStrategy() : super('wild_card');
}

/// Composite strategy implementation
class _CompositeStrategy extends AceStrategy {
  final List<AceStrategy> strategies;
  
  _CompositeStrategy(this.strategies) : super('composite');
}
