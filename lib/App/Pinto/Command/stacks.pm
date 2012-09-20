# ABSTRACT: show available stacks

package App::Pinto::Command::stacks;

use strict;
use warnings;

#-----------------------------------------------------------------------------

use base 'App::Pinto::Command';

#------------------------------------------------------------------------------

our $VERSION = '0.049'; # VERSION

#------------------------------------------------------------------------------

sub opt_spec {
    my ($self, $app) = @_;

    return (
        [ 'format=s' => 'Format of the listing' ],
    );
}

#------------------------------------------------------------------------------

sub validate_args {
    my ($self, $opts, $args) = @_;

    $self->usage_error('No arguments are allowed')
        if @{ $args };

    $opts->{format} = eval qq{"$opts->{format}"} ## no critic qw(StringyEval)
        if $opts->{format};

    return 1;
}

#------------------------------------------------------------------------------
1;



=pod

=for :stopwords Jeffrey Thalhammer Imaginative Software Systems

=head1 NAME

App::Pinto::Command::stacks - show available stacks

=head1 VERSION

version 0.049

=head1 SYNOPSIS

  pinto --root=REPOSITORY_ROOT stacks [OPTIONS]
  pinto --root=REPOSITORY_ROOT stacks [OPTIONS]

=head1 DESCRIPTION

This command lists the names (and some other details) of all the
stacks available in the repository.

=head1 COMMAND ARGUMENTS

None.

=head1 COMMAND OPTIONS

=over 4

=item --format=FORMAT_SPECIFICATION

Format each record in the listing with C<printf>-style placeholders.
Valid placeholders are:

  Placeholder    Meaning
  -----------------------------------------------------------------------------
  %k             Stack name
  %e             Stack description
  %M             Stack default status                             (*) = default
  %U             Stack last-modified-on
  %j             Stack last-modified-by
  %%             A literal '%'

=back

=head1 AUTHOR

Jeffrey Thalhammer <jeff@imaginative-software.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Imaginative Software Systems.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__

