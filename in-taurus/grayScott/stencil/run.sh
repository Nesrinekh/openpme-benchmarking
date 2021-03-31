#!/bin/bash
for i in {1..2};
do
	echo 1>&2
	htop -n 1 -b 1>&2
        echo 1>&2
	sleep 1
done &
time ./main > output
