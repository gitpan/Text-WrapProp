package Text::WrapProp;

use strict;
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK);

require Exporter;

@ISA = qw(Exporter AutoLoader);
# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

@EXPORT_OK = qw( wrap_prop );
@EXPORT = qw();

$VERSION = '0.04';

1;

sub wrap_prop {
   my ($text, $width, $ref_width_table) = @_;

   my @width_table = @{$ref_width_table};

   return '' if $text eq '';

   # simplify whitespace, including newlines
   $text =~ s/\s+/ /gs;

   my $cursor = 0; # width so far of line
   my $c;          # current character
   my $out;        # output buffer
   my $nextline = '';

   my $i=0;

   my $ltext = length $text;

# In 1998, regex scanning, but 50% slower than C-style char processing. eg. while ($text =~ /(.)/gcs) {
# In 2014, they're equally fast. See eg/NOTES.

   while ($i < $ltext) {
         # pop off next character
         $c    = substr($text,$i++,1);
         
         # don't need leading spaces at start of line
         next if $nextline eq '' and $c eq ' ';

         # see if character will fit on line - but don't include if too long
         if ($cursor + $width_table[ord $c] <= $width) {
            # another character fits
            $nextline .= $c;
            $cursor += $width_table[ord $c];
         }
         else {
            # find where we can wrap by checking backwards for separator
            my $j = length($nextline);
            foreach (split '', reverse $nextline) { # find separator
               $j--;
               last if /( |:|;|,|\.|-|\(|\)|\/)/o; # separator characters
            }

            # see if no separator found
            if (!$j) { # no separator, so just truncate line right here
               $i--; # rerun on $c
               $out .= $nextline."\n";
            }
            # 
            else { # separator found, so break line at separator
               $i -= length($nextline) - $j; # rerun characters after separator
               $out .= substr($nextline, 0, $j+1)."\n";
            }

            $nextline = '';
            $cursor = 0;
         }
   }

   $out.$nextline;
}

__END__

=head1 NAME

Text::WrapProp - proportional line wrapping to form simple paragraphs

=head1 SYNOPSIS 

	use Text::WrapProp qw(wrap_prop);

	print wrap_prop($text, $width, $ref_width_table);

=head1 DESCRIPTION

Text::WrapProp::wrap_prop() is a very simple paragraph formatter
for proportional text. It formats a
single paragraph at a time by breaking lines at word boundries.
You must supply the column width in floating point units which should
be set to the full width of your output device. A reference to a
character width table must also be supplied. The width units
can be any metric you choose, as long as the column width and
the width table use the same metric.

Proportional wrapping is most commonly used in the publishing
industry. In the HTML age, custom proportional wrapping is less often
performed as the browser performs the calculations automatically.

=head1 EXAMPLE

	use strict;
	use diagnostics;
	
	use Text::WrapProp qw(wrap_prop);

	my @width_table = 0.05 x 256;
	print wrap_prop("This is a bit of text that forms a normal book-style paragraph. Supercajafrajalisticexpialadocious!", 4.00, \@width_table);

=head1 BUGS

It's not clear what the correct behavior should be when WrapProp() is
presented with a word that is longer than a line.  The previous 
behavior was to die.  Now the word is split at line-length.

=head1 AUTHOR

James Briggs <james.briggs@yahoo.com>. Styled after Text::Wrap.

=cut
