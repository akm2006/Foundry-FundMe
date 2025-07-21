```markdown
# Foundry Fund Me 🚀

This repository contains a decentralized crowdfunding (FundMe) smart contract built with the **Foundry** development framework. The contract is written in **Solidity** and allows an owner to collect funds in ETH from anyone and withdraw them.

A key feature of this contract is its use of **Chainlink Price Feeds** to ensure that any funding transaction meets a minimum value specified in **USD**, making the funding goal independent of ETH's price volatility.

This project serves as a comprehensive exercise in smart contract development, testing, and deployment using modern Ethereum tools.

---

## 📄 Live Deployment

The smart contract has been successfully deployed and verified on the **Sepolia Testnet**.

- **Contract Address:** `0x6A4737FDa9c0c48d3666B94166c13669fe41Ae87`  
- **View on Etherscan:** [Sepolia Etherscan Link](https://sepolia.etherscan.io/address/0x6A4737FDa9c0c48d3666B94166c13669fe41Ae87)

---

## ✨ Features

- **Fund Contract:** Anyone can send ETH to the contract.
- **Owner-Only Withdrawal:** Only the contract owner can withdraw the entire balance.
- **USD Value Minimum:** Enforces a minimum funding amount (e.g., $5) by using Chainlink Price Feeds to get the latest ETH/USD price.
- **Funder Tracking:** Keeps a record of all addresses that have funded the contract.
- **Optimized Gas:** Developed with gas efficiency in mind using modern Solidity patterns.

---

## 📁 Project Structure

The repository is organized as a standard Foundry project:

```

src/              --> Solidity source code
├── FundMe.sol              # Main crowdfunding contract
└── PriceConverter.sol      # Library for Chainlink price conversion

script/          --> Deployment and interaction scripts
└── DeployFundMe.s.sol      # Deployment script

test/            --> Smart contract test files
└── FundMeTest.t.sol        # Unit and integration tests

lib/             --> External dependencies (e.g., forge-std, chainlink-brownie-contracts)

broadcast/, cache/, out/  --> Foundry's default directories (ignored by Git)

Makefile         --> Shortcut commands for build/test/deploy

.env             --> Stores environment variables (ignored by Git)

````

---

## 🛠️ Tech Stack

- **Language:** Solidity  
- **Framework:** Foundry (Anvil, Forge, Cast)  
- **Oracle:** Chainlink Price Feeds  
- **Blockchain:** Ethereum (Sepolia Testnet)  
- **Frontend Interaction:** Ethers.js  

---

## 🏁 Getting Started

To get a local copy up and running, follow these simple steps.

### Prerequisites

Make sure you have the following installed:

- Git
- Foundry

### Installation & Setup

Clone the repository:

```bash
git clone https://github.com/akm2006/Foundry-FundMe.git
cd Foundry-FundMe
````

Install dependencies:

```bash
forge install
```

Set up environment variables:

```bash
cp .env.example .env
```

Then, edit the `.env` file with your credentials:

```
SEPOLIA_RPC_URL="your_alchemy_or_infura_rpc_url"
PRIVATE_KEY="your_metamask_private_key"
ETHERSCAN_API_KEY="your_etherscan_api_key"
```

---

### Create the Makefile

Create a file named `Makefile` in the root directory and add the following content:

```makefile
-include .env

build:
	forge build

deploy-sepolia:
	forge script script/DeployFundMe.s.sol:DeployFundMe \
		--rpc-url $(SEPOLIA_RPC_URL) \
		--private-key $(PRIVATE_KEY) \
		--broadcast \
		--verify \
		--etherscan-api-key $(ETHERSCAN_API_KEY) \
		-vvvv

verify:
	forge verify-contract \
		--chain-id 11155111 \
		--etherscan-api-key $(ETHERSCAN_API_KEY) \
		--rpc-url $(SEPOLIA_RPC_URL) \
		0x6A4737FDa9c0c48d3666B94166c13669fe41Ae87 \
		src/FundMe.sol:FundMe \
		--constructor-args $(shell cast abi-encode "constructor(address)" 0x694aa1769357215de4fac081bf1f309adc325306)
```

---

## ⚙️ Usage

Use the provided Makefile to simplify common development tasks:

### Build

```bash
make build
```

### Testing

```bash
forge test --gas-report
```

### Deployment to Sepolia

```bash
make deploy-sepolia
```

### Manual Verification

```bash
make verify
```

---

## 🙏 Acknowledgments

This project was inspired by and built as part of the learning journey from the **Cyfrin Updraft** and **Patrick Collins' blockchain development courses**.

