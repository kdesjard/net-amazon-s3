package Net::Amazon::S3::Constraint::ObjectType;

use Moose::Util::TypeConstraints;

type __PACKAGE__, where { $_ =~ /^(object|version|marker|folder)$/ };

1;

