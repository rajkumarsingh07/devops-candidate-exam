import requests

payload = {
  "subnet_id": "aws_subnet.private.id",
  "name": "Rajkumar Singh",
  "email": "rajkumarsingh07@gmail.com"
}

headers = {
    'X-Siemens-Auth': 'test'
}

url = 'https://ij92qpvpma.execute-api.eu-west-1.amazonaws.com/candidate-email_serverless_lambda_stage/data'

response = requests.post(url, json=payload, headers=headers)

print(response.status_code)
print(response.json())
