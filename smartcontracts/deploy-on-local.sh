forge b --skip test script --build-info

forge script script/deploy.local.s.sol:Local \
    --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 \
    -f http://127.0.0.1:8545 \
    --broadcast \
    --legacy

python deploy.py
