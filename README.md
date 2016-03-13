# awesome-conf-api

This is API for awesome-conf project.

## Setup

### 0. Clone the project

`git clone https://github.com/alChaCC/awesome-conf-api`

### 1. Install gems

`bundle install`

### 2. Run Postgresql(SQL server)

please check: [https://gorails.com/setup/osx/10.11-el-capitan](https://gorails.com/setup/osx/10.11-el-capitan)

### 3. Create database and data

`rake db:create db:migrate`

`rails c`

and run

`Attendee.csv_upload(File.join("#{Rails.root}/spec/fixtures/", 'sample_data.csv'))`

### 4. Run Server

`rails s`

### 5. Run Frontend Server

please check here [https://github.com/alChaCC/awesome-conf](https://github.com/alChaCC/awesome-conf)


## Testing

`rspec`