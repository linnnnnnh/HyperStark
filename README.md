# 🚀 HyperStark
Automated Rewards and Re-staking in the HyperStark Vault Service on Starknet.

## 📌 Overview
This project aims to automate the compounding of rewards for users who deposit tokens into liquidity pools on Starknet. 
By automating the process of harvesting and reinvesting rewards, we can simplify the user experience and boost yield. 
Below is a detailed breakdown of the workflows, technical requirements, and development plan.

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
