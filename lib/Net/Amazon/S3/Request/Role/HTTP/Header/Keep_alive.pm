package Net::Amazon::S3::Request::Role::HTTP::Header::Keep_alive;
# ABSTRACT: Content-Type header role

use MooseX::Role::Parameterized;

parameter keep_alive_header => (
	is => 'ro',
	isa => 'Str',
	required => 1,
);

role {
	my ($params) = @_;
	my $keep_alive = $params->keep_alive_header;

	around _request_headers => sub {
		my ($inner, $self) = @_;

		return ($self->$inner, ('Keep-Alive' => $keep_alive_header));
	};
};

1;

