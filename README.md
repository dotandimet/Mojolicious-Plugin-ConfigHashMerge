# NAME

Mojolicious::Plugin::ConfigHashMerge - Perlish Configuration, with merging of deeply-nested defaults.

# SYNOPSIS

    # myapp.conf (it's just Perl returning a hash, with possible nesting)
    {
      foo         => "bar",
      watch_dirs  => {
        music => app->home->rel_dir('music'),
        ebooks => app->home->rel_dir('ebooks')
      }
    };

    # Mojolicious
    my $config = $self->plugin('ConfigHashMerge', { options... } );

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
    say $_ for (sort keys %{app->config->{watch_dirs}});
    # will print:
    # downloads
    # ebooks
    # music

# DESCRIPTION

[Mojolicious::Plugin::ConfigHashMerge](https://metacpan.org/pod/Mojolicious::Plugin::ConfigHashMerge) behaves __exactly__ like the standard plugin
[Mojolicious::Plugin::Config](https://metacpan.org/pod/Mojolicious::Plugin::Config), except that it uses [Hash::Merge::Simple](https://metacpan.org/pod/Hash::Merge::Simple) to merge
the defaults with the contents of the config file, instead of simply merging the
config hashes as flattened lists. This allows merging of deeply-nested config options.

Specifically, the only change introduced in this plugin is to replace these two lines:

    $config = {%$config, %{$self->load($mode, $conf, $app)}} if $mode;
    $config = {%{$conf->{default}}, %$config} if $conf->{default};

with these:

    $config = merge($config, $self->load($mode, $conf, $app)) if $mode;
    $config = merge($conf->{default}, $config) if $conf->{default};

So that if your defaults look like this:

    { optA => 42, optB => { victor => 1 }, optC => [2, 7, 8] }

And your config file looks like this:

    { optB => { alpha => 3 }, optC => 7 }

The merged config will look like this:

    { optA => 42, optB => { alpha => 3, victor => 1 }, optC => 7 }

Instead of like this (with the regular Config plugin):

    { optA => 42, optB => { alpha => 3 }, optC => 7 }

See [Mojolicious::Plugin::Config](https://metacpan.org/pod/Mojolicious::Plugin::Config) for more.

# OPTIONS

[Mojolicious::Plugin::ConfigHashMerge](https://metacpan.org/pod/Mojolicious::Plugin::ConfigHashMerge) supports all options supported by
[Mojolicious::Plugin::Config](https://metacpan.org/pod/Mojolicious::Plugin::Config).

# METHODS

[Mojolicious::Plugin::ConfigHashMerge](https://metacpan.org/pod/Mojolicious::Plugin::ConfigHashMerge) inherits all methods from
[Mojolicious::Plugin::Config](https://metacpan.org/pod/Mojolicious::Plugin::Config) and implements the following new ones.

## register

    $plugin->register(Mojolicious->new, { file => 'foo.conf', default => { ... } });

Register plugin in [Mojolicious](https://metacpan.org/pod/Mojolicious) application. See [Mojolicious::Plugin::Config](https://metacpan.org/pod/Mojolicious::Plugin::Config) for available
config options.

# SEE ALSO

[Mojolicious](https://metacpan.org/pod/Mojolicious), [Mojolicious::Guides](https://metacpan.org/pod/Mojolicious::Guides), [http://mojolicio.us](http://mojolicio.us), [Mojolicious::Plugin::Config](https://metacpan.org/pod/Mojolicious::Plugin::Config)
