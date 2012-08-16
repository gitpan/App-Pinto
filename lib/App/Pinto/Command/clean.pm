# ABSTRACT: remove orphaned distribution archives

package App::Pinto::Command::clean;

use strict;
use warnings;

#------------------------------------------------------------------------------

use base 'App::Pinto::Command';

#------------------------------------------------------------------------------

our $VERSION = '0.044'; # VERSION

#-----------------------------------------------------------------------------

1;



=pod

=for :stopwords Jeffrey Thalhammer Imaginative Software Systems

=head1 NAME

App::Pinto::Command::clean - remove orphaned distribution archives

=head1 VERSION

version 0.044

=head1 SYNOPSIS

  pinto --root=REPOSITORY_ROOT clean

=head1 DESCRIPTION

The database for L<Pinto> is transactional, so failures and aborted
commands do not change the indexes.  However, the filesystem where
distribution archives are physically stored is not transactional and
may become cluttered with archives that are not on any stack.

Normally, L<Pinto> tries to clean up those orphaned archives.  But in
some cases it might not.  Running this command will force their
removal.

=head1 COMMAND ARGUMENTS

None.

=head1 COMMAND OPTIONS

None.

=head1 AUTHOR

Jeffrey Thalhammer <jeff@imaginative-software.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Imaginative Software Systems.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__

