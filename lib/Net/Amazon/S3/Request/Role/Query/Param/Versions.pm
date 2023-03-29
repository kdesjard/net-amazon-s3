package Net::Amazon::S3::Request::Role::Query::Param::Versions;
# ABSTRACT: delimiter query param role

use Moose::Role;

with 'Net::Amazon::S3::Request::Role::Query::Param' => {
	param => 'versions',
	constraint => 'Maybe[Str]',
	default => '',
};

1;

