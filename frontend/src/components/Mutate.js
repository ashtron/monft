import React from "react";

export function Mutate({ mutate }) {
  const styles = {
    background: "none",
    border: "none",
  }

  return (
    <div>
      <button style={styles} onClick={mutate}>
        <img src={require(`../assets/button_mutate_1.png`)} style={{ width: 225 }}></img>
      </button>
    </div>
  );
}
