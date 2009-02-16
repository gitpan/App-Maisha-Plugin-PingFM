use ExtUtils::MakeMaker;
WriteMakefile(
    NAME                => 'App::Maisha::Plugin::PingFM',
    VERSION_FROM        => 'lib/App/Maisha/Plugin/PingFM.pm',
    PREREQ_PM           => {
        'App::Maisha'           => '0.06',
        'Class::Accessor::Fast' => '0',
        'Net::PingFM'           => '0',

        'Test::More'            => '0.47',  # testing only
    },
    NO_META             => 1,

    ($] >= 5.005 ?
        (ABSTRACT       => 'A Maisha plugin for ping.fm',
         AUTHOR         => 'Barbie <barbie@cpan.org>') : ()),
);
