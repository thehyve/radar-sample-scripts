#!/bin/bash

baseUrl='<BASE_URL>'
clientId='<CLIENT_ID>'
clientSecret='<CLIENT_SECRET>'

# Get auth response
response=$(curl --silent --location "${baseUrl}/managementportal/oauth/token" \
  --header 'Content-Type: application/x-www-form-urlencoded' \
  --data-urlencode "client_id=${clientId}" \
  --data-urlencode "client_secret=${clientSecret}" \
  --data-urlencode 'grant_type=client_credentials')


# Extract the access token using jq
accessToken=$(echo "$response" | jq -r '.access_token')

echo "ACCESS TOKEN"
echo "$accessToken"
echo

# Get Projects (STEP2 - a)
projects_response=$(curl --silent --location "${baseUrl}/managementportal/api/projects" \
 --header "Authorization: Bearer $accessToken")

echo "PROJECTS"
echo "$projects_response" | jq -r '.[] | .projectName'
echo 

# Get Subjects (STEP2 - a)
subjects_response=$(curl --silent --location "${baseUrl}/managementportal/api/subjects" \
 --header "Authorization: Bearer $accessToken")

# Create lookup table for subjectId and subjectExternalId
lookup_table=$(echo "$subjects_response" | jq -r '.[] | "\(.login) \(.externalId)"')

# Create lookup table for login, externalId, and projectName
lookup_table=$(echo "$subjects_response" | jq -r '.[] | "\(.login) \(.externalId) \(.roles[0].projectName)"')

echo "SUBJECTS"
echo -e "Login\tExternalId\tProjectName"
echo "$lookup_table" | column -t -s $'\t'
echo


# Get Topics
topics_response=$(curl --silent --location "${baseUrl}/kafka/topics" \
 --header "Authorization: Bearer $accessToken")
echo "TOPICS" 
echo "$topics_response"
echo
