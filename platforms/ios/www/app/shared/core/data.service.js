(function() {
    'use strict';

    angular
        .module('app.core')
        .factory('dataservice', dataservice);

    dataservice.$inject = ['$q','$resource', 'logger', 'apiurl','$cacheFactory'];

    /* @ngInject */
    function dataservice($q,$resource, logger, apiurl, $cacheFactory) {
        
        var cacheEngine = $cacheFactory("1");
        var service = {
            ready : ready,
            callApi : callApi
        };

        return service;

        ////////////////////////
        
        function ready(promises) {
            return $q.all(promises);
        }
        
        function getDefaultResource(apiUrl,load) {
            var paramDefaults = {callback: 'JSON_CALLBACK'};
            var actions = {
                'load': {
                    'method': 'JSONP',
                    'cache': true
                }
            };
            
            for (var prop in load) 
                actions['load'][prop] = load[prop];

            return $resource(apiUrl, paramDefaults, actions);
        }
        
        function callApi(endPoint,params,load) {
            var q = $q.defer();
            var apiUrl = apiurl(endPoint);
            var cacheId = angular.toJson(params);
            var cache = (cacheId) ? cacheEngine.get(cacheId) : null;
            
            logger.info("callapi url : ",apiUrl);
            logger.info("callapi params : ",angular.toJson(params));
            
            if(cache) {
                logger.info("get from cache");
                q.resolve(cache);
            } else {
                logger.info("get from "+endPoint);
                getDefaultResource(apiUrl,load).load(params, success, failure);
            }
            
            function success(resp) {
                //logger.info("return : ",angular.toJson(resp));
                cacheEngine.put(cacheId, resp);
                q.resolve(resp);
            };
            
            function failure(err) {
                q.reject(err);
            };
            
            return q.promise;
        }
    }
})();