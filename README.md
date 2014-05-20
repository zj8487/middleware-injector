## middleware-injector
Node.js middleware dependency injection tool.

## Install

    npm install middleware-injector

## Usage

    parseToken = (req, res, next) ->
      req.token = req.cookies.token
      next()

    accountInfo = (req, res, next) ->
      req.inject [parseToken], ->
        mAccount.authenticate req.token, (account) ->
          req.account = account
          next()

    errorHandling = (req, res, next) ->
      res.error = (name, param) ->
        param = _.extend param, error: name
        res.json 400, param
      next()

    requestAuthenticate = (req, res, next) ->
      req.inject [accountInfo, errorHandling], ->
        if req.account
          next()
        else
          if req.method == 'GET'
            res.redirect '/account/login/'
          else
            res.error 'auth_failed'
