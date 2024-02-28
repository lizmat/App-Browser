my sub expand($url) {
    $url.contains('://') ?? $url !! "https://$url"
}

my proto sub linux(|) {*}
my multi sub linux($url, '') {
    run 'xdg-open', expand($url)
}
my multi sub linux($url, $browser) {
    my $Browser = $browser.tc;
    X::NYI.new(feature => "opening $Browser on Linux").throw
}

# it's possible that other distros should also be included here...
my constant &debian = &linux;

my proto sub macos(|) {*}
my multi sub macos($url, '') {
    run 'open', expand($url)
}
my multi sub macos($url, 'chrome') {
    run 'open', '-a', 'Google Chrome', expand($url)
}
my multi sub macos($url, $browser) {
    run 'open', '-a', $browser.tc, expand($url)
}

# Older versions still have the X
my constant &macosx = &macos;

my proto sub browse(|) is export {*}
my multi sub browse($url) {
    (my &handle := ::('&' ~ $*DISTRO.name))
      ?? handle($url, %*ENV<APP_BROWSER> // "")
      !! Nil
}
my multi sub browse($url, $id) {
    (my &handle := ::('&' ~ $*DISTRO.name))
      ?? handle($url, $id)
      !! Nil
}

=begin pod

=head1 NAME

App::Browser - OS independent interface to a browser

=head1 SYNOPSIS

=begin code :lang<raku>

use App::Browser;

browse('raku.org');             # visit the Raku web site with default browser

browse('raku.org', 'firefox');  # visit the Raku web site with Firefox

=end code

=head1 DESCRIPTION

App::Browser provides a simple generic interface to starting a browser
for a given URL.  It exports the C<browse> function that takes a C<URL>
as the first parameter, and an optional browser identification as a
second parameter (which defaults to the C<APP_BROWSER> environment variable).

The C<browse> function returns a C<Proc> object, or C<Nil> if something
went wrong.  Whether it makes sense to do something with that object, is
unsure.

It also exports a command line script C<browse> that will take a C<URL>
and an optional browser identifier (e.g. C<chrome>, C<firefox>, C<safari>).

    $ browse raku.org

    $ APP_BROWSER=chrome browse raku.org

    $ browse raku.org firefox

=head1 WORK IN PROGRESS

Please note that this is a continuing work in progress.  At the moment of
this writing, only C<MacOS> is supported.  Specifically the different ways
of opening browsers on C<Windows> and the various tastes of C<Linux> will
need some experienced users to get this right.

=head1 AUTHOR

Elizabeth Mattijsen <liz@raku.rocks>

Source can be located at: https://github.com/lizmat/App-Browser . Comments and
Pull Requests are welcome.

If you like this module, or what I’m doing more generally, committing to a
L<small sponsorship|https://github.com/sponsors/lizmat/>  would mean a great
deal to me!

=head1 COPYRIGHT AND LICENSE

Copyright 2021 - 2022 Elizabeth Mattijsen

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod

# vim: expandtab shiftwidth=4
