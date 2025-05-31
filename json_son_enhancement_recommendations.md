# Recommendations for Enhancing json_son

## Current Challenges

While working on the Better Certs app to centralize JSON type conversion using the `json_son` package, we encountered several challenges:

1. **Manual Field-by-Field Updates**: Each field in every DTO requires manual annotation with the appropriate conversion function, which is time-consuming and error-prone.

2. **Repetitive Code**: The same pattern (`@JsonKey(name: 'fieldName', fromJson: flexibleXxxFromJson)`) needs to be repeated for every field.

3. **Maintenance Burden**: When new DTOs are added or existing ones are modified, developers must remember to apply the appropriate conversion functions.

4. **Inconsistency Risk**: Without a centralized approach, there's a risk of inconsistent application of conversion functions across the codebase.

## Enhancement Recommendations

### 1. Class-Level Configuration

Implement a class-level annotation that can automatically apply conversion functions based on field types:

```dart
@JsonSonConfig(
  applyToAllFields: true,  // Apply default converters to all fields
  nullable: {  // Configuration for nullable fields
    'int': flexibleIntFromJson,
    'double': flexibleDoubleFromJson,
    'bool': flexibleBoolFromJson,
    'String': flexibleStringFromJson,
  },
  required: {  // Configuration for non-nullable fields
    'int': flexibleRequiredIntFromJson,
    'double': flexibleRequiredDoubleFromJson,
    'bool': flexibleRequiredBoolFromJson,
    'String': flexibleRequiredStringFromJson,
  }
)
class MyDto {
  // Fields will automatically use the appropriate converter
  final int? nullableInt;
  final int requiredInt;
  // ...
}
```

### 2. Type-Specific Annotations

Provide type-specific annotations for more granular control:

```dart
class MyDto {
  @JsonSonInt(nullable: true)  // Uses flexibleIntFromJson
  final int? nullableInt;
  
  @JsonSonInt(required: true)  // Uses flexibleRequiredIntFromJson
  final int requiredInt;
  
  @JsonSonString(required: true, name: 'custom_name')  // Combines name and converter
  final String requiredString;
}
```

### 3. Global Configuration

Allow setting global defaults that can be overridden at the class or field level:

```dart
// In main.dart or a config file
JsonSon.configure(
  defaultNullableConverters: true,  // Use flexible converters for nullable fields
  defaultRequiredConverters: true,  // Use flexible converters for required fields
  explicitFieldNames: true,  // Always use the field name as the JSON key
);
```

### 4. Build-Time Code Generation

Create a build-time code generation tool that can automatically add the appropriate converters to existing DTOs:

```bash
# Command-line tool
flutter pub run json_son:add_converters --target=lib/src/data/network/dtos/
```

This would scan all DTOs in the specified directory and add the appropriate converters based on field types and nullability.

### 5. Integration with json_serializable/freezed

Develop deeper integration with `json_serializable` and `freezed` to automatically apply converters during their code generation process:

```dart
@freezed
@JsonSonEnabled  // Enables automatic application of converters
class MyDto with _$MyDto {
  const factory MyDto({
    required int id,
    required String name,
    bool? isActive,
  }) = _MyDto;
  
  factory MyDto.fromJson(Map<String, dynamic> json) => _$MyDtoFromJson(json);
}
```

### 6. Selective Override

Allow selectively overriding the global or class-level configuration for specific fields:

```dart
@JsonSonConfig(applyToAllFields: true)
class MyDto {
  final int id;  // Uses default converter
  
  @JsonSonOverride(useFlexibleConverter: false)  // Opt out for this field
  final String rawValue;
  
  @JsonSonOverride(converter: myCustomConverter)  // Custom converter
  final dynamic customField;
}
```

### 7. Conversion Strategy Patterns

Implement predefined conversion strategies that can be applied to entire classes:

```dart
@JsonSonConfig(strategy: JsonSonStrategy.strictWithFallbacks)
class MyDto {
  // All fields use a strategy that tries strict parsing first,
  // then falls back to flexible conversion if that fails
}
```

## Package Structure Recommendation

To better organize functionality and allow users to adopt only what they need, consider splitting `json_son` into multiple packages with clear separation of concerns:

### 1. `json_son` (Core Package)

- **Purpose**: Provide runtime utilities for flexible JSON parsing
- **Contents**:
  - Flexible conversion functions (`flexibleIntFromJson`, etc.)
  - `JsonSon` class for runtime JSON manipulation
  - Error handling utilities
- **Dependencies**: Minimal, just core Dart libraries

### 2. `json_son_annotation` (Annotation Package)

- **Purpose**: Provide annotations for marking up code
- **Contents**:
  - `JsonSonConfig` annotation for class-level configuration
  - `JsonSonOverride` annotation for field-level overrides
  - Type-specific annotations (`JsonSonInt`, `JsonSonString`, etc.)
- **Dependencies**: Only on `json_son` core package

### 3. `json_son_generator` (Code Generation Package)

- **Purpose**: Generate code based on annotations
- **Contents**:
  - Build system integration
  - Code generation logic
  - Integration with `json_serializable` and `freezed`
- **Dependencies**: `build`, `source_gen`, `analyzer`, `json_son`, `json_son_annotation`

### Benefits of This Approach

1. **Clear Separation of Concerns**: Each package has a focused responsibility
2. **Flexible Adoption**: Users can adopt just the parts they need
3. **Manageable Maintenance**: Packages can evolve at different rates
4. **Reduced Overhead**: Users who only need runtime utilities don't have to include code generation dependencies
5. **Follows Ecosystem Patterns**: Aligns with common patterns in the Flutter/Dart ecosystem (e.g., `json_serializable`/`json_annotation`, `freezed`/`freezed_annotation`)

## Implementation Considerations

1. **Backward Compatibility**: Ensure any enhancements maintain compatibility with existing code using the current API.

2. **Performance Impact**: Evaluate the performance impact of automatic conversion, especially for large DTOs.

3. **Clear Documentation**: Provide comprehensive documentation and examples for the new features.

4. **Testing Tools**: Include testing utilities to verify that conversions are working as expected.

5. **Migration Guide**: Create a migration guide for users of the current API to adopt the new features.

## Conclusion

Enhancing `json_son` with these features would significantly reduce the manual effort required to implement robust JSON parsing in Flutter applications. It would make the package more attractive for large-scale projects where manually annotating hundreds of fields is impractical.

The most impactful enhancements would be the class-level configuration and build-time code generation, as these would provide immediate benefits for existing codebases without requiring extensive refactoring.
