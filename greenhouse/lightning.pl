#!/bin/env perl

use strict;
use Data::Dumper;

my $tmp_file = '/tmp/weather.html';

eval {
	system ("curl http://tubo.fce.vutbr.cz/new/meteoPanel.asp > $tmp_file");

	my $file = $tmp_file;
	open(FILE, $file);
	my @raw_data=<FILE>;
	my $string_data;
	for (@raw_data) {
    	chomp;
    	$string_data .= $_ . " ";
	}
	#print $string_data;	
	
	
	$string_data =~ s/.*\<BR\>\<B\>(\d+)\sW\/m\<SUP\>2\<\/SUP\>.*/$1/mg;	
	print $string_data;	
}; 
warn $@ if $@;


1;