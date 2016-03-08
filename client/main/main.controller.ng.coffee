'use strict'

angular.module 'buildoSolidFunApp'
.controller 'MainCtrl', ($scope, $ionicScrollDelegate, $ionicActionSheet, $meteor) ->

  Users = $meteor.collection(Meteor.users)

  $scope.helpers
    things: () => Things.find {}, { sort: { createdAt: -1 } }
    users: () => $meteor.collection(Meteor.users)

  $scope.subscribe 'things', () ->
    [
      {}
      $scope.getReactively 'search'
    ]

  remove = (thing) ->
    Things.remove
      _id: thing._id
    $ionicScrollDelegate.resize()

  update = (thing) =>
    Things.update thing._id, { $set: { parties: thing.parties } }

  $scope.picture = (user) => $scope.pictureFromFBId(user?.services?.facebook?.id)

  $scope.pictureFromId = (_id) =>
    user = Users.filter( (u) => u._id)[0]
    $scope.picture(user)

  $scope.pictureFromFBId = (FBId) => "//graph.facebook.com/#{FBId}/picture"

  $scope.togglePerson = (thing, person) =>
    if thing.parties.indexOf(person) is -1
      thing.parties = thing.parties.concat(person)
    else
      thing.parties = thing.parties.filter (p) => p isnt person
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
