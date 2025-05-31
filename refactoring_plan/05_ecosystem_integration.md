# Phase 5: Ecosystem Integration

**Status**: 🔜 Planned

## Objective

Develop deep integration with popular Dart/Flutter serialization packages like `json_serializable` and `freezed` to allow seamless use of `json_ace` within existing codebases, while maintaining compatibility with `json_son`.

## Rationale

Ecosystem integration will:
- Leverage existing adoption of popular serialization packages
- Allow gradual adoption of `json_ace` features
- Reduce friction for teams already using these packages
- Enable more powerful serialization capabilities while maintaining familiar workflows
- Provide a clear migration path from `json_son` to `json_ace`

## Tasks

### 1. Analyze Integration Points

- [ ] Identify extension points in `json_serializable`
- [ ] Identify extension points in `freezed`
- [ ] Document how these packages handle custom converters
- [ ] Identify potential conflicts or limitations

### 2. Design Integration Approach

- [ ] Design integration annotations (`@AceEnabled`, etc.)
- [ ] Define how `json_ace` will interact with existing annotations
- [ ] Design build system integration that works alongside existing generators
- [ ] Plan for conflict resolution and precedence rules
- [ ] Define compatibility layer between `json_son` and `json_ace`

### 3. Implement json_serializable Integration

- [ ] Create integration layer for `json_serializable`
- [ ] Implement custom builder that works with `json_serializable` builder
- [ ] Add support for `json_ace` annotations in `json_serializable` generated code
- [ ] Test compatibility with various `json_serializable` features

### 4. Implement freezed Integration

- [ ] Create integration layer for `freezed`
- [ ] Implement custom builder that works with `freezed` builder
- [ ] Add support for `json_ace` annotations in `freezed` generated code
- [ ] Test compatibility with various `freezed` features

### 5. Create Unified Build System

- [ ] Implement build system that coordinates all generators
- [ ] Ensure correct build order and dependencies
- [ ] Optimize build performance
- [ ] Add configuration options for integration behavior

### 6. Testing

- [ ] Create integration tests with `json_serializable`
- [ ] Create integration tests with `freezed`
- [ ] Test complex scenarios with nested objects and collections
- [ ] Test edge cases and error handling
- [ ] Verify build performance with large codebases

### 7. Documentation

- [ ] Create detailed documentation for integration with each package
- [ ] Document configuration options and customization
- [ ] Create migration guides for existing users of these packages
- [ ] Provide examples of common integration scenarios
- [ ] Document known limitations or considerations

## Dependencies

- Phase 1: Package Structure
- Phase 2: Class-Level Configuration
- Phase 3: Type-Specific Annotations
- Phase 4: Code Generation System

## Estimated Effort

- **Analysis**: 2 days
- **Design**: 3 days
- **Implementation**: 6 days
- **Testing**: 4 days
- **Documentation**: 3 days
- **Total**: 18 days

## Risks and Mitigation

| Risk | Impact | Likelihood | Mitigation |
|------|--------|------------|------------|
| Breaking changes in integrated packages | High | Medium | Monitor package releases and maintain version compatibility matrix |
| Build system conflicts | High | High | Thorough testing with various build configurations and provide conflict resolution options |
| Performance degradation with multiple generators | Medium | Medium | Optimize build process and implement caching strategies |
| Complex configuration requirements | Medium | Medium | Provide sensible defaults and clear documentation |

## Definition of Done

- Integration with `json_serializable` is fully implemented and tested
- Integration with `freezed` is fully implemented and tested
- Build system correctly coordinates all generators
- All tests pass with various integration scenarios
- Documentation and migration guides are complete
- Performance is acceptable for large codebases

## Example Implementation

### Integration with json_serializable

```dart
@JsonSonEnabled  // Enables automatic application of converters
@JsonSerializable()
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

### Integration with freezed

```dart
@freezed
@JsonSonEnabled  // Enables automatic application of converters
class MyDto with _$MyDto {
  const factory MyDto({
    int? nullableInt,
    required int requiredInt,
    String? nullableString,
    required String requiredString,
  }) = _MyDto;
  
  factory MyDto.fromJson(Map<String, dynamic> json) => _$MyDtoFromJson(json);
}
```

### Build Configuration

```yaml
# In build.yaml
targets:
  $default:
    builders:
      json_son_generator|json_son:
        enabled: true
        options:
          integrate_with_json_serializable: true
          integrate_with_freezed: true
      json_serializable:
        options:
          # json_serializable options
      freezed:
        options:
          # freezed options
```
