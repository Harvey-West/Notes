# Corda

## What is Corda

Corda is for permissioned nodes to communicate on a need-to-know basis about updating shared facts.

### Joining the network

When a node wants to join the network it goes through a KYC process to obtain an identity certificate. When they join they publish their legal name, IP address, public key and more to a map service. The network then can use this to communicate using TLS P2P messaging.

### Preventing double spends

Done through notary pools. A set of nodes (which do not trust one another - byzantine fault-tolerant consensus) that will sign a transaction if it does not represent a double sign transaction. These nodes do not actually see the contents of ledger updates.
They only see the hash each transaction and the index of the fact being consumed in the outputs of that transaction.

### What is a corda node

They provide user-defined flows (start tokenIssuanceFlow, createMortgageFlow) that allow the node to perform some action, normally to update the ledger.

They also enable reading back from the ledger to see the results of executing these flows. The advantage of the node is that all the data management and messaging systems are hidden away from the user.

## Example update to ledger flow:

Background: Node A wishes to update the ledger to share something with Node B. We have a notary pool available on our network to enable signing of transactions.

Steps:

1) Node A creates, verifies and signs a transaction to the ledger.
2) Then node A send it onto node B.
3) Node B needs to verify and sign the transaction it receives before it could send back to node A.
4) Node B says to node A that it needs to get it signed by the notary pool be recorded ont he ledger
5) Node A sends transaction to sign transaction.
6) Node A receives that it can sign the transaction and sends this to node B.
7) Node B also records the transaction.

## Contracts

Contracts define the rules that the transaction must obey for it to be allowed onto the ledger.

Normally there are three sections to a contract:

1) Shape
   1) The number of inputs, outputs, commands and types.
2) Content
   1) Inspecting the inputs, outputs, commands and types to ensure it is what you expected.

   ``` java
   HouseState inputHouse = (HouseState) input;
            HouseState outputHouse = (HouseState) output;

            if(!(inputHouse.getAddress().equals(outputHouse.getAddress()))){
                throw new IllegalArgumentException("In a transfer, the address can't change.");
            }
            if(inputHouse.getOwner().equals(outputHouse.getOwner())){
                throw new IllegalArgumentException("In a transfer, the owner must change.");
            }
   ```

3) Signer
   1) Checking the signers are the appropriate entities related to that state.

   ``` java
   Party inputOwner = inputHouse.getOwner();
            Party outputOwner = outputHouse.getOwner();

            if(!(requiredSigners.contains(inputOwner.getOwningKey()))){
                throw new IllegalArgumentException("Current owner must sign transfer.");
            }
            if(!(requiredSigners.contains(outputOwner.getOwningKey()))){
                throw new IllegalArgumentException("New owner must sign transfer.");
            }

        } else {
            throw new IllegalArgumentException("Command type not recognised.");
        }
   ```

``` java
if (command.getValue() instanceof TokenContract.Commands.Issue) {
            requireThat(req -> {
                req.using("Transaction must have no input states.", inputs.isEmpty());
                req.using("Transaction must have exactly one output.", outputs.size() == 1);
                req.using("Output must be a TokenState.", outputs.get(0) instanceof TokenState);
                TokenState output = (TokenState) outputs.get(0);
                req.using("Issuer must be required singer.", command.getSigners().contains(output.getIssuer().getOwningKey()));
                req.using("Owner must be required singer.", command.getSigners().contains(output.getOwner().getOwningKey()));
                req.using("Amount must be positive.", output.getAmount() > 0);
                return null;
            });
        } else {
            throw new IllegalArgumentException("Unrecognized command");
        }
```

## State

State defines the shared information that is recorded onto the ledger. Importantly it `@BelongsToContract(TokenContract.class)` and it `implements ContractState`. By implementing `ContractState` you must implement the function `getParticipants`. For example:

``` java
    @NotNull
    @Override
    public List<AbstractParty> getParticipants() {
       return ImmutableList.of(owner,issuer);
    }
```

This participant list is the list of people that should be notified if there is a change to the state of this record.

## Transaction builder

 A TransactionBuilder is a transaction class that's mutable (unlike the others which are all immutable). It is intended to be passed around contracts that may edit it by adding new states/commands. Then once the states and commands are right, this class can be used as a holding bucket to gather signatures from multiple parties. Once it is signed it is immutable of course without breaking those signatures.

The builder can be customised for specific transaction types, e.g. where additional processing is needed before adding a state/command.

Takes a parameter in the form of a notary. This is used for the transaction. If null, this indicates the transaction DOES NOT have a notary.
When this is set to a non-null value, an output state can be added by just passing in a [ContractState] – a[TransactionState] with this notary specified will be generated automatically.

## Flow Logic
