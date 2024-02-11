#!/usr/bin/env

which n;
n install lts_latest
n use lts_latest -- echo .exit

npm i -g npm
npm create tamagui@latest

exit 0;
