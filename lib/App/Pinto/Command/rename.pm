# ABSTRACT: change the name of a stack

package App::Pinto::Command::rename;

use strict;
use warnings;

#-----------------------------------------------------------------------------

use base 'App::Pinto::Command';

#------------------------------------------------------------------------------

our $VERSION = '0.054'; # VERSION

#------------------------------------------------------------------------------

sub command_names { return qw(rename mv) }

#------------------------------------------------------------------------------

sub validate_args {
    my ($self, $opts, $args) = @_;

    $self->usage_error('Must specify FROM_STACK and TO_STACK')
        if @{$args} != 2;

    return 1;
}

#------------------------------------------------------------------------------

sub execute {
    my ($self, $opts, $args) = @_;

    my %stacks = ( from_stack => $args->[0], to_stack => $args->[1] );
    my $result = $self->pinto->run($self->action_name, %{$opts}, %stacks);

    return $result->exit_status;
}

#------------------------------------------------------------------------------
1;



=pod

=for :stopwords Jeffrey Thalhammer Imaginative Software Systems

=head1 NAME

App::Pinto::Command::rename - change the name of a stack

=head1 VERSION

version 0.054

=head1 SYNOPSIS

  pinto --root=REPOSITORY_ROOT rename [OPTIONS] FROM_STACK TO_STACK

=head1 DESCRIPTION

This command changes the name of an existing stack.  Once the name is
changed, you will not be able to perform commands or access archives
via the old stack name.  Name changes are not recorded in the revision
history, so the L<revert|App::Pinto::Command::revert> command will
never cause the stack name to change back to its former value.

Please see the L<new|App::Pinto::Command::new> command to create a new
empty stack, or the L<edit|App::Pinto::Command::edit> command to
change a stack's properties after it has been created, or the
L<copy|App::Pinto::Command::copy> command to duplicate an existing
stack.

=head1 COMMAND ARGUMENTS

The two required arguments are the current name and new name of the
stack.  Stack names must be alphanumeric plus hyphens and underscores,
and are not case-sensitive.

=head1 COMMAND OPTIONS

NONE.

=head1 AUTHOR

Jeffrey Thalhammer <jeff@imaginative-software.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Imaginative Software Systems.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__

