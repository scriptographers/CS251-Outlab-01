if [ $# -ne 3 ]; then # '$#' gives the number of command line args supplied
    echo 'Usage: ./verifier.sh <source file> <testcases url> <cut-dirs arg>'
    exit 1
fi

source_file="$1"
url="$2"
cut_dirs=$(($3 + 1))

wget -r --no-parent --reject "index.html*" -nH --cut-dirs=${cut_dirs} ${url}

cp ${source_file} .
