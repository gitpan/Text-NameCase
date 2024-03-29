#!/usr/bin/perl -w

=pod

Test script for Text::NameCase.pm

Copyright (c) Mark Summerfield 1998/9. All Rights Reserved. This program is
free software; you can redistribute it and/or modify it under the GPL. 

=cut

require 5.004 ;

use strict ;
use integer ;

use Text::NameCase qw( NameCase nc ) ;

my $debugging = 0 ;

# Set up data for the tests.
my @proper_names = (
    "Keith",            "Leigh-Williams",       "McCarthy",
    "O'Callaghan",      "St. John",             "von Streit",
    "van Dyke",         "ap Llwyd Dafydd",      
    "al Fayd", 
    "el Grecco",        #"ben Gurion", # Can't use -- could be Ben as in Benjamin.
    "da Vinci",
    "di Caprio",        "du Pont",              "de Legate",
    "del Crond",        "der Sind",             "van der Post",
    "von Trapp",        "la Poisson",           "le Figaro",
    "Mack Knife",       "Dougal MacDonald",
    # Mac exceptions
    "Machin",           "Machlin",              "Machar",
    "Mackle",           "Macklin",              "Mackie",
    "Macquarie",        "Machado",              "Macevicius",
    "Maciulis",         "Macias",               "MacMurdo",
 
) ;

# Set up some module globals.
my @uppercase_names = map { uc } @proper_names ;
my @names = @uppercase_names ;
my @result ;
my $name ;
my $fixed_name ;

my $i = 1 ;

$" = ", " ;

print "1..21\n" ;

# Print the original.
print "\tOriginal:\n@uppercase_names.\n" if $debugging ;

# Test an array without changing the array's contents; print the first result.
@result = NameCase( @names ) ;
print "\tResult:\n@result.\n" if $debugging ;
print "\nArray assignment with source array passed by copy..." 
if $debugging ;
print "" . ( &eq_array( \@names, \@uppercase_names ) ? "ok" : "not ok\a" ) 
if $debugging ;
print "" . ( &eq_array( \@names, \@uppercase_names ) ? "ok $i\n" : "not ok $i\n" ) ; $i++ ;
print ". Fixed..." 
if $debugging ;
print "" . ( &eq_array( \@result, \@proper_names ) ? "ok\n" : "not ok\a\n" ) 
if $debugging ;
print "" . ( &eq_array( \@result, \@proper_names ) ? "ok $i\n" : "not ok $i\n" ) ; $i++ ;

# Test an array without changing the array's contents;
# but pass the array by reference.
@result = () ;
@result = NameCase( \@names ) ;
print "Array assignment with source array passed by reference..." 
if $debugging ;
print "" . ( &eq_array( \@names, \@uppercase_names ) ? "ok" : "not ok\a" ) 
if $debugging ;
print "" . ( &eq_array( \@names, \@uppercase_names ) ? "ok $i\n" : "not ok $i\n" ) ; $i++ ;
print ". Fixed..." 
if $debugging ;
print "" . ( &eq_array( \@result, \@proper_names ) ? "ok\n" : "not ok\a\n" ) 
if $debugging ;
print "" . ( &eq_array( \@result, \@proper_names ) ? "ok $i\n" : "not ok $i\n" ) ; $i++ ;

# Test an array in-place.
NameCase( \@names ) ;
print "In-place with source array passed by reference...ok. Fixed..." 
if $debugging ;
print "" . ( &eq_array( \@names, \@proper_names ) ? "ok\n" : "not ok\a\n" ) 
if $debugging ;
print "" . ( &eq_array( \@names, \@proper_names ) ? "ok $i\n" : "not ok $i\n" ) ; $i++ ;

# Test a scalar in-place.
$name = $uppercase_names[1] ;
NameCase( \$name ) ;
print "In-place scalar (null operation)..." 
if $debugging ;
print "" . ( $name eq $uppercase_names[1] ? "ok\n" : "not ok\a\n" ) 
if $debugging ;
print "" . ( $name eq $uppercase_names[1] ? "ok $i\n" : "not ok $i\n" ) ; $i++ ;

# Test a scalar.
$name = $uppercase_names[1] ;
$fixed_name = NameCase( $name ) ;
print "Scalar..." 
if $debugging ;
print "" . ( $fixed_name eq $proper_names[1] ? "ok\n" : "not ok\a\n" ) 
if $debugging ;
print "" . ( $fixed_name eq $proper_names[1] ? "ok $i\n" : "not ok $i\n" ) ; $i++ ;

# Test a literal scalar.
$fixed_name = NameCase( "john mcvey" ) ;
print "Literal scalar..." 
if $debugging ;
print "" . ( $fixed_name eq "John McVey" ? "ok\n" : "not ok\a\n" ) 
if $debugging ;
print "" . ( $fixed_name eq "John McVey" ? "ok $i\n" : "not ok $i\n" ) ; $i++ ;

# Test a literal array.
@result = NameCase( "nancy", "drew" ) ;
print "Literal array..." 
if $debugging ;
print "" . ( &eq_array( \@result, [ "Nancy", "Drew" ] ) ? "ok\n" : "not ok\a\n" ) 
if $debugging ;
print "" . ( &eq_array( \@result, [ "Nancy", "Drew" ] ) ? "ok $i\n" : "not ok $i\n" ) ; $i++ ;

# Test a scalar.
$name = $uppercase_names[1] ;
$fixed_name = nc $name ;
print "Scalar as list operator..." 
if $debugging ;
print "" . ( $fixed_name eq $proper_names[1] ? "ok\n" : "not ok\a\n" ) 
if $debugging ;
print "" . ( $fixed_name eq $proper_names[1] ? "ok $i\n" : "not ok $i\n" ) ; $i++ ;

# Test a literal scalar.
$fixed_name = nc "john mcvey" ;
print "Literal scalar as list operator..." 
if $debugging ;
print "" . ( $fixed_name eq "John McVey" ? "ok\n" : "not ok\a\n" ) 
if $debugging ;
print "" . ( $fixed_name eq "John McVey" ? "ok $i\n" : "not ok $i\n" ) ; $i++ ;

# Test a reference to a scalar.
$name = $uppercase_names[1] ;
$fixed_name = nc( \$name ) ;
print "Reference to a scalar using nc..." 
if $debugging ;
print "" . ( $name eq $uppercase_names[1] ? "ok" : "not ok\a" ) 
if $debugging ;
print "" . ( $name eq $uppercase_names[1] ? "ok $i\n" : "not ok $i\n" ) ; $i++ ;
print ". Fixed..." 
if $debugging ;
print "" . ( $fixed_name eq $proper_names[1] ? "ok\n" : "not ok\a\n" ) 
if $debugging ;
print "" . ( $fixed_name eq $proper_names[1] ? "ok $i\n" : "not ok $i\n" ) ; $i++ ;

# Test a scalar in an array context.
$name = $uppercase_names[1] ;
@result = nc $name ;
print "Scalar in a list context using nc..." 
if $debugging ;
print "" . ( $result[0] eq $proper_names[1] ? "ok\n" : "not ok\a\n" ) 
if $debugging ;
print "" . ( $result[0] eq $proper_names[1] ? "ok $i\n" : "not ok $i\n" ) ; $i++ ;

# Test a reference to a scalar in an array context.
$name = $uppercase_names[1] ;
@result = nc \$name ;
print "Reference to a scalar in a list context using nc..." 
if $debugging ;
print "" . ( $name eq $uppercase_names[1] ? "ok" : "not ok\a" ) 
if $debugging ;
print "" . ( $name eq $uppercase_names[1] ? "ok $i\n" : "not ok $i\n" ) ; $i++ ;
print ". Fixed..." 
if $debugging ;
print "" . ( $result[0] eq $proper_names[1] ? "ok\n" : "not ok\a\n" ) 
if $debugging ;
print "" . ( $result[0] eq $proper_names[1] ? "ok $i\n" : "not ok $i\n" ) ; $i++ ;

# Test a reference to a scalar.
$name = $uppercase_names[1] ;
$fixed_name = NameCase( \$name ) ;
print "Reference to a scalar using NameCase..." 
if $debugging ;
print "" . ( $name eq $uppercase_names[1] ? "ok" : "not ok\a" ) 
if $debugging ;
print "" . ( $name eq $uppercase_names[1] ? "ok $i\n" : "not ok $i\n" ) ; $i++ ;
print ". Fixed..." 
if $debugging ;
print "" . ( $fixed_name eq $proper_names[1] ? "ok\n" : "not ok\a\n" ) 
if $debugging ;
print "" . ( $fixed_name eq $proper_names[1] ? "ok $i\n" : "not ok $i\n" ) ; $i++ ;

# Test a scalar in an array context.
$name = $uppercase_names[1] ;
@result = NameCase $name ;
print "Scalar in a list context using NameCase..." 
if $debugging ;
print "" . ( $result[0] eq $proper_names[1] ? "ok\n" : "not ok\a\n" ) 
if $debugging ;
print "" . ( $result[0] eq $proper_names[1] ? "ok $i\n" : "not ok $i\n" ) ; $i++ ;

# Test a reference to a scalar in an array context.
$name = $uppercase_names[1] ;
@result = NameCase \$name ;
print "Reference to a scalar in a list context using NameCase..." 
if $debugging ;
print "" . ( $name eq $uppercase_names[1] ? "ok" : "not ok\a" ) 
if $debugging ;
print "" . ( $name eq $uppercase_names[1] ? "ok $i\n" : "not ok $i\n" ) ; $i++ ;
print ". Fixed..." 
if $debugging ;
print "" . ( $result[0] eq $proper_names[1] ? "ok\n" : "not ok\a\n" ) 
if $debugging ;
print "" . ( $result[0] eq $proper_names[1] ? "ok $i\n" : "not ok $i\n" ) ; $i++ ;


sub eq_array {
    my( $array_ref_A, $array_ref_B ) = @_ ;
    local( $_ ) ;

    # Can't be equal if different lengths.
    return 0 if $#{$array_ref_A} != $#{$array_ref_B} ;

    for ( 0..$#{$array_ref_A} ) {
        # Can't be equal if any element differs.
        return 0 if ${$array_ref_A}[$_] ne ${$array_ref_B}[$_] ;
    }

    1 ; # Must be equal.
}

