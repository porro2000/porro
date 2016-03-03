'use strict'

log = (x) => console.log x

angular.module 'buildoSolidFunApp'
.directive 'nav', ($state) ->
  restrict: 'AE'
  templateUrl: 'client/components/nav/nav.view.html'
  replace: true
  link: (scope, elem, attr) ->

    scope.getState = =>
      $state.current.name

    scope.login = => Meteor.loginWithFacebook log

    scope.logout = => Meteor.logout log
