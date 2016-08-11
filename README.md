# Pull genes from Prokka output

###Perform a [Prokka 1.8] (https://github.com/tseemann/prokka) run on your FASTA formatted bacterial genome assemblies 
```bash
  
  for i in *.fasta

  do 
	  new="$(echo "$i" | cut -d '.' -f 1)"
	  prokka --kingdom Bacteria --outdir prokka_$new --locustag $new $i
  done
```

###Put all the .ffn files in the same folder (e.g. using ln -s or cp command) and pull out your gene of interest from each .ffn, for instance Recombinase A (RecA)
```bash

  perl pull_gene_from_prokka_ffn_fasta.pl Recombinase A
```

