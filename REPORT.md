# MP Report

## Team

- Name(s): Patel Zeel Rakshitkumar
- AID(s): A20556822

## Self-Evaluation Checklist

Tick the boxes (i.e., fill them with 'X's) that apply to your submission:

- [x] The app builds without error
- [x] I tested the app in at least one of the following platforms (check all that apply):
  - [x] iOS simulator / MacOS
  - [x] Android emulator
- [x] There are at least 3 separate screens/pages in the app
- [x] There is at least one stateful widget in the app, backed by a custom model class using a form of state management
- [x] Some user-updateable data is persisted across application launches
- [x] Some application data is accessed from an external source and displayed in the app
- [x] There are at least 5 distinct unit tests, 5 widget tests, and 1 integration test group included in the project

## Questionnaire

Answer the following questions, briefly, so that we can better evaluate your work on this machine problem.

1. What does your app do?

  The app is a news reader that allows users to search for and browse news articles from the News API. Users can filter the news by country, category, or news channel. The app allows users to search for specific news articles using keywords, and it displays the results dynamically. Users can tap on any article to view its details in a new screen.

2. What external data source(s) did you use? What form do they take (e.g., RESTful API, cloud-based database, etc.)?

   The app uses NewsAPI as the external data source, which is a RESTful API that provides news articles. The app fetches the top headlines, and news articles are filtered based on user-selected parameters like country, category, and news channel.

3. What additional third-party packages or libraries did you use, if any? Why?

  cached_network_image: Used to efficiently display images in a list and cache them for faster subsequent loads.
  google_fonts: Used for custom fonts to enhance the design and readability of the app.
  http: Used to make HTTP requests to fetch news articles from the NewsAPI.
  flutter: The core framework for building the app.

4. What form of local data persistence did you use?

   SharedPreferences is used to store and retrieve user preferences such as the selected country and category. This ensures that the user’s selections persist across app launches.

5. What workflow is tested by your integration test?

   The integration test would likely focus on ensuring the following:
   The app correctly fetches news from the API based on the selected country, category, and news channel.
   The search functionality works as expected when a keyword is entered.
   The app correctly handles scenarios where no results are found or when the API call fails.
   Navigation between pages works properly (e.g., from the main page to the article detail page).

## Summary and Reflection

API Key Usage: Due to reaching the daily limit on my API key, I have used a friend's API key for fetching the news articles. The API key provided in the code (81a79e41c8af42198f4a64e6cc96bf9f) is currently active, and the app should work with this key. If you want to use my original key, you can replace it with (70264e1a57314340a764719da1795fc4) in the code in file named constants.dart and main.dart. For validation i have included its screenshot in folder.even you can use your new api key for testing.

I have submitted the output screenshot (outputzeel), which includes both the dark and light modes of the app, with all features functioning correctly. Additionally, I have included a picture showing the selected category, demonstrating that SharedPreferences is working properly. The app clearly displays the category the user has selected, ensuring the selected category is visible and retained across app launches.

What I Enjoyed:

I enjoyed building the user interface (UI) for the app. It was rewarding to see the app dynamically update based on user inputs like country, category, and news channel selections.
Working with the NewsAPI was interesting, and I liked how I could fetch news articles dynamically, with filtering based on user preferences. This made the app feel responsive and personalized.

Challenges:

One of the major challenges I faced was the API daily usage limit. I initially used my own API key, but I soon encountered the daily limit, which restricted me from further testing. I had to switch to a friend's API key, which solved the immediate issue but highlighted the need to handle API limits more effectively.
Error handling for cases where no results are found or the API fails was another area that I struggled with. I initially had issues ensuring that the app gracefully handles these scenarios and provides meaningful feedback to the user.

What I Wish I Had Known Before Starting:

I wish I had known more about API rate limits and how to handle them before starting the project. I encountered the daily limit quickly, and understanding how to manage or request higher limits would have saved me time and effort.
Learning more about best practices for API usage in Flutter would have been beneficial, particularly when dealing with rate-limited APIs. Understanding how to gracefully handle API failures and retries would have been helpful.