# Author: Wecros
# Date: 14/Apr/2020
# first arg is optional

if [ -n "$1" ]; then
	path=$(realpath "$1")
fi
cd tail
echo TESTING TAIL
if [ -n "$1" ]; then
	./tests.sh "$path"
else
	./tests.sh ./../../tail
fi
cd ..
