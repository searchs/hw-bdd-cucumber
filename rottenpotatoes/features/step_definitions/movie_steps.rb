# Add a declarative step here for populating the DB with movies.
# rake db:reset db:migrate


Given /the following movies exist/ do |movies_table|
  pp "Ready to "
  @movies = Movie.all
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    movie['title'].present?
    movie['rating'].present?
    movie['release_date'].present?

  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.

  page.body.inc('table#movies').each do |tr|

  end

  # within_table('movie') do
  #   p locate("//*[@title='#{e1['title']}']").tr.size
  # end
  # f = page.body.table[e1['title']].length
  #
  # s = page.body.table[e2['title']].length
  # s > f == true
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  fail "Unimplemented"
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  fail "Unimplemented"
end
