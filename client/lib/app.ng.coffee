angular.module 'buildoSolidFunApp', [
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