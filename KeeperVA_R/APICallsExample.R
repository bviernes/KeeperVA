#### API Calls ###


library(httr)
library(jsonlite)

# Set your API key (you need to get this from OpenAI)
api_key <- "YOUR_API_KEY_HERE"

# Define the API endpoint for ChatGPT (chat completions)
#url <- https://api.openai.com/v1/chat/completions
url <- "https://vagptbeta.va.gov"

# Prepare the header with your API key
headers <- add_headers(
  "Content-Type" = "application/json",
  "Authorization" = paste("Bearer", api_key)
)

# Construct the request body with the model and messages
data <- list(
  model = "gpt-4",  # or another supported model
  messages = list(
    list(role = "system", content = "You are a helpful assistant."),
    list(role = "user", content = "Hello, how can I access the ChatGPT API from R?")
  )
)

# Convert the data to JSON format
json_data <- toJSON(data, auto_unbox = TRUE)

# Send the POST request
response <- POST(url, headers, body = json_data)

# Check the status code
if (status_code(response) == 200) {
  # Parse the response content
  result <- content(response, as = "text")
  result_json <- fromJSON(result)
  print(result_json)
} else {
  # Print the error message if something goes wrong
  print(paste("Error:", status_code(response)))
  print(content(response, as = "text"))
}
