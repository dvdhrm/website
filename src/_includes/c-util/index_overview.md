# Overview

The C-Util Project is a collection of utility libraries for the C11 language.
The libraries follow common rules and are designed in a consistent style.
Prominent properties include:

 * **Unbundled**: The different projects implement each only a single
                  functionality, mostly provided independently of the other
                  projects. Bundling is avoided if possible, but it is not
                  discouraged. On the contrary, if provided as shared library
                  on a target system, downstream bundling is encouraged.

 * **Self-Contained**: The libraries aim to be self-contained, with minimal
                       external, mandatory dependencies. This means, the APIs
                       are designed to allow for the library user to choose and
                       provide the required resources, rather than depending
                       directly on a specific project.

 * **C11+**: C11 is mandatory! Furthermore, several non-standard compiler
             features are used to provide ergonomic APIs and make C less
             cumbersome to use. This includes automatic variable cleanup, block
             expressions, automatic type deduction, and more.

The C-Util project is a loose collection of mostly independent utility
libraries. There is no overall scope which these libraries try to cover. On the
contrary, the scope to cover is in no way limited. Their only connection is the
common development style and project maintenance.
