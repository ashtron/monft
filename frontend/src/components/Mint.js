import React from "react";

export function Mint({ mint }) {
  const styles = {
    background: "none",
    border: "none",
  }

  return (
    <div>
      <button style={styles} onClick={mint}>
        <img src={require(`../assets/button_mint_1.png`)} style={{ width: 225 }}></img>
      </button>
    </div>
  );
}
