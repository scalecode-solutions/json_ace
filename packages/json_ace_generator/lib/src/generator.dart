/// Generator for JSON ACE
///
/// This file contains the implementation of the code generator for JSON ACE

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:json_ace_annotation/json_ace_annotation.dart';
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';

/// Generator for JSON ACE
class AceGenerator extends GeneratorForAnnotation<AceConfig> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
        'AceConfig can only be applied to classes.',
        element: element,
      );
    }

    final className = element.name;
    final fields = element.fields.where((field) => !field.isStatic);
    
    // Get configuration from annotation
    final validateSchema = annotation.read('validateSchema').boolValue;
    final schemaPath = annotation.peek('schemaPath')?.stringValue;
    final collectMetrics = annotation.read('collectMetrics').boolValue;
    
    // Generate fromJson method
    final fromJsonMethod = _generateFromJsonMethod(className, fields, validateSchema, schemaPath, collectMetrics);
    
    // Generate toJson method
    final toJsonMethod = _generateToJsonMethod(className, fields, collectMetrics);
    
    // Format the generated code
    final formatter = DartFormatter();
    return formatter.format('''
      // Generated code - do not modify by hand
      
      $fromJsonMethod
      
      $toJsonMethod
    ''');
  }
  
  /// Generate fromJson method
  String _generateFromJsonMethod(
    String className,
    Iterable<FieldElement> fields,
    bool validateSchema,
    String? schemaPath,
    bool collectMetrics,
  ) {
    final buffer = StringBuffer();
    
    buffer.writeln('$className _\$${className}FromJson(Map<String, dynamic> json) {');
    
    // Add schema validation if needed
    if (validateSchema && schemaPath != null) {
      buffer.writeln('  // Schema validation');
      buffer.writeln('  if (!Ace.validateSchema(json, \'$schemaPath\')) {');
      buffer.writeln('    throw AceException(');
      buffer.writeln('      message: \'JSON does not match schema\',');
      buffer.writeln('      path: \'\',');
      buffer.writeln('      expectedType: \'$className schema\',');
      buffer.writeln('      actualValue: json,');
      buffer.writeln('    );');
      buffer.writeln('  }');
      buffer.writeln();
    }
    
    // Add metrics collection if needed
    if (collectMetrics) {
      buffer.writeln('  // Metrics collection');
      buffer.writeln('  final stopwatch = Stopwatch()..start();');
      buffer.writeln();
    }
    
    // Process each field
    buffer.writeln('  // Create instance with converted fields');
    buffer.writeln('  return $className(');
    
    for (final field in fields) {
      final fieldName = field.name;
      final fieldType = field.type.getDisplayString(withNullability: true);
      
      // Get field annotations
      buffer.writeln('    $fieldName: _convert${fieldName.capitalize()}(json[\'$fieldName\']),');
    }
    
    buffer.writeln('  );');
    
    // Add metrics recording if needed
    if (collectMetrics) {
      buffer.writeln();
      buffer.writeln('  // Record metrics');
      buffer.writeln('  stopwatch.stop();');
      buffer.writeln('  Ace.metrics.recordSuccess(\'$className\', stopwatch.elapsed);');
    }
    
    buffer.writeln('}');
    
    // Generate conversion helpers for each field
    for (final field in fields) {
      final fieldName = field.name;
      final fieldType = field.type.getDisplayString(withNullability: true);
      
      buffer.writeln();
      buffer.writeln('$fieldType _convert${fieldName.capitalize()}(dynamic value) {');
      buffer.writeln('  // This would be customized based on field annotations');
      buffer.writeln('  return Ace.convert<${fieldType.replaceAll(\'?\', \'\')}>(value);');
      buffer.writeln('}');
    }
    
    return buffer.toString();
  }
  
  /// Generate toJson method
  String _generateToJsonMethod(
    String className,
    Iterable<FieldElement> fields,
    bool collectMetrics,
  ) {
    final buffer = StringBuffer();
    
    buffer.writeln('Map<String, dynamic> _\$${className}ToJson($className instance) {');
    
    // Add metrics collection if needed
    if (collectMetrics) {
      buffer.writeln('  // Metrics collection');
      buffer.writeln('  final stopwatch = Stopwatch()..start();');
      buffer.writeln();
    }
    
    // Create the JSON map
    buffer.writeln('  final json = <String, dynamic>{');
    
    for (final field in fields) {
      final fieldName = field.name;
      buffer.writeln('    \'$fieldName\': instance.$fieldName,');
    }
    
    buffer.writeln('  };');
    
    // Add metrics recording if needed
    if (collectMetrics) {
      buffer.writeln();
      buffer.writeln('  // Record metrics');
      buffer.writeln('  stopwatch.stop();');
      buffer.writeln('  Ace.metrics.recordSuccess(\'$className\', stopwatch.elapsed);');
    }
    
    buffer.writeln('  return json;');
    buffer.writeln('}');
    
    return buffer.toString();
  }
}

/// Extension to capitalize strings
extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }
}
