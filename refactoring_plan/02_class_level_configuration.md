# Phase 2: Class-Level Configuration

**Status**: 🔜 Planned

## Objective

Implement a class-level annotation system for JSON ACE that can automatically apply conversion functions based on field types, significantly reducing boilerplate code and ensuring consistency.

## Rationale

Class-level configuration will:
- Eliminate repetitive annotations for each field
- Ensure consistent conversion across similar field types
- Reduce the risk of missing conversions
- Make code more maintainable and readable

## Tasks

### 1. Design the Class-Level Annotation API

- [ ] Define the `@AceConfig` annotation class
- [ ] Design the configuration parameters (nullable/required field handling, etc.)
- [ ] Design the type-to-converter mapping system
- [ ] Document the API design decisions

### 2. Implement the Annotation Class

- [ ] Create the annotation class in the `json_ace_annotation` package
- [ ] Implement parameter validation
- [ ] Write comprehensive documentation
- [ ] Create examples of usage

### 3. Implement Runtime Support (if needed)

- [ ] Add runtime support for accessing annotation data
- [ ] Implement fallback mechanisms for when annotations are not processed
- [ ] Ensure backward compatibility with existing code

### 4. Implement Basic Code Generation

- [ ] Create a build system generator in `json_ace_generator` for processing the annotations
- [ ] Implement logic to extract field information from annotated classes
- [ ] Generate appropriate conversion code based on class configuration
- [ ] Handle edge cases (generic types, nested objects, etc.)

### 5. Testing

- [ ] Create unit tests for the annotation class
- [ ] Create integration tests with various class configurations
- [ ] Test edge cases and error handling
- [ ] Benchmark performance compared to manual field annotations

### 6. Documentation

- [ ] Update API documentation
- [ ] Create usage examples
- [ ] Document best practices
- [ ] Update migration guide

## Dependencies

- Phase 1: Package Structure must be completed first

## Estimated Effort

- **Design**: 2 days
- **Implementation**: 4 days
- **Testing**: 3 days
- **Documentation**: 2 days
- **Total**: 11 days

## Risks and Mitigation

| Risk | Impact | Likelihood | Mitigation |
|------|--------|------------|------------|
| Complex edge cases with nested types | High | Medium | Thorough testing with complex object structures |
| Performance impact of automatic conversion | Medium | Medium | Benchmark and optimize generated code |
| Compatibility issues with existing code | High | Medium | Ensure backward compatibility and provide clear migration path |

## Definition of Done

- The `@JsonSonConfig` annotation is fully implemented
- Code generation correctly applies converters based on class configuration
- All tests pass with various class configurations
- Documentation and examples are complete
- Performance is comparable to or better than manual field annotations

## Example Implementation

```dart
// Target implementation example
@AceConfig(
  applyToAllFields: true,
  nullable: {
    'int': AceConverters.flexibleInt,
    'double': AceConverters.flexibleDouble,
    'bool': AceConverters.flexibleBool,
    'String': AceConverters.flexibleString,
  },
  required: {
    'int': AceConverters.requiredInt,
    'double': AceConverters.requiredDouble,
    'bool': AceConverters.requiredBool,
    'String': AceConverters.requiredString,
  }
)
class MyDto {
  final int? nullableInt;
  final int requiredInt;
  final String? nullableString;
  final String requiredString;
  
  MyDto({
    this.nullableInt,
    required this.requiredInt,
    this.nullableString,
    required this.requiredString,
  });
  
  factory MyDto.fromJson(Map<String, dynamic> json) => _$MyDtoFromJson(json);
  Map<String, dynamic> toJson() => _$MyDtoToJson(this);
}
```
