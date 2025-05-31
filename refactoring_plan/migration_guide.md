# Migration Guide: From json_son to JSON ACE

## Overview

This guide provides instructions for migrating from `json_son` to the new `json_ace` package. We've designed the migration path to be as smooth as possible, allowing for incremental adoption of new features while maintaining compatibility with existing code. Note that `json_son` will continue to exist as a standalone package, and migration is optional.

## Migration Paths

### Path 1: Gradual Adoption (Recommended)

This path allows you to incrementally adopt new features while maintaining existing code:

1. Update to the new package structure
2. Continue using existing code as-is
3. Adopt new features for new DTOs
4. Gradually migrate existing DTOs as needed

### Path 2: Automated Migration

This path uses our migration tools to automatically update your codebase:

1. Update to the new package structure
2. Run the migration assistant tool
3. Review and test the changes
4. Make manual adjustments as needed

### Path 3: Complete Refactoring

This path involves a complete refactoring of your codebase to use all new features:

1. Update to the new package structure
2. Implement global configuration
3. Refactor all DTOs to use class-level configuration
4. Add custom strategies as needed

## Step-by-Step Migration Instructions

### Step 1: Update Dependencies

Update your `pubspec.yaml` to use the new package structure:

```yaml
# Before
dependencies:
  json_son: ^1.0.0

# After - Option 1: Use both packages
dependencies:
  json_son: ^1.0.0  # json_son remains as a standalone package
  json_ace: ^1.0.0  # new enhanced package
  json_ace_annotation: ^1.0.0

# After - Option 2: Complete migration to JSON ACE
dependencies:
  json_ace: ^1.0.0
  json_ace_annotation: ^1.0.0
  
dev_dependencies:
  json_ace_generator: ^1.0.0
  build_runner: ^2.0.0
```

### Step 2: Update Imports

Update your imports to use the new package structure:

```dart
// Before
import 'package:json_son/json_son.dart';

// After
import 'package:json_son/json_son.dart';
import 'package:json_son_annotation/json_son_annotation.dart';
```

### Step 3: Configure Build System

Add build configuration to your project:

```yaml
# build.yaml
targets:
  $default:
    builders:
      json_son_generator|json_son:
        enabled: true
        options:
          # Configuration options
```

### Step 4: Migrate Existing DTOs

#### Option A: Keep Existing Annotations

Your existing code will continue to work with the new version:

```dart
// This code will continue to work as before
class MyDto {
  @JsonKey(name: 'nullable_int', fromJson: flexibleIntFromJson)
  final int? nullableInt;
  
  @JsonKey(name: 'required_int', fromJson: flexibleRequiredIntFromJson)
  final int requiredInt;
  
  MyDto({
    this.nullableInt,
    required this.requiredInt,
  });
  
  factory MyDto.fromJson(Map<String, dynamic> json) => _$MyDtoFromJson(json);
  Map<String, dynamic> toJson() => _$MyDtoToJson(this);
}
```

#### Option B: Use Type-Specific Annotations

Migrate to the new type-specific annotations:

```dart
// Using new type-specific annotations
class MyDto {
  @JsonSonInt(nullable: true, name: 'nullable_int')
  final int? nullableInt;
  
  @JsonSonInt(required: true, name: 'required_int')
  final int requiredInt;
  
  MyDto({
    this.nullableInt,
    required this.requiredInt,
  });
  
  factory MyDto.fromJson(Map<String, dynamic> json) => _$MyDtoFromJson(json);
  Map<String, dynamic> toJson() => _$MyDtoToJson(this);
}
```

#### Option C: Use Class-Level Configuration

Migrate to class-level configuration:

```dart
// Using class-level configuration
@JsonSonConfig(
  applyToAllFields: true,
  nullable: {
    'int': flexibleIntFromJson,
    'String': flexibleStringFromJson,
  },
  required: {
    'int': flexibleRequiredIntFromJson,
    'String': flexibleRequiredStringFromJson,
  }
)
class MyDto {
  final int? nullableInt;
  final int requiredInt;
  
  MyDto({
    this.nullableInt,
    required this.requiredInt,
  });
  
  factory MyDto.fromJson(Map<String, dynamic> json) => _$MyDtoFromJson(json);
  Map<String, dynamic> toJson() => _$MyDtoToJson(this);
}
```

### Step 5: Run Code Generation

Run the build_runner to generate code:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Step 6: Test and Verify

Thoroughly test your migrated code to ensure it works as expected.

## Using the Migration Assistant

Our migration assistant tool can help automate the migration process:

```bash
# Analyze your codebase and suggest migrations
flutter pub run json_son:migrate --analyze-only --target=lib/src/data/network/dtos/

# Apply suggested migrations
flutter pub run json_son:migrate --target=lib/src/data/network/dtos/

# Apply specific migration strategy
flutter pub run json_son:migrate --target=lib/src/data/network/dtos/ --strategy=class_level
```

## Breaking Changes

### Removed Features

- `legacyConverter` function has been removed
- `JsonSonLegacyConfig` class has been removed
- Direct access to internal converters is no longer supported

### Changed Behavior

- Default converters are now more strict by default
- Error messages have been improved and may be different
- Code generation is now required for some features

## Troubleshooting

### Common Issues

#### Issue: Build failures after migration

**Solution**: Check that you've added the correct dependencies and build configuration.

#### Issue: Runtime type errors

**Solution**: Verify that your converters are correctly handling all possible input types.

#### Issue: Missing generated code

**Solution**: Ensure you've run the build_runner and that your annotations are correct.

## Getting Help

If you encounter issues during migration:

- Check the [FAQ](https://github.com/your-org/json_son/wiki/FAQ)
- Open an issue on [GitHub](https://github.com/your-org/json_son/issues)
- Join our [Discord community](https://discord.gg/your-discord)

## Migration Checklist

- [ ] Update dependencies in pubspec.yaml
- [ ] Update imports in your code
- [ ] Configure build system
- [ ] Decide on migration strategy for each DTO
- [ ] Run code generation
- [ ] Test thoroughly
- [ ] Update documentation
