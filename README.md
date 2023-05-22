# exchangeRate---recrutiment-task

In this repository I added some tests written in `Cucumber/Pactum` for one specific endpoint:
https://api.apilayer.com/exchangerates_data/latest. 
Tests cover API codes `200`, `400`, `401`, `403`, `404`.

## Setup 
Before running tests you'll need to do following steps:

    1. Find '.env-temp' file, create a copy of it and name the new file '.env'
    2. Open '.env' file and set your API_KEY

## Usage
Now you're ready to run tests. 
Use following command:
```bash
npm run test
```
