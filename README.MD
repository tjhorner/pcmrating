# PCMRatings

Proper PC game reviews.

## Getting Started

PCMRatings is built using Ruby, Ruby on Rails and PostgreSQL.

It is hosted on Heroku.

---

Assuming you're completely new and you want to contribute to the project, here's
how you can easily clone the project, install dependencies and run the project.

1. Clone the project.

    $ cd ~/Work
    $ git clone git@github.com:PCMRating/pcmrating.git

1. Install dependencies.

    $ cd pcmrating/
    $ bundle install

2. Create the database.

    $ rake db:create
    $ rake db:migrate

3. Run the project.

    $ rails server

## Contributing Guidelines

- All pull requests must be done via GitHub.
- Pull requests must be atomic in nature, and not extend beyond their intended scope.
- Pull requests must have descriptive titles.

## Code Style Guidelines

- Use RuboCop to validate your code and detect code smells.
- Use 2 space identation. No tabs.
