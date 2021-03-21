# MonFT

Mint a monster that evolves when traded!

![Trade Evolution](/frontend/src/pokemonbiology_linktrade.png)

Built using [Hardhat Hackathon Boilerplate](https://github.com/nomiclabs/hardhat-hackathon-boilerplate).

# Instructions

## Running Locally

```sh
git clone https://github.com/ashtron/monft.git
cd monft
npm i
```

Run the test network:

```sh
npx hardhat node
```

In a new terminal, go to the repository's root folder and run this to
deploy the contract:

```sh
npx hardhat run scripts/deploy.js --network localhost
```

Run the frontend with:

```sh
cd frontend
npm i
npm start
```
You will need to have [Metamask](https://metamask.io) installed and listening to
`localhost 8545` with Chain ID `31337`.

## Kovan
