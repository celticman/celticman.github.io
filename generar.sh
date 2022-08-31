rm *.html
DIRECTORIO=$(pwd)
for fichero in *.md; do 
    pandoc --standalone -t html5 --data-dir=$DIRECTORIO --template "celticman_plantilla.html5" "$fichero" -o "${fichero%.md}.html" -V pandocversion="$(pandoc --version | head -n 1)" -V curdate="$(date -u --iso-8601)" 
done
