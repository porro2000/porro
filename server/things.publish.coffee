'use strict'

Api = new Restivus({
  prettyJson: true
  apiPath: '/'
})

Api.addRoute('add', {
  post: ->
    name = this.bodyParams.text
    createdAt = new Date()
    createdBy = 'API' # TODO think about profile pic
    parties = []
    thingId = Things.insert { name, createdBy, createdAt, parties }
    if thingId then { success: "added porro " + thingId } else { fail: 'porro not added' }
})
