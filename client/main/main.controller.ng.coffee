'use strict'

angular.module 'buildoSolidFunApp'
.controller 'MainCtrl', ($scope, $ionicScrollDelegate, $meteor) ->

  Users = $meteor.collection(Meteor.users)

  $scope.helpers
    things: () => Things.find {}, { sort: { createdAt: -1 } }
    users: () => Users

  $scope.subscribe 'things', () ->
    [
      {}
      $scope.getReactively 'search'
    ]

  console.log($scope.things)

  $scope.remove = (thing) ->
    if not confirm 'Sure?' then return
    Things.remove
      _id: thing._id
    $ionicScrollDelegate.resize()

  update = (thing) =>
    Things.update thing._id, { $set: { parties: thing.parties } }

  $scope.picture = (user, options = {}) => "//graph.facebook.com/#{user.services.facebook.id}/picture?height=#{options.height}"

  $scope.pictureFromId = (_id) => $scope.picture Users.find(_id)

  $scope.togglePerson = (thing, person) =>
    if thing.parties.indexOf(person) is -1
      thing.parties = thing.parties.concat(person)
    else
      thing.parties = thing.parties.filter (p) => p isnt person
    update thing

  $scope.initials = (name) =>
    name
      .split(' ')
      .map (x) => x[0]
      .join('')
