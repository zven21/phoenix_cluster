import {Socket, Presence} from 'phoenix';

const getSocket = () => {
  const socket = new Socket('/socket', {
  params: {
    token: window.userToken
  }
  });

  socket.connect();
  return socket;
};

export const getChannel = (dispatch) => {
  const ch = getSocket().channel(`page:index`);
  const presence = new Presence(ch);

  ch.join()
    // eslint-disable-next-line no-console
    .receive('ok', resp => { console.log('Joined successfully', resp); })
    // eslint-disable-next-line no-console
    .receive('error', resp => { console.error('Unable to join', resp); });

  presence.onSync(
    () => dispatch({
      type: 'COLLABORATOR_UPDATE',
      users: getUsers(presence.list())
    })
  );

  return ch;
};

function getUsers(list) {
  return list.map(
    ({metas}) => Object.values(metas)[0]
  );
}
