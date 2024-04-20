import { Route, Routes } from "react-router-dom";
import Catalog from "./pages/Catalog/Catalog";
import Header from "./components/Header/Header";
import Products from "./pages/Products/Products";
import Product from "./pages/Products/Product";

function App() {
  return (
    <>
      <Header></Header>
      <Routes>
        <Route path="/catalogs" element={<Catalog />}></Route>
        <Route path="/catalogs/:id" element={<Products/>}></Route>
        <Route path="/catalogs/:id/product/:id" element={<Product/>}></Route>
      </Routes>
    </>
  );
}

export default App;
