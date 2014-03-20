# NAME

Mojolicious::Plugin::ConfigHashMerge - Perlish Configuration, with merging of deeply-nested defaults.

# SYNOPSIS

    # myapp.conf (it's just Perl returning a hash, with possible nesting)
    {
      foo         => "bar",
      watch_dirs  => {
        music => app->home->rel_dir('music'),
        ebooks => app->home->rel_dir('ebooks'),
        movies => app->home->rel_dir('movies')
      }
    };

    # Mojolicious
    my $config = $self->plugin('ConfigHashMerge');

    # Mojolicious::Lite
    plugin ConfigHashMerge =>
    {
      default =>
      { 
        watch_dirs => { 
          downloads => app->home->rel_dir('downloads')
        }
      },
      file => 'myapp.conf' # will be loaded anyway
    };
    say $_ for (sort keys %{app->config->{watch_dirs}}); # downloads ebooks movies music



# DESCRIPTION

[Mojolicious::Plugin::ConfigHashMerge](http://search.cpan.org/perldoc?Mojolicious::Plugin::ConfigHashMerge) is a Perl-ish configuration plugin, identical 
to [Mojolicious::Plugin::Config](http://search.cpan.org/perldoc?Mojolicious::Plugin::Config), except that it will merge config file and defaults using
[Hash::Merge::Simple](http://search.cpan.org/perldoc?Hash::Merge::Simple). This allows merging of deeply-nested config options.

See [Mojolicious::Plugin::Config](http://search.cpan.org/perldoc?Mojolicious::Plugin::Config) for more.

# OPTIONS

[Mojolicious::Plugin::ConfigHashMerge](http://search.cpan.org/perldoc?Mojolicious::Plugin::ConfigHashMerge) supports all options supported by 
[Mojolicious::Plugin::Config](http://search.cpan.org/perldoc?Mojolicious::Plugin::Config).

# METHODS

[Mojolicious::Plugin::ConfigHashMerge](http://search.cpan.org/perldoc?Mojolicious::Plugin::ConfigHashMerge) inherits all methods from
[Mojolicious::Plugin::Config](http://search.cpan.org/perldoc?Mojolicious::Plugin::Config) and implements the following new ones.

## register

    $plugin->register(Mojolicious->new, { file => 'foo.conf', default => { ... } });

Register plugin in [Mojolicious](http://search.cpan.org/perldoc?Mojolicious) application. See [Mojolicious::Plugin::Config](http://search.cpan.org/perldoc?Mojolicious::Plugin::Config) for available
config options.

# SEE ALSO

[Mojolicious](http://search.cpan.org/perldoc?Mojolicious), [Mojolicious::Guides](http://search.cpan.org/perldoc?Mojolicious::Guides), [http://mojolicio.us](http://mojolicio.us), [Mojolicious::Plugin::Config](http://search.cpan.org/perldoc?Mojolicious::Plugin::Config)
