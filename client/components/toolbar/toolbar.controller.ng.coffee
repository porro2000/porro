'use strict'

angular.module 'buildoSolidFunApp'
.controller 'ToolbarCtrl', ($scope, $ionicScrollDelegate, $meteor) ->

  $scope.user = Meteor.user()

  $scope.save = () ->
    if not $scope.newThing.name then return
    $scope.newThing.createdAt = new Date()
    $scope.newThing.createdBy = $scope.user._id
    $scope.newThing.parties = [$scope.user._id]
    Things.insert $scope.newThing
    $scope.newThing = undefined
    $ionicScrollDelegate.resize()
