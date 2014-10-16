# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl Text-WrapProp.t'

use strict;
use diagnostics;

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More tests => 2;

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

BEGIN { use_ok('Text::WrapProp', qw(wrap_prop), ) };

   my $DEBUG = 0;

   my @width_table = (0.05) x 256;

   my $input = "The quick brown fox jumped over the lazy red log. This is the next sentence.  Supercajafrajalisticexpialadocious 1!.  Super-cajafrajalistic-expialadocious 2!.  Supercajafrajal-isticexpialadocious 3!.  Supercajafrajalisticexpialado-cious 4!. The End.";

   my $output = wrap_prop($input, 1.00, \@width_table);

   ok(length($output) > 0, 'output check');
   if ($DEBUG) {
      print "width_table elements: " . scalar(@width_table) . "\n";
      print $output . "\n";
   }

