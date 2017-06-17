import RootProd from './Root.prod'
import RootDev from './Root.dev'

if (process.env.NODE_ENV === 'production') {
  module.exports = RootProd
} else {
  module.exports = RootDev
}
