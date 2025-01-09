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

# vim: expandtab shiftwidth=4
