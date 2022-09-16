#!/bin/bash
git log -4 --oneline --all --graph
git checkout giteeRemote
git merge master
git push gitee HEAD:master
git checkout githubRemote
git merge master
git push github HEAD:master
git checkout master
git log -4 --oneline --all --graph
