
import 'package:cryptowallet/pages/walletdetails.dart';
import 'package:flutter/material.dart';
import 'package:cryptowallet/pages/walletfunctions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class createwallet extends StatefulWidget {
  const createwallet({Key? key}) : super(key: key);

  @override
  State<createwallet> createState() => _createWallet();
}

class _createWallet extends State<createwallet> {
  int? selected;
  String? public_address;
  String? private_address;
  String? username;
  dynamic? data;
  @override
  void initState() {
    super.initState();
    details();
  }

  details() async {
    data = await getUserDetails();
    data != null
        ? setState(() {

            private_address = data()['privateKey'];
            public_address = data()['publicKey'];
            username = data()['user_name'];
            bool created = data()['wallet_created']!;
            created == true ? selected = 1 : selected = 0;
          })
        : setState(() {
            selected = 0;
          });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: const Text("Wallet Information"), actions: [
          IconButton(
              onPressed: () {
                if (mounted) {
                  Navigator.pop(context);
                }
              },
              icon: const Icon(Icons.backspace)),
        ]),
        body: Column(children: [
          selected == 0
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                      Container(
                          margin: const EdgeInsets.all(10),
                          child: const Text("Add a wallet")),
                      Container(
                          margin: const EdgeInsets.all(10),
                          child: ElevatedButton(
                            child: const Icon(Icons.add),
                            onPressed: () async {
                              setState(() {
                                selected = 1;
                              });
                              WalletAddressService service = WalletAddress();
                              final mnemonic = service.generateMnemonic();
                              final privateKey =
                                  await service.getPrivateKey(mnemonic);
                              final publicKey =
                                  await service.getPublicKey(privateKey);

                              private_address = privateKey;
                              public_address = publicKey.toString();
                              addUserDetails(privateKey, publicKey);
                            },
                          ))
                    ])
              : Column(
                  children: [
                    //Center(
                     // child:Text(data()['privateKey'])
                    //),
                    Center(
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(20),
                        height: 100,
                        width: 500,
                        color: Colors.blueAccent,
                        child: const Text("Successfully initiated the wallet!!",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                      ),
                    ),
                    const Center(
                      child: Text("wallet private address :",
                          style: TextStyle(fontSize: 16)),
                    ),
                    Center(
                      child: Text(
                        "${private_address}",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    Center(
                      child: Text("Dont reveal your private address to anyone",
                          style: TextStyle(color: Colors.grey, fontSize: 15)),
                    ),
                    const Divider(),
                    Center(
                      child: Text("Wallet public address",
                          style: TextStyle(fontSize: 15)),
                    ),
                    Center(
                      child: Text("${public_address}",
                          style: TextStyle(fontSize: 12)),
                    ),
                    const Divider(),
                    const Center(
                      child: Text(
                        "Go back to main page!",
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    )
                  ],
                )
        ]));
  }
}
