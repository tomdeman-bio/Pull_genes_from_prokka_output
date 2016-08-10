#! /usr/bin/perl

# Written by Tom de Man

use strict; 

#gene name of interest, when spaces are present only the part before the first space is considered 
my $gene_name = shift;

if (scalar(@ARGV)==0){
	print "Usage: perl $0 <gene name> \n";
	exit;
}

#pull your gene(s) of interest using grep and awk
system("grep -i '$gene_name' *.ffn | awk '{print $1}' > $gene_name.txt");

open TXT, "$gene_name.txt" || die "cannot open $gene_name for reading";

while (<TXT>) {
	chomp;
	if ($_ =~ m/$gene_name/) {
		my @line = split (":", $_);
		my @split_second = split (">", $line[1]);
		my @split_third = split (" ", $split_second[1]);
		&createFasta($line[0], $split_third[0]);
	}
}
close TXT;

sub createFasta {
	my $fasta_file = shift;
	my $header = shift;
	my $name;
	my %hash;
	$hash{$header}=1;
	open FFN, "$fasta_file" || die "cannot open $fasta_file for reading";
	while (<FFN>) {
		chomp;
		if (/>(\S+)/) {
			$name=$1;
			$_ = join '',(split/^./);
			print ">".$_."\n" if ($hash{$name});
		}
		else {
			print $_."\n" if ($hash{$name});
		}
	}
}
