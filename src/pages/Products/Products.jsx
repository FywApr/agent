import { useEffect, useState } from "react";
import { Link, useParams } from "react-router-dom";

export default function Products() {
  const { id } = useParams();
  const [products, setProducts] = useState([]);

  useEffect(() => {
    fetch(`http://test.test/server/api/products/get-products.php?id=${id}`)
      .then((response) => response.json())
      .then((data) => {
        setProducts(data);
      });
  }, []);

  return (
    <>
      <main>
        <ul>
          {products.map((product) => (
            <Link
              className="catalog-card"
              key={product.id}
              to={`/catalogs/${id}/product/${product.id}`}
            >
              <li>
                <img
                  className="product-img"
                  src={`http://test.test/${product.image}`}
                  alt={product.product_name}
                />
                {product.product_name}
              </li>
            </Link>
          ))}
        </ul>
      </main>
    </>
  );
}
