@Things = new Mongo.Collection('things')

Things.allow
  insert: (userId, thing) ->
    thing.createdAt = new Date()
    thing.name_sort = thing.name.toLowerCase()
    userId
  update: (userId, thing, fields, modifier) ->
    console.log(userId, thing, fields, modifier)
    thing.updatedAt = new Date()
    thing.updatedBy = userId
    thing.name_sort = thing.name.toLowerCase()
  remove: (userId, thing) -> !!userId
