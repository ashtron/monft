import React from "react";

export function MonsterDisplay({ dna }) {
  return (
      <div style={{ width: 500, height: 500 }}>
          <img id="body" src={require("../parts/body_0001.svg")}></img>
      </div>
  );
}