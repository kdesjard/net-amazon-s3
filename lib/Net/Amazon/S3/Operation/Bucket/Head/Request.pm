package Net::Amazon::S3::Operation::Bucket::Head::Request;
# ABSTRACT: An internal class to handle HeadBucket request

use Moose 0.85;
use MooseX::StrictConstructor 0.16;

extends 'Net::Amazon::S3::Request::Bucket';

with 'Net::Amazon::S3::Request::Role::HTTP::Method::HEAD';

__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 DESCRIPTION

Implements operation L<< HeadBucket|https://docs.aws.amazon.com/AmazonS3/latest/API/API_HeadBucket.html >>.

=head1 COPYRIGHT AND LICENSE

This module is part of L<Net::Amazon::S3> distribution.

=cut

