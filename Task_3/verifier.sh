if [ $# -ne 3 ]; then # '$#' gives the number of command line args supplied
    echo 'Usage: ./verifier.sh <source file> <testcases url> <cut-dirs arg>'
    exit 1 # Exit if the number of arguments aren't 3.
fi

# Giving better names to the CLI arguments
source_file="$1"
url="$2"
cut_dirs="$3"

# Getting the test cases
wget -q -r --no-parent --reject "index.html*" -nH --cut-dirs=${cut_dirs} ${url}

# Getting the cpp file and making the executable
cp ${source_file} .
cpp_file=$(basename "${source_file}")
g++ ${cpp_file}

# Compute the output of the code for each input file
cd $(basename ${url})
mkdir -p my_outputs/
cd inputs/
for input in *.in; do
    ../../a.out <${input} >../my_outputs/${input%.in}.out
done

# Now, comparing with the true output and saving the feedback
echo "Failed testcases are:" >../../feedback.txt
count=0
for input in *.in; do
    difference=$(diff ../outputs/${input%.in}.out ../my_outputs/${input%.in}.out | wc -m)
    if [ ${difference} -ne 0 ]; then
        count=$((${count} + 1))
        echo "${input%.in}" >>../../feedback.txt
    fi
done

# Giving out appropriate message
if [ ${count} -eq 0 ]; then
    echo "All testcases passed!"
else
    echo "Some testcases failed."
fi
