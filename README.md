# CI Config Generator

[github.com/codevise/ci_config_generator](http://github.com/codevise/ci_config_generator)

Generate config files for continuous integration from templates inside
the repository.

## Usage

Require generator tasks inside your `Rakefile`:

    # Rakefile
    require 'ci_config_generator/tasks'

Given `config/database.yml` is an ignored file, commit a
`config/database.yml.ci` file and invoke

    $ rake ci:config:generate

in continuous integration. The task generates a `config/database.yml`
and interpolates environment variables:

    # config/database.yml.ci
    test:
      db: "%{DB_NAME}"

    $ rake ci:config:generate DB_NAME=test_db

    # config/databse.yml
    test:
      db: "test_db"

The task fails if files would be overriden. So make sure to clean your
repository on each ci run.

## License

Please fork and improve.

Copyright (c) 2013 Codevise Solutions Ltd. This software is licensed under the MIT License.
