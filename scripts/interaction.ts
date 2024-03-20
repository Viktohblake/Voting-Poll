import { ethers } from "hardhat";

async function main() {

    const VotingContractAddress = "0x5FbDB2315678afecb367f032d93F642f64180aa3";

    const VotingContract = await ethers.getContractAt("IVoting", VotingContractAddress);

    const pollCreationQuestion = "What is your favorite color?";
    const votersOption = ["Blue", "Red", "Green", "Black"];

    const creatingPoll = await VotingContract.createPoll(pollCreationQuestion, votersOption);
    await creatingPoll.wait();

    const pollIdentity = 0;

    const voteCasting = await VotingContract.vote(pollIdentity, 3);
    await voteCasting.wait();

    const pollResult = await VotingContract.getPoll(0);

    console.log(pollResult)
    console.log(`Your favorite color: ${pollCreationQuestion}`);
    console.log(`Candidates: ${votersOption.join(", ")}`);
}
main().catch(error => {
    console.error(error);
    process.exit(1);
});