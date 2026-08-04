import { Routes, Route } from "react-router-dom";

import Login from "./pages/Login";
import Register from "./pages/Register";
import Home from "./pages/Home";
import Layout from "./Layout";
import Contact from "./pages/Contact";
import ProtectedRoutes from "./utils/ProtectedRoutes";
import Profile from "./pages/Profile";
import AllReview from "./pages/AllReview"
import Admin from "./pages/Admin";
import Match from "./pages/Match"
import Account from "./pages/Account";


function App() {
  return (
    <Routes>
      <Route element={<Layout />}>
        <Route path="/" element={<Home />} />
        <Route path="/contact" element={<Contact />} />
        <Route path="/viewReview" element={<AllReview />} />
      </Route>

      <Route path="/login" element={<Login />} />
      <Route path="/register" element={<Register />} />
      <Route element={<ProtectedRoutes />}>

        <Route element={<Layout />}>
          <Route path="/admin" element={<Admin />} />
          <Route path="/profile" element={<Profile />} />
          <Route path="/account" element={<Account />} />
          <Route path="/match" element={<Match />} />
        </Route>
      </Route>
    </Routes>
  );
}

export default App;


