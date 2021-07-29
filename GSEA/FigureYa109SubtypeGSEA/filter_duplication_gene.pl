#!/usr/bin/perl -w

use strict;
use Data::Dumper;



my %Data;
open IN,"easy_input_expr.csv" or die $!;
open OUT,">new_easy_input_expr.csv" or die $!;
my $header = <IN>;
while (my $line = <IN>){
	chomp($line);
	$line =~ s/\r//g;
	my @all = split/\t/,$line;
	my $gene = shift @all;
	$Data{$gene}{'count'} += 1;
	#$Data{$gene}{'data'} = ;
	if ($Data{$gene}{'count'} > 1){
		@{$Data{$gene}{'data'}} = map{${$Data{$gene}{'data'}}[$_]+$all[$_]}0..$#all;
	}else{
		$Data{$gene}{'data'} = [@all];
	}
}
close IN;


print OUT $header;
for my $i(keys %Data){
	@{$Data{$i}{'data'}} = map{${$Data{$i}{'data'}}[$_]/$Data{$i}{'count'}}0..$#{$Data{$i}{'data'}};
	my $new_line = join("\t",$i,@{$Data{$i}{'data'}});
	print OUT $new_line."\n";
}
close OUT;


