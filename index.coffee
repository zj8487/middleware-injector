_ = require 'underscore'
async = require 'async'

module.exports = (req, res, next) ->
  req.inject = (dependency, callback) ->
    if req.injected
      dependency = _.reject dependency, (item) ->
        return item in req.injected

    async.eachSeries dependency, (item, callback) ->
      req.injected = [] unless req.injected
      req.injected.push item
      item req, res, callback
    , callback
