'use strict'

angular.module 'buildoSolidFunApp'
.controller 'ToolbarCtrl', ($scope, $ionicScrollDelegate, $meteor) ->

  $scope.user = Meteor.user().services.facebook.id

  $scope.save = () ->
    if not $scope.newThing.name then return
    $scope.newThing.createdAt = new Date()
    $scope.newThing.createdBy = $scope.user
    $scope.newThing.parties = []
    Things.insert $scope.newThing
    $scope.newThing = undefined
    $ionicScrollDelegate.resize()
