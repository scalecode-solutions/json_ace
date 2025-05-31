/// Annotation classes for JSON ACE
/// 
/// These annotations provide configuration for JSON serialization and deserialization
import 'package:meta/meta.dart';
import 'strategies.dart';

/// Base class for all JSON ACE annotations
@immutable
abstract class AceAnnotation {
  const AceAnnotation();
}

/// Class-level configuration for JSON serialization and deserialization
@immutable
class AceConfig extends AceAnnotation {
  /// The strategy to use for conversion
  final AceStrategy? strategy;
  
  /// Whether to validate against a JSON schema
  final bool validateSchema;
  
  /// Path to the JSON schema file
  final String? schemaPath;
  
  /// Whether to collect metrics for conversions
  final bool collectMetrics;
  
  /// Constructor for AceConfig
  const AceConfig({
    this.strategy,
    this.validateSchema = false,
    this.schemaPath,
    this.collectMetrics = false,
  });
}

/// Base class for field-level annotations
@immutable
abstract class AceField extends AceAnnotation {
  /// The JSON key to use for this field
  final String? name;
  
  /// Whether this field is required
  final bool required;
  
  /// The strategy to use for conversion
  final dynamic strategy;
  
  /// Constructor for AceField
  const AceField({
    this.name,
    this.required = false,
    this.strategy,
  });
}

/// Annotation for int fields
@immutable
class AceInt extends AceField {
  /// Default value if conversion fails
  final int? defaultValue;
  
  /// Constructor for AceInt
  const AceInt({
    super.name,
    super.required,
    super.strategy,
    this.defaultValue,
  });
}

/// Annotation for double fields
@immutable
class AceDouble extends AceField {
  /// Default value if conversion fails
  final double? defaultValue;
  
  /// Constructor for AceDouble
  const AceDouble({
    super.name,
    super.required,
    super.strategy,
    this.defaultValue,
  });
}

/// Annotation for String fields
@immutable
class AceString extends AceField {
  /// Default value if conversion fails
  final String? defaultValue;
  
  /// Constructor for AceString
  const AceString({
    super.name,
    super.required,
    super.strategy,
    this.defaultValue,
  });
}

/// Annotation for bool fields
@immutable
class AceBool extends AceField {
  /// Default value if conversion fails
  final bool? defaultValue;
  
  /// Constructor for AceBool
  const AceBool({
    super.name,
    super.required,
    super.strategy,
    this.defaultValue,
  });
}

/// Annotation for DateTime fields
@immutable
class AceDateTime extends AceField {
  /// Format for DateTime conversion
  final String? format;
  
  /// Default value if conversion fails
  final DateTime? defaultValue;
  
  /// Constructor for AceDateTime
  const AceDateTime({
    super.name,
    super.required,
    super.strategy,
    this.format,
    this.defaultValue,
  });
}

/// Annotation for List fields
@immutable
class AceList extends AceField {
  /// Default value if conversion fails
  final List? defaultValue;
  
  /// Constructor for AceList
  const AceList({
    super.name,
    super.required,
    super.strategy,
    this.defaultValue,
  });
}

/// Annotation for Map fields
@immutable
class AceMap extends AceField {
  /// Default value if conversion fails
  final Map? defaultValue;
  
  /// Constructor for AceMap
  const AceMap({
    super.name,
    super.required,
    super.strategy,
    this.defaultValue,
  });
}

/// Annotation for custom type fields
@immutable
class AceCustom<T> extends AceField {
  /// Default value if conversion fails
  final T? defaultValue;
  
  /// Constructor for AceCustom
  const AceCustom({
    super.name,
    super.required,
    super.strategy,
    this.defaultValue,
  });
}

/// Annotation to ignore a field during serialization/deserialization
@immutable
class AceIgnore extends AceAnnotation {
  /// Constructor for AceIgnore
  const AceIgnore();
}
