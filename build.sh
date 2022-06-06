#!/bin/sh

# Build Hugo Project

echo "🔨 Building Hugo Site"

EXTRA_PARAMS=$@

#####
## remove dist directory
#####
if [ -d "./src/dist" ]; then
  echo "🗑  Removing dist directory"
  rm -rf ./src/dist
fi


## Hugo Options used for building the site
# -d                        dist directory
# -gc                       run some cleanup tasks (remove unused cache files) after the build
# --minify                  minify the output
# --cleanDestinationDir     remove files from destination not found in static directories
# -v                        verbose mode

CURRENT_USER="$(id -u):$(id -g)" docker compose run --rm hugo build --minify --gc -v --cleanDestinationDir -d dist $EXTRA_PARAMS

#####
## remove unwanted files
#####
echo "🗑  Removing unwanted files"  

if [ -d "./src/dist/page" ]; then
  rm -rf ./src/dist/page
fi

if [ -f "./src/dist/sitemap.xml" ]; then
  rm -rf ./src/dist/sitemap.xml
fi

if [ -d "./src/dist/posts/page" ]; then
  rm -rf ./src/dist/posts/page
fi

echo "✅ build complete"
