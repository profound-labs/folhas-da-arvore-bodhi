#!/bin/bash
echo "PWD: $PWD"
echo "TARGET: $1"
grep -E '\\.' "$1"/*.tex | grep -vf ./helpers/known_latex | sort | uniq
