// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// OpenZeppelin 5.x ERC20 ve Ownable
import "./openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./openzeppelin/contracts/access/Ownable.sol";

/// @title Purgatory Token (PURG) - BEP20 / ERC20
/// @notice Güvenli, CMC uyumlu, mint limiti ile topluluk dostu
contract Purgatory is ERC20, Ownable {

    uint256 public constant MAX_SUPPLY = 10_000_000 * 10 ** 18;

    // Deploy eden kişi otomatik sahibi olur
    constructor() ERC20("Purgatory", "PURG") Ownable(msg.sender) {
        // Başlangıçta tüm tokenları deploy eden cüzdana ver
        _mint(msg.sender, MAX_SUPPLY);
    }

    /// @notice Sadece sahibi yeni token basabilir, toplam arzı aşamaz
    /// @param to Tokenların gönderileceği adres
    /// @param amount Mintlenecek token miktarı
    function mint(address to, uint256 amount) external onlyOwner {
        require(totalSupply() + amount <= MAX_SUPPLY, "Toplam arz limiti asildi");
        _mint(to, amount);
    }

    /// @notice Herkes kendi tokenini yakabilir
    /// @param amount Yakılacak miktar
    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
    }
}
