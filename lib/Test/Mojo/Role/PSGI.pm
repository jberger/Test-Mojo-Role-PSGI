package Test::Mojo::Role::PSGI;

use Role::Tiny;

use Mojolicious;

our $VERSION = '0.01';
$VERSION = eval $VERSION;

around new => sub {
  my ($orig, $self, $script) = @_;
  if (!$script || ref $script) {
    return $self->$orig($script);
  }
  my $t = $self->$orig;
  my $app = Mojolicious->new;
  $app->plugin('Mojolicious::Plugin::MountPSGI' => { '/' => $script });
  return $t->app($app);
};

1;

=head1 NAME

Test::Mojo::Role::PSGI - Test PSGI apps using Test::Mojo

=head1 SYNOPSIS

  use strict;
  use warnings;

  use Test::More;
  use Test::Mojo::WithRoles 'PSGI';

  my $t = Test::Mojo::WithRoles->new('path/to/app.psgi');

  $t->get_ok('/some/path')
    ->status_is(200)
    ->content_type_like(qr/html/)
    ->text_is('.some-class:nth-child(5)' => 'content of 5th some-class');

  ...

  done_testing;

=head1 DESCRIPTION

L<Test::Mojo> makes testing L<Mojolicious> applications easy and fun.
Wouldn't it be nice if there was some way to use it for non-Mojolicious apps?
L<Test::Mojo::Role::PSGI> does just that.

The author suggests using L<Test::Mojo::WithRoles> to make instances of the tester with (possibly multiple) roles applied in a sane way.

=head1 OVERRIDES

=head2 new

Overrides the L<Test::Mojo/new> method to instantiate a PSGI app I<IF> the argument to new is a string and not empty or an app instance.
This should feel very similar to the original behavior except that now PSGI apps are instantiated rather than Mojolicious apps.

=head1 SEE ALSO

=over

=item L<Test::Mojo>

=item L<Mojolicious>

=item L<Mojolicious::Plugin::MountPSGI>

=item L<Role::Tiny>

=item L<Test::Mojo::WithRoles>

=back

=head1 SOURCE REPOSITORY

L<http://github.com/jberger/Test-Mojo-Role-PSGI>

=head1 AUTHOR

Joel Berger, E<lt>joel.a.berger@gmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2015 by Joel Berger

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

