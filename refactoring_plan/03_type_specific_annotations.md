# Phase 3: Type-Specific Annotations

**Status**: 🔜 Planned

## Objective

Create a set of type-specific annotations for JSON ACE that provide granular control over JSON conversion while still reducing boilerplate compared to the current approach.

## Rationale

Type-specific annotations will:
- Provide more explicit and type-safe conversion options
- Allow for field-level customization when needed
- Improve code readability through clear intent
- Simplify IDE auto-completion and documentation

## Tasks

### 1. Design Type-Specific Annotation API

- [ ] Define the base annotation interface/class
- [ ] Design type-specific annotations for primitive types (`@AceInt`, `@AceString`, etc.)
- [ ] Design annotations for collection types (`@AceList`, `@AceMap`, etc.)
- [ ] Design annotations for custom types (`@AceDateTime`, `@AceUri`, etc.)
- [ ] Define common parameters across all annotations (nullable, required, name, etc.)
- [ ] Define type-specific parameters for each annotation

### 2. Implement Annotation Classes

- [ ] Create the base annotation class in the `json_ace_annotation` package
- [ ] Implement primitive type annotations
- [ ] Implement collection type annotations
- [ ] Implement custom type annotations
- [ ] Implement parameter validation
- [ ] Write comprehensive documentation

### 3. Implement Code Generation Support

- [ ] Extend the build system generator to process type-specific annotations
- [ ] Implement logic to generate appropriate conversion code based on annotation type
- [ ] Handle interaction between class-level and field-level annotations
- [ ] Implement priority rules for when multiple annotations apply

### 4. Testing

- [ ] Create unit tests for each annotation class
- [ ] Create integration tests with various annotation combinations
- [ ] Test interaction with class-level configuration
- [ ] Test edge cases and error handling

### 5. Documentation

- [ ] Update API documentation
- [ ] Create usage examples for each annotation type
- [ ] Document best practices for choosing between class-level and field-level annotations
- [ ] Update migration guide

## Dependencies

- Phase 1: Package Structure
- Phase 2: Class-Level Configuration

## Estimated Effort

- **Design**: 2 days
- **Implementation**: 5 days
- **Testing**: 3 days
- **Documentation**: 2 days
- **Total**: 12 days

## Risks and Mitigation

| Risk | Impact | Likelihood | Mitigation |
|------|--------|------------|------------|
| Too many annotation types causing confusion | Medium | Medium | Group related annotations and provide clear documentation |
| Conflicts between class-level and field-level annotations | High | Medium | Establish clear precedence rules and document them |
| Performance overhead from multiple annotation processing | Low | Low | Optimize code generation and benchmark performance |

## Definition of Done

- All type-specific annotations are implemented
- Code generation correctly processes annotations and generates appropriate conversion code
- Interaction between class-level and field-level annotations works as expected
- All tests pass with various annotation combinations
- Documentation and examples are complete

## Example Implementation

```dart
// Target implementation example
class MyDto {
  @AceInt(nullable: true)  // Uses AceConverters.flexibleInt
  final int? nullableInt;
  
  @AceInt(required: true)  // Uses AceConverters.requiredInt
  final int requiredInt;
  
  @AceString(required: true, name: 'custom_name')  // Combines name and converter
  final String requiredString;
  
  @AceList(itemType: AceType.string, nullable: true)
  final List<String>? stringList;
  
  @AceDateTime(format: 'yyyy-MM-dd')
  final DateTime date;
  
  MyDto({
    this.nullableInt,
    required this.requiredInt,
    required this.requiredString,
    this.stringList,
    required this.date,
  });
  
  factory MyDto.fromJson(Map<String, dynamic> json) => _$MyDtoFromJson(json);
  Map<String, dynamic> toJson() => _$MyDtoToJson(this);
}
```
