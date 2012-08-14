package App::Pinto::Command::pin;

# ABSTRACT: force a package to stay in a stack

use strict;
use warnings;

#------------------------------------------------------------------------------

use base 'App::Pinto::Command';

#------------------------------------------------------------------------------

our $VERSION = '0.043'; # VERSION

#-----------------------------------------------------------------------------

sub opt_spec {
    my ($self, $app) = @_;

    return (
        [ 'dryrun'      => 'Do not commit any changes'        ],
        [ 'stack|s=s'   => 'Stack on which to pin the target' ],
    );
}

#------------------------------------------------------------------------------

sub args_attribute { return 'targets' }

#------------------------------------------------------------------------------

sub args_from_stdin { return 1 }

#------------------------------------------------------------------------------

1;



=pod

=for :stopwords Jeffrey Thalhammer Imaginative Software Systems

=head1 NAME

App::Pinto::Command::pin - force a package to stay in a stack

=head1 VERSION

version 0.043

=head1 SYNOPSIS

  pinto --root=REPOSITORY_ROOT pin [OPTIONS] TARGET ...
  pinto --root=REPOSITORY_ROOT pin [OPTIONS] < LIST_OF_TARGETS

=head1 DESCRIPTION

This command pins a package so that it stays in the stack even if a
newer version is subsequently mirrored, imported, or added to that
stack.  The pin is local to the stack and does not affect any other
stacks.

A package must be in the stack before you can pin it.  To bring a
package into the stack, use the
L<pull|App::Pinto::Command::pull> command.  To remove the pin
from a package, please see the
L<unpin|App::Pinto::Command::unpin> command.

=head1 COMMAND ARGUMENTS

Arguments are the targets you wish to unpin.  Targets can be
specified as packages or distributions, such as:

  Some::Package
  Some::Other::Package

  AUTHOR/Some-Dist-1.2.tar.gz
  AUTHOR/Some-Other-Dist-1.3.zip

When pinning a distribution, all the packages in that distribution
become pinned.  Likewise when pinning a package, all its sister
packages in the same distributon also become pinned.

You can also pipe arguments to this command over STDIN.  In that case,
blank lines and lines that look like comments (i.e. starting with "#"
or ';') will be ignored.

=head1 COMMAND OPTIONS

=over 4

=item --dryrun

Go through all the motions, but do not actually commit any changes to
the repository.  Use this option to see how operations would potentially
impact the stack.

=item --stack=NAME

Pins the package on the stack with the given NAME.  Defaults to the
name of whichever stack is currently marked as the default stack.  Use
the L<stacks|App::Pinto::Command::stacks> command to see the
stacks in the repository.

=back

=head1 AUTHOR

Jeffrey Thalhammer <jeff@imaginative-software.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Imaginative Software Systems.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__


