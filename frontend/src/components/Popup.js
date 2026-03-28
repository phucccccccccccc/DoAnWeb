import React from "react";

function Popup({ message, onClose }) {
  return (
    <div style={overlay}>
      <div style={popup}>
        <h3>Thông báo</h3>
        <p style={{ margin: "20px 0" }}>{message}</p>

        <button onClick={onClose} style={button}>
          OK
        </button>
      </div>
    </div>
  );
}

const overlay = {
  position: "fixed",
  top: 0,
  left: 0,
  width: "100%",
  height: "100%",
  background: "rgba(0,0,0,0.4)",
  display: "flex",
  justifyContent: "center",
  alignItems: "center"
};

const popup = {
  background: "white",
  padding: 30,
  borderRadius: 8,
  textAlign: "center"
};

const button = {
  padding: "8px 20px",
  background: "blue",
  color: "white",
  border: "none"
};

export default Popup;