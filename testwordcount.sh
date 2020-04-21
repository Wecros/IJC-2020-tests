cd wordcount
echo Testing wordcount static
./tests.sh ./../../wordcount
echo Testing wordcount dynamic
./tests.sh ./../../wordcount-dynamic
if [ ! -s diffs ]; then
	echo ALL TESTS PASSED
fi
cd ..


