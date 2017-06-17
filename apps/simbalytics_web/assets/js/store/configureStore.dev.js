import { createStore, combineReducers, applyMiddleware, compose } from 'redux'
import { createLogger } from 'redux-logger'
import reducers, { formReducer } from '../reducers'
import DevTools from '../containers/DevTools'

const configureStore = (client, preloadedState) => {
  const store = createStore(
    combineReducers({
      form: formReducer,
      apollo: client.reducer(),
    }),
    preloadedState,
    compose(
      applyMiddleware(createLogger(), client.middleware()),
      DevTools.instrument(),
    ),
  )

  if (module.hot) {
    // Enable Webpack hot module replacement for reducers
    module.hot.accept('../reducers', () => {
      const nextRootReducer = reducers.default
      store.replaceReducer(nextRootReducer)
    })
  }

  return store
}

export default configureStore
