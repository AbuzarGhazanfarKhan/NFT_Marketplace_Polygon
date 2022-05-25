require("@nomiclabs/hardhat-waffle");
const fs=require("fs")
const privateKey = fs.readFileSync(".secret").toString()
console.log(privateKey)

module.exports = {
  networks:{
    hardhat:{
      chainId:1337,
    },
    mumbai:{
      url:"https://polygon-mumbai.g.alchemy.com/v2/O9HlXwFBx9fkCD8YSw3yN2wlIyKqCNUB",
      accounts:[`0x${privateKey}`]
    }
  },
  solidity: "0.8.4",
};
