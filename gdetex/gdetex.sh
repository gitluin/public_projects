#!/bin/sh

# Convert .latex file to plaintext
# Will still require manual tweaking
LTFILE="$1"
OUTFILE="$(echo $1 | sed 's/latex$/txt/')"
TMPFILE="$(echo $1 | sed 's/latex$/tmp/')"

ITEMSYM='*'

cp $LTFILE $OUTFILE


sed -i 's/\\.*document.*//g' $OUTFILE
sed -i 's/\\.*usepackage.*//g' $OUTFILE


# titlepage stuff
sed -i 's/\\title{\(.*\)}/\1/g' $OUTFILE
sed -i 's/\\author{\(.*\)}/\1/g' $OUTFILE
sed -i 's/\\date{\(.*\)}/\1/g' $OUTFILE


TOPLEVEL=''
# Find the top level
SECLEVELS='section subsection subsubsection'
for SLEVEL in $SECLEVELS; do
	if ! test -z "$(cat $LTFILE | grep "\\\\$SLEVEL")"; then
		TOPLEVEL=$SLEVEL
		break
	fi
done

# Remove headers that are not top level
for SLEVEL in $SECLEVELS; do
	if test "$SLEVEL" != "$TOPLEVEL"; then
		sed -i "s/\\\\$SLEVEL\*{\(.*\)}/\1/g" $OUTFILE
		sed -i "s/\\\\$SLEVEL{\(.*\)}/\1/g" $OUTFILE

		# Cleanup in case something spans lines
		sed -i "s/\\\\$SLEVEL\*{\(.*\)/\1/g" $OUTFILE
		sed -i "s/\\\\$SLEVEL{\(.*\)/\1/g" $OUTFILE
	fi
done


# Text formatting
sed -i 's/\\textit{\(.*\)}/\1/g' $OUTFILE
sed -i 's/\\textbf{\(.*\)}/\1/g' $OUTFILE
sed -i 's/\\LaTeX/LaTeX/g' $OUTFILE
sed -i 's/\\LARGE//g' $OUTFILE
sed -i 's/\\large//g' $OUTFILE
sed -i 's/\\normalsize//g' $OUTFILE
sed -i 's/\\small//g' $OUTFILE
sed -i 's/\\tiny//g' $OUTFILE
sed -i 's/\\textcolor{[^}]*}{\(.*\)}/\1/g' $OUTFILE
sed -i 's/\\href{[^}]*}{\(.*\)}/\1/g' $OUTFILE
sed -i 's/\\&/\&/g' $OUTFILE
sed -i 's/:\\/:/g' $OUTFILE
sed -i 's/[.]\\/./g' $OUTFILE


# Page formatting
sed -i 's/\\vspace{[^}]*}//g' $OUTFILE
sed -i 's/\\.*hrulefill.*//g' $OUTFILE
sed -i 's/\\newpage//g' $OUTFILE
sed -i 's/\\begin{[^}]*}//g' $OUTFILE
sed -i 's/\\end{[^}]*}//g' $OUTFILE
sed -i 's/\\indent //g' $OUTFILE
sed -i 's/\\.*pagenumbering.*//g' $OUTFILE
sed -i 's/\\maketitle//g' $OUTFILE


# Newline stuff
sed -i 's/\\\\//g' $OUTFILE
sed -i 's/\~\\\\//g' $OUTFILE


# Remove comments
sed -i 's/^%.*//g' $OUTFILE


# Lists, etc.
sed -i "s/\t\\\\item/$ITEMSYM/g" $OUTFILE


# Leftovers
sed -i 's/^{//g' $OUTFILE
sed -i 's/^}//g' $OUTFILE
sed -i 's/\\textbf{//g' $OUTFILE


# Swallow excessive newlines
cat -s $OUTFILE > $TMPFILE
cat $TMPFILE > $OUTFILE
rm $TMPFILE


# Remove any empty and trailing blank lines
sed -i '1{/^$/d}' $OUTFILE
sed -i '${/^$/d}' $OUTFILE


# Top-level headers get some spacing before them
sed -i "s/\\\\$TOPLEVEL\*{\(.*\)}/\n\1/g" $OUTFILE
sed -i "s/\\\\$TOPLEVEL{\(.*\)}/\n\1/g" $OUTFILE

# Cleanup in case some spanned lines, etc.
sed -i "s/\\\\$TOPLEVEL\*{\(.*\)/\n\1/g" $OUTFILE
sed -i "s/\\\\$TOPLEVEL{\(.*\)/\n\1/g" $OUTFILE
