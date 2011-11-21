use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Text::Perfide::WordBags',
    license             => 'perl',
    dist_author         => q{Andre Santos <andrefs@cpan.org>},
    dist_version_from   => 'lib/Text/Perfide/WordBags.pm',
    build_requires => {
        'Test::More' => 0,
        'Module::Build' => 0,
    },
    add_to_cleanup      => [ 'Text-Perfide-WordBags-*' ],
    create_makefile_pl => 'traditional',
);

$builder->create_build_script();
