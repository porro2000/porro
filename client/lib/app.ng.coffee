app = angular.module 'buildoSolidFunApp', [
  'angular-meteor'
  'ionic'
  'accounts.ui'
]

onReady = () ->
  angular.bootstrap document, ['buildoSolidFunApp']

if Meteor.isCordova
  angular.element(document).on 'deviceready', onReady
else
  angular.element(document).ready onReady

app.directive 'ngEnter', ->
  (scope, element, attrs) ->
    element.bind "keydown keypress", (event) ->
      if event.which is 13
        scope.$apply -> scope.$eval(attrs.ngEnter)
        event.preventDefault()
