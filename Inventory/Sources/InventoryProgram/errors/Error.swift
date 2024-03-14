/**
 * This code was GENERATED using the solita package.
 * Please DO NOT EDIT THIS FILE, instead rerun solita to update it or write a wrapper to add functionality.
 *
 * See: https://github.com/metaplex-foundation/solita-swift
 */
import Foundation

public enum inventoryError: String, Error {
    /**
 * InvalidAssetId: '0x1770'
 *
 * @category Errors
 * @category generated
 */
    case invalidAssetIdError = "0x1770"
    /**
 * InsufficientInventoryAsset: '0x1771'
 *
 * @category Errors
 * @category generated
 */
    case insufficientInventoryAssetError = "0x1771"
    /**
 * InsufficientUSDC: '0x1772'
 *
 * @category Errors
 * @category generated
 */
    case insufficientUSDCError = "0x1772"
    /**
 * InsufficientAsset: '0x1773'
 *
 * @category Errors
 * @category generated
 */
    case insufficientAssetError = "0x1773"

    public var code: String? { self.rawValue }
}

extension inventoryError: LocalizedError {
    public var errorDescription: String? {
        switch self {
            /**
 * InvalidAssetId: 'An invalid asset functions address provided'
 *
 * @category Errors
 * @category generated
 */
    case .invalidAssetIdError: return "An invalid asset functions address provided"
    /**
 * InsufficientInventoryAsset: 'Not enough asset in inventory'
 *
 * @category Errors
 * @category generated
 */
    case .insufficientInventoryAssetError: return "Not enough asset in inventory"
    /**
 * InsufficientUSDC: 'Not enough usdc to execute traction'
 *
 * @category Errors
 * @category generated
 */
    case .insufficientUSDCError: return "Not enough usdc to execute traction"
    /**
 * InsufficientAsset: 'Not enough asset to deposit'
 *
 * @category Errors
 * @category generated
 */
    case .insufficientAssetError: return "Not enough asset to deposit"
        }
    }
}