#!/bin/bash

set -e

projects=(
#        "bus1"         # key already added
        "c-util"
        "converse1"
#        "nettools"     # key already added
        "r-util"
)

case "$1" in
        new-keys)
                for project in "${projects[@]}" ; do
                        file="ci/ssh/${project}-web-rsa.sec"
                        if test ! -f "$file" ; then
                                ssh-keygen \
                                        -t rsa \
                                        -b 4096 \
                                        -N "" \
                                        -C "david.rheinsberg@gmail.com" \
                                        -f "ci/ssh/${project}-web-rsa.sec"
                        fi
                done
                ;;

        pack-keys)
                tar \
                        -cv \
                        --exclude "*.pub" \
                        -f ci/ssh.tar \
                        -C ci \
                        ssh
                travis \
                        encrypt-file \
                        --com \
                        --print-key \
                        ci/ssh.tar \
                        ci/ssh.tar.enc
                ;;

        setup-keys)
                (
                        openssl aes-256-cbc \
                                -K $encrypted_7fdda92792e6_key \
                                -iv $encrypted_7fdda92792e6_iv \
                                -in ci/ssh.tar.enc \
                                -out ci/ssh.tar \
                                -d
                        tar -xvf ci/ssh.tar -C ci

                        for file in ci/ssh/*.sec ; do
                                chmod 600 "$file"
                        done
                )
                ;;

        setup-repos)
                rm -Rf "./build"
                mkdir -p "./build"
                for project in "${projects[@]}" ; do
                        GIT_SSH_COMMAND="ssh -i ./ci/ssh/$project-web-rsa.sec" \
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
                                git commit \
                                        --allow-empty \
                                        -m "Regenerate web-pages"
                                GIT_SSH_COMMAND="ssh -i ../../ci/ssh/$project-web-rsa.sec" \
                                        git push
                        )
                done
                ;;

        *)
                echo "Invalid command '$1'"
                ;;
esac
