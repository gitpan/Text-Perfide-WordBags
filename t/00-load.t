#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'Text::Perfide::WordBags' ) || print "Bail out!
";
}

diag( "Testing Text::Perfide::WPerfide::ordBags $Text::Perfide::WordBags::VERSION, Perl $], $^X" );
