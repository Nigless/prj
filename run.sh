#!/bin/sh

SCRIPT_DIR="$HOME/.zsh/scripts/prj"

prj() {
    eval $(dart \
        --define=PROJECTS=$PROJECTS \
        --define=CACHE="$HOME/.cache/prj" \
        --define=RECENT_PROJECT="$RECENT_PROJECT" \
        $SCRIPT_DIR/bin/cli.dart $@)
}

_update_recent_project() {
    eval $(dart \
        --define=PROJECTS="$PROJECTS" \
        --define=CACHE="$HOME/.cache/prj" \
        --define=RECENT_PROJECT="$RECENT_PROJECT" \
        $SCRIPT_DIR/bin/update_recent_project.dart)
}

_update_recent_project
