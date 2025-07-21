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
