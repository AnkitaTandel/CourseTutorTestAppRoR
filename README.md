# CourseTutorTestApp

CourseTutorTestApp is a Ruby on Rails application that manages courses and tutors. User model is there for managing authentication.

## Here are some key points:

- Due to time constraints, I've prioritized RSpec tests for `GET /courses` and `POST /course` API calls.
- I have implemented comprehensive RSpec tests for the `Course` and `Tutor` models, including all necessary validations.
- I introduced token-based authentication, along with an additional user model, to enhance security.
- RuboCop has been integrated for code style enforcement.


## Getting Started

### Prerequisites

- Ruby (version 3.0.5 recommended)
- Rails (version 6.1 recommended)
- PostgreSQL (or your preferred database)

### Installation

1. Clone the repository:

   `git clone https://github.com/.../CourseTutorTestApp.git` (replace once pushed to git)

  * Navigate into the project directory: `cd CourseTutorTestApp`

  * Install dependencies: `bundle install`

  * Set up the database: `rails db:create db:migrate`

### Usage
1. Start the Rails server:
`rails server`

2. Testing: To run the test suite, use the following command: `rspec`

##### 1. Create a User
You can create a user by making a POST request to the /api/v1/users endpoint. Here's an example using curl:

```
curl -X POST \
  http://localhost:3000/api/v1/users \
  -H 'Content-Type: application/json' \
  -d '{
    "user": {
      "first_name": "Foo",
      "last_name": "Bar",
      "email": "foo.bar@example.com",
      "password": "password12345"
    }
  }'
```
##### 2. Generate a Token

```
curl -X POST \
  http://localhost:3000/api/v1/tokens \
  -H 'Content-Type: application/json' \
  -d '{
    "user": {
      "email": "foo.bar@example.com",
      "password": "password12345"
    }
  }'

```

##### 3. Call the API with Token
```
curl -X POST \
  http://localhost:3000/api/v1/courses \
  -H 'Content-Type: application/json' \
  -H 'Authorization: Bearer YOUR_TOKEN' \
  -d '{
    "course": {
      "name": "Ruby on Rails",
      "tutors_attributes": [
        { "name": "Tutor 1" },
        { "name": "Tutor 2" }
      ]
    }
  }'

```

##### 4. List all course and tutors (this can be accessed without token/ authentication can be added to this api if required, but I feel it is fine if listing API is public)

```
curl -X GET http://localhost:3000/api/v1/courses

```
