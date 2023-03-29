package Net::Amazon::S3::Operation::Versions::List::Request;

use Moose 0.85;
use MooseX::StrictConstructor 0.16;
use URI::Escape qw(uri_escape_utf8);
extends 'Net::Amazon::S3::Request::Bucket';

with 'Net::Amazon::S3::Request::Role::Query::Param::Versions';
with 'Net::Amazon::S3::Request::Role::Query::Param::Delimiter';
with 'Net::Amazon::S3::Request::Role::Query::Param::Marker';
with 'Net::Amazon::S3::Request::Role::Query::Param::Max_keys';
with 'Net::Amazon::S3::Request::Role::Query::Param::Prefix';
with 'Net::Amazon::S3::Request::Role::HTTP::Method::GET';

__PACKAGE__->meta->make_immutable;

1;

