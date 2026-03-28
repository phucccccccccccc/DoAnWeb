import React, { useEffect, useState } from "react";
import api from "../api";

function Cart() {
  const [cartItems, setCartItems] = useState([]);
  const user_id = 1;

  const getCart = () => {
    api.get(`/cart/${user_id}`)
      .then((res) => setCartItems(res.data))
      .catch((err) => console.log(err));
  };

  useEffect(() => {
    getCart();
  }, []);

  const increaseQty = (id, qty) => {
    api.put("/cart/update", {
      cart_item_id: id,
      quantity: qty + 1
    }).then(() => getCart());
  };

  const decreaseQty = (id, qty) => {
    if (qty <= 1) return;

    api.put("/cart/update", {
      cart_item_id: id,
      quantity: qty - 1
    }).then(() => getCart());
  };

  const removeItem = (id) => {
    api.delete(`/cart/${id}`)
      .then(() => getCart());
  };

  // TÍNH TỔNG TIỀN
  const totalPrice = cartItems.reduce((sum, item) => sum + Number(item.total), 0);

  // CHECKOUT
  const checkout = () => {
    api.post("/cart/checkout")
      .then(() => {
        alert("Đặt hàng thành công 🎉");
        getCart();
      })
      .catch((err) => console.log(err));
  };

  return (
    <div style={{ padding: 30 }}>
      <h1>Giỏ hàng</h1>

      {cartItems.length === 0 && <p>Giỏ hàng đang trống</p>}

      {cartItems.map((item) => (
        <div
          key={item.cart_item_id}
          style={{
            border: "1px solid #ccc",
            margin: 10,
            padding: 15,
            width: 400
          }}
        >
          <h3>{item.name}</h3>
          <p>Giá: ${item.price}</p>
          <p>Số lượng: {item.quantity}</p>
          <p><b>Tổng: ${item.total}</b></p>

          <div style={{ display: "flex", gap: 10 }}>
            <button onClick={() => decreaseQty(item.cart_item_id, item.quantity)}>-</button>
            <button onClick={() => increaseQty(item.cart_item_id, item.quantity)}>+</button>
          </div>

          <button
            onClick={() => removeItem(item.cart_item_id)}
            style={{
              marginTop: 10,
              background: "red",
              color: "white",
              border: "none",
              padding: 5
            }}
          >
            Xoá sản phẩm
          </button>
        </div>
      ))}

      {/* TỔNG TIỀN */}
      <h2 style={{ marginTop: 20 }}>Tổng tiền: ${totalPrice}</h2>

      {/* NÚT CHECKOUT */}
      <button
        onClick={checkout}
        style={{
          marginTop: 10,
          padding: 10,
          background: "green",
          color: "white",
          border: "none"
        }}
      >
        Đặt Hàng
      </button>
    </div>
  );
}

export default Cart;