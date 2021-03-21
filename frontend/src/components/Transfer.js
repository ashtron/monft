import React from "react";

export function Transfer({ from, transferMon }) {
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
          <input className="btn btn-primary" type="submit" value="Transfer" />
        </div>

        <div className="row justify-content-md-center" style={{ marginBottom: 15 }}>
          <input className="form-control" type="text" name="to" placeholder="Address" required />
        </div>
      </form>
    </div>
  );
}
