#!/bin/bash
set -ex
tag=v0.1.0-dev

nif=$(mix nif_filename)
cp _build/test/lib/cmark/priv/cmark.so $nif
gh release upload --clobber $tag $nif
