package Net::Amazon::S3::Request::Role::HTTP::Header::Connection;
# ABSTRACT: Content-Type header role

use MooseX::Role::Parameterized;

parameter connection => (
	is => 'ro',
	isa => 'Str',
	required => 1,
);

role {
	my ($params) = @_;
	my $connection = $params->connection;

	around _request_headers => sub {
		my ($inner, $self) = @_;

		return ($self->$inner, ('Connection' => $connection));
	};
};

1;

