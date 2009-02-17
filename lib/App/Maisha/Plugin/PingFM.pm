package App::Maisha::Plugin::PingFM;

use strict;
use warnings;

our $VERSION = '0.02';

#----------------------------------------------------------------------------
# Library Modules

use base qw(App::Maisha::Plugin::Base);
use base qw(Class::Accessor::Fast);
use Net::PingFM;

#----------------------------------------------------------------------------
# Accessors

__PACKAGE__->mk_accessors($_) for qw(api);

#----------------------------------------------------------------------------
# Public API

sub login {
    my ($self,$user,$pass) = @_;
    my $api = Net::PingFM->new(
        user_key    => $user,
        api_key     => $pass,
        source      => $self->{source},
        useragent   => $self->{useragent},
        clientname  => $self->{clientname},
        clientver   => $self->{clientver},
        clienturl   => $self->{clienturl}
    );

    return 0    unless($api);

    $self->api($api);
    return 1;
}

sub api_update
{
    my $self = shift;
    my $text = join(' ',@_);
    $self->api->post($text, {post_method => 'status'});
}

1;

__END__

=head1 NAME

App::Maisha::Plugin::PingFM - Maisha interface to ping.fm

=head1 SYNOPSIS

   maisha
   maisha> use PingFM
   use ok

=head1 DESCRIPTION

App::Maisha::Plugin::PingFM is the gateway for Maisha to access the ping.fm
API.

=head1 METHODS

=head2 Constructor

=over 4

=item * new

=back

=head2 Process Methods

=over 4

=item * login

Login to the service.

=back

=head2 API Methods

The API methods are used to interface to with the ping.fm API.

=over 4

=item * api_update

=back

ping.fm provides a default service to post to othjer services, thus in this
instance only the update method is available.

=head1 BUGS, PATCHES & FIXES

There are no known bugs at the time of this release. However, if you spot a
bug or are experiencing difficulties that are not explained within the POD
documentation, please submit a bug to the RT system (see link below). However,
it would help greatly if you are able to pinpoint problems or even supply a
patch.

Fixes are dependant upon their severity and my availablity. Should a fix not
be forthcoming, please feel free to (politely) remind me by sending an email
to barbie@cpan.org .

RT: http://rt.cpan.org/Public/Dist/Display.html?Name=App-Maisha-Plugin-PingFM

=head1 SEE ALSO

For further information regarding the commands and configuration, please see
the 'maisha' script included with this distribution.

L<App::Maisha> - http://maisha.grango.org

L<Net::PingFM>

=head1 THANKS TO

Robert Rothenberg for giving me the idea to write this plugin in the first
place.

=head1 AUTHOR

  Copyright (c) 2009 Barbie <barbie@cpan.org> Miss Barbell Productions.

=head1 LICENSE

  This program is free software; you can redistribute it and/or modify it
  under the same terms as Perl itself.

  See http://www.perl.com/perl/misc/Artistic.html

=cut
