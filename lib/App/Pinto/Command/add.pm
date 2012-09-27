package App::Pinto::Command::add;

# ABSTRACT: add local archives to the repository

use strict;
use warnings;

#------------------------------------------------------------------------------

use base 'App::Pinto::Command';

#------------------------------------------------------------------------------

our $VERSION = '0.051'; # VERSION

#-----------------------------------------------------------------------------

sub opt_spec {
    my ($self, $app) = @_;

    return (
        [ 'author=s'    => 'Your (alphanumeric) author ID'     ],
        [ 'dryrun'      => 'Do not commit any changes'         ],
        [ 'message|m=s' => 'Message to describe the change'    ],
        [ 'norecurse|n' => 'Do not recursively pull prereqs'   ],
        [ 'pin'         => 'Pin packages to the stack'         ],
        [ 'stack|s=s'   => 'Put packages into this stack'      ],
    );
}

#------------------------------------------------------------------------------

sub args_attribute { return 'archives' }

#------------------------------------------------------------------------------

sub args_from_stdin { return 1 }

#------------------------------------------------------------------------------

1;



=pod

=for :stopwords Jeffrey Thalhammer Imaginative Software Systems

=head1 NAME

App::Pinto::Command::add - add local archives to the repository

=head1 VERSION

version 0.051

=head1 SYNOPSIS

  pinto --root=REPOSITORY_ROOT add [OPTIONS] ARCHIVE_FILE ...
  pinto --root=REPOSITORY_ROOT add [OPTIONS] < LIST_OF_ARCHIVE_FILES

=head1 DESCRIPTION

This command adds local distribution archives to the repository.
Then it recursively pulls all the distributions that are necessary
to satisfy their prerequisites.

When locating packages, Pinto first looks at the the packages that
already exist in the local repository, then Pinto looks at the
packages that are available on the upstream repositories.

=head1 COMMAND ARGUMENTS

Arguments to this command are paths to the distribution archives that
you wish to add.  Each of these files must exist and must be readable.

You can also pipe arguments to this command over STDIN.  In that case,
blank lines and lines that look like comments (i.e. starting with "#"
or ';') will be ignored.

=head1 COMMAND OPTIONS

=over 4

=item --author NAME

Set the identity of the distribution author.  The C<NAME> must be
alphanumeric characters (no spaces) and will be forced to uppercase.
Defaults to the C<user> specified in your C<~/.pause> configuration
file (if such file exists).  Otherwise, defaults to your current login
username.

=item --dryrun

Go through all the motions, but do not actually commit any changes to
the repository.  Use this option to see how the command would
potentially impact the stack.

=item --message=TEXT

=item -m TEXT

Use TEXT as the revision history log message.  If you do not use
C<--message> option, then you will be prompted to enter the message
via your text editor.  Use the C<EDITOR> or C<VISUAL> environment
variables to control which editor is used.  A log message is not
required whenever the C<--dryrun> option is set, or if the action did
not yield any changes to the repository.

=item --norecurse

=item -n

Do not recursively pull distributions required to satisfy the
prerequisites of the added distributions.

=item --pin

Pins all the packages in the added distributions to the stack, so they
cannot be changed until you unpin them.  The pin does not apply to any
prerequisites that are pulled in for this distribution.  However, you
may pin them separately with the
L<pin|App::Pinto::Command::pin> command, if you so desire.

=item --stack NAME

Puts all the packages onto the stack with the given NAME.  Defaults
to the name of whichever stack is currently marked as the default
stack.  Use the L<stacks|App::Pinto::Command::stacks> command
to see the stacks in the repository.

=back

=head1 AUTHOR

Jeffrey Thalhammer <jeff@imaginative-software.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Imaginative Software Systems.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__

