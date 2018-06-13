#!perl
use warnings;
use strict;
use URI;
use Net::Twitter;
use Net::OAuth::Message;
use Test::More;
use JSON::MaybeXS qw/decode_json/;

plan tests => 1;

# Ensure post args are encoded per the OAuth spec
#
# We assume Net::OAuth does the right thing, here.
#
# Bug reported by Nick Andrew (@elronxenu) 2013-02-27

my $nt = Net::Twitter->new(
    ssl                 => 0,
    traits              => [qw/API::RESTv1_1/],
    consumer_key        => 'mykey',
    consumer_secret     => 'mysecret',
    access_token        => 'mytoken',
    access_token_secret => 'mytokensecret',
);

my $req;
$nt->ua->add_handler(request_send => sub {
    $req = shift;
    my $res = HTTP::Response->new(200, 'OK');
    $res->content('{}');

    return $res;
});

my $text = q[Bob's your !@##$%^&*(){}} uncle!];
$nt->new_direct_message(
    event => {
        type => 'message_create',
        message_create => {
            target => {
                recipient_id => 1564061,
            },
            message_data => {
                text => $text
            },
        }
    },
);

my $content = decode_json($req->content);
my $content_text = $content->{message_create}{message_data}{text};
is $content_text, $text, 'properly encoded and text matches';
