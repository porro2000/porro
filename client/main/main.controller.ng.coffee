'use strict'

angular.module 'buildoSolidFunApp'
.controller 'MainCtrl', ($scope, $ionicScrollDelegate, $meteor) ->

  $scope.helpers
    things: () => Things.find {}, { sort: { createdAt: -1 } }
    users: () => $meteor.collection(Meteor.users)

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

  $scope.picture = (userId, options = {}) => "//graph.facebook.com/#{userId}/picture?height=#{options.height}"

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
