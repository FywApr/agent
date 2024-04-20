import { useEffect, useState } from "react";
import { Link } from "react-router-dom";

export default function Catalog() {
  const [catalogs, setCatalogs] = useState([]);

  useEffect(() => {
    fetch("http://smak.back/server/api/catalogs/get-catalogs.php")
      .then((response) => response.json())
      .then((data) => {
        setCatalogs(data);
      });
  }, []);

  return (
    <>
      <main>
        <ul>
          {catalogs.map((catalog) => (
            <Link
              className="catalog-card"
              key={catalog.id}
              to={`/catalogs/${catalog.id}`}
            >
              <li>
                <img
                  src={`http://smak.back/${catalog.image}`}
                  alt={catalog.name}
                />
                {catalog.name}
              </li>
            </Link>
          ))}
        </ul>
      </main>
    </>
  );
}
