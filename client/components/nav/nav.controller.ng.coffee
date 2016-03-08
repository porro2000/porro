'use strict'

angular.module 'buildoSolidFunApp'
.controller 'NavCtrl', ($scope, $ionicScrollDelegate, $meteor) ->

  $scope.user = Meteor.user()

  $scope.initials = (name = '') =>name.trim().split(' ').map((x) => x[0]).join('')
