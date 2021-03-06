#!/usr/bin/env bash

MASON_NAME=android-ndk
MASON_VERSION=mips-9-r11c
MASON_LIB_FILE=

. ${MASON_DIR}/mason.sh

function mason_load_source {
    if [ ${MASON_PLATFORM} = 'osx' ]; then
        mason_download \
            http://dl.google.com/android/repository/android-ndk-r11c-darwin-x86_64.zip \
            0c6fa2017dd5237f6270887c85feedc4aafb3aef
    elif [ ${MASON_PLATFORM} = 'linux' ]; then
        mason_download \
            http://dl.google.com/android/repository/android-ndk-r11c-linux-x86_64.zip \
            0c646e2fceb3ef853e1832f4aa3a0dc4c16d2229
    fi

    mason_setup_build_dir
    rm -rf ./android-ndk-r11c
    unzip -q ../.cache/${MASON_SLUG} $@

    export MASON_BUILD_PATH=${MASON_ROOT}/.build/android-ndk-r11c
}

function mason_compile {
    rm -rf ${MASON_PREFIX}
    mkdir -p ${MASON_PREFIX}

    ${MASON_BUILD_PATH}/build/tools/make-standalone-toolchain.sh \
          --toolchain="mipsel-linux-android-clang" \
          --use-llvm \
          --package-dir="${MASON_BUILD_PATH}/package-dir/" \
          --install-dir="${MASON_PREFIX}" \
          --stl="libcxx" \
          --arch="mips" \
          --platform="android-9"
}

function mason_clean {
    make clean
}

function mason_cflags {
    :
}

function mason_ldflags {
    :
}

function mason_static_libs {
    :
}

mason_run "$@"
