# Author: Wecros
# Date: 14/Apr/2020

wordcount=$1

if [ -z $1 ];then
	echo "Usage: correct dir and correct path to your wordcount"
	exit 1
fi

rm -rf book.ref book

"$wordcount" < book.txt > book

if [ ! -f book.ref ]; then
	./genref.sh
fi

diff -u book.ref book | awk 'NR > 15 {print "TRUNCTATED"; exit}; {print}'
