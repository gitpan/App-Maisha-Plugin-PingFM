#!/usr/bin/perl -w
use strict;

use Test::More tests => 5;
use App::Maisha::Plugin::PingFM;

my $nomock;
my ($mock,$mock2);

BEGIN {
	eval "use Test::MockObject";
    $nomock = $@;

    unless($nomock) {
        $mock = Test::MockObject->new();
        $mock->fake_module( 'Net::Twitter', 'update' => sub  { return 1; },  get_authorization_url => sub { return 'http://127.0.0.1' } );
        $mock->fake_new( 'Net::Twitter' );

        $mock->set_true(qw(
            update
            show_user
            user_timeline
            following_timeline
            public_timeline
            replies
            new_direct_message
            direct_messages
            sent_direct_messages
            create_friend
            destroy_friend
            following

            access_token
            access_token_secret
            get_authorization_url
            request_access_token
        ));

        $mock->set_list('friends',   ());
        $mock->set_list('followers', ());

        $mock2 = Test::MockObject->new();
        $mock2->fake_module( 'Net::PingFM', 'update' => sub  { return 1; },  get_authorization_url => sub { return 'http://127.0.0.1' } );
        $mock2->fake_new( 'Net::PingFM' );

        $mock2->set_true(qw(
            post
        ));
    }
}


SKIP: {
	skip "Test::MockObject required for plugin testing\n", 29   if($nomock);

    ok( my $obj = App::Maisha::Plugin::PingFM->new(), "got object" );
    isa_ok($obj,'App::Maisha::Plugin::PingFM');

    my $ret = $obj->login({ username => 'test', home => '.', test => 1 });
    is($ret, 1, '.. login done');

    my $api = $obj->api();

    for my $k ( qw/
        update
    / ){
      for my $m (qw(api)) {
        my $j = "${m}_$k";
        my $label = "[$j]";
        SKIP: {
          ok( $obj->can($j), "$label can" ) or skip "'$j' method missing", 2;
          isnt($obj->$j(), undef, "$label returns nothing" );
        }
      }
    }
}
