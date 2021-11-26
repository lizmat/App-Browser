[![Actions Status](https://github.com/lizmat/App-Browser/workflows/test/badge.svg)](https://github.com/lizmat/App-Browser/actions)

NAME
====

App::Browser - OS independent interface to a browser

SYNOPSIS
========

```raku
use App::Browser;

browse('raku.org');             # visit the Raku web site with default browser

browse('raku.org', 'firefox');  # visit the Raku web site with Firefox
```

DESCRIPTION
===========

App::Browser provides a simple generic interface to starting a browser for a given URL. It exports the `browse` function that takes a `URL` as the first parameter, and an optional browser identification as a second parameter (which defaults to the `APP_BROWSER` environment variable..

The `browse` function returns a `Proc` object, or `Nil` if something went wrong. Whether it makes sense to do something with that object, is unsure.

It also exports a command line script `browse` that will take a `URL` and an optional browser identifier (e.g. `chrome`, `firefox`, `safari`).

    $ browse raku.org

    $ APP_BROWSER=chrome browse raku.org

    $ browse raku.org firefox

WORK IN PROGRESS
================

Please note that this is a continuing work in progress. At the moment of this writing, only `MacOS` is supported. Specifically the different ways of opening browsers on `Windows` and the various tastes of `Linux` will need some experienced users to get this right.

AUTHOR
======

Elizabeth Mattijsen <liz@raku.rocks>

Source can be located at: https://github.com/lizmat/App-Browser . Comments and Pull Requests are welcome.

COPYRIGHT AND LICENSE
=====================

Copyright 2021 Elizabeth Mattijsen

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

