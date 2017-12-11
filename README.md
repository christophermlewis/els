# Els

I've provided a static html file to show the websockets in action.
It appends to the list whenever a refresh is done, this is just to evidence the updates.

If you start the app 

      iex -S mix

and browse to 

  http://localhost:8000

you'll be served index.html page

The following I would change given more time:

- Stub HackerNews when in test to return stubbed responses allowing tests  without having to hit the real site
- Pass the pid of the Repository to the supervisor so that testing HackerNews refreshes can be verified via the test
- HackerNews calls HTTPoison.get! -> if a get fails it will terminate the process. This is by design, however allowing timeouts, retries etc would be a preferred choice
- Test the supervision 
- Test Coverage of responses back from hackenews  verifying stories are of expected type
- Tests around API -> for a full blown API you would verify more status codes and conditions
