# 🚀 HyperStark
Automated Rewards and Re-staking in the HyperStark Vault Service on Starknet.

## 📌 Overview
This project aims to automate the compounding of rewards for users who deposit tokens into liquidity pools on Starknet. 
By automating the process of harvesting and reinvesting rewards, we can simplify the user experience and boost yield. 
Below is a detailed breakdown of the workflows, technical requirements, and development plan.

## 🛠️ Key Points
### **1. Automated Reward Harvesting and Reinvestment** 
- **Automation with Keeper:** Utilize a keeper to automate the process of harvesting rewards and reinvesting them. This means users only need to deposit tokens once, and the system will automatically handle the harvesting of rewards and reinvestment of STRK or any other applicable tokens.
- **Efficiency:** Automating these processes ensures rewards are harvested and reinvested as soon as possible, maximizing yield and reducing the manual effort required by users.

### **2. Simplified User Interface** 
- **Deposit Function:** A straightforward function allowing users to deposit funds into the vault.
- **Withdraw Function:** A function that enables users to withdraw their initial deposits along with any rewards earned, simplifying the user’s interaction with the system.

## 🔓 Difference
> Before Nostra Service

The existing structure of Starknet's Nostra service was based on a simple process for the DeFi service, allowing users to create liquidity pools, make deposits, and receive rewards.
However, even within that, Nostra provides users with good rewards and user interface in detail, such as various APR and APY.

![image](https://github.com/linnnnnnh/HyperStark/assets/144579614/368b5c6b-4bd4-4e5f-a2ed-d82ab2d63e6b)

> After HyperStark Service

On the other hand, we at HyperStark act like an intermediate provider, acting as a bridge between users and Nostra.
We own our **own Vault service** and provide it to users who deposit into our Vault and are **automatically deposited into Nostra's liquidity pool.** 
**Rewards are also automatically received** from Nostra through our Vault service. You can receive it.
In other words, it provides a service that maximizes user convenience by providing automated deposit services to users while serving the same service role as restaking.

![image](https://github.com/linnnnnnh/HyperStark/assets/144579614/b615000d-d7ee-412a-b3b5-5cd4775110a2)

## 🛠️ Technical Requirements

### Nostra Pool Interface
- **Function Interfaces:** Create function interfaces using the ABI from Starkscan to interact with Nostra pools. This will enable seamless integration and communication with the pools to manage deposits, withdrawals, and reward harvesting.

### Local Testing Environment
- **Fork Mainnet:** Set up a local testing environment by forking the mainnet. This allows for testing and development in a controlled environment that closely mirrors the live network.
- **Testing Contracts:** Deploy contracts to the local testnet and conduct comprehensive testing to ensure reliability and security before moving to the mainnet.

### Vault Accounting Design
- **Simplified ERC-4626:** Design the vault's accounting system using a simplified version of ERC-4626 tailored for Cairo. This will handle the tracking of user shares, the overall pool balance, and the accurate distribution of rewards.
- **Efficient Tracking:** Implement efficient methods for tracking deposits, withdrawals, and the compounding of rewards to ensure transparency and accuracy in the vault's operations.

### Keeper Integration
- **Automate Reward Harvesting:** Identify and integrate a keeper service compatible with Starknet to automate the harvesting of rewards. This ensures that rewards are harvested and reinvested without manual intervention, optimizing yield.
