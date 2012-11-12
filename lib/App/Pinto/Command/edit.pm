# ABSTRACT: change stack properties

package App::Pinto::Command::edit;

use strict;
use warnings;

#-----------------------------------------------------------------------------

use base 'App::Pinto::Command';

#------------------------------------------------------------------------------

our $VERSION = '0.054'; # VERSION

#------------------------------------------------------------------------------

sub opt_spec {

    return (
        ['default'              => 'mark stack as the default'     ],
        ['properties|prop|P=s%' => 'name=value pairs of properties'],
    );
}

#------------------------------------------------------------------------------

sub validate_args {
    my ($self, $opts, $args) = @_;

    $self->usage_error('Cannot specify multiple stacks')
        if @{$args} > 1;

    return 1;
}

#------------------------------------------------------------------------------

sub execute {
    my ($self, $opts, $args) = @_;

    my $stack = $args->[0];
    my $result = $self->pinto->run($self->action_name, %{$opts},
                                                       stack => $stack);

    return $result->exit_status;
}

#------------------------------------------------------------------------------
1;



=pod

=for :stopwords Jeffrey Thalhammer Imaginative Software Systems

=head1 NAME

App::Pinto::Command::edit - change stack properties

=head1 VERSION

version 0.054

=head1 SYNOPSIS

  pinto --root=REPOSITORY_ROOT edit [OPTIONS] [STACK]

=head1 DESCRIPTION

This command edits the properties of a stack.  See the
L<props|App::Pinto::Command::props> command to display stack
properties.

=head1 COMMAND ARGUMENTS

The argument is the name of the stack you wish to edit the properties
for.  If you do not specify a stack, it defaults to whichever stack
is currently marked as default.  Stack names must be alphanumeric
plus hyphens and underscores, and are not case-sensitive.

=head1 COMMAND OPTIONS

=over 4

=item --default

Causes the selected stack to be marked as the "default".  The
default stack becomes the default for all operations where you do no
not specify an explicit stack.  The default stack also governs the
static index file for your repository.  DO NOT CHANGE THE DEFAULT STACK
WITHOUT DUE DILLIGENCE.  It has broad impact, especially if your
repository has multiple users.

=item --properties name1=value1

=item --prop name1=value1

=item -P name1=value1

Specifies property names and values.  You can repeat this option
to set multiple properties.  If the property with that name does
not already exist, it will be created.  Property names must be
alphanumeric plus hyphens and underscores, and are not case
sensitive.  Properties starting with the prefix 'pinto-' are reserved
for internal use, SO DO NOT CHANGE THEM.

=back

=head1 AUTHOR

Jeffrey Thalhammer <jeff@imaginative-software.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Imaginative Software Systems.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__


