weather() {
	# Retrieve weather information based on that amazing website
	# Optional argument: airport code or city name
	if [ "$#" -ne 1  ]; then
		location="edinburgh"
	else
		location="$1"
	fi
	curl "http://wttr.in/$location?m";
}

moon() {
	# Retrieve moon information based on that amazing website
	# Optional argument: date (YYYY-MM-DD)
	if [ "$#" -ne 1  ]; then
		date=""
	else
		date="$1"
	fi
	curl http://wttr.in/Moon@$date;
}


joke() {
	curl -s -H 'Accept: application/json' https://icanhazdadjoke.com/ | jq '.joke'
}


emoji-party() {
  if ! command -v figlet; then
    if ! command -v brew; then
      echo Requires figlet or brew to be installed
      return 1
    fi
    brew install figlet
  fi

  if [ -z "$1" ]; then
    echo "Enter party word: "
    read PARTY_WORD
  else
    PARTY_WORD=$1
  fi

  if [ -z "$2" ]; then
    echo "Enter party word emoji (without colons): "
    read WORD_EMOJI
  else
    WORD_EMOJI=$2
  fi

  if [ -z "$3" ]; then
    echo "Enter background emoji (without colons): "
    read BACKGROUND_EMOJI
  else
    BACKGROUND_EMOJI=$3
  fi

  echo
  figlet -f banner $PARTY_WORD | sed -e "s/#/:$WORD_EMOJI:/g" -e 's/^/ /g' -e "s/ /:$BACKGROUND_EMOJI:/g"
}
