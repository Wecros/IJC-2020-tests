# Author: Wecros
# Date: 14/Apr/2020

tail=$1 # path to your tail program
tests=('n-1tf' 'n+1tf' 'n-3tf' 'n3tf' 'n+3tf' 'tf' 'ml' 'n+750ml' 'n150ml' 'n2last' 'n-1tf.stdin' \
'n+1tf.stdin' 'n-3tf.stdin' 'n3tf.stdin' 'n+3tf.stdin' 'tf.stdin' 'ml.stdin' 'n+750ml.stdin' \
'n150ml.stdin' 'n2last.stdin' 'n+0tf' 'n+0tf.stdin' 'n0tf' 'n0tf.stdin')
if [ -z $1 ]; then
	echo "Usage: correct directory and first arg is path to your tail program" 
	exit 1	
fi

for test in "${tests[@]}"; do
	rm -rf "$test" "$test".ref
done
rm -rf alldiffs

tail -n -1 testfile.txt > n-1tf.ref
tail -n +1 testfile.txt > n+1tf.ref
tail -n -3 testfile.txt > n-3tf.ref
tail -n 3 testfile.txt > n3tf.ref
tail -n +3 testfile.txt > n+3tf.ref
tail testfile.txt > tf.ref
tail manylines.txt > ml.ref
tail -n +750 manylines.txt > n+750ml.ref
tail -n 150 manylines.txt > n150ml.ref
tail -n 2 last.txt > n2last.ref
tail -n -0 testfile.txt >> n0tf.ref
tail -n +0 testfile.txt >> n+0tf.ref

tail -n -1 <testfile.txt > n-1tf.stdin.ref
tail -n +1 <testfile.txt > n+1tf.stdin.ref
tail -n -3 <testfile.txt > n-3tf.stdin.ref
tail -n 3 <testfile.txt > n3tf.stdin.ref
tail -n +3 <testfile.txt > n+3tf.stdin.ref
tail <testfile.txt > tf.stdin.ref
tail <manylines.txt > ml.stdin.ref
tail -n +750 <manylines.txt > n+750ml.stdin.ref
tail -n 150 <manylines.txt > n150ml.stdin.ref
tail -n 2 <last.txt > n2last.stdin.ref 
tail -n -0 <testfile.txt >> n0tf.stdin.ref
tail -n +0 <testfile.txt >> n+0tf.stdin.ref

"$tail" -n -1 testfile.txt > n-1tf
"$tail" -n +1 testfile.txt > n+1tf
"$tail" -n -3 testfile.txt > n-3tf
"$tail" -n 3 testfile.txt > n3tf
"$tail" -n +3 testfile.txt > n+3tf
"$tail" testfile.txt > tf
"$tail" manylines.txt > ml
"$tail" -n +750 manylines.txt > n+750ml
"$tail" -n 150 manylines.txt > n150ml
"$tail" -n 2 last.txt >n2last 2>n2last.err
"$tail" -n -0 testfile.txt >> n0tf
"$tail" -n +0 testfile.txt >> n+0tf

"$tail" -n -1 <testfile.txt > n-1tf.stdin
"$tail" -n +1 <testfile.txt > n+1tf.stdin
"$tail" -n -3 <testfile.txt > n-3tf.stdin
"$tail" -n 3 <testfile.txt > n3tf.stdin
"$tail" -n +3 <testfile.txt > n+3tf.stdin
"$tail" <testfile.txt > tf.stdin
"$tail" <manylines.txt > ml.stdin
"$tail" -n +750 <manylines.txt > n+750ml.stdin
"$tail" -n 150 <manylines.txt > n150ml.stdin
"$tail" -n 2 <last.txt > n2last.stdin 2>n2last.stdin.err
"$tail" -n -0 <testfile.txt >> n0tf.stdin
"$tail" -n +0 <testfile.txt >> n+0tf.stdin

for test in "${tests[@]}"; do
	echo Testing "$test"...
	# if [ ! -s "$test" ]; then
	    # echo STDOUT is empty, something wrong with your program or the way you are using this script >&2
		# continue		
	# fi
	diff -u "$test".ref	"$test" | awk 'NR>10 {print "TRUNCATED"; exit}; {print}' 
	diff -u "$test".ref	"$test" >> alldiffs  
done
if [ ! -s alldiffs ]; then
	echo ALL TESTS PASSED	
fi
