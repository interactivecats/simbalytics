import DevStore from './configureStore.dev'
import ProdStore from './configureStore.prod'

if (process.env.NODE_ENV === 'production') {
  module.exports = ProdStore
} else {
  module.exports = DevStore
}
