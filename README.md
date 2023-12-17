# Bazoekt [![Test status](https://github.com/filmil/bazoekt/workflows/Test/badge.svg)](https://github.com/filmil/bazoekt/workflows/Test/badge.svg)

Easy indexing for your Bazel project. $\text{bazoekt} = \text{bazel} + \text{zoekt}$

This is a small wrapper and an easy addition to your Bazel projects, that provides powerful code indexing features. It is easy for anyone to add indexing to a Bazel project. But now, that work has been done for you, so you can save yourself some 30 or so minutes with `bazoekt`. Add it to your Bazel `WORKSPACE`, and you  get fast code indexing and search.

Thanks to the excellent [`zoekt`][zo] software by H,-W. Nijenhuis which does the real actual work.


[zo]: https://github.com/google/zoekt

## Installation

TBD, pending the resolution of https://github.com/bazelbuild/bazel-gazelle/issues/1694. Something weird is
going on there.

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