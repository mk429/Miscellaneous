# daft-rss-alerter

A simple Ruby script to send Pushover notifications when a new property shows up in a Daft.ie saved search.

## Installation

`bundle install`

## Configuration

- Copy the RSS feed link from one of your saved searches on Daft.ie. It should look like `http://www.daft.ie/rss.daft?uid=<digits>&id=<digits>&xk=<digits>` and define it in the code as `DAFT_RSS_URI`
- Copy your user key from https://pushover.net and set it in the code as `PUSHOVER_USER_KEY`

## Running

`bundle exec ruby daft-rss-alerter`

