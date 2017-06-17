import React from 'react'
import PropTypes from 'prop-types'
import { ApolloProvider } from 'react-apollo'
import Routes from '../../routes'
import DevTools from '../DevTools'

const Root = (props) => {
  const { client, store } = props
  return (
    <ApolloProvider client={client} store={store}>
      <div>
        <Routes />
        <DevTools />
      </div>
    </ApolloProvider>
  )
}

Root.propTypes = {
  client: PropTypes.object.isRequired,  // eslint-disable-line react/forbid-prop-types
  store: PropTypes.object.isRequired, // eslint-disable-line react/forbid-prop-types
}

export default Root
