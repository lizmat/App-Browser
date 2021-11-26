my sub expand($url) {
    $url.contains('://') ?? $url !! "https://$url"
}

my multi sub linux($url, '') {
    X::NYI.new(feature => "opening default browser on Linux").throw
}
my multi sub linux($url, $browser) {
    my $Browser = $browser.tc;
    X::NYI.new(feature => "opening $Browser on Linux").throw
}

my multi sub macosx($url, '') {
    run 'open', expand($url)
}
my multi sub macosx($url, 'chrome') {
    run 'open', '-a', 'Google Chrome', expand($url)
}
my multi sub macosx($url, $browser) {
    run 'open', '-a', $browser.tc, expand($url)
}

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
second parameter (which defaults to the C<APP_BROWSER> environment variable..

The C<browse> function returns a C<Proc> object, or C<Nil> if something
went wrong.  Whether it makes sense to do something with that object, is
unsure.

It also exports a command line script C<browse> that will take a C<URL>
and an optional browser identifier (e.g. C<chrome>, C<firefox>, C<safari>).

=head1 WORK IN PROGRESS

Please note that this is a continuing work in progress.  At the moment of
this writing, only C<MacOS> is supported.  Specifically the different ways
of opening browsers on C<Windows> and the various tastes of C<Linux> will
need some experienced users to get this right.

=head1 AUTHOR

Elizabeth Mattijsen <liz@raku.rocks>

=head1 COPYRIGHT AND LICENSE

Copyright 2021 Elizabeth Mattijsen

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod

# vim: expandtab shiftwidth=4
