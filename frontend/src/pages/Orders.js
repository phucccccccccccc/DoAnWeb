import React, { useEffect, useState } from "react";
import api from "../api";

function Orders() {
  const [orders, setOrders] = useState([]);

  useEffect(() => {
    api.get("/orders")
      .then((res) => setOrders(res.data.orders))
      .catch((err) => console.log(err));
  }, []);

  return (
    <div style={{ padding: 30 }}>
      <h1>Danh sách đơn hàng</h1>

      {orders.length === 0 && <p>Chưa có đơn hàng</p>}

      {orders.map((order) => (
        <div
          key={order.order_id}
          style={{
            border: "1px solid #ccc",
            margin: 10,
            padding: 15,
            width: 400
          }}
        >
          <h3>Đơn hàng #{order.order_id}</h3>
          <p>Tổng tiền: ${order.total_price}</p>
          <p>Trạng thái: {order.status}</p>
        </div>
      ))}
    </div>
  );
}

export default Orders;