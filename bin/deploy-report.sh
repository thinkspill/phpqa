#!/bin/sh

# Deploy latest report to gh-pages (https://edgedesigncz.github.io/phpqa/report/phpqa.html)
#
# Usage:
#  $ bin/deploy-report.sh ../github-pages/phpqa

repository=$1

deploy() {
    checkout_repository
    build_report
    copy_artifacts
    publish_changes
}

checkout_repository() {
    (
        cd $repository
        git checkout gh-pages
    )
}

build_report() {
    phpqa --report
}

copy_artifacts() {
    cp -R build/*.html $repository/report
    cp -R build/*.svg $repository/report
    cp -R build/*.xml $repository/report
}

publish_changes() {
    (
        cd $repository
        git add .
        git commit -m "Report - `date +'%Y-%m-%d %H:%M:%S'`"
        git push origin gh-pages
    )
}

deploy