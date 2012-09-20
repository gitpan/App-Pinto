# ABSTRACT: create a new empty stack

package App::Pinto::Command::new;

use strict;
use warnings;

#-----------------------------------------------------------------------------

use base 'App::Pinto::Command';

#------------------------------------------------------------------------------

our $VERSION = '0.050'; # VERSION

#------------------------------------------------------------------------------

sub opt_spec {
    my ($self, $app) = @_;

    return (
        [ 'message|m=s'     => 'Message to describe the change' ],
        [ 'description|d=s' => 'Brief description of the stack' ],
    );


}

#------------------------------------------------------------------------------

sub validate_args {
    my ($self, $opts, $args) = @_;

    $self->usage_error('Must specify exactly one stack')
        if @{$args} != 1;

    return 1;
}

#------------------------------------------------------------------------------

sub execute {
    my ($self, $opts, $args) = @_;

    my $result = $self->pinto->run($self->action_name, %{$opts},
                                                       stack => $args->[0]);

    return $result->exit_status;
}

#------------------------------------------------------------------------------
1;



=pod

=for :stopwords Jeffrey Thalhammer Imaginative Software Systems

=head1 NAME

App::Pinto::Command::new - create a new empty stack

=head1 VERSION

version 0.050

=head1 SYNOPSIS

  pinto --root=REPOSITORY_ROOT new [OPTIONS] STACK

=head1 DESCRIPTION

This command creates a new empty stack.

Please see the L<copy|App::Pinto::Command::copy> command to
create a new stack from another one, or the
L<edit|App::Pinto::Command::edit> command to change a
stack's properties after it has been created.

=head1 COMMAND ARGUMENTS

The required argument is the name of the stack you wish to create.
Stack names must be alphanumeric (including "-" or "_") and will be
forced to lowercase.

=head1 COMMAND OPTIONS

=over 4

=item --description=TEXT

=item -d TEXT

Use TEXT for the description of the stack.  This is usually used to
help explain the purpose of the stack.

=item --message=TEXT

=item -m TEXT

Use TEXT as the revision history log message.  If you do not use
C<--message> option, then you will be prompted to enter the message
via your text editor.  Use the C<EDITOR> or C<VISUAL> environment
variables to control which editor is used.  A log message is not
required whenever the C<--dryrun> option is set, or if the action did
not yield any changes to the repository.

=back

=head1 AUTHOR

Jeffrey Thalhammer <jeff@imaginative-software.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Imaginative Software Systems.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__


