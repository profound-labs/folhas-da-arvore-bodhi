#!/bin/bash

SRC="$1"
DEST="$2"

cat "$SRC" |\
sed -e 's/\\label[{][^}]\+[}]//g; s/\\pageref[{][^}]\+[}]/FIXME:pageref/g' |\
sed 's/\\verseref[{]\([^}]\+\)[}]/\1.\\\\/g' |\
sed 's/\\thai[{]\([^}]\+\)[}]/\\emph{\1}/g' |\
sed 's/\\speaker[{]\([^}]\+\)[}]/\\emph{\1}/g' |\
sed 's/\\LaTeX/LaTeX/g' |\
sed 's/\(\w\)"-\(\w\)/\1-\2/g' |\
sed 's/\\tocChapterNote{\([^}]\+\)}/\n\\emph{\1}/g' |\
sed 's/\\QA{\([^}]\+\)}/\\textbf{\1}/g' |\
sed 's/\\begin{packeditemize}//g' |\
sed 's/\\end{packeditemize}//g' |\
pandoc --smart --normalize --from=latex --to=markdown |\
sed 's/\([^\\]\)\\$/\1\\\\/' > "$DEST"

