import DateTime from "./lib/DateTime.jsx";
import Battery from "./lib/Battery.jsx";
import Cpu from "./lib/Cpu.jsx";
import Wifi from "./lib/Wifi.jsx";
import Volume from "./lib/Volume.jsx";
import Error from "./lib/Error.jsx";
import parse from "./lib/parse.jsx";
import styles from "./lib/styles.jsx";
import Spotify from "./lib/Spotify.jsx";

const style = {
  display: "grid",
  padding: "0 12px",
  gridAutoFlow: "column",
  gridGap: "16px",
  position: "fixed",
  overflow: "hidden",
  right: "0px",
  bottom: "0px",
  color: styles.colors.dim,
  fontFamily: styles.fontFamily,
  fontSize: styles.fontSize,
  lineHeight: styles.lineHeight,
  fontWeight: styles.fontWeight
};

export const refreshFrequency = 10000;

export const command = "./nibar/scripts/stats.sh";

export const render = ({ output }) => {
  const data = parse(output);
  if (typeof data === "undefined") {
    return (
      <div style={style}>
        <Error msg="Error: unknown script output" side="right" />
      </div>
    );
  }
  return (
    <div style={style}>
{/*   <Netstats output={data.netstats} /> */}
{/*   <Dnd output={data.dnd} /> */}
      <Spotify output={data.spotify} />
      <Volume output={data.volume} />
      <Wifi output={data.wifi} />
      <Cpu output={data.cpu} />
      <Battery output={data.battery} />
      <DateTime output={data.datetime} />
    </div>
  );
};

export default null;
