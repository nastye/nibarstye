import Desktop from "./lib/Desktop.jsx";
import Error from "./lib/Error.jsx";
import parse from "./lib/parse.jsx";
import styles from "./lib/styles.jsx";

const style = {
  padding: "0 12px",
  display: "grid",
  gridAutoFlow: "column",
  gridGap: "16px",
  position: "fixed",
  overflow: "hidden",
  left: "0px",
  top: "0px",
  fontFamily: styles.fontFamily,
  lineHeight: styles.lineHeight,
  fontWeight: styles.fontWeight,
  fontSize: styles.fontSize,
  color: styles.colors.dim
};

export const refreshFrequency = false;

export const command = "./nibar/scripts/spaces-primary.sh";

export const render = ({ output }) => {
  const data = parse(output);
  if (typeof data === "undefined") {
    return (
      <div style={style}>
        <Error msg="Error: unknown script output" side="left" />
      </div>
    );
  }
  if (typeof data.error !== "undefined") {
    return (
      <div style={style}>
        <Error msg={`Error: ${data.error}`} side="left" />
      </div>
    );
  }
  if (typeof data !== "undefined") {
    return (
      <div style={style}>
        <Desktop output={data.desktop} />
      </div>
    );
  }
  return (
    <div style={style}></div>
  )
};

export default null;
