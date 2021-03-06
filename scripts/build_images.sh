#!/bin/bash

set -e

sha1=${CIRCLE_SHA1:-latest}
version=${DECIDIM_VERSION:-0.9.3}

docker build -f Dockerfile \
            --build-arg "decidim_version=$version" \
            -t "decidim/decidim:$sha1" \
            --cache-from=decidim/decidim:latest .

docker build -f Dockerfile-test \
            --build-arg "base_image=decidim/decidim:$sha1" \
            --build-arg "decidim_version=$version" \
            -t "decidim/decidim:$sha1-test" \
            --cache-from=decidim/decidim:latest-test .

docker build -f Dockerfile-dev \
            --build-arg "base_image=decidim/decidim:$sha1-test" \
            -t "decidim/decidim:$sha1-dev" \
            --cache-from=decidim/decidim:latest-dev .

docker build -f Dockerfile-deploy \
            --build-arg "base_image=decidim/decidim:$sha1" \
            -t "decidim/decidim:$sha1-deploy" \
            --cache-from=decidim/decidim:latest-deploy .
