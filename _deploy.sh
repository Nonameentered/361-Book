#!/bin/sh

set -e

[ -z "${GITHUB_PAT}" ] && exit 0
[ "${TRAVIS_BRANCH}" != "main" ] && exit 0

git config --global user.email "matthewshu88@gmail.com"
git config --global user.name "Matt Shu"

git clone -b gh-pages https://${GITHUB_PAT}@github.com/${TRAVIS_REPO_SLUG}.git book-output
cd book-output
cp -r ../_book/* ./
git add --all *
git commit -m "Update the book" || true
git remote add origin-pages https://${GITHUB_PAT}@github.com/${TRAVIS_REPO_SLUG}.git > /dev/null 2>&1
git push --quiet --set-upstream origin-pages gh-pages
