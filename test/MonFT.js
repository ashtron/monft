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

    monFT = await MonFT.deploy();
    await monFT.deployed();
  });

  describe("mintMon", function () {
    it("Should mint NFTs", async function () {
      await monFT.mintMon();

      expect(await monFT.balanceOf(addr1.address)).to.equal(1);
    });
  });

  describe("transferMon", function () {
    it("Should transfer NFTs", async function () {
      await monFT.mintMon();
      await monFT.transferMon(addr1.address, addr2.address, 1);

      expect(await monFT.ownerOf(1)).to.equal(addr2.address);
    });
  });
});
