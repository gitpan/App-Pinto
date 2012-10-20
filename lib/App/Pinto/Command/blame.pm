# ABSTRACT: show who put each package on a stack

package App::Pinto::Command::blame;

use strict;
use warnings;

#-----------------------------------------------------------------------------

use base 'App::Pinto::Command';

#------------------------------------------------------------------------------

our $VERSION = '0.052'; # VERSION

#------------------------------------------------------------------------------

sub command_names { return qw( blame praise ) }

#------------------------------------------------------------------------------

sub opt_spec {
    my ($self, $app) = @_;

    return (
        [ 'stack|s=s'  => 'Show blame for stack other than the default' ],
    );
}

#------------------------------------------------------------------------------

sub validate_args {
    my ($self, $opts, $args) = @_;

    $self->usage_error('Multiple arguments are not allowed') if @{ $args } > 1;

    $opts->{stack} = $args->[0] if @{ $args };

    return 1;
}

#------------------------------------------------------------------------------

1;



=pod

=for :stopwords Jeffrey Thalhammer Imaginative Software Systems

=head1 NAME

App::Pinto::Command::blame - show who put each package on a stack

=head1 VERSION

version 0.052

=head1 SYNOPSIS

  pinto --root=REPOSITORY_ROOT blame [STACK] [OPTIONS]

=head1 DESCRIPTION

!! THIS COMMAND IS EXPERIMENTAL !!

This comand shows who put each package in the head revision of the
stack, and which revision it was last added, pinned, or unpinned.

=head1 COMMAND ARGUMENTS

As an alternative to the C<--stack> option, you can specify it as an
argument.  So the following examples are equivalent:

  pinto --root REPOSITORY_ROOT blame --stack=dev
  pinto --root REPOSITORY_ROOT blame dev

A C<STACK> argument will silently override anything specified with the
C<--stack> option.

=head1 COMMAND OPTIONS

=over 4

=item --stack NAME

=item -s NAME

Show blame for the stack with the given NAME.  Defaults to the name of
whichever stack is currently marked as the default stack.  Use the
L<stacks|App::Pinto::Command::stack> command to see the stacks in the
repository.

=back

=head1 AUTHOR

Jeffrey Thalhammer <jeff@imaginative-software.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Imaginative Software Systems.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__

