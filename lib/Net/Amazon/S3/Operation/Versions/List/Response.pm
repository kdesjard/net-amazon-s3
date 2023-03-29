package Net::Amazon::S3::Operation::Versions::List::Response;

use Moose;
use Data::Dumper;

extends 'Net::Amazon::S3::Response';

sub bucket {
	$_[0]->_data->{bucket};
}

sub prefix {
	$_[0]->_data->{prefix};
}

sub marker {
	$_[0]->_data->{marker};
}

sub next_marker {
	$_[0]->_data->{next_marker};
}

sub max_keys {
	$_[0]->_data->{max_keys};
}

sub is_truncated {
	$_[0]->_data->{is_truncated};
}

sub versions {
	@{ $_[0]->_data->{versions} };
}

sub common_prefixes {
	@{ $_[0]->_data->{common_prefixes} };
}

sub delete_markers {
	@{ $_[0]->_data->{delete_markers} };
}

sub _parse_data {
	my ($self) = @_;

	my $xpc = $self->xpath_context;

	my $data = {
		bucket            => scalar $xpc->findvalue ("/s3:ListVersionsResult/s3:Name"),
		prefix            => scalar $xpc->findvalue ("/s3:ListVersionsResult/s3:Prefix"),
		key_marker        => scalar $xpc->findvalue ("/s3:ListVersionsResult/s3:KeyMarker"),
		version_id_marker => scalar $xpc->findvalue ("/s3:ListVersionsResult/s3:VersionIdMarker"),
		max_keys          => scalar $xpc->findvalue ("/s3:ListVersionsResult/s3:MaxKeys"),
		is_truncated      => scalar $xpc->findvalue ("/s3:ListVersionsResult/s3:IsTruncated") eq 'true',
		versions          => [],
		delete_markers    => [],
		common_prefixes   => [],
	};

	for my $content ($xpc->findnodes ("/s3:ListVersionsResult/s3:Version")) {
		push @{ $data->{versions} }, {
			key             => scalar $xpc->findvalue ("./s3:Key",          $content),
			version_id      => scalar $xpc->findvalue ("./s3:VersionId",    $content),
			is_latest       => scalar $xpc->findvalue ("./s3:IsLatest",     $content),
			last_modified   => scalar $xpc->findvalue ("./s3:LastModified", $content),
			etag            => scalar $xpc->findvalue ("./s3:ETag",         $content),
			size            => scalar $xpc->findvalue ("./s3:Size",         $content),
			storage_class   => scalar $xpc->findvalue ("./s3:StorageClass", $content),
			owner => {
				id          => $xpc->findvalue ("./s3:Owner/s3:ID",           $content),
				displayname => $xpc->findvalue ("./s3:Owner/s3:DisplayName",  $content),
			},
		};
		$data->{versions}[-1]{etag} =~ s/^"|"$//g;
	}

	for my $content ($xpc->findnodes ("/s3:ListVersionsResult/s3:DeleteMarker")) {
		push @{ $data->{delete_markers} }, {
			key             => scalar $xpc->findvalue ("./s3:Key",          $content),
			version_id      => scalar $xpc->findvalue ("./s3:VersionId",    $content),
			is_latest       => scalar $xpc->findvalue ("./s3:IsLatest",     $content),
			last_modified   => scalar $xpc->findvalue ("./s3:LastModified", $content),
			owner => {
				id          => $xpc->findvalue ("./s3:Owner/s3:ID",           $content),
				displayname => $xpc->findvalue ("./s3:Owner/s3:DisplayName",  $content),
			},
		};
	}

	for my $delimiter ($xpc->findnodes ("/s3:ListVersionsResult/s3:Delimiter")) {
		$data->{delimiter} = $xpc->findvalue ('.', $delimiter);
	}

	if (defined $data->{delimiter}) {
		my $strip_delim = length $data->{delimiter};

		for my $common_prefix ($xpc->findnodes ("/s3:ListVersionsResult/s3:CommonPrefixes")) {
			my $prefix = $xpc->findvalue ('./s3:Prefix', $common_prefix);
			$prefix = substr $prefix, 0, -$strip_delim;
			push @{ $data->{common_prefixes} }, $prefix;
		}
	}
	return $data;
}

1;

__END__

=head1 DESCRIPTION

Implements operation L<< ListObjects|https://docs.aws.amazon.com/AmazonS3/latest/API/API_ListObjects.html >>.
