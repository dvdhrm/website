#!/bin/bash

set -e

KEY="./ci/converse2-github-rsa.sec"

projects=(
        "c-util"
        "converse1"
        "nettools"
        "r-util"
)

case "$1" in
        pack-key)
                travis \
                        encrypt-file \
                        --com \
                        --print-key \
                        "$KEY" \
                        "$KEY.enc"
                ;;

        setup-key)
                (
                        openssl aes-256-cbc \
                                -K $encrypted_7fdda92792e6_key \
                                -iv $encrypted_7fdda92792e6_iv \
                                -in "$KEY.enc" \
                                -out "$KEY" \
                                -d
                        chmod 600 "$KEY"
                )
                ;;

        setup-repos)
                rm -Rf "./build"
                mkdir -p "./build"
                for project in "${projects[@]}" ; do
                        GIT_SSH_COMMAND="ssh -i $KEY" \
                                git clone \
                                        "git@github.com:${project}/${project}.github.io.git" \
                                        "build/${project}"
                done
                ;;

        build)
                for project in "${projects[@]}" ; do
                        test -d "build/${project}" || ( echo "Run setup first!" ; exit 1 )
                        bundle exec jekyll build \
                                --config "src/_config_${project}.yml" \
                                --source "src" \
                                --destination "build/${project}"
                        bundle exec htmlproofer "build/${project}"
                done
                ;;

        deploy)
                for project in "${projects[@]}" ; do
                        test -d "build/${project}" || ( echo "Build first!" ; exit 1 )
                        (
                                cd "build/${project}"
                                git add --all .
                                GIT_COMMITTER_NAME="Converse2" \
                                GIT_COMMITTER_EMAIL="david.rheinsberg+converse2@gmail.com" \
                                GIT_AUTHOR_NAME="Converse2" \
                                GIT_AUTHOR_EMAIL="david.rheinsberg+converse2@gmail.com" \
                                        git commit \
                                                --allow-empty \
                                                -m "Regenerate web-pages"
                                GIT_SSH_COMMAND="ssh -i ../../$KEY" \
                                        git push
                        )
                done
                ;;

        *)
                echo "Invalid command '$1'"
                ;;
esac
