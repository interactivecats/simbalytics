import React from 'react'
import { BrowserRouter as Router, Route, Switch } from 'react-router-dom'
import App from '../containers/App'
import { Communities } from '../containers/Community'
import NotFound from '../components/NotFound'

const Routes = () => (
  <Router>
    <App>
      <Switch>
        <Route exact path="/app" component={Communities} />
        <Route component={NotFound} />
      </Switch>
    </App>
  </Router>
)

export default Routes
