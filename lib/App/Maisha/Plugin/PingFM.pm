package App::Maisha::Plugin::PingFM;

use strict;
use warnings;

our $VERSION = '0.05';

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
    my $api;

    eval {
        $api = Net::PingFM->new(
            user_key    => $user,
            api_key     => $pass,
            source      => $self->{source},
            useragent   => $self->{useragent},
            clientname  => $self->{clientname},
            clientver   => $self->{clientver},
            clienturl   => $self->{clienturl}
        );
    };

    unless($api) {
        warn "Unable to establish connection to PingFM API\n";
        return 0;
    }

    $self->api($api);
    return 1;
}

sub api_update {
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

Fixes are dependent upon their severity and my availability. Should a fix not
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

  Barbie, <barbie@cpan.org>
  for Miss Barbell Productions <http://www.missbarbell.co.uk>.

=head1 COPYRIGHT AND LICENSE

  Copyright (C) 2009-2014 by Barbie

  This distribution is free software; you can redistribute it and/or
  modify it under the Artistic License v2.

=cut
