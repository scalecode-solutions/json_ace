# JSON ACE

**J**ust **S**traightens **O**ut **N**onsense **A**nd **C**onverts **E**verything

## Overview

JSON ACE is a powerful Dart package that provides enhanced JSON conversion with flexible parsing, annotations, and advanced features. It builds upon the foundation of the json_son package while offering more comprehensive capabilities.

## Features

- **Flexible Type Conversion**: Intelligently convert between JSON types and Dart types
- **Annotation-Based Configuration**: Configure conversion behavior using annotations
- **Multiple Conversion Strategies**: Choose from different conversion strategies or create your own
- **Code Generation**: Automatically generate serialization/deserialization code
- **Advanced Features**: Schema validation, metrics collection, and detailed error reporting
- **Card Game Themed API**: Intuitive strategy names like `highCard` and `wildCard`

## Installation

Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  json_ace: ^0.1.0
  json_ace_annotation: ^0.1.0

dev_dependencies:
  build_runner: ^2.4.0
  json_ace_generator: ^0.1.0
```

## Usage

### Basic Usage

```dart
import 'package:json_ace/json_ace.dart';

// Convert values with flexible parsing
final int? myInt = Ace.convert<int>('123');
final double? myDouble = Ace.convert<double>('123.45');
final bool? myBool = Ace.convert<bool>('true');
```

### Annotation-Based Usage

```dart
import 'package:json_ace/json_ace.dart';

part 'my_model.g.dart';

@AceConfig(
  strategy: AceStrategy.flexible,
  collectMetrics: true
)
class MyModel {
  @AceInt(strategy: AceStrategy.highCard)
  final int id;
  
  @AceString()
  final String name;
  
  @AceBool(defaultValue: false)
  final bool isActive;
  
  MyModel({
    required this.id,
    required this.name,
    required this.isActive,
  });
  
  factory MyModel.fromJson(Map<String, dynamic> json) => _$MyModelFromJson(json);
  Map<String, dynamic> toJson() => _$MyModelToJson(this);
}
```

### Conversion Strategies

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

### Advanced Features

#### Metrics Collection

```dart
// Configure metrics collection
Ace.configure(
  collectMetrics: true,
  detailedMetrics: true,
  metricsRetention: Duration(days: 7),
);

// Access metrics
final metrics = Ace.metrics;
print('Conversion success rate: ${metrics.getSuccessRate('MyModel')}');
print('Average conversion time: ${metrics.getAverageTime('MyModel')}');
print('Failure count: ${metrics.getFailureCount('MyModel.nullableInt')}');
```

#### Debugging Tools

```dart
// Visual debugging
final result = Ace.debugView(jsonString, MyModel);
print(result.visualTree);  // Shows visual conversion process

// Detailed error reporting
try {
  final model = MyModel.fromJson(json);
} catch (e) {
  final details = Ace.getErrorDetails(e);
  print('Error path: ${details.path}');
  print('Expected type: ${details.expectedType}');
  print('Actual value: ${details.actualValue}');
  print('Suggested fix: ${details.suggestedFix}');
}
```

#### Custom Type Support

```dart
// Register custom types
Ace.registerType<Color>(
  fromJson: (json) => Color(int.parse(json.toString().replaceAll('#', '0xFF'))),
  toJson: (color) => '#${color.value.toRadixString(16).substring(2).toUpperCase()}',
);

// Use custom types
class ThemeModel {
  @AceCustom<Color>()
  final Color primaryColor;
  
  @AceCustom<Color>()
  final Color accentColor;
  
  ThemeModel({
    required this.primaryColor,
    required this.accentColor,
  });
}
```

## Relationship with json_son

JSON ACE builds upon the foundation of the json_son package, which provides basic JSON conversion utilities. While json_son focuses on simple conversion functions, JSON ACE offers a more comprehensive solution with annotations, code generation, and advanced features.

json_son remains a standalone package that can be used independently, while JSON ACE provides enhanced functionality for more complex use cases.

## License

MIT
