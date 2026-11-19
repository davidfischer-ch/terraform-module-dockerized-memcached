# Changelog


## Release v1.2.1 (2026-11-19)

Diff: https://github.com/davidfischer-ch/terraform-module-dockerized-memcached/compare/1.2.0...1.2.1

### Features

CI:

* Add CI: formatting, validation and the tests, in the GitHub workflow (with the newest Docker provider and its minimum) and in the GitLab pipeline

### Fix and enhancements

Server:

* Pass `ALL` in `cap_add` and `cap_drop` to Docker as its wildcard instead of `CAP_ALL`

Requirements:

* Require Terraform 1.17
* Require the Docker provider 4.7.0

Docs:

* Document `ALL` in `cap_add` and `cap_drop`
* Point the README and the examples at this release


## Release v1.2.0 (2026-03-14)

### Minor compatibility breaks

* Remove the `CAP_` prefix from `cap_add` and `cap_drop` values — the module now adds it automatically when calling the Docker provider

### Fix and enhancements

* Add validation of `cap_add` and `cap_drop` against the exhaustive list of Linux capabilities
* Reorder variables to be consistent

## Release v1.1.1 (2026-03-13)

### Features

* Add Docker healthcheck using a bash TCP probe on `var.port`

### Fix and enhancements

* Set `enabled` and `wait` defaults to `true`
* Refine variable descriptions, validators, and attribute ordering
* Remove redundant default values from examples and README

## Release v1.1.0 (2026-03-13)

### Fix and enhancements

* Add `# Process` section: `app_uid`, `app_gid`, `privileged`, `cap_add`, `cap_drop`
  variables wired into the container via `user`, `privileged`, and a dynamic `capabilities` block
* Add `examples/default/` Terraform example

## Release v1.0.1 (2026-01-03)

### Fix and enhancements

* Module: Declare network_mode bridge to prevent infinite recreate

## Release v1.0.0 (2025-01-20)

Initial release
