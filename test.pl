# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

######################### We start with some black magic to print on failure.

# Change 1..1 below to 1..last_test_to_print .
# (It may become useful if the test is moved to ./t subdirectory.)

BEGIN { $| = 1; print "1..1\n"; }
END {print "not ok 1\n" unless $loaded;}
use Text::WrapProp;
$loaded = 1;
print "ok 1\n";

######################### End of black magic.

use strict;
use diagnostics;

my $DEBUG = 0;

   my @width_table = (0.05) x 256;

   my $text = wrap_prop(
"The quick brown fox jumped over the lazy red log. This is the next sentence.  Supercajafrajalisticexpialadocious 1!.  Super-cajafrajalistic-expialadocious 2!.  Supercajafrajal-isticexpialadocious 3!.  Supercajafrajalisticexpialado-cious 4!. The End.",
1.00,
\@width_table);

   print $text if $DEBUG;
__END__
