# Author: Wecros
# Date: 14/Apr/2020
# first arg is optional

path=$(realpath "$1")
cd tail
echo TESTING TAIL
if [ -n "$1" ]; then
	./tests.sh "$path"
else
	./tests.sh ./../../tail
fi
cd ..
