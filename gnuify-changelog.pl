#!/usr/bin/perl -w

# a script to munge the output of 'svn log' into something approaching the
# style of a GNU ChangeLog.
#
# to use this, just fill in the 'hackers' hash with the usernames and
# name/emails of the people who work on your project, go to the top level
# of your working copy, and run:
#
# $ svn log | /path/to/gnuify-changelog.pl > ChangeLog

require 5.0;
use strict;

my %hackers = (
	       "romary" => 'Laurent Romary <laurent.romary@inria.fr>',
	       "kshawkin" => 'Kevin Hawkins <kevin.s.hawkins@ultraslavonic.info>',
	       "rahtz"           => 'Sebastian Rahtz <sebastian.rahtz@gmail.com>',
	       "louBurnard"      => 'Lou Burnard <lou.burnard@retired.ox.ac.uk>',
	       "louburnard"      => 'Lou Burnard <lou.burnard@retired.ox.ac.uk>',
	       "sbauman"         => 'Syd Bauman  <sbauman@brown.edu>',
	       "mlforcada"       => 'Mikel L. Forcada <mlf@ua.es>',
	       "dsew"            => 'David Sewell <dsewell@virginia.edu>',
	       "ge8"             => 'J-L Benoit <jean-luc.benoit@atilf.fr>',
	       "bansp" => "Piotr Bański <bansp\@o2.pl>",
	       "brettbarney" => "Brett Barney <bbarney2\@unlnotes.unl.edu>",
	       "dpod" => "Daniel O'Donnell <daniel.odonnell\@uleth.ca>",
	       "gabrielbodard" => "Gabriel Bodard <gabriel.bodard\@kcl.ac.uk>",
	       "jcummings" => "James Cummings <james.cummings\@oucs.ox.ac.uk>",
	       "martindholmes" => "Martin Holmes <mholmes\@uvic.ca>",
	       "stuartyeates" => "Stuart Yeates <syeates\@gmail.com>",
	       "trolard" => "Perry Trolard <ptrolard\@gmail.com>",
);

my $parse_next_line = 0;
my $last_line_empty = 0;
my $last_rev = "";

while (my $entry = <>) {

  # Axe windows style line endings, since we should try to be consistent, and
  # the repos has both styles in its log entries
  $entry =~ s/\r\n$/\n/;

  # Remove trailing whitespace
  $entry =~ s/\s+$/\n/;

  my $this_line_empty = $entry eq "\n";

  # Avoid duplicate empty lines
  next if $this_line_empty and $last_line_empty;

  # Don't fail on valid dash-only lines
  if ($entry =~ /^-+$/ and length($entry) >= 72) {

    # We're at the start of a log entry, so we need to parse the next line
    $parse_next_line = 1;

    # Check to see if the final line of the commit message was blank,
    # if not insert one
    print "\n" if $last_rev ne "" and !$last_line_empty;

  } elsif ($parse_next_line) {

    # Transform from svn style to GNU style
    $parse_next_line = 0;

    my @parts = split (/ /, $entry);
    $last_rev  = $parts[0];
    my $hacker = $parts[2];
    my $tstamp = $parts[4];

    # Use alias if we can't resolve to name, email
    $hacker = $hackers{$hacker} if defined $hackers{$hacker};

    printf "%s  %s\n", $tstamp, $hacker;

  } elsif ($this_line_empty) {

    print "\n";

  } else {

    print "\t$entry";

  }

  $last_line_empty = $this_line_empty;
}

# As a HERE doc so it also sets the final changelog's coding
print <<LOCAL;
;; Local Variables:
;; coding: utf-8
;; End:
LOCAL

1;
