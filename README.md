# Project 4 - *翻版twitter*

**翻版twitter** is a basic twitter app to read and compose tweets the [Twitter API](https://apps.twitter.com/).

Time spent: **7** hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] User can sign in using OAuth login flow
- [x] User can view last 20 tweets from their home timeline
- [x] The current signed in user will be persisted across restarts
- [x] In the home timeline, user can view tweet with the user profile picture, username, tweet text, and timestamp.
- [x] Retweeting and favoriting should increment the retweet and favorite count.

The following **optional** features are implemented:

- [x] User can load more tweets once they reach the bottom of the feed using infinite loading similar to the actual Twitter client.
- [x] User should be able to unretweet and unfavorite and should decrement the retweet and favorite count.
- [x] User can pull to refresh.

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. Learning from an outdated video tutorial is exhausting due to lack of understanding the newest update information
2. Minor mistake caused long hour of debugging

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

<img src='http://i.imgur.com/73VLJ6J.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Describe any challenges encountered while building the app.

## License

    Copyright [2016] [Zhipeng Mei]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.


# Project 5 - *翻版twitter Reduxe*

Time spent: **12+** hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] Tweet Details Page: User can tap on a tweet to view it, with controls to retweet, favorite, and reply.
- [x] Profile page:
   - [x] Contains the user header view
   - [x] Contains a section with the users basic stats: # tweets, # following, # followers
- [x] Home Timeline: Tapping on a user image should bring up that user's profile page
- [x] Compose Page: User can compose a new tweet by tapping on a compose button.

The following **optional** features are implemented:

- [x] When composing, you should have a countdown in the upper right for the tweet limit.
- [x] After creating a new tweet, a user should be able to view it in the timeline immediately without refetching the timeline from the network.
- [x] Profile Page
   - [x] Implement the paging view for the user description.
   - [ ] As the paging view moves, increase the opacity of the background screen. See the actual Twitter app for this effect
   - [ ] Pulling down the profile page should blur and resize the header image.
- [ ] Account switching
   - [ ] Long press on tab bar to bring up Account view with animation
   - [ ] Tap account to switch to
   - [ ] Include a plus button to Add an Account
   - [ ] Swipe to delete an account

The following **additional** features are implemented:

llowing **additional** features are implemented:

- [x] Display retweet/likes when retweeted and liked in details view, else hides 
- [x] Modified date formate in details view
- [x] Mention View
- [x] Enable retweet/favorite feature in cell and in details view
- [x] Reply to friends/tweet
- [x] Enable buttons to dismiss view controller
- [x] Display tweet with media image if user has one
- [x] Display location/website in profile view if user make it public
- [x] Change the twitter logo’s color with respect to different view controller
- [x] Disable send button when tweet is over 140 characters
- [x] Send tweet height changes as keyboard shows/hides
- [x] Placeholder in textView, hide when editing begins and show when textView is empty
- [x] When favorite icon is clicked, heart-animation show up

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. Protcol usage/benefits
2. Tips for reading/understanding/using Twitter API

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

<img src='http://i.imgur.com/nRR83fX.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />
<img src='http://i.imgur.com/lYujaha.gif' width='' alt='Video Walkthrough' />
<img src='http://i.imgur.com/NMSFqex.gif' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

I runs into many walls and spending days on stackoverflow to find solutions. It's because I did not realize the point of this assignment is for us to learn and use protocol. I have been lookings for way to go around to pass data from the Cell.swift to other view controller. Working with multiple view controllers can be a headache but it's a lot of us. Another main challenge is the implemntation of "sub-view". I want to do more within a sing view controller but somehow I just cound not figure that out and being using an extra view controller as a temoporary fix.

## License

    Copyright [2016] [Zhipeng Mei]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
