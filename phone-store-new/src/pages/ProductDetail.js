import { useParams } from "react-router-dom";
import { useEffect, useState } from "react";
import axios from "axios";

function ProductDetail() {
  const { id } = useParams();
  const [product, setProduct] = useState({});

  useEffect(() => {
    axios.get(`http://localhost:8000/api/product/${id}`)
      .then(res => setProduct(res.data));
  }, [id]);

  return (
    <div className="container mt-5">
      <div className="row">

        <div className="col-md-6">
          <img
            src={`http://localhost:8000/${product.image}`}
            className="img-fluid"
          />
        </div>

        <div className="col-md-6">
          <h2>{product.name}</h2>
          <h4 className="text-danger">
            {product.price} VND
          </h4>

          <p>{product.description}</p>

          <button className="btn btn-primary btn-lg">
            Add to cart
          </button>
        </div>

      </div>
    </div>
  );
}

export default ProductDetail;