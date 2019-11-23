const render = ({ output }) => {
  if (typeof output === "undefined") return null;
  const artist = (output.artist === "" ? output.artist : output.artist + " - ");
  const track = output.track;
  const playing = (output.playing === "playing" ? '\u25B6\uFE0E ' :  ''/*'\u23F8\uFE0E'*/);
  if (typeof artist === "undefined" || typeof track === "undefined" || track === "") return null;
  return <div>[{playing}{artist}{track}]</div>;
};

export default render;
