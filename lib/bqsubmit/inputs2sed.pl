#!/usr/bin/perl
###############################################################################
# Batch Queuing Tools (bqTools) 
#
# Copyright (C) 2018  Minh-Nghia Nguyen <Minh-Nghia.Nguyen@CalculQuebec.ca>
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
###############################################################################
use strict;

###############################################################################
# Utility to create sed script file from key-value pairs file
###############################################################################
main();

sub main {
    my %keyValue;
    my @keysList = ();
    my @valuesList = ();

    while (<STDIN>) {
        s/\//\\\//g;   
        
        if (/^#/) {
            next;
        }
        elsif (/^param(\d+)\s*=\s*(\S+)\s*=\s*(.+)/) {
            $keyValue{$1}{$2} = "$3";
        }
        elsif (/(\w+)Files\s*=\s*(.+)/) {
            my @files = split(/,/, $2);
            printf "s/~~%sFiles~~/%s/g\n", $1, "@files";
        }
        elsif (/(\w+)Files\s*=\s*\"+\s*(.+)\"+\s*/) {
            my @files = split(/,/, $2);
            printf "s/~~%sFiles~~/%s/g\n", $1, "@files";
        }
        elsif (/^(\w+)\s*=\s*\"+\s*(.+)\"+\s*$/) {
            printf "s/~~%s~~/%s/g\n", $1, $2;
        }
        elsif (/^(\w+)\s*=\s*(.+)$/) {
            printf "s/~~%s~~/%s/g\n", $1, $2;
        }
	    elsif (/^(\w+)\s*=\s+$/) {
	        printf "s/~~%s~~//g\n", $1;
    	}			
    }

    foreach my $a (sort keys %keyValue) {
        foreach my $b (sort keys $keyValue{$a}) {
            push @keysList, $b;          
            push @valuesList, "::: " . $keyValue{$a}{$b}; 
        }      
    }

    printf "s/~~%s~~/%s/g\n", "keysList",   "@keysList";
    printf "s/~~%s~~/%s/g\n", "valuesList", "@valuesList";
}
