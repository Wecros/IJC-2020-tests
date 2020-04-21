# Author: Wecros
# Date: 14/Apr/2020

wordcount=$1
stdin=$2

if [ -z $2 ]; then
	stdin="book.txt"
fi

if [ -z $1 ];then
	echo "Usage: correct dir and correct path to your wordcount"
	exit 1
fi

rm -rf book.ref book diffs

LD_LIBRARY_PATH='../../.' "$wordcount" < "$stdin" | sort > book

./genref.sh "$stdin"

diff -u book.ref book | awk 'NR > 15 {print "TRUNCTATED"; exit}; {print}'
diff -u book.ref book >> diffs

