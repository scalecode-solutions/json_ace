# Phase 7: Conversion Strategy Patterns

**Status**: 🔜 Planned

## Objective

Implement predefined conversion strategy patterns for JSON ACE that encapsulate complex conversion logic in reusable components, allowing for more sophisticated and consistent JSON parsing across a codebase while building on the foundation of `json_son`.

## Rationale

Conversion strategy patterns will:
- Encapsulate complex conversion logic in reusable components
- Allow for consistent application of conversion strategies
- Reduce duplication of conversion logic
- Enable more sophisticated parsing strategies
- Support custom strategy implementations

## Tasks

### 1. Design Strategy Pattern Architecture

- [ ] Define the strategy interface and base classes
- [ ] Identify common conversion strategies
- [ ] Design the strategy selection and application mechanism
- [ ] Plan for strategy composition and chaining
- [ ] Design extension points for custom strategies

### 2. Implement Core Strategies

- [ ] Implement strict parsing strategy
- [ ] Implement flexible parsing strategy
- [ ] Implement strict-with-fallbacks strategy
- [ ] Implement null-safe strategy
- [ ] Implement validation strategy

### 3. Implement Strategy Application

- [ ] Add strategy support to class-level configuration
- [ ] Add strategy support to field-level annotations
- [ ] Implement strategy resolution and precedence rules
- [ ] Add support for strategy composition

### 4. Implement Custom Strategy Support

- [ ] Create extension points for custom strategies
- [ ] Implement strategy registration mechanism
- [ ] Add documentation and examples for custom strategies
- [ ] Create testing utilities for strategy validation

### 5. Integrate with Code Generation

- [ ] Update code generators to support strategies
- [ ] Generate optimized code for each strategy
- [ ] Add strategy configuration to build system
- [ ] Support conditional strategies based on environment

### 6. Testing

- [ ] Create unit tests for each strategy
- [ ] Test strategy composition and chaining
- [ ] Test custom strategy implementation
- [ ] Test integration with code generation

### 7. Documentation

- [ ] Document all built-in strategies
- [ ] Create examples of strategy usage
- [ ] Document custom strategy implementation
- [ ] Create strategy selection guide

## Dependencies

- Phase 1: Package Structure
- Phase 2: Class-Level Configuration
- Phase 3: Type-Specific Annotations
- Phase 4: Code Generation System
- Phase 6: Global Configuration

## Estimated Effort

- **Design**: 3 days
- **Implementation**: 5 days
- **Testing**: 3 days
- **Documentation**: 2 days
- **Total**: 13 days

## Risks and Mitigation

| Risk | Impact | Likelihood | Mitigation |
|------|--------|------------|------------|
| Strategy complexity overwhelming users | Medium | Medium | Provide clear documentation and examples |
| Performance impact of complex strategies | Medium | Medium | Optimize generated code and benchmark performance |
| Strategy conflicts or unexpected behavior | High | Medium | Thorough testing and clear precedence rules |
| Difficulty in debugging strategy issues | Medium | High | Add detailed error messages and debugging tools |

## Definition of Done

- All core strategies are implemented
- Strategy application works at class and field levels
- Custom strategy support is implemented
- Code generation correctly applies strategies
- All tests pass with various strategy scenarios
- Documentation and examples are complete

## Example Implementation

### Built-in Strategies

```dart
// Using a built-in strategy at the class level
@JsonSonConfig(
  strategy: JsonSonStrategy.strictWithFallbacks
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

### Custom Strategies

```dart
// Defining a custom strategy
class MyCustomStrategy implements JsonSonStrategy {
  @override
  T? convert<T>(dynamic value, {bool required = false}) {
    // Custom conversion logic
    if (value == null) {
      return required ? throw JsonSonException('Value is required') : null;
    }
    
    // Type-specific conversion
    if (T == int) {
      return int.tryParse(value.toString()) as T?;
    }
    
    // Default fallback
    return value as T?;
  }
}

// Registering the custom strategy
JsonSon.registerStrategy('my_custom', MyCustomStrategy());

// Using the custom strategy
@JsonSonConfig(
  strategy: 'my_custom'
)
class MyDto {
  // ...
}
```

### Strategy Composition

```dart
// Composing multiple strategies
@AceConfig(
  strategy: AceStrategy.compose([
    AceStrategy.validation,
    AceStrategy.strictWithFallbacks,
    AceStrategy.nullSafe
  ])
)
class MyDto {
  // ...
}
```

### Field-Level Strategies

```dart
class MyDto {
  @AceInt(strategy: AceStrategy.highCard) // Using card game themed strategy names
  final int strictInt;
  
  @AceInt(strategy: AceStrategy.wildCard) // Flexible conversion
  final int flexibleInt;
  
  @AceString(strategy: 'royal_flush') // Custom strategy
  final String customString;
  
  MyDto({
    required this.strictInt,
    required this.flexibleInt,
    required this.customString,
  });
}
```
