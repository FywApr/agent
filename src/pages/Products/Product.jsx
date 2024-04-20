import { useEffect, useState } from "react";
import { useParams } from "react-router-dom";

export default function Product() {
  const { id } = useParams();
  const [product, setProduct] = useState({});

  useEffect(() => {
    fetch(`http://smak.back/server/api/products/get-product.php?id=${id}`)
      .then((response) => response.json())
      .then((data) => {
        setProduct(data);
      });
  }, [id]);

  return (
    <>
      <main className="product">
        <img
          className="product-img"
          src={`http://smak.back/${product.image}`}
          alt={product.product_name}
        />
        <ul>
          <h1>{product.product_name}</h1>
          <li>
            <strong>Категория: </strong>
            {product.catalog_name}
          </li>
          <li>
            <strong>Бренд: </strong>
            {product.brand_name}
          </li>
          <li>
            <strong>Состав: </strong>
            {product.compound}
          </li>
          <li>
            <strong>Стоимость: </strong>
            {product.price} тенге
          </li>
          <li>
            <strong>Описание: </strong>
            {product.description}
          </li>
          <li>
            <strong>Кол-во: </strong>
            {product.count}
          </li>
          <li>
            <strong>Размер: </strong>
            {product.weight} {product.type === "Жидкость" ? " литров" : "грамм"}
          </li>
        </ul>
      </main>
    </>
  );
}
