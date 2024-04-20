import { Link } from "react-router-dom";

export default function Header() {
  return (
    <header>
      <ul>
        <Link to="/catalogs">
          <li>
            <strong>Catalog</strong>
          </li>
        </Link>
      </ul>
    </header>
  );
}
