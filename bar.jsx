import styles from "./lib/styles.jsx";

const style = {
  background: styles.colors.bg,
  cursor: "default",
  userSelect: "none",
  zIndex: "-1",
  width: "100%",
  height: "20px",
  position: "fixed",
  overflow: "hidden",
  bottom: "0px",
  right: "0px",
  left: "0px"
};

export const refreshFrequency = false;

export const render = ({ output }) => {
  return <div style={style} />;
};

export default null;
