const { create } = require('ipfs-http-client')
const Web3 = require("web3")

const HDWalletProvider = require('@truffle/hdwallet-provider');
var fs = require('fs');
const path = require("path");

const client = create('https://ipfs.infura.io:5001/api/v0')

//Changed to Rinkeby
const priKey = 'YOUR PRIVATE KEY';
const kovanurl = 'https://rinkeby.infura.io/v3/ID'
const AdvanceCollectibles = require('../../build/contracts/AdvanceCollectibles.json');


const metadataTemple = {
    "name": "",
    "description": "",
    "image": "",
};

async function createSale(url) {
    console.log("IN CREATE SALE: ", url);
    const provider = new HDWalletProvider(priKey, kovanurl);
    const web3 = new Web3(provider);
    let myAccounts = await web3.eth.getAccounts();
    const network = await web3.eth.net.getNetworkType();
    const networkId = await web3.eth.net.getId();
    const AdvanceCollectiblesData = await AdvanceCollectibles.networks[networkId];
    const contAdd = AdvanceCollectiblesData.address;
    const advanceCollectible = new web3.eth.Contract(AdvanceCollectibles.abi, AdvanceCollectiblesData.address);
    const dev = myAccounts[0];
    const receipt = await advanceCollectible.methods.mint(url).send({ from: dev });

    let transactionReceipt = null
    while (transactionReceipt == null) { // Waiting expectedBlockTime until the transaction is mined
        console.log("TransactionHash : ", receipt.transactionHash)
        transactionReceipt = await web3.eth.getTransactionReceipt(receipt.transactionHash);
        //await sleep(expectedBlockTime)
    }
}

module.exports = async callback => {
    const provider = new HDWalletProvider(priKey, kovanurl);
    const web3 = new Web3(provider);

    console.log("hello crypto create collectible");
    let myAccounts = await web3.eth.getAccounts();
    console.log(myAccounts)
    const network = await web3.eth.net.getNetworkType();

    console.log("network: ", network);
    const networkId = await web3.eth.net.getId();
    console.log("networkId: ", networkId);
    const AdvanceCollectiblesData = await AdvanceCollectibles.networks[networkId];
    const contAdd = AdvanceCollectiblesData.address;
    console.log("Contract Address: ", contAdd)
    const advanceCollectible = new web3.eth.Contract(AdvanceCollectibles.abi, AdvanceCollectiblesData.address);
    const dev = myAccounts[0];
    console.log("Dev Account: ", dev);

    //Reading ImageUrls from file
    var filePath = path.join(__dirname, '/IPFS SportStars Punk.txt')
    console.log(filePath)
    var text = fs.readFileSync(filePath, 'utf-8');
    var textByLine = text.split('\n')

    for (var i = 0; i < textByLine.length; i++) {
        console.log(textByLine[i]);
        console.log("IPFS: ", textByLine[i], "  INDEX: ", i);

        var name = 'SportsPunk ' + i.toString();
        var description = 'Sports punk NFT';
        var fileUrl = textByLine[i];
        var url;
        const data = JSON.stringify({
            name, description, image: fileUrl
        })

        try {
            const added = await client.add(data)
            url = 'https://ipfs.infura.io/ipfs/' + added.path
            console.log("Image URL : ", url);
            await createSale(url)
        }
        catch (err) {
            console.log(err);
        }
    }

    callback()
}
