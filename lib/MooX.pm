package MooX;
# ABSTRACT: Using Moo and MooX:: packages the most lazy way

use strict;
use warnings;
use Import::Into;
use Module::Runtime qw( use_module );
use Carp;

sub import {
	my ( $self, @modules ) = @_;
	my $target = caller;
	unshift @modules, 'Moo';
	while (@modules) {
		my $package = shift @modules;
		if (substr($package,0,1) eq '+') {
			$package = substr($package,1);
		} elsif ($package eq 'Moo') {
			# do nothing
		} else {
			$package = 'MooX::'.$package;
		}
		croak "No package name given" if ref $package;
		my @args = ref $modules[0] eq 'ARRAY'
						? @{shift @modules}
						: ref $modules[0] eq 'HASH'
							? %{shift @modules}
							: ();
		use_module($package)->import::into($target,@args);
	}
}

1;

=encoding utf8

=head1 SYNOPSIS

  package MyMoo;

  use MooX qw(
    Options
  );

  # use Moo;
  # use MooX::Options;

  package MyMooComplex;

  use MooX
    SomeThing => [qw( import params )],
    'OtherThing', MoreThing => { key => 'value' },
    '+NonMooXStuff';

  # use Moo;
  # use MooX::SomeThing qw( import params );
  # use MooX::OtherThing;
  # use MooX::MoreThing key => 'value';
  # use NonMooXStuff;

=head1 DESCRIPTION

Using Moo and MooX:: packages the most lazy way

=head1 SUPPORT

Repository

  http://github.com/Getty/p5-moox
  Pull request and additional contributors are welcome
 
Issue Tracker

  http://github.com/Getty/p5-moox/issues


