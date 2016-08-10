#!/bin/sh

for i in *.fasta

do 
	new="$(echo "$i" | cut -d '.' -f 1)"
	prokka --kingdom Bacteria --outdir prokka_$new --locustag $new $i
done

