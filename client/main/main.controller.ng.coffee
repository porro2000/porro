'use strict'

angular.module 'buildoSolidFunApp'
.controller 'MainCtrl', ($scope, $ionicScrollDelegate, $ionicActionSheet, $meteor) ->

  didJoin = (user, thing) => thing.parties.indexOf(user._id) >  - 1

  portionJoined = (user, thing) => if didJoin(user, thing) then (1 / thing.parties.length) else 0

  sumJoined = (user) => (acc, thing) => acc + portionJoined(user, thing)

  $scope.helpers
    things: () => Things.find { done: $ne: true }, { sort: { createdAt: -1 } }
    doneThings: () => Things.find { done: true }, { sort: { createdAt: -1 } }
    users: () => $meteor.collection(Meteor.users)

  $scope.joined = (user) => Math.round($scope.doneThings.reduce(sumJoined(user), 0)*100)/100

  Users = $meteor.collection(Meteor.users).sort((user1, user2) => $scope.joined(user2) - $scope.joined(user1))

  remove = (thing) ->
    Things.remove
      _id: thing._id
    $ionicScrollDelegate.resize()

  update = (thing) =>
    Things.update thing._id, { $set: { parties: thing.parties, done: thing.done } }

  $scope.picture = (user) => $scope.pictureFromFBId(user?.services?.facebook?.id)

  $scope.pictureFromId = (_id) =>
    user = Users.filter((u) => u._id === _id)[0]
    $scope.picture(user)

  $scope.pictureFromFBId = (FBId) => "//graph.facebook.com/#{FBId}/picture"

  $scope.togglePerson = (thing, person) =>
    if thing.parties.indexOf(person) is -1
      thing.parties = thing.parties.concat(person)
    else
      thing.parties = thing.parties.filter (p) => p isnt person
    update thing

  $scope.checkAsDone = (thing) =>
    thing.done = yes
    update thing


  $scope.showConfirmDelete = (thing) ->
    hideSheet = $ionicActionSheet.show({
      destructiveText: 'Delete',
      titleText: 'Are you sure?',
      cancelText: 'Cancel',
      cancel: hideSheet,
      destructiveButtonClicked: ->
        remove thing
        hideSheet()
    })

  maxJoined = $scope.joined(Users[0])

  $scope.barWidth = (user) => "#{($scope.joined(user)/maxJoined)*100}%"
