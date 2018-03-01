#!/bin/bash

typeset MYSELF="$(readlink -f $0)"
typeset MYPATH="${MYSELF%/*}"


typeset ROLENAME="$1"
typeset SRCDIR="$MYPATH/_template"
typeset DSTDIR="$MYPATH/$ROLENAME"

[[ -z "$ROLENAME" ]] && {
	echo "Usage: $0 'rolename'"
	echo "  Rolename being the new role located in $MYPATH"
	exit 1
}
[[ -e "$DSTDIR" ]] && {
	echo "Role '$ROLENAME' already exists"
	exit 1
}
echo $ROLENAME | grep -qP '[\./#]' && {
	echo "rolename cannot contain '.' or '/'"
	exit 1
}

# Copy files
echo "Creating '$ROLENAME' as '$DSTDIR'"
rsync -a "$SRCDIR/" "$DSTDIR"

# Sed the templates
typeset tplreplace="${ROLENAME#*-}"
typeset tplsearch="__TEMPLATE__"
grep -r "$tplsearch" -l $DSTDIR | xargs sed -e "s/$tplsearch/$tplreplace/g" -i


