'use strict'

angular.module 'buildoSolidFunApp'
.config ($stateProvider) ->
  $stateProvider
  .state 'archive',
    url: '/archive'
    templateUrl: 'client/archive/archive.view.html'
    controller: 'MainCtrl'
    resolve:
      currentUser: ['$meteor', ($meteor) ->
        $meteor.requireUser()
      ]
