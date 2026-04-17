# Bazoekt

[![Test](https://github.com/filmil/bazoekt/actions/workflows/test.yml/badge.svg)](https://github.com/filmil/bazoekt/actions/workflows/test.yml) [![Tag and Release](https://github.com/filmil/bazoekt/actions/workflows/tag-and-release.yml/badge.svg)](https://github.com/filmil/bazoekt/actions/workflows/tag-and-release.yml) [![Publish on Bazel Central Registry](https://github.com/filmil/bazoekt/actions/workflows/publish-bcr.yml/badge.svg)](https://github.com/filmil/bazoekt/actions/workflows/publish-bcr.yml) [![Publish to my Bazel registry](https://github.com/filmil/bazoekt/actions/workflows/publish.yml/badge.svg)](https://github.com/filmil/bazoekt/actions/workflows/publish.yml)

Easy indexing for your Bazel project. $\text{bazoekt} = \text{bazel} + \text{zoekt}$

This is a small wrapper and an easy addition to your Bazel projects, that provides powerful code indexing features. It is easy for anyone to add indexing to a Bazel project. But now, that work has been done for you, so you can save yourself some 30 or so minutes with `bazoekt`. Add it to your Bazel `MODULE.bazel`, and you get fast code indexing and search.

Thanks to the excellent [`zoekt`][zo] software by H.-W. Nijenhuis which does the real actual work. I only provided the glue.

[zo]: https://github.com/filmil/zoekt

## Installation

First, configure your `.bazelrc` to pull modules from the custom registry. Add the following to your `.bazelrc` to get access to my bazel registry:

```
common --registry=https://raw.githubusercontent.com/filmil/bazel-registry/main
common --registry=https://bcr.bazel.build
```

Next, add the following into your `MODULE.bazel` file:

```starlark
bazel_dep(name = "bazoekt", version = "0.1.1", dev_dependency = True)
```

This should be enough to have `bazoekt` available to you.

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
