#!/bin/bash

cd ~/scripts/mangata
git stash push --include-untracked
git pull
chmod +x *.sh
