# Changelog

All notable changes to this project will be documented in this file.

The format is based on
[Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to
[Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.5.0](https://github.com/terraform-google-modules/terraform-google-healthcare/compare/v2.4.0...v2.5.0) (2024-12-03)


### Features

* add Data Mapper Workspace resource support ([#109](https://github.com/terraform-google-modules/terraform-google-healthcare/issues/109)) ([95014e2](https://github.com/terraform-google-modules/terraform-google-healthcare/commit/95014e2c983f6b87c877e27135ce75ff7059fc20))
* add support for enableHistoryModifications ([#93](https://github.com/terraform-google-modules/terraform-google-healthcare/issues/93)) ([34670c9](https://github.com/terraform-google-modules/terraform-google-healthcare/commit/34670c9edff1b0cad3947b1477b3d97c645c9d4d))


### Bug Fixes

* Change lookup of data_project_ids in module definition ([#113](https://github.com/terraform-google-modules/terraform-google-healthcare/issues/113)) ([ab69f2a](https://github.com/terraform-google-modules/terraform-google-healthcare/commit/ab69f2aaba85cbfadb7941e243b6ac867f4e9742))
* Correct lastUpdatedPartitionConfig as Optional in Terraform ([#98](https://github.com/terraform-google-modules/terraform-google-healthcare/issues/98)) ([2e76a5f](https://github.com/terraform-google-modules/terraform-google-healthcare/commit/2e76a5f24ad569ff5da899e00bbf013b2676b967))

## [2.4.0](https://github.com/terraform-google-modules/terraform-google-healthcare/compare/v2.3.0...v2.4.0) (2023-11-03)


### Features

* add sendPreviousResourceOnDelete to fhir-notification-configs ([#83](https://github.com/terraform-google-modules/terraform-google-healthcare/issues/83)) ([a0696bb](https://github.com/terraform-google-modules/terraform-google-healthcare/commit/a0696bbb9068154b737b4779c8f98b9940a13445))
* add support for complexDataTypeReferenceParsing ([#79](https://github.com/terraform-google-modules/terraform-google-healthcare/issues/79)) ([cb3530c](https://github.com/terraform-google-modules/terraform-google-healthcare/commit/cb3530cadb8f5d6972caf8792d01d2174ed88525))
* add support for lastUpdatedPartitionConfig ([#88](https://github.com/terraform-google-modules/terraform-google-healthcare/issues/88)) ([9de996c](https://github.com/terraform-google-modules/terraform-google-healthcare/commit/9de996cb33a269ce55a06e9301e1af2a512b1f8c))


### Bug Fixes

* upgraded versions.tf to include minor bumps from tpg v5 ([#84](https://github.com/terraform-google-modules/terraform-google-healthcare/issues/84)) ([ac4548a](https://github.com/terraform-google-modules/terraform-google-healthcare/commit/ac4548a28b2e8c616a5a1c291eeb643c79d30c05))

## [2.3.0](https://github.com/terraform-google-modules/terraform-google-healthcare/compare/v2.2.1...v2.3.0) (2022-12-29)


### Features

* Add fhir notification configs ([#59](https://github.com/terraform-google-modules/terraform-google-healthcare/issues/59)) ([5aafd38](https://github.com/terraform-google-modules/terraform-google-healthcare/commit/5aafd3842b33700397fec2d85418e54d6b306491))

### [2.2.1](https://github.com/terraform-google-modules/terraform-google-healthcare/compare/v2.2.0...v2.2.1) (2022-05-04)


### Bug Fixes

* Use google-beta for FHIR stores to support beta only V2 analytics schema feature. ([#56](https://github.com/terraform-google-modules/terraform-google-healthcare/issues/56)) ([512e110](https://github.com/terraform-google-modules/terraform-google-healthcare/commit/512e1103dd2fc82b30f440b1bb8280383f7fdfb5))

## [2.2.0](https://www.github.com/terraform-google-modules/terraform-google-healthcare/compare/v2.1.0...v2.2.0) (2021-11-17)


### Features

* update TPG version constraints to allow 4.0 ([#53](https://www.github.com/terraform-google-modules/terraform-google-healthcare/issues/53)) ([54c975d](https://www.github.com/terraform-google-modules/terraform-google-healthcare/commit/54c975d6c0bf1ec57e3f0f3330fd99ab294e8408))

## [2.1.0](https://www.github.com/terraform-google-modules/terraform-google-healthcare/compare/v2.0.0...v2.1.0) (2021-05-17)


### Features

* Add dicom bq support ([#48](https://www.github.com/terraform-google-modules/terraform-google-healthcare/issues/48)) ([c2ead6f](https://www.github.com/terraform-google-modules/terraform-google-healthcare/commit/c2ead6f0d40a136863c7befd8088d990de2855e8))

## [2.0.0](https://www.github.com/terraform-google-modules/terraform-google-healthcare/compare/v1.3.0...v2.0.0) (2021-03-15)


### ⚠ BREAKING CHANGES

* add Terraform 0.13 constraint and module attribution (#45)

### Features

* add Terraform 0.13 constraint and module attribution ([#45](https://www.github.com/terraform-google-modules/terraform-google-healthcare/issues/45)) ([0997d75](https://www.github.com/terraform-google-modules/terraform-google-healthcare/commit/0997d755fa58f126949d020a0d06a9ad90cb6c9b))

## [1.3.0](https://www.github.com/terraform-google-modules/terraform-google-healthcare/compare/v1.2.1...v1.3.0) (2021-02-02)


### Features

* support consent store ([#33](https://www.github.com/terraform-google-modules/terraform-google-healthcare/issues/33)) ([8597c89](https://www.github.com/terraform-google-modules/terraform-google-healthcare/commit/8597c89057ec00e5dcdd7cb57a69b322969670df))

### [1.2.1](https://www.github.com/terraform-google-modules/terraform-google-healthcare/compare/v1.2.0...v1.2.1) (2021-01-29)


### Bug Fixes

* force release ([#41](https://www.github.com/terraform-google-modules/terraform-google-healthcare/issues/41)) ([874609e](https://www.github.com/terraform-google-modules/terraform-google-healthcare/commit/874609e3baaed2de5cd7992a7f75a63678eaae45))

## [1.2.0](https://www.github.com/terraform-google-modules/terraform-google-healthcare/compare/v1.1.0...v1.2.0) (2020-12-04)


### Features

* add parser_config to hl7v2 source ([#27](https://www.github.com/terraform-google-modules/terraform-google-healthcare/issues/27)) ([66f5640](https://www.github.com/terraform-google-modules/terraform-google-healthcare/commit/66f56401dc053650d04a2ee9896fb5fb3183529b))
* support more FHIR store attributes ([#30](https://www.github.com/terraform-google-modules/terraform-google-healthcare/issues/30)) ([8790b0a](https://www.github.com/terraform-google-modules/terraform-google-healthcare/commit/8790b0a5441c277e4013986c85b6c562c4ba39f4))

## [1.1.0](https://www.github.com/terraform-google-modules/terraform-google-healthcare/compare/v1.0.0...v1.1.0) (2020-12-03)


### Features

* Add support for stream_configs in FHIR store ([#22](https://www.github.com/terraform-google-modules/terraform-google-healthcare/issues/22)) ([a2bcaf6](https://www.github.com/terraform-google-modules/terraform-google-healthcare/commit/a2bcaf69e1c42f7a3b0701a506e8044e92aa9d10))

## [1.0.0](https://www.github.com/terraform-google-modules/terraform-google-healthcare/compare/v0.1.0...v1.0.0) (2020-06-05)


### ⚠ BREAKING CHANGES

* release please for GA migration (#19)

### Features

* Add version field to fhir ([#12](https://www.github.com/terraform-google-modules/terraform-google-healthcare/issues/12)) ([2103c13](https://www.github.com/terraform-google-modules/terraform-google-healthcare/commit/2103c13652e7c67e50d92385a88de75b1282288e))


* BREAKING CHANGE: release please for GA migration (#19) ([4642ed5](https://www.github.com/terraform-google-modules/terraform-google-healthcare/commit/4642ed5f9e774abd0212d64eb4bf890b01bd5deb)), closes [#19](https://www.github.com/terraform-google-modules/terraform-google-healthcare/issues/19)

## [Unreleased]

## [0.1.0] - 2019-12-02

### Added

- Initial release

[Unreleased]: https://github.com/terraform-google-modules/terraform-google-healthcare/compare/v0.1.0...HEAD
[0.1.0]: https://github.com/terraform-google-modules/terraform-google-healthcare/releases/tag/v0.1.0
