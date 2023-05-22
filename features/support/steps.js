require('dotenv').config()
const pactum = require('pactum')
const { Given, When, Then, Before, After } = require('@cucumber/cucumber')

let spec = pactum.spec()

Before(() => {
  spec = pactum.spec()
})

Given(/^I make a "(.*)" request to "(.*)"$/, function (method, endpoint) {
  spec[method.toLowerCase()](endpoint)
})

Given(/^I set header "(.*)" to "(.*)"$/, function (key, value) {
  spec.withHeaders(key, value)
})

Given('I use a valid API key', function () {
  spec.withHeaders('apikey', process.env.API_KEY)
})

When('I receive a response', async function () {
  await spec.toss()
})

Then('I expect response should have a status "{int}"', function (code) {
  spec.response().should.have.status(code)
})

Then(/^I expect response should have a json$/, function (json) {
  spec.response().should.have.json(JSON.parse(json))
})

Then(/^I expect response should have a json like$/, function (json) {
  spec.response().should.have.jsonLike(JSON.parse(json))
})

Then(/^I expect response should have a json like at "(.*)"$/, function (path, value) {
  spec.response().should.have.jsonLike(path, JSON.parse(value))
})

Then(/^I expect response should have a json schema at "(.*)"$/, function (path, value) {
  spec.response().should.have.jsonSchema(path, JSON.parse(value))
})

After(() => {
  spec.end()
})
