import React          from 'react';
// import ReactDOM       from 'react-dom';
import renderApp      from '../utils/renderApp';
import reducer        from '../reducers/user';
import Collabration   from '../containers/Collaboration';

const IndexPage = (props) => {
  return (
    <div>
      <h1>Hello User</h1>
      <Collabration />
    </div>
  )
};

renderApp({ reducer })(IndexPage);

// const root = document.querySelector('#app');
// console.log('root', root);
// const state = JSON.parse(root.dataset.state);
// ReactDOM.render(<IndexPage />, root);