#!/usr/bin/perl

use strict;
use Data::Dumper;

my $tmp_file = '/tmp/weather.html';

sub download_data {
	my $string_data;
	eval {
		system ("curl http://tubo.fce.vutbr.cz/new/meteoPanel.asp > $tmp_file");
	
		my $file = $tmp_file;
		open(FILE, $file);
		my @raw_data=<FILE>;
		for (@raw_data) {
	    	chomp;
	    	$string_data .= $_ . " ";
		}
		#print $string_data;	
		
		
		$string_data =~ s/.*\<BR\>\<B\>(\d+)\sW\/m\<SUP\>2\<\/SUP\>.*/$1/mg;	
		return $string_data;	
	}; 
	
	if ($@){
		warn $@ if $@;
		return -1;			
	}
	return $string_data;
}

sub switch_on {
	print "switching on: " . `date` . "\n";
	system ('echo "23" > /sys/class/gpio/export; echo "out" > /sys/class/gpio/gpio23/direction');
}

sub switch_off {
	print "switching off: " . `date` . "\n";
	system ('echo "in" > /sys/class/gpio/gpio23/direction; echo "23" > /sys/class/gpio/unexport');
}

sub local_hour {
	my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
	return $hour;
}

sub check_sun {
	my $watts = download_data();
	print "data: $watts\n";
	if ($watts == -1){
		die "No value downloaded. Keeping in current state";
	}
	print ("localhour: ".local_hour() . "\n");
	if ($watts >= 200 or local_hour() >= 21){
		switch_off();
	} elsif ($watts < 200 and local_hour() >= 6) {
		switch_on();
	}		
}

check_sun();
1;