#!/usr/bin/env sh
set -e
DIR=~/Downloads
APP=openshift-origin-client-tools

mirror() {
    local major_ver=$1
    local minor_ver=$2
    local file=$3
    printf "https://artifacts-openshift-release-%d-%d.svc.ci.openshift.org/zips/%s" $major_ver $minor_ver $file
}

dl()
{
    local major_ver=$1
    local minor_ver=$2
    local patch_ver=$3
    local sha_infix=$4
    local lchecksums=$5
    local platform=$6
    local archive_type=${7:-zip}
    local file="${APP}-v${major_ver}.${minor_ver}.${patch_ver}-${sha_infix}-${platform}.${archive_type}"
    local url=$(mirror $major_ver $minor_ver $file)

    printf "      # %s\n" $url
    printf "      %s: sha256:%s\n" $platform `fgrep $file $lchecksums | awk '{print $1}'`
}

dl_ver() {
    local major_ver=$1
    local minor_ver=$2
    local patch_ver=$3
    local sha_infix=$4

    local rchecksums=$(mirror $major_ver $minor_ver CHECKSUM)
    local lchecksums=$DIR/${APP}-${major_ver}.${minor_ver}.${patch_ver}-checksums.txt

    if [ ! -e $lchecksums ];
    then
        wget -q -O $lchecksums $rchecksums
    fi

    printf "  v%d.%d.%d:\n" $major_ver $minor_ver $patch_ver
    printf "    # %s\n" $rchecksums
    printf "    '%s':\n" $sha_infix
    dl $major_ver $minor_ver $patch_ver $sha_infix $lchecksums linux-64bit tar.gz
    dl $major_ver $minor_ver $patch_ver $sha_infix $lchecksums mac
    dl $major_ver $minor_ver $patch_ver $sha_infix $lchecksums windows
}

dl_ver 3 11 0 '7876dd5-361'
dl_ver 4 1 0 '3040211-315'
