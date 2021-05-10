#!/bin/bash
set -ex
tag=v0.1.0-dev

if gh release list | grep $tag; then
  gh release delete -y $tag
  git push origin :$tag
fi

gh release create $tag --notes ""
gh release list
