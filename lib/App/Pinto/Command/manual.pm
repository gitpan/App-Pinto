package App::Pinto::Command::manual;

# ABSTRACT: show the full manual for a command

use strict;
use warnings;

use Pod::Usage qw(pod2usage);

use base qw(App::Pinto::Command);

#-------------------------------------------------------------------------------

our $VERSION = '0.066'; # VERSION

#-------------------------------------------------------------------------------

sub command_names { return qw( manual man --man ) }

#-----------------------------------------------------------------------------

sub validate_args {
    my ($self, $opts, $args) = @_;

    $self->usage_error("Must specify a command") if @{ $args } != 1;

    return 1;
}

#-------------------------------------------------------------------------------
# This was stolen from App::Cmd::Command::help

sub execute {
    my ($self, $opts, $args) = @_;

    my ($cmd, undef, undef) = $self->app->prepare_command(@$args);

    my $class = ref $cmd;
    (my $relative_path = $class) =~ s< :: ></>xmsg;
    $relative_path .= '.pm';

    my $absolute_path = $INC{$relative_path}
        or die "No manual available for $class\n"; 

    pod2usage(-verbose => 2, -input => $absolute_path, -exitval => 0);

    return 1;
}

#-------------------------------------------------------------------------------
1;

__END__

=pod

=for :stopwords Jeffrey Ryan Thalhammer Imaginative Software Systems

=head1 NAME

App::Pinto::Command::manual - show the full manual for a command

=head1 VERSION

version 0.066

=head1 AUTHOR

Jeffrey Ryan Thalhammer <jeff@stratopan.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Imaginative Software Systems.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
