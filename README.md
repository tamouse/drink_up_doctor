# DrinkUpDoctor

## Dependencies

`DrinkUpDoctor` depends on [Gulp], [Bower], [Jekyll], and [Compass]. You'll need to have both [Ruby] and [Node.js] installed and running.

### Installing Global Dependencies

Installations should be simple:

    $ gem install jekyll
    $ gem install compass
    $ npm install -g bower
    $ npm install -g gulp

If you have problems installing any of these, seek help in the associated IRC channels on `irc.freenode.net`.

## Installation

Installing the command should be as simple as

    $ gem install drink_up_doctor

## Usage

See the help text:

    $ drink_up_doctor new help

Creating a new site:

    $ drink_up_doctor new NAME [OPTIONS]

The above creates a standard Jekyll site, with a few
modifications. The new site's README file describes the changes.

After creating a new site, you need to install the components:

    $ npm install
    $ bower install

After all the installation is done, you can start the gulp server to
build the various pieces and keep a browser going with site changes:

    $ gulp serve

The new site's README file has more details on working with your new
site with Gulp. Following the instructions at the [Jekyll] site
should speed you on the rest of your way.

## Acknowledgements

Billy Overton's blog post on
[Setting up Jekyll, Gulp, and Automated Git Deployment](http://billyoverton.com/2015/07/27/Jekyll-Gulp-and-Automated-Deployments.html)
provided all the inspiration for this tiny bit of automation, which
mainly for my own nefarious purposes.

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/tamouse/drink_up_doctor. This project is
intended to be a safe, welcoming space for collaboration, and
contributors are expected to adhere to the
[Contributor Covenant](contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the
[MIT License](http://opensource.org/licenses/MIT).

[Jekyll]: http://jekyllrb.com/ "Jekyll"
[Gulp]: http://gulpjs.com/ "Gulp"
[Bower]: http://bower.io/ "Bower"
[Compass]: http://compass-style.org/ "Compass"
