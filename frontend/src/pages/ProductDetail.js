import { useParams } from "react-router-dom";
import { useEffect, useState } from "react";
import axios from "axios";

// Component hiển thị các ảnh phụ + biến thể
function ProductImages({ images = [], variants = [], onSelect }) {
  return (
    <div className="d-flex mt-3">
      {images.map(img => (
        <img
          key={img.image_id}
          src={`http://127.0.0.1:8000/${img.image_url}`}
          alt=""
          width="80"
          className="me-2 border"
          style={{ cursor: "pointer" }}
          onClick={() => onSelect(img.image_url)}
        />
      ))}
      {variants.map(v => (
        <img
          key={v.variant_id}
          src={`http://127.0.0.1:8000/${v.image_url}`}
          alt=""
          width="80"
          className="me-2 border"
          style={{ cursor: "pointer" }}
          onClick={() => onSelect(v.image_url)}
        />
      ))}
    </div>
  );
}

function ProductDetail() {
  const { id } = useParams();
  const [product, setProduct] = useState(null);
  const [mainImage, setMainImage] = useState("");
  const [quantity, setQuantity] = useState(1);
  const [selectedVariant, setSelectedVariant] = useState(null);
  const [specs, setSpecs] = useState([]); // dùng riêng cho thông số

  useEffect(() => {
    axios.get(`http://localhost:8000/api/product/${id}`)
      .then(res => {
        const data = res.data;

        console.log("Product API:", data); // check dữ liệu thật

        // đảm bảo các mảng luôn tồn tại
        const safeData = {
          ...data,
          images: data.images || [],
          variants: data.variants || [],
        };
        setProduct(safeData);

        // set thông số kỹ thuật
        if (data.specifications && data.specifications.length > 0) {
          setSpecs(data.specifications);
        } else if (data.specs && data.specs.length > 0) {
          setSpecs(data.specs);
        } else {
          setSpecs([]);
        }

        // set ảnh chính
        if (safeData.variants.length > 0) {
          setSelectedVariant(safeData.variants[0]);
          setMainImage(safeData.variants[0].image_url);
        } else {
          setMainImage(safeData.image_url);
        }
      })
      .catch(err => console.log(err));
  }, [id]);

  const addToCart = () => {
    if (!product) return;

    const maxQty = selectedVariant ? selectedVariant.stock_quantity : product.stock_quantity;
    if (quantity < 1 || quantity > maxQty) {
      alert(`Vui lòng chọn số lượng từ 1 đến ${maxQty}`);
      return;
    }

    axios.post('http://localhost:8000/api/cart', {
      product_id: selectedVariant ? selectedVariant.variant_id : product.product_id,
      quantity: quantity
    })
    .then(() => alert("Đã thêm vào giỏ hàng!"))
    .catch(err => console.log(err));
  };

  if (!product) return <p>Loading...</p>;

  return (
    <div className="container mt-5">
      <div className="row">
        {/* Ảnh sản phẩm */}
        <div className="col-md-6">
          <img
            src={`http://localhost:8000/${mainImage}`}
            className="img-fluid border"
            alt={product.name}
          />

          <ProductImages
            images={product.images}
            variants={product.variants}
            onSelect={(img) => setMainImage(img)}
          />
        </div>

        {/* Thông tin sản phẩm */}
        <div className="col-md-6">
          <h2>{product.name}</h2>
          <h4 className="text-danger">
            {selectedVariant ? selectedVariant.price : product.price} VND
          </h4>
          <p>{product.description}</p>

          {/* Chọn số lượng */}
          <div className="d-flex align-items-center mb-3">
            <label className="me-2">Số lượng:</label>
            <input
              type="number"
              className="form-control w-25"
              min="1"
              max={selectedVariant ? selectedVariant.stock_quantity : product.stock_quantity}
              value={quantity}
              onChange={e => setQuantity(Number(e.target.value))}
            />
          </div>

          {/* Thông số kỹ thuật */}
          {specs.length > 0 && (
            <>
              <h5>Thông số kỹ thuật:</h5>
              <ul>
                {specs.map(spec => (
                  <li key={spec.spec_id || spec.id}>
                    <strong>{spec.spec_name || spec.name}:</strong> {spec.spec_value || spec.value}
                  </li>
                ))}
              </ul>
            </>
          )}

          <button className="btn btn-primary btn-lg" onClick={addToCart}>
            Add to Cart
          </button>
        </div>
      </div>
    </div>
  );
}

export default ProductDetail;