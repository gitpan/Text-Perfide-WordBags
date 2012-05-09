package Text::Perfide::WordBags;

use warnings;
use strict;
use utf8::all;

use base 'Exporter';
our @EXPORT = (qw/pairability file2bag bagint baguni bagcard/);


=head1 NAME

Text::Perfide::WordBags - Create word bags from text, and operate over them.

=head1 VERSION

Version 0.01_02

=cut

our $VERSION = '0.01_02';

=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use Text::Perfide::WordBags;

    my $foo = Text::Perfide::WordBags->new();
    ...

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 FUNCTIONS

=head2 pairability 
	
	Calculates pairability of two wordbags. Pairibitily value is given by:

		$int/($uni || 1)

	where $int and $uni are the values given by, respectively, the intersection
	and the union of the two bags.

=cut 

sub pairability{
	my ($bag1,$bag2) = @_;
	my $int = bagcard(bagint($bag1,$bag2));
	my $uni = bagcard(baguni($bag1,$bag2));
	return $int/($uni || 1);
}

=head2 file2bag

	Create a word bag from a file.

	Receives as argument a function ref and a file path.

	Reads a file in slurp mode, passes the text to the function passed as argument,
	and returns the result.

=cut

sub file2bag{
	my ($txt2bag_fn,$file) = @_;
	open my $fp,'<:utf8',$file or die "Could not open file '$file'";
	my $text = join '',<$fp>;
	return $txt2bag_fn->($text);
}

# sub txt2bag_pn{ # proper nouns
# 	my $text = shift;
# 
# 	my $upper = {};
# 	my $uppat = qr{\b[A-Z]\w{3,}(?:['-]\w+)*\b};
# 	$upper->{$1}++ while($text =~ /($uppat)/g);
# 
# 	my $lower = {};
# 	my $lwpat = qr{\b[a-z]+(?:['-][a-z]+)*\b};
# 	$lower->{$1}++ while($text =~ /($lwpat)/g);
# 	
# 	foreach my $k (keys %$upper){
# 		if($lower->{lc $k}){
# 			my $ratio = $upper->{$k}/$lower->{lc $k};
# 			delete $upper->{$k} if $ratio < 10;
# 		}
# 	}
# 	return $upper;
# }
# 
# sub txt2bag_num{
# 	my $text = shift;
# 	my $bag = {};
# 	my $pecul = qr{\d+};
# 	$bag->{$1}++ while($text =~ /($pecul)/g);
# 	if(haspn($bag)){
# 		foreach(1..300){
# 			$bag->{$_}-- if $bag->{$_};
# 			delete $bag->{$_} unless $bag->{$_};
# 		}
# 	}
# 	return $bag;
# }

=head2 bagint
	
	Calculates the intersection between two wordbags.
	
=cut

sub bagint {
	my ($bag1,$bag2) = @_;
	my $inters = {};
	foreach(keys %$bag1){
		next unless $bag2->{$_};
		$inters->{$_} = $bag1->{$_} < $bag2->{$_} ? $bag1->{$_} : $bag2->{$_};
	}
	return $inters;
}

=head2 baguni

	Calculates the union of two wordbags.

=cut

sub baguni {
	my ($bag1,$bag2) = @_;
	my $union = {};
	foreach(keys %$bag1){
		no warnings;
		$union->{$_} = $bag1->{$_} > $bag2->{$_} ? $bag1->{$_} : $bag2->{$_};
	}
	foreach(keys %$bag2){
		$union->{$_}//=$bag2->{$_};
	}
	return $union;
}

=head2 bagcard

	Calculates the cardinality of two wordbags.

=cut

sub bagcard {
	my $bag = shift;
	my $soma = 0;
	map { $soma+= $bag->{$_} } keys %$bag;
	return $soma;
}



=head1 AUTHOR

Andre Santos, C<< <andrefs at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-text-wordbags at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Text-WordBags>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2011 Project Natura.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

1; # End of Text::Perfide::WordBags
