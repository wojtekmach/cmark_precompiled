#!/bin/bash
set -ex
tag=v0.1.0-dev

if gh release list | grep $tag; then
  git tag -f $tag
  git push -f origin $tag
else
  gh release create $tag --notes ""
fi
