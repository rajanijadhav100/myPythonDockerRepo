#!/bin/bash

INCOMING_DIR=~/deploy_zips/incoming
EXTRACT_DIR=~/deploy_zips/extracted
REPO_DIR=~/myPythonDockerRepo
GITHUB_REPO=https://github.com/rajanijadhav100/myPythonDockerRepo.git

while true; do
    for zip in $INCOMING_DIR/*.zip; do
        [ -e "$zip" ] || continue

        echo "Processing $zip"

        rm -rf "$EXTRACT_DIR"
        mkdir -p "$EXTRACT_DIR"
        unzip "$zip" -d "$EXTRACT_DIR"

        if [ ! -d "$REPO_DIR/.git" ]; then
            git clone "$GITHUB_REPO" "$REPO_DIR"
        fi

        cp -r $EXTRACT_DIR/* $REPO_DIR/

        cd "$REPO_DIR"
        git config user.name "Auto Deploy Bot"
        git config user.email "deploy@example.com"

        # 🔁 Rebase to avoid non-fast-forward errors
        git pull --rebase origin master

        git add .
        git commit -m "Auto update from uploaded zip" || echo "Nothing to commit"
        git push origin master

        rm -f "$zip"
    done
    sleep 5
done
