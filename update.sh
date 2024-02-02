#!/usr/bin/env bash
set -euxo pipefail

EXT_NAME=nodejs

# clean up
rm -rf ${EXT_NAME}

# download 
curl "https://nodejs.org/dist/v20.11.0/node-${NODE_VERSION}-linux-x64.tar.xz" \
    -o node-${NODE_VERSION}-linux-x64.tar.xz
tar zxvf node-${NODE_VERSION}-linux-x64.tar.xz

rm node-${NODE_VERSION}-linux-x64/CHANGELOG.md
rm node-${NODE_VERSION}-linux-x64/LICENSE
rm node-${NODE_VERSION}-linux-x64/README.md

# create enclosure
mkdir ${EXT_NAME}

# move files into it
mv node-${NODE_VERSION}-linux-x64 usr
mv usr ${EXT_NAME}

mkdir -p ${EXT_NAME}/usr/lib/extension-release.d/

cat > "${EXT_NAME}/usr/lib/extension-release.d/extension-release.${EXT_NAME}" << EOL
ID_LIKE="flatcar rhel fedora debian"
SYSEXT_LEVEL=1.0
EOL

echo "READY, run ./bake.sh nodejs to build the extension"
