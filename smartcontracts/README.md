# Smartcontract of DREX

## How to build

```bash
forge build
```

## How to deploy

**Local deploy**

- Edit `script/deploy.local.s.sol` and run

```bash
./deploy-on-local.sh
```

**Testnet deploy (example: Mumbai)**

- Edit `script/deploy.testnet.s.sol` and run

```bash
export MUMBAI_PRIVATE_KEY=""
export MUMBAI_RPC_URL=""
./deploy-on-testnet.sh
```

**Mainnet deploy (example: Polygon)**

- Edit `script/deploy.mainnet.s.sol` and run

```bash
export POLYGON_PRIVATE_KEY=""
export POLYGON_RPC_URL=""
./deploy-on-mainnet.sh
```
