import React from "react";

export function Transfer({ from, transferMon }) {
  const styles = {
    background: "none",
    border: "none",
  }

  return (
    <div>
      <form
        onSubmit={(event) => {
          event.preventDefault();

          const formData = new FormData(event.target);
          const to = formData.get("to");

          if (to) {
            transferMon(from, to, 1);
          }
        }}
      >

        <div className="row justify-content-md-center" style={{ marginBottom: 15 }}>
          <button style={styles} type="submit" value="Transfer">
            <img src={require(`../assets/button_transfer_1.png`)} style={{ width: 225 }}></img>
          </button>
        </div>

        <div className="row justify-content-md-center" style={{ marginBottom: 15 }}>
          <input className="form-control" type="text" name="to" placeholder="Address" required />
        </div>
      </form>
    </div>
  );
}
