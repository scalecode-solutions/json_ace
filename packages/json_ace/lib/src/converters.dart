/// Converters for JSON ACE
///
/// This file contains the implementation of various conversion strategies

import 'package:json_son/json_son.dart' as json_son;
import 'package:json_ace_annotation/json_ace_annotation.dart';

/// Converters for JSON ACE
class AceConverters {
  /// Convert a value to an int using the specified strategy
  static int? toInt(dynamic value, {dynamic strategy}) {
    if (strategy is AceStrategy) {
      // Apply different conversion strategies based on the strategy parameter
      if (strategy == AceStrategy.strict) {
        return _strictToInt(value);
      } else if (strategy == AceStrategy.flexible) {
        return _flexibleToInt(value);
      } else if (strategy == AceStrategy.nullSafe) {
        return _nullSafeToInt(value);
      } else if (strategy == AceStrategy.highCard) {
        return _highCardToInt(value);
      } else if (strategy == AceStrategy.wildCard) {
        return _wildCardToInt(value);
      } else if (strategy is _CompositeStrategy) {
        // Apply composite strategies in order
        for (final s in (strategy as _CompositeStrategy).strategies) {
          final result = toInt(value, strategy: s);
          if (result != null) {
            return result;
          }
        }
        return null;
      }
    } else if (strategy is String) {
      // Handle custom strategies by name
      if (strategy == 'high_card') {
        return _highCardToInt(value);
      } else if (strategy == 'wild_card') {
        return _wildCardToInt(value);
      }
    }
    
    // Default to flexible conversion
    return _flexibleToInt(value);
  }
  
  /// Convert a value to a double using the specified strategy
  static double? toDouble(dynamic value, {dynamic strategy}) {
    if (strategy is AceStrategy) {
      // Apply different conversion strategies based on the strategy parameter
      if (strategy == AceStrategy.strict) {
        return _strictToDouble(value);
      } else if (strategy == AceStrategy.flexible) {
        return _flexibleToDouble(value);
      } else if (strategy == AceStrategy.nullSafe) {
        return _nullSafeToDouble(value);
      } else if (strategy == AceStrategy.highCard) {
        return _highCardToDouble(value);
      } else if (strategy == AceStrategy.wildCard) {
        return _wildCardToDouble(value);
      } else if (strategy is _CompositeStrategy) {
        // Apply composite strategies in order
        for (final s in (strategy as _CompositeStrategy).strategies) {
          final result = toDouble(value, strategy: s);
          if (result != null) {
            return result;
          }
        }
        return null;
      }
    } else if (strategy is String) {
      // Handle custom strategies by name
      if (strategy == 'high_card') {
        return _highCardToDouble(value);
      } else if (strategy == 'wild_card') {
        return _wildCardToDouble(value);
      }
    }
    
    // Default to flexible conversion
    return _flexibleToDouble(value);
  }
  
  /// Convert a value to a bool using the specified strategy
  static bool? toBool(dynamic value, {dynamic strategy}) {
    if (strategy is AceStrategy) {
      // Apply different conversion strategies based on the strategy parameter
      if (strategy == AceStrategy.strict) {
        return _strictToBool(value);
      } else if (strategy == AceStrategy.flexible) {
        return _flexibleToBool(value);
      } else if (strategy == AceStrategy.nullSafe) {
        return _nullSafeToBool(value);
      } else if (strategy == AceStrategy.highCard) {
        return _highCardToBool(value);
      } else if (strategy == AceStrategy.wildCard) {
        return _wildCardToBool(value);
      } else if (strategy is _CompositeStrategy) {
        // Apply composite strategies in order
        for (final s in (strategy as _CompositeStrategy).strategies) {
          final result = toBool(value, strategy: s);
          if (result != null) {
            return result;
          }
        }
        return null;
      }
    } else if (strategy is String) {
      // Handle custom strategies by name
      if (strategy == 'high_card') {
        return _highCardToBool(value);
      } else if (strategy == 'wild_card') {
        return _wildCardToBool(value);
      }
    }
    
    // Default to flexible conversion
    return _flexibleToBool(value);
  }
  
  /// Convert a value to a String using the specified strategy
  static String? toString(dynamic value, {dynamic strategy}) {
    if (strategy is AceStrategy) {
      // Apply different conversion strategies based on the strategy parameter
      if (strategy == AceStrategy.strict) {
        return _strictToString(value);
      } else if (strategy == AceStrategy.flexible) {
        return _flexibleToString(value);
      } else if (strategy == AceStrategy.nullSafe) {
        return _nullSafeToString(value);
      } else if (strategy == AceStrategy.highCard) {
        return _highCardToString(value);
      } else if (strategy == AceStrategy.wildCard) {
        return _wildCardToString(value);
      } else if (strategy is _CompositeStrategy) {
        // Apply composite strategies in order
        for (final s in (strategy as _CompositeStrategy).strategies) {
          final result = toString(value, strategy: s);
          if (result != null) {
            return result;
          }
        }
        return null;
      }
    } else if (strategy is String) {
      // Handle custom strategies by name
      if (strategy == 'high_card') {
        return _highCardToString(value);
      } else if (strategy == 'wild_card') {
        return _wildCardToString(value);
      }
    }
    
    // Default to flexible conversion
    return _flexibleToString(value);
  }
  
  /// Convert a value to a DateTime using the specified strategy
  static DateTime? toDateTime(dynamic value, {dynamic strategy, String? format}) {
    if (strategy is AceStrategy) {
      // Apply different conversion strategies based on the strategy parameter
      if (strategy == AceStrategy.strict) {
        return _strictToDateTime(value, format: format);
      } else if (strategy == AceStrategy.flexible) {
        return _flexibleToDateTime(value, format: format);
      } else if (strategy == AceStrategy.nullSafe) {
        return _nullSafeToDateTime(value, format: format);
      } else if (strategy == AceStrategy.highCard) {
        return _highCardToDateTime(value, format: format);
      } else if (strategy == AceStrategy.wildCard) {
        return _wildCardToDateTime(value, format: format);
      } else if (strategy is _CompositeStrategy) {
        // Apply composite strategies in order
        for (final s in (strategy as _CompositeStrategy).strategies) {
          final result = toDateTime(value, strategy: s, format: format);
          if (result != null) {
            return result;
          }
        }
        return null;
      }
    } else if (strategy is String) {
      // Handle custom strategies by name
      if (strategy == 'high_card') {
        return _highCardToDateTime(value, format: format);
      } else if (strategy == 'wild_card') {
        return _wildCardToDateTime(value, format: format);
      }
    }
    
    // Default to flexible conversion
    return _flexibleToDateTime(value, format: format);
  }
  
  // Private implementation methods for different strategies
  
  // Int conversions
  static int? _strictToInt(dynamic value) {
    if (value is int) {
      return value;
    }
    return null;
  }
  
  static int? _flexibleToInt(dynamic value) {
    return json_son.JsonSon.toInt(value);
  }
  
  static int? _nullSafeToInt(dynamic value) {
    if (value == null) {
      return null;
    }
    return _flexibleToInt(value);
  }
  
  static int? _highCardToInt(dynamic value) {
    // High card strategy is more strict but still allows some conversions
    if (value is int) {
      return value;
    } else if (value is double) {
      if (value == value.toInt()) {
        return value.toInt();
      }
    } else if (value is String) {
      try {
        return int.parse(value);
      } catch (_) {}
    }
    return null;
  }
  
  static int? _wildCardToInt(dynamic value) {
    // Wild card strategy tries very hard to convert anything to an int
    return json_son.JsonSon.toInt(value);
  }
  
  // Double conversions
  static double? _strictToDouble(dynamic value) {
    if (value is double) {
      return value;
    }
    return null;
  }
  
  static double? _flexibleToDouble(dynamic value) {
    return json_son.JsonSon.toDouble(value);
  }
  
  static double? _nullSafeToDouble(dynamic value) {
    if (value == null) {
      return null;
    }
    return _flexibleToDouble(value);
  }
  
  static double? _highCardToDouble(dynamic value) {
    if (value is double) {
      return value;
    } else if (value is int) {
      return value.toDouble();
    } else if (value is String) {
      try {
        return double.parse(value);
      } catch (_) {}
    }
    return null;
  }
  
  static double? _wildCardToDouble(dynamic value) {
    return json_son.JsonSon.toDouble(value);
  }
  
  // Bool conversions
  static bool? _strictToBool(dynamic value) {
    if (value is bool) {
      return value;
    }
    return null;
  }
  
  static bool? _flexibleToBool(dynamic value) {
    return json_son.JsonSon.toBool(value);
  }
  
  static bool? _nullSafeToBool(dynamic value) {
    if (value == null) {
      return null;
    }
    return _flexibleToBool(value);
  }
  
  static bool? _highCardToBool(dynamic value) {
    if (value is bool) {
      return value;
    } else if (value is String) {
      final lower = value.toLowerCase();
      if (lower == 'true' || lower == 'yes' || lower == '1') {
        return true;
      } else if (lower == 'false' || lower == 'no' || lower == '0') {
        return false;
      }
    } else if (value is num) {
      if (value == 1) {
        return true;
      } else if (value == 0) {
        return false;
      }
    }
    return null;
  }
  
  static bool? _wildCardToBool(dynamic value) {
    return json_son.JsonSon.toBool(value);
  }
  
  // String conversions
  static String? _strictToString(dynamic value) {
    if (value is String) {
      return value;
    }
    return null;
  }
  
  static String? _flexibleToString(dynamic value) {
    return json_son.JsonSon.toString(value);
  }
  
  static String? _nullSafeToString(dynamic value) {
    if (value == null) {
      return null;
    }
    return _flexibleToString(value);
  }
  
  static String? _highCardToString(dynamic value) {
    if (value is String) {
      return value;
    } else if (value != null) {
      return value.toString();
    }
    return null;
  }
  
  static String? _wildCardToString(dynamic value) {
    return json_son.JsonSon.toString(value);
  }
  
  // DateTime conversions
  static DateTime? _strictToDateTime(dynamic value, {String? format}) {
    if (value is DateTime) {
      return value;
    }
    return null;
  }
  
  static DateTime? _flexibleToDateTime(dynamic value, {String? format}) {
    if (value is DateTime) {
      return value;
    } else if (value is String) {
      try {
        return DateTime.parse(value);
      } catch (_) {}
    } else if (value is int) {
      try {
        return DateTime.fromMillisecondsSinceEpoch(value);
      } catch (_) {}
    }
    return null;
  }
  
  static DateTime? _nullSafeToDateTime(dynamic value, {String? format}) {
    if (value == null) {
      return null;
    }
    return _flexibleToDateTime(value, format: format);
  }
  
  static DateTime? _highCardToDateTime(dynamic value, {String? format}) {
    return _flexibleToDateTime(value, format: format);
  }
  
  static DateTime? _wildCardToDateTime(dynamic value, {String? format}) {
    if (value is DateTime) {
      return value;
    } else if (value is String) {
      try {
        return DateTime.parse(value);
      } catch (_) {
        // Try different formats
        // This would be expanded in the actual implementation
      }
    } else if (value is int) {
      try {
        return DateTime.fromMillisecondsSinceEpoch(value);
      } catch (_) {}
    }
    return null;
  }
}
