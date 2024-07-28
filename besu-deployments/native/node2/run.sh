besu \
--data-path=data \
--genesis-file=./genesis.json \
--p2p-port=30304 \
--rpc-http-enabled \
--rpc-http-api=ETH,NET,QBFT \
--host-allowlist="*" \
--rpc-http-cors-origins="all" \
--rpc-http-port=8546 \
--bootnodes=enode://dca9f58eed6dc98b4d0209b46cf70c3e086cbd0675a314d495d4a2c5edf6dc2b25822894c7a463c5b14ac6f67f24a29bd0326f018e35f8fe6d21249ee6df8dc8@127.0.0.1:30303