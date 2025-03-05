#!/bin/bash
for i in yandex.ru google.com cloudflare.com comss.ru gcore.com vk.com
do
	ping -c5 -q $i &> /dev/null && echo "$i is available!" || echo "$i is ureachable!"
done
