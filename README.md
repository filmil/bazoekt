# Bazoekt [![Test status](https://github.com/filmil/bazoekt/workflows/Test/badge.svg)](https://github.com/filmil/bazoekt/workflows/Test/badge.svg)

Easy indexing for your Bazel project. $\text{bazoekt} = \text{bazel} + \text{zoekt}$

This is a small wrapper and an easy addition to your Bazel projects, that provides powerful code indexing features. It is easy for anyone to add indexing to a Bazel project. But now, that work has been done for you, so you can save yourself some 30 or so minutes with `bazoekt`. Add it to your Bazel `WORKSPACE`, and you  get fast code indexing and search.

Thanks to the excellent [`zoekt`][zo] software by H,-W. Nijenhuis which does the real actual work.


[zo]: https://github.com/google/zoekt

## Installation

You will need [`bazel_rules_go`][brg] installed and operating in your repo.

[brg]: https://github.com/bazelbuild/rules_go?tab=readme-ov-file#setup

Add the following into your WORKSPACE file:

```
load("//:deps.bzl", "bazoekt_dependencies", "bazoekt_go_dependencies")
bazoekt_dependencies()
# gazelle:repository_macro deps.bzl%bazoekt_go_dependencies
bazoekt_go_dependencies()
load("@gotopt2//build:deps.bzl", "gotopt2_dependencies")
gotopt2_dependencies()
```

## Index

Update your index, by occasionally running the following:

```bash
bazel run @bazoekt//:index
```

## Search

Start the web server for the index:

```bash
bazel run @bazoekt//:serve
```

Visit http://localhost:6070 to search.
