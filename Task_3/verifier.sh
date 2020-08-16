if [ $# -ne 3 ]; then # '$#' gives the number of command line args supplied
    echo 'Usage: ./verifier.sh <source file> <testcases url> <cut-dirs arg>'
    exit 1 # Exit if the number of arguments aren't 3.
fi

# Giving better names to the CLI arguments
source_file="$1"
url="$2"
cut_dirs=$(($3 + 1))

# Getting the test cases
wget -r --no-parent --reject "index.html*" -nH --cut-dirs=${cut_dirs} ${url}

# Getting the cpp file and making the executable
cp ${source_file} .
cpp_file=$(basename "${source_file}")
g++ ${cpp_file}
