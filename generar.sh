rm *.html
DIRECTORIO=$(pwd)
for fichero in *.md; do 
    pandoc --standalone -t html5 --data-dir=$DIRECTORIO --template "celticman_plantilla.html5" "$fichero" -o "${fichero%.md}.html" 
done
