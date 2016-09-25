# to_do

Simple JSON API (using RESTful principles) that helps users manage tasks.

## Development

This project is written in Elixir. In order to build and run it, you will need
to install (Elixir)[http://elixir-lang.org/install.html]. On Mac OS X, if you
have homebrew installed, this can be done with:
```
brew install elixir
```

### Running Locally

TBD

## API

The following endpoints are supported.

### GET `/users`

Returns a list of all users.

### GET `/users/<user-id>/tasks`

Returns a list of all tasks for the user.

### GET `/users/<user-id>/tasks/<date>`

Returns a list of all tasks for the user on the given date. Dates are
represented in ISO 8601 (YYYY-MM-DD) format.
