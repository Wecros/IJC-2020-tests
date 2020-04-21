stdin="$1"

if [ -z "$1" ]; then
	stdin="book.txt"
fi

./../../wordcount- <"$stdin" | sort >book.ref
