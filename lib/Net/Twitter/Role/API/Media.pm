package Net::Twitter::Role::API::Media;

use Moose::Role;
use Net::Twitter::API;
use DateTime::Format::Strptime;
use namespace::autoclean;

base_url 'apiurl';
authenticate 1;

our $DATETIME_PARSER = DateTime::Format::Strptime->new(pattern => '%a %b %d %T %z %Y');
datetime_parser $DATETIME_PARSER;

twitter_api_method get_video_analytics => (
    path => 'media/analytics/video',
    method => 'GET',
    params => [qw/media_keys owner_id from_timestamp to_timestamp/],
    required => [qw/media_keys owner_id/],
    returns => 'HashRef',
    description => <<'',
Returns video analytics metrics including organic stats, top tweet, and playback stats.

);

twitter_api_method get_media_user_features => (
    path => 'media/user/features',
    method => 'GET',
    params => [qw/owner_id/],
    required => [qw/owner_id/],
    description => <<'',
Media api capabilities allowed for authenticated user.

);

twitter_api_method get_media_library_item => (
    path => 'media/library/get',
    method => 'GET',
    params => [qw/owner_id media_key/],
    required => [qw/owner_id media_key/],
    returns => 'HashRef',
    description => <<'',
Returns media library item.

);

twitter_api_method get_media_library_list => (
    path => 'media/library/list',
    method => 'GET',
    params => [qw/owner_id media_type offset limit/],
    required => [qw/owner_id/],
    returns => 'HashRef',
    description => <<'',
Returns lists of media library items of the specified type.

);

twitter_api_method create_media_library_item => (
    path => 'media/library/add',
    method => 'POST',
    params => [qw/owner_id media_id media_type metadata/],
    required => [qw/owner_id media_id media_type metadata/],
    content_type => 'application/json',
    description => <<'',
Creates a media library item of the specified type. Saves the supplied meta data pertaining to the media item.

);

twitter_api_method remove_media_library_item => (
    path => 'media/library/remove',
    method => 'POST',
    params => [qw/owner_id media_key/],
    required => [qw/owner_id media_key/],
    content_type => 'application/json',
    description => <<'',
Removes specified media library item and returns a response code of 200 for success and 400 for a bad request.

);

twitter_api_method get_amplify_programs => (
    path => 'media/monetization/amplify/programs',
    method => 'GET',
    params => [qw/owner_id publisher_id/],
    required => [qw/owner_id publisher_id/],
    returns => 'HashRef',
    description => <<'',
.

);

twitter_api_method get_amplify_program => (
    path => 'media/monetization/amplify/program',
    method => 'GET',
    params => [qw/owner_id program_id/],
    required => [qw/owner_id program_id/],
    returns => 'HashRef',
    description => <<'',
.

);

twitter_api_method get_monetization_categories => (
    path => 'media/monetization/categories',
    method => 'GET',
    params => [qw/owner_id/],
    required => [qw/owner_id/],
    returns => 'HashRef',
    description => <<'',
.

);

twitter_api_method update_media_monetization => (
    path => 'media/monetization/options',
    method => 'POST',
    params => [qw/owner_id media_id metadata/],
    required => [qw/owner_id media_id metadata/],
    content_type => 'application/json',
    description => <<'',
Update Amplify Open monetization options for a video. Will update all tweets containing video.

);

1;

__END__

=head1 NAME

Net::Twitter::Role::API::Media

=head1 SYNOPSIS

  package My::Twitter;
  use Moose;
  with 'Net::Twitter::API::Media';

=head1 DESCRIPTION

This module provides definitions the Twitter Pro Media API methods.
