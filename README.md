converse1/websites - Common Website Sources
===========================================

This is the source repository of several of our websites. It is also the
canonical location of all project related artwork.

This project generates all our websites from a shared framework. That is, the
general layout of all target pages is the same and source from the same
templates. However, each website adds its own content collection on top. We use
jekyll as generator and have mostly static content as result.

Additionally to the page generator, this repository hosts artwork of all
related projects. This artwork is included in the generated content so it is
accessible through all websites.

### Project

 - **Website**: <https://converse1.github.io>
 - **Bug-Tracker**: <https://github.com/converse1/website/issues>

### Requirements:

The requirements for this project are:

 * `jekyll >= 3.0`

### Build

To build the jekyll pages, run:

```
    $ jekyll build \
        --config src/<config>.yml \
        --source src \
        --destination build/<target>
```

### Repository:

 - **web**:   <https://github.com/converse1/websites>
 - **https**: `https://github.com/converse1/websites.git`
 - **ssh**:   `git@github.com:converse1/websites.git`

### License:

 - **Apache-2.0** OR **LGPL-2.1-or-later**
 - See AUTHORS file for details.
