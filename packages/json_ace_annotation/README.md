# JSON ACE Annotation

Annotation classes for the JSON ACE package - **J**ust **S**traightens **O**ut **N**onsense **A**nd **C**onverts **E**verything.

## Overview

This package provides the annotation classes used by the JSON ACE package for configuring JSON serialization and deserialization. It's designed to be used in conjunction with the `json_ace` and `json_ace_generator` packages.

## Installation

Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  json_ace_annotation: ^0.1.0
```

## Usage

This package is typically used with the `json_ace` package and the `json_ace_generator` package:

```yaml
dependencies:
  json_ace: ^0.1.0
  json_ace_annotation: ^0.1.0

dev_dependencies:
  build_runner: ^2.4.0
  json_ace_generator: ^0.1.0
```

## Annotations

### Class-Level Annotations

#### AceConfig

Configure JSON serialization and deserialization at the class level:

```dart
@AceConfig(
  strategy: AceStrategy.flexible,
  validateSchema: true,
  schemaPath: 'assets/schemas/my_model.json',
  collectMetrics: true
)
class MyModel {
  // ...
}
```

### Field-Level Annotations

#### AceInt

Configure an integer field:

```dart
@AceInt(
  name: 'user_id', // JSON key name
  required: true,
  strategy: AceStrategy.highCard,
  defaultValue: 0
)
final int userId;
```

#### AceDouble

Configure a double field:

```dart
@AceDouble(
  name: 'price',
  required: true,
  strategy: AceStrategy.flexible,
  defaultValue: 0.0
)
final double price;
```

#### AceString

Configure a string field:

```dart
@AceString(
  name: 'user_name',
  required: true,
  strategy: AceStrategy.strict,
  defaultValue: ''
)
final String userName;
```

#### AceBool

Configure a boolean field:

```dart
@AceBool(
  name: 'is_active',
  required: false,
  strategy: AceStrategy.flexible,
  defaultValue: false
)
final bool isActive;
```

#### AceDateTime

Configure a DateTime field:

```dart
@AceDateTime(
  name: 'created_at',
  required: true,
  strategy: AceStrategy.flexible,
  format: 'yyyy-MM-dd'
)
final DateTime createdAt;
```

#### AceList

Configure a list field:

```dart
@AceList(
  name: 'tags',
  required: false,
  strategy: AceStrategy.flexible,
  defaultValue: []
)
final List<String> tags;
```

#### AceMap

Configure a map field:

```dart
@AceMap(
  name: 'properties',
  required: false,
  strategy: AceStrategy.flexible,
  defaultValue: {}
)
final Map<String, dynamic> properties;
```

#### AceCustom

Configure a custom type field:

```dart
@AceCustom<Color>(
  name: 'color',
  required: true,
  strategy: AceStrategy.flexible
)
final Color color;
```

#### AceIgnore

Ignore a field during serialization/deserialization:

```dart
@AceIgnore()
final String temporaryValue;
```

## Conversion Strategies

JSON ACE provides several built-in conversion strategies:

- `AceStrategy.strict`: Only accepts exact type matches
- `AceStrategy.flexible`: Attempts to convert between types
- `AceStrategy.nullSafe`: Handles null values gracefully
- `AceStrategy.validation`: Validates values against constraints
- `AceStrategy.strictWithFallbacks`: Tries strict first, then falls back to flexible
- `AceStrategy.highCard`: Strict conversion with high priority (card game themed)
- `AceStrategy.wildCard`: Extremely flexible conversion (card game themed)

You can also compose strategies:

```dart
final strategy = AceStrategy.compose([
  AceStrategy.validation,
  AceStrategy.strictWithFallbacks,
  AceStrategy.nullSafe
]);
```

## License

MIT
