# ABSTRACT: show the index for a stack

package App::Pinto::Command::index;

use strict;
use warnings;

#-----------------------------------------------------------------------------

use base 'App::Pinto::Command';

#------------------------------------------------------------------------------

our $VERSION = '0.043'; # VERSION

#------------------------------------------------------------------------------

sub validate_args {
    my ($self, $opts, $args) = @_;

    $self->usage_error('Cannot specify multiple stacks')
        if @{ $args } > 1;

    return 1;
}

#------------------------------------------------------------------------------

sub execute {
    my ($self, $opts, $args) = @_;

    my $stack = $args->[0];
    my $result = $self->pinto->run($self->action_name, stack => $stack);

    return $result->exit_status;
}

#------------------------------------------------------------------------------

1;



=pod

=for :stopwords Jeffrey Thalhammer Imaginative Software Systems

=head1 NAME

App::Pinto::Command::index - show the index for a stack

=head1 VERSION

version 0.043

=head1 SYNOPSIS

  pinto --root=REPOSITORY_ROOT index [STACK]

=head1 DESCRIPTION

This command shows the index of a stack.  Unlike the
L<list|App::Pinto::Command::list> command, this command shows the
index exactly as it would appear to an installer client.

=head1 COMMAND ARGUMENTS

The argument is the name of the stack you wish to see the index for.
If you do not specify a stack, it defaults to whichever stack is
marked as the default.  Stack names must be alphanumeric (including
"-" or "_") and will be forced to lowercase.

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

