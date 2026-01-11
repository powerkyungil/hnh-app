import { StrictMode, useState } from 'react';
import { createRoot } from 'react-dom/client';
import App from './App';
import './styles/global.css';

const root = document.getElementById('root');

if (root) {
  createRoot(root).render(
    <StrictMode>
      <RoleGate />
    </StrictMode>
  );
}

const RoleGate = () => {
  const [role, setRole] = useState<'admin' | 'employee'>('admin');

  return <App role={role} onRoleChange={setRole} />;
};
