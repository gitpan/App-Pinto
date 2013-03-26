# ABSTRACT: Command-line driver for Pinto

package App::Pinto;

use strict;
use warnings;

use Class::Load;
use App::Cmd::Setup -app;

#------------------------------------------------------------------------------

our $VERSION = '0.066'; # VERSION

#------------------------------------------------------------------------------

sub global_opt_spec {

    return (
        [ 'root|r=s'           => 'Path to your repository root directory'  ],
        [ 'no-color|no-colour' => 'Do not colorize any output'              ],
        [ 'password|p=s'       => 'Password for server authentication'      ],
        [ 'quiet|q'            => 'Only report fatal errors'                ],
        [ 'username|u=s'       => 'Username for server authentication'      ],
        [ 'verbose|v+'         => 'More diagnostic output (repeatable)'     ],
    );
}

#------------------------------------------------------------------------------

sub pinto {
    my ($self) = @_;

    return $self->{pinto} ||= do {
        my $global_options = $self->global_options;

        $global_options->{root} ||= $ENV{PINTO_REPOSITORY_ROOT}
            || $self->usage_error('Must specify a repository root');

        $global_options->{password} = $self->_prompt_for_password
            if defined $global_options->{password} and $global_options->{password} eq '-';

        my $pinto_class = $self->pinto_class_for($global_options->{root});
        Class::Load::load_class($pinto_class);

        $pinto_class->new( %{ $global_options } );
    };
}

#------------------------------------------------------------------------------

sub pinto_class_for {
    my ($self, $root) = @_;
    return $root =~ m{^http://}x ? 'Pinto::Remote' : 'Pinto';
}

#------------------------------------------------------------------------------

sub _prompt_for_password {
   my ($self) = @_;

   require Encode;
   require Term::Prompt;

   my $input    = Term::Prompt::prompt('p', 'Password:', '', '');
   my $password = Encode::decode_utf8($input);
   print "\n"; # Get on a new line

   return $password;
}

#-------------------------------------------------------------------------------


1;

__END__

=pod

=for :stopwords Jeffrey Ryan Thalhammer Imaginative Software Systems cpan testmatrix url
annocpan anno bugtracker rt cpants kwalitee diff irc mailto metadata
placeholders metacpan

=head1 NAME

App::Pinto - Command-line driver for Pinto

=head1 VERSION

version 0.066

=head1 DESCRIPTION

App::Pinto is the command-line driver for Pinto.  It is just a
front-end.  To do anything useful, you'll also need to install one of
the back-ends, which ship separately.  If you need to create
repositories and/or work directly with repositories on the local disk,
then install L<Pinto>.  If you already have a repository on a remote
host that is running L<pintod>, then install L<Pinto::Remote>.  If
you're not sure what you need, then install L<Task::Pinto> to get the
whole kit.

=head1 SEE ALSO

L<pinto> to create and manage a Pinto repository.

L<pintod> to allow remote access to your Pinto repository.

L<Pinto::Manual> for general information on using Pinto.

L<Stratopan|http://stratopan.com> for hosting your Pinto repository in the cloud.

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

Jeffrey Ryan Thalhammer <jeff@stratopan.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Imaginative Software Systems.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
