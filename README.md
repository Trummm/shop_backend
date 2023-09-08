#### Prerequisites

The setups steps expect folowing tools installed on the system

- Github
- Ruby [3.0.0]
- Rails [7.0.6]
- Bundler [2.2.3]
- Mysql [8.0.33]
- Nodejs [v18.16.1]
- Yarn [1.22.19]

##### 1. Check out the repository

```bash
git clone https://github.com/Trummm/shop_backend.git
```

##### 2. Modify database.yml file

Edit the database configuration as required

```yml
#config/database.yml
---
development:
  host: localhost
  username: your_uername
  password: your_password
  database: your_db_name
  port: your_port
```

##### 3. Setup the database and seed data

Run the following commands to setup the database

```ruby
bundle exec rails db:create
bundle exec rails db:migrate
bundle exec rails db:seed
```

Or

```ruby
bundle exec rails db:migrate:reset
```

**⚠️ Warning** : 'rails db:migrate:reseet' command will clear all records in database and re-un all migrations.

##### 4. How to start the server?

You can start the rails server using the command given below

```ruby
bundle exec rails s
```

And now you can visit the site with the URL http://localhost:3000
