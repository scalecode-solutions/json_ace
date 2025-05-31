/// Builder for JSON ACE Generator
///
/// This file contains the implementation of the build system integration for JSON ACE

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'generator.dart';

/// Builder factory for JSON ACE Generator
Builder aceBuilder(BuilderOptions options) => SharedPartBuilder(
      [AceGenerator()],
      'ace',
    );
