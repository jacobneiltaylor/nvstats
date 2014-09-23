package stringManip;
use strict;
use Exporter;

=pod
=head1 NAME

Simple String Manipulation Library

=head1 DESCRIPTION

A library of functions for handling strings.

=head2 Functions

=item right
Returns everything right of a position in a string.

Argument 1: The string
Argument 2: The position

=item left
Returns everything left of a position in a string.

Argument 1: The string
Argument 2: The position

=item right
Returns everything between 2 positions in a string.

Argument 1: The string
Argument 2: The left-most position
Argument 3: The right-most position

=item at
Returns the char at a position in a string.

Argument 1: The string
Argument 2: The position

=cut

our @ISA= qw( Exporter );

our @EXPORT_OK = qw( right left middle at );

our @EXPORT = qw( right left middle at );

our $VERSION = 1.0;

sub right
{
	return substr($_[0], $_[1]+1);
}

sub left
{
	return substr($_[0], 0, $_[1]);
}

sub middle
{
	return substr($_[0], $_[1], $_[2]-$_[1]);
}

sub at
{
	return substr($_[0], $_[1]-1, 1)
}
