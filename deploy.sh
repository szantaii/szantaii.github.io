#!/bin/bash

set -euf -o pipefail

script_directory="$(dirname "$(realpath "$0")")"
source_directory="${script_directory}/src"
vendor_directory="${script_directory}/vendor"
deploy_directory="${script_directory}/docs"

source_target_path_pairs=(
    "${source_directory}/html/index.html:${deploy_directory}/"
    "${source_directory}/images/favicon.svg:${deploy_directory}/"
    "${source_directory}/images/szantaii.svg:${deploy_directory}/"
    "${source_directory}/styles/style.css:${deploy_directory}/"
    "${vendor_directory}/ibm-plex/IBM-Plex-Sans/fonts/complete/ttf/IBMPlexSans-Bold.ttf:${deploy_directory}/"
    "${vendor_directory}/ibm-plex/IBM-Plex-Sans/fonts/complete/ttf/IBMPlexSans-Light.ttf:${deploy_directory}/"
    "${vendor_directory}/ibm-plex/IBM-Plex-Sans/fonts/complete/woff2/IBMPlexSans-Bold.woff2:${deploy_directory}/"
    "${vendor_directory}/ibm-plex/IBM-Plex-Sans/fonts/complete/woff2/IBMPlexSans-Light.woff2:${deploy_directory}/"
    "${vendor_directory}/normalize.css/normalize.css:${deploy_directory}/"
    "${vendor_directory}/sidenote.hu-archive/mirror:${deploy_directory}/sidenote.hu-static-archive"
)

clean_deploy_directory()
{
    set +f

    rm -rf "${deploy_directory:?}/"*

    set -f

    touch "${deploy_directory:?}/.nojekyll"
    cp "${script_directory:?}/CNAME" "${deploy_directory:?}/CNAME"
}

substitute_deployment_date()
{
    local input_file="$1"
    local formatted_date

    formatted_date="$(date "+%A, %B %d, %Y")"

    sed -i "s/{% date %}/${formatted_date}/g" "${input_file}"
}

deploy()
{
    clean_deploy_directory

    for source_target_path_pair in "${source_target_path_pairs[@]}"
    do
        IFS=':' read -r source_path target_path <<< "${source_target_path_pair}"

        cp -a "${source_path}" "${target_path}"
    done

    substitute_deployment_date "${deploy_directory}/index.html"
}

deploy
