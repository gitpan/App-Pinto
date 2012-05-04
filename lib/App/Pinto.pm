package App::Pinto;

# ABSTRACT: Command-line driver for Pinto

use strict;
use warnings;

use Class::Load;

use List::Util qw(min);
use Log::Dispatch::Screen;
use Log::Dispatch::Screen::Color;

use Pinto::Constants qw(:all);

use App::Cmd::Setup -app;

#------------------------------------------------------------------------------

our $VERSION = '0.040_02'; # VERSION

#------------------------------------------------------------------------------

sub global_opt_spec {

    return (
        [ 'root|r=s'    => 'Path to your repository root directory'  ],
        [ 'nocolor'     => 'Do not colorize diagnostic messages'     ],
        [ 'quiet|q'     => 'Only report fatal errors'                ],
        [ 'verbose|v+'  => 'More diagnostic output (repeatable)'     ],
    );

    # TODO: Add options for color contols!
}

#------------------------------------------------------------------------------


sub pinto {
    my ($self) = @_;

    return $self->{pinto} ||= do {
        my %global_options = %{ $self->global_options() };

        $global_options{root} ||= $ENV{PINTO_REPOSITORY_ROOT}
            || $self->usage_error('Must specify a repository root directory');

        my $pinto_class = $self->pinto_class();
        Class::Load::load_class($pinto_class);

        my $pinto = $pinto_class->new(%global_options);
        $pinto->add_logger($self->logger(%global_options));

        $pinto;
    };
}

#------------------------------------------------------------------------------

sub logger {
    my ($self, %options) = @_;

    my $nocolor   = $options{nocolor};
    my $colors    = $nocolor ? {} : ($self->log_colors);
    my $log_class = 'Log::Dispatch::Screen';
    $log_class .= '::Color' unless $nocolor;

    my $verbose = min($options{verbose} || 0, 2);

    my $log_level = 2 - $verbose;      # Defaults to 'notice'
    $log_level = 4 if $options{quiet}; # Only 'error' or higher

    return $log_class->new( min_level => $log_level,
                            color     => $colors,
                            stderr    => 1,
                            newline   => 1 );
}

#------------------------------------------------------------------------------

sub log_colors {
    my ($self) = @_;

    # TODO: Create command line options for controlling colors and
    # process them here.

    return $self->default_log_colors;
}

#------------------------------------------------------------------------------

sub default_log_colors { return $PINTO_DEFAULT_LOG_COLORS }

#------------------------------------------------------------------------------

sub pinto_class { return 'Pinto' }

#------------------------------------------------------------------------------

1;



=pod

=for :stopwords Jeffrey Thalhammer Imaginative Software Systems cpan testmatrix url
annocpan anno bugtracker rt cpants kwalitee diff irc mailto metadata
placeholders metacpan

=head1 NAME

App::Pinto - Command-line driver for Pinto

=head1 VERSION

version 0.040_02

=head1 METHODS

=head2 pinto()

Returns a reference to a L<Pinto> object that has been constructed for
this application.

=head1 SUPPORT

=head2 Perldoc

You can find documentation for this module with the perldoc command.

  perldoc App::Pinto

=head2 Websites

The following websites have more information about this module, and may be of help to you. As always,
in addition to those websites please use your favorite search engine to discover more resources.

=over 4

=item *

Search CPAN

The default CPAN search engine, useful to view POD in HTML format.

L<http://search.cpan.org/dist/App-Pinto>

=item *

CPAN Ratings

The CPAN Ratings is a website that allows community ratings and reviews of Perl modules.

L<http://cpanratings.perl.org/d/App-Pinto>

=item *

CPAN Testers

The CPAN Testers is a network of smokers who run automated tests on uploaded CPAN distributions.

L<http://www.cpantesters.org/distro/A/App-Pinto>

=item *

CPAN Testers Matrix

The CPAN Testers Matrix is a website that provides a visual overview of the test results for a distribution on various Perls/platforms.

L<http://matrix.cpantesters.org/?dist=App-Pinto>

=item *

CPAN Testers Dependencies

The CPAN Testers Dependencies is a website that shows a chart of the test results of all dependencies for a distribution.

L<http://deps.cpantesters.org/?module=App::Pinto>

=back

=head2 Bugs / Feature Requests

L<https://github.com/thaljef/App-Pinto/issues>

=head2 Source Code


L<https://github.com/thaljef/App-Pinto>

  git clone git://github.com/thaljef/App-Pinto.git

=head1 AUTHOR

Jeffrey Thalhammer <jeff@imaginative-software.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Imaginative Software Systems.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__
