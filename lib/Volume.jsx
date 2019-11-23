const render = ({ output }) => {
  if (typeof output === "undefined") return null;
  const value = output.value;
  const mute = output.mute;
  if (mute === "true") return <div>muted</div>;
  return <div>{value}</div>;
};

export default render;
