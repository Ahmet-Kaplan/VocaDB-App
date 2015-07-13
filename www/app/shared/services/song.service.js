/**
 * SongService Factory
 * @namespace Factories
 */

(function () {
    'use strict';
    angular
            .module('app.service')
            .factory('songservice', songService);

    songService.$inject = ['dataservice','exception'];

    /**
     * @namespace SongService
     * @desc Service for request song information
     * @memberOf Factories
     */
    /* @ngInject */
    function songService(dataservice, exception)
    {
        var service = {
            ready: dataservice.ready,
            getSongById: getSongById,
            getCommentList: getCommentList,
            querySongByName: querySongByName,
            getSongListByPV: getSongListByPV,
            querySongByTag: querySongByTag
        };

        return service;

        ///////////////////////////////////////

        /*
         * Gets a song by Id.
         * Reference : http://vocadb.net/apiHelp/Api/GET-api-songs-id_fields_lang
         * @param {String} songId
         * @param {Function} callback
         */
        function getSongById(songId) {
            var parms = {
                Id: songId,
                fields: 'ThumbUrl,Artists,PVs,Albums,Tags,Names'
            };
            return dataservice.callApi('/api/songs/:Id', parms)
                    .then(getSongByIdComplete)
                    .catch(function (message) {
                        exception.catcher('Call API Failed for getArtistById')(message);
                        //$location.url('/');
                    });

            function getSongByIdComplete(data, status, headers, config) {
                return data;
            }
        }
        ;

        /*
         * Gets a list of comments for a song.
         * Reference : http://vocadb.net/apiHelp/Api/GET-api-songs-songId-comments
         * @param {String} songId
         * @param {Function} callback
         */
        function getCommentList(songId, callback) {
        }
        ;

        /*
         * Gets a list of song names.
         * Reference : http://vocadb.net/apiHelp/Api/GET-api-songs-names_query_nameMatchMode_maxResults
         * @param {String} query
         * @param {Function} callback
         */
        function querySongByName(query, callback) {
            var parms = {
                query: query,
                getTotalCount: false,
                fields: 'ThumbUrl',
                nameMatchMode: 'Auto'
            };
            
            return dataservice.callApi('/api/songs', parms)
                    .then(querySongByNameComplete)
                    .catch(function (message) {
                        exception.catcher('Call API Failed for querySongByNameComplete')(message);
                        //$location.url('/');
                    });

            function querySongByNameComplete(data, status, headers, config) {
                return data;
            }

        }
        ;

        /*
         * Reference : http://vocadb.net/apiHelp/Api/GET-api-songs_pvService_pvId_fields_lang
         * @param {String} query
         * @param {Function} callback
         */
        function getSongListByPV(query) {
            var parms = {
                onlyWithPvs: true,
                sort: 'AdditionDate',
                start: 0,
                maxResults: 15,
                fields: 'ThumbUrl'
            };

            return dataservice.callApi('/api/songs', parms)
                    .then(getSongListByPVComplete)
                    .catch(function (message) {
                        exception.catcher('Call API Failed for getSongListByPVComplete')(message);
                        //$location.url('/');
                    });

            function getSongListByPVComplete(data, status, headers, config) {
                return data;
            }
        }
        ;
        
        
        function querySongByTag(tag, callback) {
            var parms = {
                tag: tag,
                getTotalCount: false,
                fields: 'ThumbUrl',
                nameMatchMode: 'Auto'
            };
            
            return dataservice.callApi('/api/songs', parms)
                    .then(querySongByTag)
                    .catch(function (message) {
                        exception.catcher('Call API Failed for querySongByTag')(message);
                        //$location.url('/');
                    });

            function querySongByTag(data, status, headers, config) {
                return data;
            }
        }
        ;

    }
})();