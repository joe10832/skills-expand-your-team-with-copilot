# Wallet Integration Instructions

Comprehensive guide for blockchain wallet integration and testing with AI coding agents.

*For related guidance, see:*
- [Development Instructions](development.instructions.md) - General development practices
- [Testing Instructions](testing.instructions.md) - Testing strategies and frameworks
- [General Development Instructions](general.instructions.md) - Basic development standards
- [JavaScript Development Instructions](javascript.instructions.md) - Frontend wallet integration
- [Python Development Instructions](python.instructions.md) - Backend blockchain services

## Overview

### Blockchain Wallet Integration

Wallet integration enables applications to interact with blockchain networks through user-controlled wallet applications. This includes connecting to wallets, requesting signatures, managing transactions, and handling blockchain state.

### Supported Wallet Types

#### Browser Extension Wallets
- MetaMask (Ethereum, BSC, Polygon)
- WalletConnect Protocol
- Coinbase Wallet
- Trust Wallet
- Phantom (Solana)

#### Mobile Wallets
- WalletConnect mobile support
- Deep linking integration
- QR code scanning
- In-app browser wallets

#### Hardware Wallets
- Ledger integration
- Trezor support
- Security considerations
- Transaction signing flows

## Architecture Patterns

### Frontend Wallet Integration

#### Wallet Detection and Connection
```javascript
// Example wallet detection pattern
async function detectWallets() {
  const wallets = [];
  
  if (window.ethereum) {
    wallets.push({
      name: 'MetaMask',
      provider: window.ethereum,
      type: 'injected'
    });
  }
  
  if (window.solana && window.solana.isPhantom) {
    wallets.push({
      name: 'Phantom',
      provider: window.solana,
      type: 'injected'
    });
  }
  
  return wallets;
}

async function connectWallet(wallet) {
  try {
    const accounts = await wallet.provider.request({
      method: 'eth_requestAccounts'
    });
    return accounts[0];
  } catch (error) {
    console.error('Wallet connection failed:', error);
    throw error;
  }
}
```

#### State Management
- Track wallet connection status
- Manage user account information
- Handle network switching
- Store transaction history

### Backend Integration

#### Blockchain Node Connectivity
- Web3 provider configuration
- Multiple network support
- Connection pooling
- Failover strategies

#### Transaction Processing
- Transaction building
- Gas estimation
- Broadcasting transactions
- Status monitoring

#### Smart Contract Integration
- Contract ABI management
- Method invocation
- Event listening
- Error handling

## Security Considerations

### Wallet Security

#### Connection Security
- Verify wallet authenticity
- Validate connection requests
- Implement session management
- Handle disconnection gracefully

#### Transaction Security
- Validate transaction parameters
- Implement spending limits
- Require user confirmation
- Audit transaction history

#### Private Key Management
- Never request private keys
- Use signing methods only
- Implement secure storage
- Follow wallet security standards

### Application Security

#### Input Validation
- Validate all blockchain addresses
- Sanitize transaction data
- Verify contract interactions
- Check network compatibility

#### Error Handling
- Don't expose sensitive information
- Implement graceful degradation
- Provide user-friendly messages
- Log security events

## Testing Strategies

### Unit Testing

#### Wallet Mock Objects
```javascript
// Example wallet mock for testing
const mockWallet = {
  provider: {
    request: jest.fn(),
    on: jest.fn(),
    removeListener: jest.fn()
  },
  isConnected: jest.fn(() => true),
  getAccounts: jest.fn(() => ['0x123...'])
};

// Test wallet connection
describe('Wallet Connection', () => {
  it('should connect to wallet successfully', async () => {
    mockWallet.provider.request.mockResolvedValue(['0x123...']);
    
    const result = await connectWallet(mockWallet);
    
    expect(result).toBe('0x123...');
    expect(mockWallet.provider.request).toHaveBeenCalledWith({
      method: 'eth_requestAccounts'
    });
  });
});
```

#### Smart Contract Testing
- Mock contract interactions
- Test contract method calls
- Validate event emission
- Test error conditions

### Integration Testing

#### Testnet Testing
- Use blockchain testnets
- Test with real wallet applications
- Validate complete transaction flows
- Test network switching scenarios

#### End-to-End Testing
- Automate wallet interactions
- Test complete user workflows
- Validate UI responsiveness
- Test error scenarios

### Performance Testing

#### Transaction Throughput
- Test concurrent transactions
- Measure confirmation times
- Validate gas optimization
- Test under network congestion

#### Wallet Responsiveness
- Test connection speed
- Measure signing performance
- Validate state updates
- Test with slow networks

## Development Patterns

### Connection Management

#### Connection State Tracking
```javascript
class WalletManager {
  constructor() {
    this.isConnected = false;
    this.currentAccount = null;
    this.currentNetwork = null;
    this.listeners = new Map();
  }
  
  async connect(walletType) {
    try {
      const wallet = await this.getWallet(walletType);
      const accounts = await wallet.request({
        method: 'eth_requestAccounts'
      });
      
      this.isConnected = true;
      this.currentAccount = accounts[0];
      this.setupEventListeners(wallet);
      
      return this.currentAccount;
    } catch (error) {
      this.handleConnectionError(error);
      throw error;
    }
  }
  
  setupEventListeners(wallet) {
    wallet.on('accountsChanged', this.handleAccountChange.bind(this));
    wallet.on('chainChanged', this.handleChainChange.bind(this));
    wallet.on('disconnect', this.handleDisconnect.bind(this));
  }
}
```

#### Transaction Management
```javascript
class TransactionManager {
  constructor(wallet, config) {
    this.wallet = wallet;
    this.config = config;
    this.pendingTransactions = new Map();
  }
  
  async sendTransaction(params) {
    try {
      // Validate parameters
      this.validateTransactionParams(params);
      
      // Estimate gas
      const gasEstimate = await this.estimateGas(params);
      params.gas = gasEstimate;
      
      // Send transaction
      const txHash = await this.wallet.request({
        method: 'eth_sendTransaction',
        params: [params]
      });
      
      // Track transaction
      this.trackTransaction(txHash, params);
      
      return txHash;
    } catch (error) {
      this.handleTransactionError(error);
      throw error;
    }
  }
}
```

### Error Handling Patterns

#### Wallet Error Types
- User rejection
- Network errors
- Insufficient funds
- Invalid parameters
- Connection timeouts

#### Error Recovery Strategies
- Retry mechanisms
- Fallback providers
- User guidance
- Graceful degradation

## Network Management

### Multi-Chain Support

#### Network Configuration
```javascript
const networks = {
  ethereum: {
    chainId: '0x1',
    name: 'Ethereum Mainnet',
    rpcUrl: 'https://mainnet.infura.io/v3/...',
    currency: { name: 'ETH', symbol: 'ETH', decimals: 18 }
  },
  bsc: {
    chainId: '0x38',
    name: 'Binance Smart Chain',
    rpcUrl: 'https://bsc-dataseed.binance.org/',
    currency: { name: 'BNB', symbol: 'BNB', decimals: 18 }
  },
  polygon: {
    chainId: '0x89',
    name: 'Polygon',
    rpcUrl: 'https://polygon-rpc.com/',
    currency: { name: 'MATIC', symbol: 'MATIC', decimals: 18 }
  }
};
```

#### Network Switching
- Detect current network
- Request network changes
- Handle network mismatches
- Validate network compatibility

### Gas Management

#### Gas Estimation
- Accurate gas calculation
- Dynamic gas pricing
- Priority fee management
- Gas limit validation

#### Gas Optimization
- Batch transactions
- Optimize contract calls
- Use gas tokens
- Implement gas monitoring

## Smart Contract Integration

### Contract Interaction Patterns

#### Contract Instantiation
```javascript
class ContractManager {
  constructor(provider, contractConfig) {
    this.provider = provider;
    this.contracts = new Map();
    this.contractConfig = contractConfig;
  }
  
  getContract(contractName) {
    if (!this.contracts.has(contractName)) {
      const config = this.contractConfig[contractName];
      const contract = new ethers.Contract(
        config.address,
        config.abi,
        this.provider
      );
      this.contracts.set(contractName, contract);
    }
    return this.contracts.get(contractName);
  }
  
  async callMethod(contractName, methodName, params = []) {
    const contract = this.getContract(contractName);
    return await contract[methodName](...params);
  }
}
```

#### Event Handling
- Listen for contract events
- Filter relevant events
- Handle event history
- Manage event subscriptions

### ABI Management

#### ABI Storage and Versioning
- Version control contract ABIs
- Manage ABI updates
- Validate ABI compatibility
- Handle ABI migrations

#### Type Safety
- Generate TypeScript types from ABIs
- Validate method parameters
- Ensure return type accuracy
- Handle method overloads

## User Experience Patterns

### Connection Flow UX

#### Progressive Enhancement
- Detect wallet availability
- Graceful fallback options
- Clear user guidance
- Helpful error messages

#### State Management
- Connection indicators
- Account information display
- Network status indicators
- Transaction progress tracking

### Transaction UX

#### Transaction Feedback
- Clear transaction summaries
- Real-time status updates
- Confirmation notifications
- Error explanations

#### Gas Fee Transparency
- Display estimated fees
- Show fee breakdowns
- Offer fee options
- Explain fee variations

## Monitoring and Analytics

### Transaction Monitoring

#### Status Tracking
- Monitor transaction confirmations
- Track gas usage
- Measure success rates
- Identify failure patterns

#### Performance Metrics
- Connection success rates
- Transaction throughput
- Average confirmation times
- Error frequency analysis

### User Analytics

#### Wallet Usage Patterns
- Popular wallet types
- Connection success rates
- Feature usage statistics
- User journey analysis

#### Business Metrics
- Transaction volumes
- Revenue tracking
- User retention
- Feature adoption rates

## AI Agent Integration

### Prompting for Wallet Code

#### Effective Prompts
```
"Generate a React hook for managing MetaMask wallet connections that includes:
- Connection state management
- Account change handling
- Network switching support
- Error handling with user-friendly messages
- TypeScript types for all interfaces"
```

#### Code Review with AI
- Review smart contract interactions
- Validate security practices
- Optimize gas usage
- Improve error handling

### Testing with AI

#### Test Generation
- Generate wallet interaction tests
- Create mock wallet objects
- Build transaction test scenarios
- Design error condition tests

#### Test Maintenance
- Update tests with wallet changes
- Refactor duplicated test code
- Optimize test performance
- Improve test coverage

## Best Practices Summary

### Security
- Never request private keys
- Validate all inputs
- Implement proper error handling
- Follow wallet security standards

### Performance
- Optimize gas usage
- Cache wallet connections
- Batch related operations
- Implement connection pooling

### User Experience
- Provide clear feedback
- Handle errors gracefully
- Support multiple wallets
- Maintain connection state

### Testing
- Test with real wallets on testnets
- Mock wallet interactions for unit tests
- Validate security edge cases
- Monitor performance metrics

For additional development and testing guidance, see:
- [Development Instructions](development.instructions.md)
- [Testing Instructions](testing.instructions.md)