// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/security/Pausable.sol";

/**
 * @title TwinStable
 * @dev ERC-20 token con características de seguridad avanzadas
 * - Mintable con control de roles
 * - Burnable para cualquiera
 * - Blacklist integrada
 * - Pausable en caso de emergencia
 * - Control de roles granular (MINTER_ROLE, PAUSER_ROLE)
 */
contract TwinStable is ERC20, ERC20Burnable, Ownable, AccessControl, Pausable {
    // Definición de roles
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");
    bytes32 public constant BLACKLIST_ADMIN_ROLE = keccak256("BLACKLIST_ADMIN_ROLE");

    // Mappings para blacklist
    mapping(address => bool) private _blacklist;

    // Eventos
    event AddedToBlacklist(address indexed account);
    event RemovedFromBlacklist(address indexed account);

    /**
     * @dev Constructor del token
     * - Nombre: Twin Stable
     * - Símbolo: TWIN
     * - Supply inicial: 0 (minteable)
     * - Supply ilimitado
     */
    constructor() ERC20("Twin Stable", "TWIN") {
        // Asignar roles al deployer (owner)
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(MINTER_ROLE, msg.sender);
        _grantRole(PAUSER_ROLE, msg.sender);
        _grantRole(BLACKLIST_ADMIN_ROLE, msg.sender);
    }

    /**
     * @dev Función para mintear nuevos tokens
     * Solo direcciones con MINTER_ROLE pueden mintear
     * @param to Dirección receptora
     * @param amount Cantidad a mintear
     */
    function mint(address to, uint256 amount) public onlyRole(MINTER_ROLE) {
        require(!isBlacklisted(to), "TwinStable: address is blacklisted");
        _mint(to, amount);
    }

    /**
     * @dev Pausa todas las transferencias
     * Solo PAUSER_ROLE puede pausar
     */
    function pause() public onlyRole(PAUSER_ROLE) {
        _pause();
    }

    /**
     * @dev Reanuda las transferencias
     * Solo PAUSER_ROLE puede reanudar
     */
    function unpause() public onlyRole(PAUSER_ROLE) {
        _unpause();
    }

    /**
     * @dev Añade una dirección a la blacklist
     * Solo BLACKLIST_ADMIN_ROLE puede añadir a la blacklist
     * @param account Dirección a añadir a la blacklist
     */
    function addToBlacklist(address account) public onlyRole(BLACKLIST_ADMIN_ROLE) {
        require(account != address(0), "TwinStable: cannot blacklist zero address");
        require(!_blacklist[account], "TwinStable: address already blacklisted");
        _blacklist[account] = true;
        emit AddedToBlacklist(account);
    }

    /**
     * @dev Remueve una dirección de la blacklist
     * Solo BLACKLIST_ADMIN_ROLE puede remover de la blacklist
     * @param account Dirección a remover de la blacklist
     */
    function removeFromBlacklist(address account) public onlyRole(BLACKLIST_ADMIN_ROLE) {
        require(_blacklist[account], "TwinStable: address not blacklisted");
        _blacklist[account] = false;
        emit RemovedFromBlacklist(account);
    }

    /**
     * @dev Verifica si una dirección está en la blacklist
     * @param account Dirección a verificar
     * @return bool true si está en blacklist, false en caso contrario
     */
    function isBlacklisted(address account) public view returns (bool) {
        return _blacklist[account];
    }

    /**
     * @dev Revoca el rol MINTER_ROLE a una dirección
     * Solo DEFAULT_ADMIN_ROLE puede revocar roles
     * @param account Dirección a la que revocar el rol
     */
    function revokeMinterRole(address account) public onlyRole(DEFAULT_ADMIN_ROLE) {
        revokeRole(MINTER_ROLE, account);
    }

    /**
     * @dev Asigna el rol MINTER_ROLE a una dirección
     * Solo DEFAULT_ADMIN_ROLE puede asignar roles
     * @param account Dirección a la que asignar el rol
     */
    function grantMinterRole(address account) public onlyRole(DEFAULT_ADMIN_ROLE) {
        grantRole(MINTER_ROLE, account);
    }

    /**
     * @dev Hook que se ejecuta antes de cualquier transferencia
     * Previene transferencias desde direcciones en blacklist
     * Respeta el estado pausado
     */
    function _update(
        address from,
        address to,
        uint256 amount
    ) internal override(ERC20) whenNotPaused {
        require(!isBlacklisted(from), "TwinStable: from address is blacklisted");
        require(!isBlacklisted(to), "TwinStable: to address is blacklisted");
        super._update(from, to, amount);
    }

    /**
     * @dev Sobrescribe supportsInterface para AccessControl
     */
    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC20, AccessControl)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
