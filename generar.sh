rm *.html
for fichero in *.md; do 
    pandoc "$fichero" -o "${fichero%.md}.html" --standalone -t html5
done
