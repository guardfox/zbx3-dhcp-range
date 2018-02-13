#!/usr/bin/perl -w
use strict;
use warnings;
my $ip_to_check = $ARGV[0];
my $range = $ARGV[1];

my @range_val = split('-', $range);

my $start  =$range_val[0];
my $finish = $range_val[1];

#print "IP   => $ip_to_check \n";
#print "Start => $start \n";
#print "End   => $finish \n";


my $dword       = 0;
for ( split( '\.', $ip_to_check ) ) { $dword *= 256; $dword += $_ }
    my $start_dword = 0;
    for ( split '\.', $start ) { $start_dword *= 256; $start_dword += $_ }
    my $end_dword = 0;
    for ( split '\.', $finish ) { $end_dword *= 256; $end_dword += $_ }

#print "Dword => $dword \n";
#print "Start Dword => $start_dword \n";
#print "End Dword => $end_dword";


if ( $dword >= $start_dword and $dword <= $end_dword ) {
    print "1 \n";
    exit 0;	
}
else { print "0 \n";
exit 1;
}

