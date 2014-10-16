#!/usr/bin/perl

   use strict;
   use diagnostics;

   use Text::WrapProp qw(wrap_prop);

   my @width_table = (0.05) x 256;

   print wrap_prop("This is a bit of text that forms a normal book-style paragraph. Supercajafrajalisticexpialadocious!", 4.00, \@width_table);

