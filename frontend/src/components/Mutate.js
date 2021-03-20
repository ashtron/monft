import React from "react";

export function Mutate({ mutate }) {
  return (
    <div>
      <button className="btn btn-primary" onClick={mutate}>Mutate</button>
    </div>
  );
}
