declare -x +g NNN_TMPFILE=$(mktemp)
trap "rm -f $NNN_TMPFILE" EXIT
=nnn -Ade $@
[ -s $NNN_TMPFILE ] && source $NNN_TMPFILE

