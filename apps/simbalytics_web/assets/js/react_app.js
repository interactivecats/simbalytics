import React from 'react'
import ReactDOM from 'react-dom'
import ApolloClient, { createNetworkInterface } from 'apollo-client'
import Root from './containers/Root'
import configureStore from './store/configureStore'

const networkInterface = createNetworkInterface({
  uri: '/graphql',
})
networkInterface.use([{
  applyMiddleware(req, next) {
    if (!req.options.headers) {
      req.options.headers = {}  // Create the header object if needed.
    }
    // get the authentication token from local storage if it exists
    const token = window.userToken
    req.options.headers.authorization = token ? `Bearer ${token}` : null
    next()
  },
}])

const client = new ApolloClient({
  networkInterface,
})

const store = configureStore(client)

ReactDOM.render(
  <Root client={client} store={store} />
  , document.getElementById('root'),
)
