import React from 'react'
import PropTypes from 'prop-types'


const App = (props) => {
  return (
    <div className="app">
      {props.children}
    </div>
  )
}

App.propTypes = {
  children: PropTypes.node.isRequired,
}

export default App
