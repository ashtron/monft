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

      console.log(await monFT.getFaceData(1), await monFT.getBodyData(1));      
    });

    // it("Should give NFTs a gene sequence", async function () {
    //     await monFT.mintMon();
    //     const geneSequence = Number(await monFT.geneSequences(1));

    //     // Expect a five-digit gene sequence.
    //     expect(String(geneSequence).length).to.eq(5);
    // });
  });

  // describe("transferMon", function () {
  //   it("Should transfer NFTs", async function () {
  //     await monFT.mintMon();
  //     await monFT.transferMon(addr1.address, addr2.address, 1);

  //     expect(await monFT.ownerOf(1)).to.equal(addr2.address);
  //   });
  // });

  // describe("mutate", function () {
  //   it("Should change gene sequence on transfer", async function () {
  //     await monFT.mintMon();
  //     const oldGeneSequence = await monFT.geneSequences(1);

  //     await monFT.transferMon(addr1.address, addr2.address, 1);
  //     const newGeneSequence = await monFT.geneSequences(1);
      
  //     expect(oldGeneSequence).not.to.equal(newGeneSequence);
  //   });
  // });

  // describe("test new gene sequence data structure", function () {
  //   it("let's see", async function () {
  //     // const result = Number(await monFT.geneSequences2(1)("eyes"));
  //     // console.log(result);
  //     const result = await monFT.getSequenceData(1);
  //     console.log(Number(result[0]), Number(result[1]), Number(result[2]));
  //     // expect(result).to.equal(21);
  //   });
  // });
});
