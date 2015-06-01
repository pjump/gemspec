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

### Installation

  gem install gemspec
  #Install templates somewhere
  mkdir -p ~/.gemspec/
  gemspec-install_templates ~/.gemspec/

### Starting a project
  
  mkdir project/
  cd $_
  git flow init
  rsync -avi ~/.gemspec/init/ .

  #Add a summary and description
  $EDITOR gemspec.gemspec

  #Scaffold out lib
  ruby gemspec.gemspec

  #Build gem
  rake gem

  #Run test stubs
  rake test

### Renameing a project

  mv project/ something_something-whatever/
  cd $_
  #Scaffold out new lib:
  ruby gemspec.gemspec
  #Manually fix code in lib/ -- and that’s it; all other references are dynamic

### Render and view-licenses specified in gemspec.gemspec
  
  rake view-licenses

### Bump a version
  
  #First install gemspec-bump
  gem install gemspec-bump

  #This’ll bump the last version numbers, commit the change, merge the commit into master, tag it, and merge back
  gemspec-bump +1.+1


## Contributing

  Highly welcome. The project is very bare-bones right now.

## Goals
  
  - DRY-ness:
    All info in one place
  - Convention over configuration for basic gem structure that no-one every changes anyway
  - Flexibility/customizability
    -gems should be easy to rename and parts of a gem should be usable in another gem (no hardcoded references)
  - packaging should get out of the way as much as possible -- it’s your code that matters
  - straightforward workflow
