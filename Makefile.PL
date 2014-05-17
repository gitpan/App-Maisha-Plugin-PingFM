#!/usr/bin/perl

use strict;
use warnings;
use 5.006;

use ExtUtils::MakeMaker;

WriteMakefile(
    AUTHOR              => 'Barbie <barbie@cpan.org>',
    NAME                => 'App-Maisha-Plugin-PingFM',
    VERSION_FROM        => 'lib/App/Maisha/Plugin/PingFM.pm',
    ABSTRACT            => 'A Maisha plugin for ping.fm',
    NO_META             => 1,

    PREREQ_PM           => {

        # prereqs
        'App::Maisha'           => '0.06',
        'Class::Accessor::Fast' => '0',
        'Net::PingFM'           => '0',

        # build/test prereqs
        'IO::File'              => '0',
        'Test::More'            => '0.70'

    },
);
