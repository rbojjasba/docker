#!/bin/sh -x

USER_UID=$(stat -c %u /code/Gemfile)
USER_GID=$(stat -c %g /code/Gemfile)

export USER_UID
export USER_GID

usermod -u "$USER_UID" decidim 2> /dev/null
groupmod -g "$USER_GID" decidim 2> /dev/null
usermod -g "$USER_GID" decidim 2> /dev/null

chown -R -h "$USER_UID" "$BUNDLE_PATH" 2> /dev/null
chgrp -R -h "$USER_GID" "$BUNDLE_PATH" 2> /dev/null

/usr/bin/sudo -EH -u decidim "$@"
