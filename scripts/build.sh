#!/usr/bin/env bash
#


# This script builds the application from source.
set -e

# Get the parent directory of where this script is.
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ] ; do SOURCE="$(readlink "$SOURCE")"; done
DIR="$( cd -P "$( dirname "$SOURCE" )/.." && pwd )"

# Change into that directory
cd $DIR


# Software version
VERSION="0.5.0"

# A pre-release marker for the version. If this is "" (empty string)
# then it means that it is a final release. Otherwise, this is a pre-release
# such as "dev", "beta", "rc1", etc.
VERSION_PRERELEASE="dev"

# Release version is combination of VERSION and VERSION_PRERELEASE
RELEASE_VERSION=$VERSION"-"$VERSION_PRERELEASE

# If we're building on Windows, specify an extension
EXTENSION=""
if [ "$(go env GOOS)" = "windows" ]; then
    EXTENSION=".exe"
fi

GOPATHSINGLE=${GOPATH%%:*}
if [ "$(go env GOOS)" = "windows" ]; then
    GOPATHSINGLE=${GOPATH%%;*}
fi

if [ "$(go env GOOS)" = "freebsd" ]; then
	export CC="clang"
fi

# On OSX, we need to use an older target to ensure binaries are
# compatible with older linkers
if [ "$(go env GOOS)" = "darwin" ]; then
    export MACOSX_DEPLOYMENT_TARGET=10.6
fi

# Generate Main as per the Plugin
cp main.go main.temp
cp main.go main.go.temp
for rootentry in ./DoPlugin/*
do
	entry=${rootentry:2:200}
	echo "Entry: $entry":
	line="\t_ "'\"github.com/swarvanusg/GoPlugStatic/'$entry'\"'""
	echo "Var: $line"
	awk '/import/ { print; print "'"$line"'"; next }1' main.go.temp >main.go
done
rm main.go.temp

cp main.go main.go.temp
for rootentry in ./FooPlugin/*
do
	entry=${rootentry:2:200}
	echo "Entry: $entry"
	line="\t_ "'\"github.com/swarvanusg/GoPlugStatic/'$entry'\"'""
	echo "Var: $line"
	awk '/import/ { print; print "'"$line"'"; next }1' main.go.temp >main.go
done
rm main.go.temp


# Install dependencies
echo "--> Installing dependencies to speed up builds..."
go get \
  -ldflags "${CGO_LDFLAGS}" \
  ./...

# Build!
echo "--> Building..."
go build \
  -ldflags "${CGO_LDFLAGS}" \
  -v \
  -o bin/goplug${EXTENSION}

cp bin/goplug${EXTENSION} ${GOPATHSINGLE}/bin

mv main.temp main.go

echo "Build successful"
