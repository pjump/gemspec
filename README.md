# Gemspec

Gemspec is a convention-over-configuration library for creating gems.

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

## Usage

  gem install gemspec


