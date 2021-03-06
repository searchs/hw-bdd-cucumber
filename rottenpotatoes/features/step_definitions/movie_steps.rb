# Add a declarative step here for populating the DB with movies.
# rake db:reset db:migrate


Given /the following movies exist/ do |movies_table|
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
  pos_e1 = page.body.index(/[#{e1}]/)
  pos_e2 = page.body.index(/[#{e2}]/, pos_e1)
  pos_e2 > pos_e1
end


# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rts = rating_list.split(",")

  rts.each { |r|
    if uncheck.to_s.equal? "uncheck"
      step %{
I uncheck "#{r.strip}"
           }
    elsif uncheck.to_s.equal? "check"
      step %{
I check "#{r.strip}"
             }
    end
  }
end

# Then /I should see all the movies/ do
#   # Make sure that all the movies in the app are visible in the table
#   fail "Unimplemented"
# end


Given(/^I check the "(.*?)" and "(.*?)" checkboxes$/) do |r1, r2|
  check "ratings_#{r1}"
  check "ratings_#{r2}"
end


Given(/^I uncheck "(.*?)", "(.*?)" and "(.*?)"$/) do |arg1, arg2, arg3|

  uncheck "ratings_#{arg1}"
  uncheck "ratings_#{arg2}"
  uncheck "ratings_#{arg3}"
end


Then(/^I should see only "(.*?)" and "(.*?)" rated movies$/) do |r1, r2|
  all('#movies tr > td:nth-child(2)').each do |td|
    %w{#{r1} #{r2}}.should include td.text
  end
end


Then(/^I should not see "(.*?)", "(.*?)" and "(.*?)" rated movies$/) do |nr1, nr2, nr3|
  r1 = nr1
  r2 = nr2
  r3 = nr3

  page.should have_no_content('#{nr1}')
  page.should have_no_content('#{nr2}')
  page.should have_no_content('#{nr3}')
  # all('#movies tr > td:nth-child(2)').each do |td|
  #   %w{#{r1} #{r2} #{r3}}.should_not include td.text
  # end
end

Given(/^I check all the ratings$/) do
  all_ratings = ["G", "PG", "PG-13", "NC-17", "R"]
  all_ratings.each { |c|
    step %{
I check "#{c}"
             }

  }

end


Then(/^I should see all of the movies$/) do
  all_ratings = ["G", "PG", "PG-13", "NC-17", "R"]
  all('#movies tr > td:nth-child(2)').each do |td|
    %w{#{all_ratings[0]} all_ratings[1] all_ratings[2] all_ratings[3] all_ratings[4]}.should include td.text
  end
end


