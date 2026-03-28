// src/pages/OrderDetail.js
import React, { useEffect, useState } from "react";
import api from "../api";
import { useParams } from "react-router-dom";

function OrderDetail() {
  const { id } = useParams();
  const [items, setItems] = useState([]);

  useEffect(() => {
    api.get(`/orders/${id}`)
      .then((res) => setItems(res.data.items))
      .catch((err) => console.log(err));
  }, [id]);

  return (
    <div style={{ padding: 30 }}>
      <h1>Order Detail</h1>

      {items.map((item) => (
        <div key={item.id} style={{ border: "1px solid #ccc", margin: 10, padding: 10 }}>
          <h3>{item.product.name}</h3>
          <p>Price: ${item.product.price}</p>
          <p>Quantity: {item.quantity}</p>
        </div>
      ))}
    </div>
  );
}

export default OrderDetail;