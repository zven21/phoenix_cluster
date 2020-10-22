import React from 'react';
import ReactDOM from 'react-dom';

import { createStore, applyMiddleware } from 'redux';
import { Provider, connect } from 'react-redux';
import promiseMiddleware from 'redux-promise';

const debug = require('debug')('util/renderApp');

export default function(options = {}) {
  const root = document.querySelector('#app');

  console.log("state", root.dataset.state)

  const state = JSON.parse(root.dataset.state);

  debug('page state: ', state);

  const reducer = options.reducer || (o => o);
  const store = createStore(reducer, state,
      applyMiddleware(promiseMiddleware));

  store.dispatch({ type: 'INIT' });

  return (App) => {
    App = connect(v => v)(App);
    ReactDOM.render(
      <Provider store={store}>
        <App />
      </Provider>, root
    );
  };
}
