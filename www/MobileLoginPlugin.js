var exec = require('cordova/exec');

var MobileLoginPlugin = { 
    onekey_init: function(
        success,
        error        
    ) {
        exec(success, error, 'MobileLoginPlugin', 'onekey_init', ['']);
    },
    onekey_login: function(
        success,
        error        
    ) {
        exec(success, error, 'MobileLoginPlugin', 'onekey_login', ['']);
    } 
}

module.exports = MobileLoginPlugin