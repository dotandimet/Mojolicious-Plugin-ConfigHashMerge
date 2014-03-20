use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  NAME         => 'Mojolicious::Plugin::ConfigHashMerge',
  VERSION_FROM => 'lib/Mojolicious/Plugin/ConfigHashMerge.pm',
  AUTHOR       => 'A Good Programmer <nospam@cpan.org>',
  PREREQ_PM    => {'Mojolicious' => '4.85', 'Hash::Merge::Simple' => '0.051' },
  test         => {TESTS => 't/*.t'}
);
