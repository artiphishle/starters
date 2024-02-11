#!/usr/bin/env bash

function cleanUp(){
	rm -rf ch-throttle
}
function createEnv(){
	[ -e file ] && rm .env
	printf "# Supabase" > .env
	printf "EXPO_PUBLIC_SUPABASE_URL=https://tuxhpqvpkqmvzrqguhpg.supabase.co" >> .env
	echo	"EXPO_PUBLIC_SUPABASE_ANON_KEY=" >> .env
	echo "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJ" >> .env
	echo "lZiI6InR1eGhwcXZwa3FtdnpycWd1aHBnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDc0MjEwN" >> .env
	printf "zQsImV4cCI6MjAyMjk5NzA3NH0.ZipMrEbtPHFaEPVZGUyBtjZXPLmAAuH1ixoctI2p3j8" >> .env
}
function downloadPrettierConfig(){
	git clone https://github.com/artiphishle/prettierrc &>/dev/null
	mv prettierrc/.prettierrc .
	rm -rf prettierrc
}
function log(){
	echo $1 >> ./logs/setup.log
}
function printSuccess(){
	echo "✅ ${1}"
}
function printTitle(){
	printf '\n\n'
	echo "🚘 ${1}"
	printf '\n'
}
function upgradePackages(){
	ncu && ncu -u

	# Fix (check if this is right first)
	# yarn add \
		# react-native-gesture-handler@2.14.0 \
		# react-native-reanimated@3.6.2
}

printTitle 'ch-throttle v1.0.3'
cleanUp && printSuccess "Clean up"

# Download package
# npx create-expo-stack@latest ch-throttle --expo-router --drawer+tabs --nativewind --supabase --yarn &>/dev/null
git clone --depth 1 --branch 'v1.0.3' git@github.com:artiphishle/ch-throttle &>/dev/null && printSuccess "Package 'ch-throttle' downloaded"

# Install package & add README.md
cd ch-throttle && yarn &>/dev/null && printSuccess "Package 'ch-throttle' installed"
cp .ankh/README.md . && printSuccess "README.md loaded (cached)"

# Upgrade Packages
# upgradePackages

# Install Map
# npx expo install react-native-maps && printSuccess "Map loaded"

# Download .prettierrc & run ESLint & Prettier
# downloadPrettierConfig && printSuccess "Download .prettierrc"
yarn run format &>/dev/null && printSuccess "Checked ESLint & Prettier"

# Run
yarn start

exit 0
