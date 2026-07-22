# 🐦 TwinStable - TWIN Token

**Powered by [TwinLabs](https://twinlabs.io) | Developed by TwinDevs**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Solidity](https://img.shields.io/badge/Solidity-^0.8.20-blue.svg)](https://docs.soliditylang.org/)
[![OpenZeppelin](https://img.shields.io/badge/OpenZeppelin-v5.0-brightgreen.svg)](https://docs.openzeppelin.com/)
[![Tests](https://img.shields.io/badge/Tests-Passing-success.svg)]()
[![Gas Optimized](https://img.shields.io/badge/Gas-Optimized-orange.svg)]()

Un token ERC-20 estable y seguro con características empresariales de control de acceso, gestión de blacklist y funcionalidades de seguridad avanzadas. Desarrollado con las mejores prácticas de seguridad en blockchain.

## 📋 Tabla de Contenidos

- [Características Principales](#-características-principales)
- [Especificaciones del Token](#-especificaciones-del-token)
- [Sistema de Roles](#-sistema-de-roles)
- [Instalación](#-instalación)
- [Despliegue](#-despliegue)
- [Uso](#-uso)
- [API Reference](#-api-reference)
- [Testing](#-testing)
- [Seguridad](#-seguridad)
- [Contacto](#-contacto)

## ✨ Características Principales

### 🔐 Seguridad de Nivel Empresarial

- **Blacklist Integrada**: Bloquea direcciones específicas según regulaciones
- **Sistema de Pausas de Emergencia**: Congelación inmediata de movimientos
- **Control de Acceso Basado en Roles (RBAC)**: Granularidad total sobre permisos
- **Librerías Auditadas**: OpenZeppelin v5.0 probadas y auditadas por la comunidad
- **Validación Robusta**: Checks exhaustivos en operaciones críticas

### 💰 Características del Token

- **Nombre**: Twin Stable
- **Símbolo**: TWIN
- **Decimales**: 18
- **Supply Inicial**: 0
- **Supply Máximo**: Ilimitado (Minteable)
- **Burnable**: Cualquiera puede quemar sus tokens
- **Pausable**: Congelación de emergencia
- **Blacklistable**: Cumplimiento regulatorio AML/KYC

### 👥 Sistema de Roles Granular

| Rol | Permisos | Descripción |
|-----|----------|-------------|
| **DEFAULT_ADMIN_ROLE** | Control total | Owner del contrato, gestiona todos los roles |
| **MINTER_ROLE** | Mintear tokens | Solo estos pueden crear nuevos tokens |
| **PAUSER_ROLE** | Pausar/Reanudar | Pueden congelar/descongelar transferencias |
| **BLACKLIST_ADMIN_ROLE** | Gestionar blacklist | Administran la lista negra de direcciones |

### 🛡️ Protecciones de Seguridad

✅ Overflow/Underflow protection (Solidity 0.8+)
✅ Reentrancy safe (No llamadas externas en transferencias)
✅ Checks-Effects-Interactions pattern
✅ Validación de direcciones (no address(0))
✅ Event logging exhaustivo
✅ Rate limiting en funciones críticas

## 🚀 Instalación

### Requisitos Previos

- Node.js v16+
- npm o yarn
- Cuenta con fondos en testnet (para despliegue)

### Clonar y Configurar

```bash
# Clonar repositorio
git clone https://github.com/Daimon-Security/Twinstable.git
cd Twinstable

# Instalar dependencias
npm install

# O con yarn
yarn install
```

### Configurar Variables de Entorno

```bash
# Copiar plantilla
cp .env.example .env

# Editar .env con tus valores
nano .env
```

**Variables requeridas:**
```env
# Network RPC URLs
SEPOLIA_RPC_URL=https://sepolia.infura.io/v3/YOUR_KEY
MAINNET_RPC_URL=https://mainnet.infura.io/v3/YOUR_KEY

# Private Key (NUNCA COMPARTAS!)
PRIVATE_KEY=your_private_key_here

# API Keys para verificación
ETHERSCAN_API_KEY=your_etherscan_key
```

## 🌐 Redes Soportadas

| Red | Blockchain | Estado | Chain ID |
|-----|-----------|--------|----------|
| Ethereum Mainnet | Mainnet | ✅ Soportado | 1 |
| Sepolia Testnet | Ethereum | ✅ Recomendado | 11155111 |
| Polygon | L2 Scaling | ✅ Soportado | 137 |
| Arbitrum One | L2 Scaling | ✅ Soportado | 42161 |
| Optimism | L2 Scaling | ✅ Soportado | 10 |
| Base | L2 Scaling | ✅ Soportado | 8453 |

## 🧪 Compilar y Testing

### Compilar Contratos

```bash
npm run compile

# Output: artifacts/contracts/TwinStable.sol/TwinStable.json
```

### Ejecutar Tests

```bash
# Tests completos
npm test

# Con reporte de cobertura
npm run test:coverage

# Con reporte de gas
npm run gas-report

# Tests en red local
npm run node
# (en otra terminal)
npm run deploy:localhost
```

### Cobertura de Tests

```
✅ Minting autorizado/no autorizado
✅ Burning de tokens propios
✅ Blacklist functionality
✅ Pausable operations
✅ Role management
✅ Transferencias estándar
✅ Edge cases y validaciones
✅ Eventos correctos
```

## 🚀 Despliegue

### Despliegue en Red Local (Testing)

```bash
# Terminal 1: Inicia nodo local
npm run node

# Terminal 2: Despliega contrato
npm run deploy:localhost
```

### Despliegue en Sepolia Testnet

```bash
npm run deploy:sepolia

# Output esperado:
# 🚀 Iniciando despliegue de TwinStable...
# 📍 Desplegador: 0x...
# 💰 Balance: X.XX ETH
# ✅ TwinStable desplegado en: 0x...
```

### Despliegue en Mainnet

```bash
# ⚠️ CUIDADO: Verifica todo antes de desplegar en mainnet
npm run deploy:mainnet
```

### Verificar en Etherscan

```bash
# Después del despliegue
npx hardhat verify --network sepolia CONTRACT_ADDRESS

# Con constructor arguments (si aplica)
npx hardhat verify --network sepolia CONTRACT_ADDRESS "arg1" "arg2"
```

## 📝 Uso

### Ejemplo 1: Mintear Tokens

```javascript
const hre = require("hardhat");

async function mintTokens() {
  const TwinStable = await hre.ethers.getContractFactory("TwinStable");
  const token = TwinStable.attach("0x...CONTRACT_ADDRESS");
  
  // Mintear 1000 TWIN (1000 * 10^18 unidades atómicas)
  const tx = await token.mint(
    "0x...RECIPIENT_ADDRESS",
    hre.ethers.parseEther("1000")
  );
  
  console.log("Mint tx:", tx.hash);
  await tx.wait();
  console.log("✅ 1000 TWIN minteados!");
}

mintTokens().catch(console.error);
```

### Ejemplo 2: Quemar Tokens

```solidity
// Desde una billetera con tokens
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

// Usar en ethers.js o truffle
const token = new ethers.Contract(tokenAddress, ABI, signer);

// Quemar 100 TWIN propios
await token.burn(ethers.parseEther("100"));
```

### Ejemplo 3: Gestionar Blacklist

```javascript
// Añadir dirección a blacklist
await token.addToBlacklist("0x...ADDRESS_TO_BLOCK");

// Verificar si está bloqueada
const isBlocked = await token.isBlacklisted("0x...ADDRESS");
console.log("¿Bloqueada?", isBlocked);

// Remover de blacklist
await token.removeFromBlacklist("0x...ADDRESS");
```

### Ejemplo 4: Gestionar Roles

```javascript
// Asignar rol de minteador
const MINTER_ROLE = await token.MINTER_ROLE();
await token.grantMinterRole("0x...NEW_MINTER");

// Verificar si tiene rol
const hasMinterRole = await token.hasRole(MINTER_ROLE, "0x...ADDRESS");

// Revocar rol
await token.revokeMinterRole("0x...OLD_MINTER");
```

### Ejemplo 5: Pausa de Emergencia

```javascript
// Pausar todas las transferencias
await token.pause();
console.log("🛑 Token pausado");

// Reanudar
await token.unpause();
console.log("▶️ Token reanudado");
```

## 📡 API Reference

### Funciones Públicas

#### Minting
```solidity
function mint(address to, uint256 amount) 
  public onlyRole(MINTER_ROLE)
```
Mintea nuevos tokens y los asigna a una dirección.
- **Requisitos**: Llamador debe tener MINTER_ROLE
- **Parámetros**: `to` (destinatario), `amount` (cantidad en wei)
- **Emite**: `Transfer` event

#### Burning
```solidity
function burn(uint256 amount) public
```
Quema tokens propios, eliminándolos de circulación.

```solidity
function burnFrom(address account, uint256 amount) public
```
Quema tokens de otra dirección (requiere aprobación).

#### Pausable
```solidity
function pause() public onlyRole(PAUSER_ROLE)
function unpause() public onlyRole(PAUSER_ROLE)
```
Pausa/Reanuda todas las transferencias de tokens.

#### Blacklist
```solidity
function addToBlacklist(address account) 
  public onlyRole(BLACKLIST_ADMIN_ROLE)
```
Añade una dirección a la blacklist.

```solidity
function removeFromBlacklist(address account) 
  public onlyRole(BLACKLIST_ADMIN_ROLE)
```
Remueve una dirección de la blacklist.

```solidity
function isBlacklisted(address account) 
  public view returns (bool)
```
Verifica si una dirección está en la blacklist.

#### Role Management
```solidity
function grantMinterRole(address account) 
  public onlyRole(DEFAULT_ADMIN_ROLE)
function revokeMinterRole(address account) 
  public onlyRole(DEFAULT_ADMIN_ROLE)

function grantPauserRole(address account) 
  public onlyRole(DEFAULT_ADMIN_ROLE)
function revokePauserRole(address account) 
  public onlyRole(DEFAULT_ADMIN_ROLE)

function grantBlacklistAdminRole(address account) 
  public onlyRole(DEFAULT_ADMIN_ROLE)
function revokeBlacklistAdminRole(address account) 
  public onlyRole(DEFAULT_ADMIN_ROLE)
```
Asigna y revoca roles administrativos.

#### Estándar ERC-20
```solidity
function transfer(address to, uint256 amount) 
  public returns (bool)
function transferFrom(address from, address to, uint256 amount) 
  public returns (bool)
function approve(address spender, uint256 amount) 
  public returns (bool)
function balanceOf(address account) 
  public view returns (uint256)
function allowance(address owner, address spender) 
  public view returns (uint256)
function totalSupply() 
  public view returns (uint256)
function decimals() 
  public pure returns (uint8)
```

### Eventos

```solidity
// Blacklist
event AddedToBlacklist(address indexed account);
event RemovedFromBlacklist(address indexed account);

// ERC20 (heredados)
event Transfer(address indexed from, address indexed to, uint256 value);
event Approval(address indexed owner, address indexed spender, uint256 value);

// Pausable (heredados)
event Paused(address indexed account);
event Unpaused(address indexed account);

// AccessControl (heredados)
event RoleGranted(bytes32 indexed role, address indexed account, address indexed sender);
event RoleRevoked(bytes32 indexed role, address indexed account, address indexed sender);
```

## 🔒 Seguridad

### Características de Seguridad

✅ **NatSpec Completo**: Todas las funciones documentadas
✅ **Auditoría OpenZeppelin**: Librerías probadas
✅ **RBAC Granular**: Control fino de permisos
✅ **Validación Exhaustiva**: Checks en operaciones críticas
✅ **Event Logging**: Todos los cambios auditables
✅ **Emergency Pause**: Congelación inmediata

### Auditoría de Seguridad

Consulta [docs/SECURITY.md](docs/SECURITY.md) para información completa sobre:
- Verificaciones de seguridad
- Protecciones contra ataques comunes
- Limitaciones conocidas
- Checklist pre-deployment
- Proceso de reporte responsable

### Reportar Vulnerabilidades

**NO** publiques vulnerabilidades en issues públicos.

Por favor envía un email a: **security@twinlabs.io**

Incluir:
- Descripción detallada
- Proof of Concept (PoC)
- Impacto potencial

## 📊 Análisis de Gas

Estimaciones de gas para operaciones comunes:

```
transfer()           ~52,000 gas (depende de la red)
mint()              ~72,000 gas
burn()              ~52,000 gas
addToBlacklist()    ~48,000 gas
pause()             ~28,000 gas
```

Para reporte detallado:
```bash
npm run gas-report
```

## 🤝 Contribuir

¡Las contribuciones son bienvenidas! Por favor consulta [CONTRIBUTING.md](CONTRIBUTING.md) para:

- Estándares de código
- Proceso de Pull Request
- Requisitos de tests
- Guías de seguridad

**Pasos rápidos:**

```bash
# 1. Fork el repositorio
# 2. Crea rama de feature
git checkout -b feature/mi-feature

# 3. Commit cambios
git commit -m "feat: descripción"

# 4. Push a rama
git push origin feature/mi-feature

# 5. Abre Pull Request
```

## 📚 Documentación

- [Smart Contract Source](contracts/TwinStable.sol) - Código fuente con NatSpec
- [Security Documentation](docs/SECURITY.md) - Análisis de seguridad
- [Contributing Guidelines](CONTRIBUTING.md) - Guía de contribución
- [OpenZeppelin Docs](https://docs.openzeppelin.com/) - Referencia de librerías
- [Solidity Docs](https://docs.soliditylang.org/) - Lenguaje Solidity

## 📖 Recursos Adicionales

- [ERC-20 Standard](https://eips.ethereum.org/EIPS/eip-20)
- [Ethereum Development Guide](https://ethereum.org/en/developers/)
- [Hardhat Documentation](https://hardhat.org/docs)
- [Web3.js Documentation](https://docs.web3js.org/)
- [Ethers.js Documentation](https://docs.ethers.org/)

## 🔧 Estructura del Proyecto

```
Twinstable/
├── contracts/
│   └── TwinStable.sol          # Smart contract principal
├── scripts/
│   └── deploy.js               # Script de despliegue
├── test/
│   └── TwinStable.test.js      # Tests unitarios
├── docs/
│   └── SECURITY.md             # Documentación de seguridad
├── .env.example                # Variables de entorno (plantilla)
├── hardhat.config.js           # Configuración Hardhat
├── package.json                # Dependencias
├── README.md                   # Este archivo
├── CONTRIBUTING.md             # Guía de contribución
└── LICENSE                     # Licencia MIT
```

## 🧪 Ejemplos Completos

### Ejemplo: Despliegue y Mint

```javascript
const hre = require("hardhat");

async function main() {
  // Desplegar contrato
  const TwinStable = await hre.ethers.getContractFactory("TwinStable");
  const token = await TwinStable.deploy();
  await token.waitForDeployment();
  
  const contractAddress = await token.getAddress();
  console.log("✅ Token desplegado en:", contractAddress);
  
  // Obtener información
  const name = await token.name();
  const symbol = await token.symbol();
  const totalSupply = await token.totalSupply();
  
  console.log(`Nombre: ${name}`);
  console.log(`Símbolo: ${symbol}`);
  console.log(`Supply Total: ${totalSupply}`);
  
  // Mintear 1000 TWIN
  const [owner] = await hre.ethers.getSigners();
  const tx = await token.mint(owner.address, hre.ethers.parseEther("1000"));
  await tx.wait();
  
  console.log("✅ 1000 TWIN minteados!");
  
  // Verificar balance
  const balance = await token.balanceOf(owner.address);
  console.log(`Balance: ${hre.ethers.formatEther(balance)} TWIN`);
}

main().catch(console.error);
```

## 📞 Contacto y Soporte

- **Discord**: [TwinLabs Community](https://discord.gg/twinlabs)
- **Twitter**: [@TwinLabsIO](https://twitter.com/TwinLabsIO)
- **Email**: dev@twinlabs.io
- **Website**: [https://twinlabs.io](https://twinlabs.io)
- **Organización GitHub**: [Daimon-Security](https://github.com/Daimon-Security)

## ⚠️ Disclaimer

Este contrato se proporciona "tal cual" sin ninguna garantía. Aunque se han tomado todas las precauciones de seguridad, los usuarios asumen todo el riesgo. 

**Para aplicaciones críticas o en producción, se recomienda encarecidamente:**

1. ✅ Auditoría profesional independiente
2. ✅ Testnet deployment extensivo
3. ✅ Monitoring continuo
4. ✅ Plan de respuesta a incidentes

## 📜 Licencia

Este proyecto está licenciado bajo la Licencia MIT. Ver archivo [LICENSE](LICENSE) para detalles completos.

```
MIT License

Copyright (c) 2024 TwinLabs - Powered by TwinDevs

Permission is hereby granted, free of charge...
```

## 🎓 Educación

Este proyecto es mantenido por **TwinDevs - Powered by TwinLabs**, dedicados a educación en blockchain, desarrollo de smart contracts seguros y mejores prácticas en Web3.

### Aprende Más

- Smart Contract Development
- Security Best Practices
- Blockchain Architecture
- Token Economics

---

<div align="center">

## ⭐ ¿Te fue útil?

Si encontraste útil este proyecto, **¡por favor deja una estrella!** ⭐

**Hecho con ❤️ por TwinDevs - Powered by [TwinLabs](https://twinlabs.io)**

[Visita TwinLabs →](https://twinlabs.io)

</div>
