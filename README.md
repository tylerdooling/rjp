[![Build Status](https://travis-ci.org/tylerdooling/rjp.png?branch=master)](https://travis-ci.org/tylerdooling/rjp)
# rjp
A command line tool for formatting JSON and extracting values.

## Installation

    $ gem install rjp

## Usage

### Formating a JSON response
```bash
$ curl https://api.github.com | rjp
{
                 "current_user_url" => "https://api.github.com/user",
               "authorizations_url" => "https://api.github.com/authorizations",
                  "code_search_url" => "https://api.github.com/search/code?q={query}{&page,per_page,sort,order}",
                       "emails_url" => "https://api.github.com/user/emails",
                       "emojis_url" => "https://api.github.com/emojis",
                       "vents_url" => "https://api.github.com/events",
                        "feeds_url" => "https://api.github.com/feeds",
                    "following_url" => "https://api.github.com/user/following{/target}",
                        "gists_url" => "https://api.github.com/gists{/gist_id}",
                          "hub_url" => "https://api.github.com/hub",
                 "issue_search_url" => "https://api.github.com/search/issues?q={query}{&page,per_page,sort,order}",
                       "issues_url" => "https://api.github.com/issues",
                         "keys_url" => "https://api.github.com/user/keys",
                "notifications_url" => "https://api.github.com/notifications",
    "organization_repositories_url" => "https://api.github.com/orgs/{org}/repos/{?type,page,per_page,sort}",
                 "organization_url" => "https://api.github.com/orgs/{org}",
                 "public_gists_url" => "https://api.github.com/gists/public",
                   "rate_limit_url" => "https://api.github.com/rate_limit",
                   "repository_url" => "https://api.github.com/repos/{owner}/{repo}",
            "repository_search_url" => "https://api.github.com/search/repositories?q={query}{&page,per_page,sort,order}",
    "current_user_repositories_url" => "https://api.github.com/user/repos{?type,page,per_page,sort}",
                      "starred_url" => "https://api.github.com/user/starred{/owner}{/repo}",
                "starred_gists_url" => "https://api.github.com/gists/starred",
                         "team_url" => "https://api.github.com/teams",
                         "user_url" => "https://api.github.com/users/{user}",
           "user_organizations_url" => "https://api.github.com/user/orgs",
            "user_repositories_url" => "https://api.github.com/users/{user}/repos{?type,page,per_page,sort}",
                  "user_search_url" => "https://api.github.com/search/users?q={query}{&page,per_page,sort,order}"
}
```
### Chaining to navigate hypermedia apis
```bash
$ curl https://api.github.com | rjp -k current_user_url | xargs curl -u {github_auth} | rjp
```
### Default value
```bash
$ curl https://api.github.com | rjp -k not_present -d default_value
"default_value"
```
### Post processing
```bash
$ curl https://api.github.com | rjp -k current_user_url -e 'value.upcase'
"HTTPS://API.GITHUB.COM/USER"
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
