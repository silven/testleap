#!/bin/bash
set -euo pipefail

[[ -d ccache ]] && rm -rf ccache
[[ -d build_ccache ]] && rm -rf build_ccache

git clone --depth 1 https://github.com/ccache/ccache.git

SHA=$(git -C ccache describe --match NeVer --always)

cmake -B build_ccache -S ccache -GNinja

cmake --build build_ccache

ctest --output-junit "`pwd`/ccache.${SHA}.junit.xml" --test-dir build_ccache
