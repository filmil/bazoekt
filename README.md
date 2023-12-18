# Bazoekt [![Test status](https://github.com/filmil/bazoekt/workflows/Test/badge.svg)](https://github.com/filmil/bazoekt/workflows/Test/badge.svg)

Easy indexing for your Bazel project. $\text{bazoekt} = \text{bazel} + \text{zoekt}$

This is a small wrapper and an easy addition to your Bazel projects, that provides powerful code indexing features. It is easy for anyone to add indexing to a Bazel project. But now, that work has been done for you, so you can save yourself some 30 or so minutes with `bazoekt`. Add it to your Bazel `WORKSPACE`, and you  get fast code indexing and search.

Thanks to the excellent [`zoekt`][zo] software by H.-W. Nijenhuis which does the real actual work. I only provided the glue.


[zo]: https://github.com/google/zoekt

## Installation

Add the following into your WORKSPACE file:

```
# BEGIN: bazoekt
http_archive(
    name = "bazoekt",
    sha256 = "",
    strip_prefix = "bazoekt",
    urls = [
        "https://github.com/filmil/bazoekt/releases/download/0.0.7/bazoekt-linux-amd64.zip",
    ],
)
# END: bazoekt
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
