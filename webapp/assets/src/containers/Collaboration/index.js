import React from 'react';
import {connect} from 'react-redux';
import { getChannel } from './socket';

class Collaboration extends React.Component {

  componentDidMount() {
    this.channel = getChannel(this.props.dispatch);
    this.channel.push('user:focus', {})
  }

  // componentDidUpdate(prevProps) {
  //   this.channel.push('user:focus', {});
  // }

  render() {
    console.log('props,', this.props)
    // const collaborators = this.props.collaborators.filter(
    //   c => c.id !== this.props.user.id
    // );

    return (
      <section id="collaboration">
        { this.renderMessage(this.props.collaborators) }
      </section>
    );
  }

  renderMessage(collaborators) {
    if (collaborators.length === 0) {
      return null;
    }

    return (
      <div>
        <p>在线用户</p>
        <ul>
        {
          collaborators.map((item, index) => (
            <li key={index}>
            {
              item.email
            }
            </li>
          ))
        }
        </ul>
      </div>
    );
  }
}

export default connect(
  st => ({
    collaborators: st.collaborators,
  })
)(Collaboration);
