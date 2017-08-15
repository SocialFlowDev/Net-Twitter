package Net::Twitter::Role::API::Media;

use Moose::Role;
use Net::Twitter::API;
use DateTime::Format::Strptime;

with 'Net::Twitter::Role::API::Media::Analytics';
with 'Net::Twitter::Role::API::Media::Library';
with 'Net::Twitter::Role::API::Media::User';

has media_api_url => (
    isa => 'Str',
    is => 'rw',
    default => 'http://api.twitter.com/1.1',
);

after BUILD => sub {
    my $self = shift;

    $self->{media_api_url} =~ s/^http:/https:/ if $self->ssl;
};

base_url = 'media_api_url';
authenticate = 1;

our $DATETIME_PARSER = DateTime::Format::Strptime->new(pattern => '%a %b %d %T %z %Y');
datetime_parser $DATETIME_PARSER;

twitter_api_method get_video_analytics => (
    path => 'media/analytics/video.json',
    method => 'GET',
    params => [qw/media_keys owner_id from_timestamp to_timestamp/],
    required => [qw/media_keys ownder_id/],
    returns => 'HashRef',
    description => <<'',
Returns video analytics metrics including organic stats, top tweet, and playback stats.

);

twitter_api_method get_media_user_features => (
    path => 'media/user/features.json',
    method => 'GET',
    params => [qw/owner_id/],
    required => [qw/owner_id/],
    returns => 'ArrayRef[features]',
    description => <<'',
Media api capabilities allowed for authenticated user.

);

twitter_api_method get_media_library_item => (
    path => 'media/library/get.json',
    method => 'GET',
    params => [qw/owner_id media_key/],
    required => [qw/owner_id media_key/],
    returns => 'HashRef',
    description => <<'',
Returns media library item.

);

twitter_api_method get_media_library_list => (
    path => 'media/library/get.json',
    method => 'GET',
    params => [qw/owner_id media_type offset limit/],
    required => [qw/owner_id offset/],
    returns => 'HashRef',
    description => <<'',
Returns lists of media library items of the specified type.

);

twitter_api_method create_media_library_item => (
    path => 'media/library/add.json',
    method => 'POST',
    params => [qw/owner_id media_id media_type metadata/],
    required => [qw/owner_id media_id media_type metadata/],
    returns => 'HashRef',
    description => <<'',
Creates a media library item of the specified type. Saves the supplied meta data pertaining to the media item.

);

twitter_api_method remove_media_library_item => (
    path => 'media/library/remove.json',
    method => 'POST',
    params => [qw/owner_id media_id/],
    required => [qw/owner_id media_id/],
    description => <<'',
Removes specified media library item and returns a response code of 200 for success and 400 for a bad request.

);

twitter_api_method update_media_monetization_options => (
    path => 'media/monetization/options.json',
    method => 'POST',
    params => [qw/owner_id media_id metadata/],
    required => [qw/owner_id media_id metadata/],
    description => <<'',
Update Amplify Open monetization options for a video. Will update all tweets containing video.

);

1;
