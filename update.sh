#!/usr/bin/env bash
set -euxo pipefail

EXT_NAME=nodejs

_dl="node-${NODE_VERSION}-linux-x64.tar"

# clean up
rm -rf ${EXT_NAME}

# download 
curl "https://nodejs.org/dist/${NODE_VERSION}/${_dl}.xz" \
    -o ${_dl}.xz
xz --decompress ${_dl}.xz
tar xf ${_dl}

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
