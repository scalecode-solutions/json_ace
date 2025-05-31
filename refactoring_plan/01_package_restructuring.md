# Phase 1: Package Structure

**Status**: 🔜 Planned

## Objective

Create the new `json_ace` package structure with three focused packages with clear separation of concerns, while maintaining `json_son` as a standalone package:
1. `json_ace` (Core Package)
2. `json_ace_annotation` (Annotation Package)
3. `json_ace_generator` (Code Generation Package)

## Rationale

This package structure will:
- Create clear separation of concerns
- Allow for flexible adoption of only needed components
- Reduce dependencies for users who only need runtime utilities
- Follow established patterns in the Flutter/Dart ecosystem
- Maintain compatibility with existing `json_son` users
- Allow for more advanced features in `json_ace` without disrupting `json_son`

## Tasks

### 1. Analyze Current Package Structure

- [ ] Identify all current functionality in the `json_son` package
- [ ] Determine which functionality to leverage in `json_ace`
- [ ] Categorize functionality into the three new packages
- [ ] Identify dependencies between components
- [ ] Define the relationship between `json_son` and `json_ace`

### 2. Create Package Scaffolding

- [ ] Create directory structure for the three `json_ace` packages
- [ ] Set up basic pubspec.yaml files for each package
- [ ] Configure package dependencies, including `json_son` as a dependency where appropriate
- [ ] Set up README.md files for each package

### 3. Implement Core Package (`json_ace`)

- [ ] Implement core functionality building on `json_son` concepts
- [ ] Create the `Ace` class for runtime JSON manipulation
- [ ] Implement enhanced error handling utilities
- [ ] Create bridges between `json_son` and `json_ace` functionality
- [ ] Create minimal example for core package
- [ ] Write tests for core package functionality

### 4. Implement Annotation Package (`json_ace_annotation`)

- [ ] Create annotation classes for class-level configuration (`@AceConfig`)
- [ ] Create annotation classes for field-level overrides (`@AceOverride`)
- [ ] Create type-specific annotation classes (`@AceInt`, `@AceString`, etc.)
- [ ] Update imports and references
- [ ] Create minimal example for annotation package
- [ ] Write tests for annotation package functionality

### 5. Implement Generator Package (`json_ace_generator`)

- [ ] Set up build system integration
- [ ] Create basic code generation logic
- [ ] Implement integration with `json_serializable` and `freezed`
- [ ] Update imports and references
- [ ] Create minimal example for generator package
- [ ] Write tests for generator package functionality

### 6. Update Documentation

- [ ] Create main README.md explaining the JSON ACE concept
- [ ] Document the relationship between `json_son` and `json_ace`
- [ ] Create migration guide for `json_son` users
- [ ] Create comprehensive API documentation
- [ ] Create examples showing how to use the new packages together

### 7. Publish Packages

- [ ] Verify package compliance with pub.dev requirements
- [ ] Run final tests across all packages
- [ ] Set initial version numbers according to semver
- [ ] Publish `json_ace` packages to pub.dev
- [ ] Update `json_son` documentation to reference `json_ace`

## Dependencies

- Existing `json_son` package

## Estimated Effort

- **Analysis**: 2 days
- **Implementation**: 5 days
- **Testing**: 3 days
- **Documentation**: 2 days
- **Total**: 12 days

## Risks and Mitigation

| Risk | Impact | Likelihood | Mitigation |
|------|--------|------------|------------|
| Confusion between `json_son` and `json_ace` | Medium | Medium | Clear documentation explaining the relationship and differences |
| Circular dependencies between packages | Medium | Medium | Carefully plan package boundaries and interfaces |
| Increased maintenance burden with multiple packages | Medium | Low | Automate cross-package testing and documentation |
| Duplication of functionality | Medium | Medium | Clearly define what functionality belongs in each package |

## Definition of Done

- All three `json_ace` packages are implemented and published to pub.dev
- All tests pass across all packages
- Documentation clearly explains the relationship with `json_son`
- Migration guide is available for `json_son` users
- Example projects demonstrate how to use the new packages
