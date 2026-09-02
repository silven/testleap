#!/bin/bash
set -euo pipefail

sudo apt install libfontconfig-dev libinput-dev libcairo2-dev libpango1.0-dev libgbm-dev

[[ -d jay ]] && rm -rf jay

git clone --depth 1 https://github.com/mahkoh/jay.git

SHA=$(git -C jay describe --match NeVer --always)

cd jay

cargo install --locked --force cargo-nextest

mkdir -p .config

cat <<EOF > .config/nextest.toml
[profile.default.junit]
path = "junit.xml"
EOF

cargo nextest run

mv "target/nextest/default/junit.xml" "../jay.${SHA}.junit.xml"
