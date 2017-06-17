import { createStore, combineReducers, applyMiddleware, compose } from 'redux'
import { formReducer } from '../reducers'

const configureStore = (client, preloadedState) => {
  const store = createStore(
    combineReducers({
      form: formReducer,
      apollo: client.reducer(),
    }),
    preloadedState,
    compose(
      applyMiddleware(client.middleware()),
    ),
  )

  return store
}

export default configureStore
