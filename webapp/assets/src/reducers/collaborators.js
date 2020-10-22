const ACTIONS = {
  COLLABORATOR_UPDATE: (_, payload) => payload.users
};

export default function(state, action) {
  const handler = ACTIONS[action.type];
  return handler ? handler(state, action) : state || [];
}
