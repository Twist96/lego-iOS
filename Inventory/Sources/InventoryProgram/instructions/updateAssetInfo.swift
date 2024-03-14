/**
 * This code was GENERATED using the solita package.
 * Please DO NOT EDIT THIS FILE, instead rerun solita to update it or write a wrapper to add functionality.
 *
 * See: https://github.com/metaplex-foundation/solita-swift
 */
import Foundation
import Solana
import BeetSolana
import Beet

/**
 * @category Instructions
 * @category UpdateAssetInfo
 * @category generated
 */
public struct UpdateAssetInfoInstructionArgs{
    let instructionDiscriminator: [UInt8] /* size: 8 */
    let newPrice: UInt64
    let newUsdcAccount: PublicKey

    public init(
        instructionDiscriminator: [UInt8] /* size: 8 */ = updateAssetInfoInstructionDiscriminator,
        newPrice: UInt64,
        newUsdcAccount: PublicKey
    ) {
        self.instructionDiscriminator = instructionDiscriminator
        self.newPrice = newPrice
        self.newUsdcAccount = newUsdcAccount
    }
}
/**
 * @category Instructions
 * @category UpdateAssetInfo
 * @category generated
 */
public let updateAssetInfoStruct = FixableBeetArgsStruct<UpdateAssetInfoInstructionArgs>(
    fields: [
        ("instructionDiscriminator", Beet.fixedBeet(.init(value: .collection(UniformFixedSizeArray<UInt8>(element: .init(value: .scalar(u8())), len: 8))))),
        ("newPrice", Beet.fixedBeet(.init(value: .scalar(u64())))),
        ("newUsdcAccount", Beet.fixedBeet(.init(value: .scalar(BeetPublicKey()))))
    ],
    description: "UpdateAssetInfoInstructionArgs"
)
/**
* Accounts required by the _updateAssetInfo_ instruction
*
* @property [_writable_, **signer**] payer  
* @property [_writable_] assetInfo  
* @property [] mint   
* @category Instructions
* @category UpdateAssetInfo
* @category generated
*/
public struct UpdateAssetInfoInstructionAccounts {
    let payer: PublicKey
    let assetInfo: PublicKey
    let mint: PublicKey
    let systemProgram: PublicKey?

    public init(
        payer: PublicKey,
        assetInfo: PublicKey,
        mint: PublicKey,
        systemProgram: PublicKey? = nil
    ) {
        self.payer = payer
        self.assetInfo = assetInfo
        self.mint = mint
        self.systemProgram = systemProgram
    }
}

public let updateAssetInfoInstructionDiscriminator = [225, 232, 152, 30, 171, 192, 32, 56] as [UInt8]

/**
* Creates a _UpdateAssetInfo_ instruction.
*
* @param accounts that will be accessed while the instruction is processed
  * @param args to provide as instruction data to the program
 * 
* @category Instructions
* @category UpdateAssetInfo
* @category generated
*/
public func createUpdateAssetInfoInstruction(accounts: UpdateAssetInfoInstructionAccounts, 
args: UpdateAssetInfoInstructionArgs, programId: PublicKey=PublicKey(string: "8oRGerutEMGTumnzzgxbsCEfLLkghC3cdT6EadZaPh3Q")!) -> TransactionInstruction {

    let data = updateAssetInfoStruct.serialize(
            instance: ["instructionDiscriminator": updateAssetInfoInstructionDiscriminator,
"newPrice": args.newPrice,
  "newUsdcAccount": args.newUsdcAccount])

    let keys: [AccountMeta] = [
        AccountMeta(
            publicKey: accounts.payer,
            isSigner: true,
            isWritable: true
        ),
        AccountMeta(
            publicKey: accounts.assetInfo,
            isSigner: false,
            isWritable: true
        ),
        AccountMeta(
            publicKey: accounts.mint,
            isSigner: false,
            isWritable: false
        ),
        AccountMeta(
            publicKey: accounts.systemProgram ?? PublicKey.systemProgramId,
            isSigner: false,
            isWritable: false
        )
    ]

    let ix = TransactionInstruction(
                keys: keys,
                programId: programId,
                data: data.0.bytes
            )
    return ix
}