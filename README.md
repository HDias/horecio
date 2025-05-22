#### Ruby on Rails Code Challenge

Project Requirements:

* Ruby version: 2.7.6

#### Before the code challenge:

* Clone the repository locally and install all the dependencies
* Get familiar with the codebase
* Check the database schema


#### Tasks

1. Users report that when filtering users by company, they still get all system users, determine the cause and fix it.
 - fix: https://github.com/HDias/horecio/commit/f0d5d6d1447c529ff8ac4a849959c251fda9b471
2. When filtering by username, no partial matchers are displayed, only full match applies.
Example: ‘username_1: max‘ and ‘username_2: mathew‘ if search by ‘ma‘, ‘ma‘ , ‘Ma‘ no results are found. determine the cause and fix it.
 - fix: https://github.com/HDias/horecio/commit/46ad201cc68a4215fc5e00949ed701b135ba0f97
3. Write specs to validate the filtering solution is valid.
 - fix: https://github.com/HDias/horecio/commit/46ad201cc68a4215fc5e00949ed701b135ba0f97
4. Implement the tweets index endpoint using a cursor pagination/infinite scroll alike approach (no gems are valid). Sort is by most recently.
 - feat: https://github.com/HDias/horecio/commit/373ab231bf4f47c2b35730ccad836a930bbfbd11
5. Retrieve the tweets for a specific user (using the same index function) - make sure to avoid boilerplate code. Use ‘User model‘ scopes. Adapt your solution to defined routes. Do not modify the routes file
 - feat: https://github.com/HDias/horecio/commit/7c5a8cb62ebd8c471c5923aa5b93fafc695993f0
6. create a Dockerfile and docker-compose to run the project
 - chore: https://github.com/HDias/horecio/commit/0c7d64969cb95fc476089dfd9ccdab1a14642508
7. implements a simple CRUD for company (with html pages)
 - feat: https://github.com/HDias/horecio/commit/e6c01dcbc82a9b8f80e4de944a528e2b0c09a725
8. implements a mailer for new user
 - feat: https://github.com/HDias/horecio/commit/70d8cb393987a3d29dcffbd9857ed238250888d3