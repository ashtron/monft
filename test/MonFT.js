const { expect } = require("chai");

describe("MonFT contract", function () {
  let MonFT;
  let monFT;
  let addr1;
  let addr2;
  let addrs;

  beforeEach(async function () {
    MonFT = await ethers.getContractFactory("MonFT");
    [addr1, addr2, ...addrs] = await ethers.getSigners();

    monFT = await MonFT.deploy(2);
    await monFT.deployed();
  });

  describe("mintMon", function () {
    it("Should mint NFTs", async function () {
      await monFT.mintMon();

      const balance = Number(await monFT.balanceOf(addr1.address));

      expect(balance).to.eq(1);
    });

    it("Should give NFTs a DNA sequence", async function () {
      await monFT.mintMon();
      const dna = (await monFT.getFaceData(1)).concat(await monFT.getBodyData(1));
      expect(dna.toString().includes("1"));
    });
  });

  describe("transferMon", function () {
    it("Should transfer NFTs", async function () {
      await monFT.mintMon();
      await monFT.transferMon(addr1.address, addr2.address, 1);

      expect(await monFT.ownerOf(1)).to.equal(addr2.address);
    });
  });

  describe("mutate", function () {
    it("Should mutate DNA on transfer", async function () {
      await monFT.mintMon();
      const oldDna = (await monFT.getFaceData(1)).concat(await monFT.getBodyData(1));

      await monFT.transferMon(addr1.address, addr2.address, 1);
      const newDna = (await monFT.getFaceData(1)).concat(await monFT.getBodyData(1));
      
      expect(oldDna.toString()).not.to.equal(newDna.toString());
    });
  });
});
