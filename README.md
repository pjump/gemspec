# Gemspec

Gemspec is a convention-over-configuration library for creating DRY ruby gems that are easy to rename
and whose gemspec and scaffolded parts easy to reuse by simply copying them elsewhere.

## Gemspec::boilerplate
The main functionality of the libary is the `Gemspec::boilerplate` method, which when called with a `Gem::Specification`
as its argument, adds standard boilerplate to your gemspec.

It assumes you're using `Git`, and it infers most of the gemspec boilerplate from:

1) the name\* of your gem, which defaults to the name of your project's directory
2) your git data

Additionally, it:

1) `git init`s your project directory unless it's already been initialized
2) scaffolds out the files and directories your `lib` folder should contain based on your project's name,
  unless those files and directories already exist.

\*The naming convetions it uses are those laid out in http://guides.rubygems.org/name-your-gem/.

Effectively, a single gemspec file file without TODO’s and FIXME’s that uses  Gemspec.boilerplate is always a valid gemspec following commonn conventions.

## Project templates
The second part of this gems functionality is in its static template library.

`gemspec-install_templates destination/`
will install it to a destination of your choice and from there you can simply add common functionality to your gem (test suites, rake tasks, etc.)
by simply copying it to your project directory.

The `bare/` template contains just a simple `gemspec.gemspec`, which makes a complete gem by itself.
(Try copying it in and running `ruby gemspec.gemspec` or `gem build gemspec.gemspec`x`).

The ‘init/’ template contains a basic `Gemfile`, `minitest` samples in `test/`, `VERSIONING.md` describing the 
dual versioning scheme that `gemspec` uses, and `rakelib/` with `test.rake` and `license.rake`.
The latter creates and views licenses specified in the gemspec (no need to have them in your repo).

## Usage

  gem install gemspec

