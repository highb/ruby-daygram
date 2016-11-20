# Daygram

[![Gem Version](https://badge.fury.io/rb/daygram.svg)](http://badge.fury.io/rb/daygram)
[![Code Climate GPA](https://codeclimate.com/github/highb/daygram.svg)](https://codeclimate.com/github/highb/daygram)
[![Code Climate Coverage](https://codeclimate.com/github/highb/daygram/coverage.svg)](https://codeclimate.com/github/highb/daygram)
[![Travis CI Status](https://secure.travis-ci.org/highb/daygram.svg)](https://travis-ci.org/highb/daygram)

<!-- Tocer[start]: Auto-generated, don't remove. -->

# Table of Contents

- [Features](#features)
- [Screencasts](#screencasts)
- [Requirements](#requirements)
- [Setup](#setup)
- [Usage](#usage)
- [Tests](#tests)
- [Versioning](#versioning)
- [Code of Conduct](#code-of-conduct)
- [Contributions](#contributions)
- [License](#license)
- [History](#history)
- [Credits](#credits)

<!-- Tocer[finish]: Auto-generated, don't remove. -->

# Features

# Requirements

0. [Ruby 2.3.1](https://www.ruby-lang.org)

# Setup

<!-- For a secure install, type the following (recommended):

    gem cert --add <(curl --location --silent /gem-public.pem)
    gem install daygram --trust-policy MediumSecurity

NOTE: A HighSecurity trust policy would be best but MediumSecurity enables signed gem verification
while allowing the installation of unsigned dependencies since they are beyond the scope of this
gem.

For an insecure install, type the following (not recommended): -->

    gem install daygram


# Usage

To print all of the entries in the Daygram:

    daygram read all

To print the latest entry:

    daygram read latest

To print the last 5 entries:

    daygram read last

To print the entries as JSON, Ruby Hash, or a table:

    daygram read last --format json
    daygram read last --format hash
    daygram read last --format table

# Tests

To test, run:

    bundle exec rake

# Versioning

Read [Semantic Versioning](http://semver.org) for details. Briefly, it means:

- Patch (x.y.Z) - Incremented for small, backwards compatible, bug fixes.
- Minor (x.Y.z) - Incremented for new, backwards compatible, public API enhancements/fixes.
- Major (X.y.z) - Incremented for any backwards incompatible public API changes.

# Code of Conduct

Please note that this project is released with a [CODE OF CONDUCT](CODE_OF_CONDUCT.md). By
participating in this project you agree to abide by its terms.

# Contributions

Read [CONTRIBUTING](CONTRIBUTING.md) for details.

# License

Copyright (c) 2016 [Brandon High](https://brandon-high.com).
Read [LICENSE](LICENSE.md) for details.

# History

Read [CHANGES](CHANGES.md) for details.
Built with [Gemsmith](https://github.com/bkuhlmann/gemsmith).

# Credits

Developed by [Brandon High](https://brandon-high.com)
