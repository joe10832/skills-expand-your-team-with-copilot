# GitHub Copilot Instructions

This repository demonstrates how to expand your team with GitHub Copilot coding agents.

*Additional instruction files available:*
- [General Development Instructions](instructions/general.instructions.md) - Basic development standards
- [Development Instructions](instructions/development.instructions.md) - Comprehensive development practices
- [Testing Instructions](instructions/testing.instructions.md) - Testing strategies and frameworks
- [Python Development Instructions](instructions/python.instructions.md) - Python-specific development
- [JavaScript Development Instructions](instructions/javascript.instructions.md) - JavaScript-specific development
- [Wallet Integration Instructions](instructions/wallet-integration.instructions.md) - Blockchain wallet integration

## Purpose

This exercise helps you learn how to:
- Set up GitHub Copilot for your development team
- Create effective prompts and instructions for Copilot
- Work collaboratively with AI coding assistants
- Implement best practices for AI-assisted development

## Getting Started

1. Ensure GitHub Copilot is enabled for your repository
2. Review the instruction files in the `.github/instructions/` directory
3. Follow the agent-specific guidance in the root-level agent files
4. Practice using Copilot with the provided examples

## Best Practices

- Write clear, descriptive comments to guide Copilot suggestions
- Use meaningful variable and function names
- Break complex problems into smaller, manageable tasks
- Review and validate all AI-generated code before committing
- Maintain coding standards and team conventions

## Comprehensive Development Guidance

### Development Workflow

#### Planning and Architecture

Effective development begins with thorough planning and architectural design:

1. **Requirements Analysis**
   - Define clear acceptance criteria for all features
   - Identify technical constraints and limitations
   - Consider security implications from the start
   - Plan for scalability and future growth
   - Document all assumptions and dependencies

2. **Architecture Design**
   - Choose appropriate design patterns for the problem domain
   - Define clear API contracts between components
   - Plan comprehensive data models with relationships
   - Consider all integration points with external systems
   - Design for testability and maintainability

3. **Technical Decision Making**
   - Evaluate multiple solution approaches
   - Consider long-term maintenance implications
   - Document architectural decisions and rationale
   - Plan for monitoring and observability
   - Consider deployment and operational requirements

#### Code Development Practices

##### Version Control Excellence

- Use semantic commit messages following conventional commits
- Create focused feature branches for new development work
- Keep commits atomic and focused on single logical changes
- Write descriptive commit messages explaining the why, not just what
- Use pull requests for all code changes with proper review

##### Code Organization Principles

- Follow established project structure conventions
- Separate concerns appropriately across modules
- Use consistent naming conventions throughout codebase
- Group related functionality into cohesive modules
- Maintain clear separation between layers (presentation, business, data)

##### Documentation Standards

- Write self-documenting code with clear intent
- Add inline comments for complex business logic
- Maintain up-to-date README files with setup instructions
- Document all public API endpoints and schemas
- Create runbooks for operational procedures

### Code Quality Standards

#### Style Guidelines

Code style consistency is crucial for team productivity:

- Enforce consistent code formatting using automated tools
- Use language-appropriate linting tools (ESLint, Pylint, etc.)
- Follow language-specific conventions and best practices
- Maintain consistent indentation (2 or 4 spaces as per language)
- Use meaningful variable and function names that express intent

#### Performance Considerations

- Profile critical code paths to identify bottlenecks
- Optimize database queries for efficiency
- Implement appropriate caching strategies
- Monitor resource usage and memory leaks
- Consider algorithmic complexity for data processing

#### Security Best Practices

Security must be built in from the beginning:

- Validate all user inputs at system boundaries
- Use parameterized queries to prevent SQL injection
- Implement proper authentication and authorization
- Follow OWASP security guidelines
- Regular security audits and dependency updates

### Testing Excellence

#### Testing Philosophy

Comprehensive testing ensures code reliability and maintainability:

##### Test-Driven Development (TDD)

1. **Red-Green-Refactor Cycle**
   - Write failing tests first to define expected behavior
   - Implement minimal code to make tests pass
   - Refactor code while maintaining all tests
   - Repeat cycle for each new feature or change

2. **Benefits of TDD Approach**
   - Forces better design decisions upfront
   - Provides comprehensive test coverage
   - Creates living documentation of system behavior
   - Builds confidence when making changes

##### Testing Pyramid Strategy

**Unit Tests (Foundation Layer)**
- Test individual functions and methods in isolation
- Ensure fast execution for rapid feedback
- Aim for high test coverage of business logic
- Use minimal dependencies and mock external services

**Integration Tests (Middle Layer)**
- Test interactions between system components
- Validate database and external API integrations
- Test service-to-service communication patterns
- Accept moderate execution time for comprehensive coverage

**End-to-End Tests (Top Layer)**
- Test complete user workflows and scenarios
- Validate UI and full system integration
- Accept slower execution for critical path validation
- Maintain fewer tests focused on key business flows

#### Test Implementation Strategies

##### Unit Testing Best Practices

```python
# Python example with comprehensive testing
import pytest
from unittest.mock import Mock, patch
from typing import Dict, List, Optional

class UserService:
    def __init__(self, database, email_service):
        self.database = database
        self.email_service = email_service
    
    def create_user(self, user_data: Dict) -> Optional[Dict]:
        """
        Create a new user with validation and notification.
        
        Args:
            user_data: Dictionary containing user information
            
        Returns:
            Created user data with ID, or None if creation failed
            
        Raises:
            ValueError: If user data is invalid
        """
        if not self._validate_user_data(user_data):
            raise ValueError("Invalid user data provided")
        
        try:
            # Create user in database
            user = self.database.create_user(user_data)
            
            # Send welcome email
            self.email_service.send_welcome_email(user['email'])
            
            return user
        except Exception as e:
            logger.error(f"Failed to create user: {e}")
            return None
    
    def _validate_user_data(self, data: Dict) -> bool:
        required_fields = ['name', 'email']
        return all(field in data and data[field] for field in required_fields)

# Comprehensive test suite
class TestUserService:
    @pytest.fixture
    def mock_database(self):
        return Mock()
    
    @pytest.fixture
    def mock_email_service(self):
        return Mock()
    
    @pytest.fixture
    def user_service(self, mock_database, mock_email_service):
        return UserService(mock_database, mock_email_service)
    
    def test_create_user_success(self, user_service, mock_database, mock_email_service):
        # Arrange
        user_data = {'name': 'John Doe', 'email': 'john@example.com'}
        expected_user = {'id': 1, 'name': 'John Doe', 'email': 'john@example.com'}
        mock_database.create_user.return_value = expected_user
        
        # Act
        result = user_service.create_user(user_data)
        
        # Assert
        assert result == expected_user
        mock_database.create_user.assert_called_once_with(user_data)
        mock_email_service.send_welcome_email.assert_called_once_with('john@example.com')
    
    def test_create_user_invalid_data(self, user_service):
        # Arrange
        invalid_data = {'name': 'John Doe'}  # Missing email
        
        # Act & Assert
        with pytest.raises(ValueError, match="Invalid user data provided"):
            user_service.create_user(invalid_data)
    
    def test_create_user_database_failure(self, user_service, mock_database, mock_email_service):
        # Arrange
        user_data = {'name': 'John Doe', 'email': 'john@example.com'}
        mock_database.create_user.side_effect = Exception("Database error")
        
        # Act
        result = user_service.create_user(user_data)
        
        # Assert
        assert result is None
        mock_email_service.send_welcome_email.assert_not_called()
```

```javascript
// JavaScript example with Jest testing
class UserService {
  constructor(database, emailService) {
    this.database = database;
    this.emailService = emailService;
  }
  
  async createUser(userData) {
    // Validate input data
    if (!this.validateUserData(userData)) {
      throw new Error('Invalid user data provided');
    }
    
    try {
      // Create user in database
      const user = await this.database.createUser(userData);
      
      // Send welcome email
      await this.emailService.sendWelcomeEmail(user.email);
      
      return user;
    } catch (error) {
      console.error('Failed to create user:', error);
      return null;
    }
  }
  
  validateUserData(data) {
    const requiredFields = ['name', 'email'];
    return requiredFields.every(field => 
      data[field] && data[field].trim().length > 0
    );
  }
}

// Comprehensive Jest test suite
describe('UserService', () => {
  let userService;
  let mockDatabase;
  let mockEmailService;
  
  beforeEach(() => {
    mockDatabase = {
      createUser: jest.fn()
    };
    mockEmailService = {
      sendWelcomeEmail: jest.fn()
    };
    userService = new UserService(mockDatabase, mockEmailService);
  });
  
  describe('createUser', () => {
    const validUserData = {
      name: 'John Doe',
      email: 'john@example.com'
    };
    
    it('should create user with valid data', async () => {
      // Arrange
      const expectedUser = { id: 1, ...validUserData };
      mockDatabase.createUser.mockResolvedValue(expectedUser);
      mockEmailService.sendWelcomeEmail.mockResolvedValue(true);
      
      // Act
      const result = await userService.createUser(validUserData);
      
      // Assert
      expect(result).toEqual(expectedUser);
      expect(mockDatabase.createUser).toHaveBeenCalledWith(validUserData);
      expect(mockEmailService.sendWelcomeEmail).toHaveBeenCalledWith(validUserData.email);
    });
    
    it('should throw error for invalid data', async () => {
      // Arrange
      const invalidData = { name: 'John Doe' }; // Missing email
      
      // Act & Assert
      await expect(userService.createUser(invalidData))
        .rejects.toThrow('Invalid user data provided');
      
      expect(mockDatabase.createUser).not.toHaveBeenCalled();
      expect(mockEmailService.sendWelcomeEmail).not.toHaveBeenCalled();
    });
    
    it('should return null when database fails', async () => {
      // Arrange
      mockDatabase.createUser.mockRejectedValue(new Error('Database error'));
      
      // Act
      const result = await userService.createUser(validUserData);
      
      // Assert
      expect(result).toBeNull();
      expect(mockEmailService.sendWelcomeEmail).not.toHaveBeenCalled();
    });
  });
  
  describe('validateUserData', () => {
    it('should return true for valid data', () => {
      const validData = { name: 'John', email: 'john@example.com' };
      expect(userService.validateUserData(validData)).toBe(true);
    });
    
    it('should return false for missing name', () => {
      const invalidData = { email: 'john@example.com' };
      expect(userService.validateUserData(invalidData)).toBe(false);
    });
    
    it('should return false for missing email', () => {
      const invalidData = { name: 'John' };
      expect(userService.validateUserData(invalidData)).toBe(false);
    });
    
    it('should return false for empty string values', () => {
      const invalidData = { name: '', email: 'john@example.com' };
      expect(userService.validateUserData(invalidData)).toBe(false);
    });
  });
});
```

### Blockchain Wallet Integration

#### Architecture Patterns for Wallet Integration

Wallet integration enables applications to interact with blockchain networks through user-controlled wallet applications:

##### Frontend Wallet Integration

```javascript
// Comprehensive wallet management system
class WalletManager {
  constructor() {
    this.isConnected = false;
    this.currentAccount = null;
    this.currentNetwork = null;
    this.supportedWallets = new Map();
    this.eventListeners = new Map();
    
    this.initializeSupportedWallets();
  }
  
  initializeSupportedWallets() {
    // MetaMask support
    if (typeof window !== 'undefined' && window.ethereum) {
      this.supportedWallets.set('metamask', {
        name: 'MetaMask',
        provider: window.ethereum,
        type: 'injected',
        icon: '/icons/metamask.svg'
      });
    }
    
    // Phantom wallet support (Solana)
    if (typeof window !== 'undefined' && window.solana && window.solana.isPhantom) {
      this.supportedWallets.set('phantom', {
        name: 'Phantom',
        provider: window.solana,
        type: 'injected',
        icon: '/icons/phantom.svg'
      });
    }
    
    // WalletConnect support
    this.supportedWallets.set('walletconnect', {
      name: 'WalletConnect',
      provider: null, // Initialized on demand
      type: 'walletconnect',
      icon: '/icons/walletconnect.svg'
    });
  }
  
  async detectWallets() {
    const availableWallets = [];
    
    for (const [key, wallet] of this.supportedWallets) {
      if (wallet.type === 'injected' && wallet.provider) {
        availableWallets.push({
          id: key,
          ...wallet
        });
      } else if (wallet.type === 'walletconnect') {
        availableWallets.push({
          id: key,
          ...wallet
        });
      }
    }
    
    return availableWallets;
  }
  
  async connectWallet(walletId) {
    const wallet = this.supportedWallets.get(walletId);
    if (!wallet) {
      throw new Error(`Unsupported wallet: ${walletId}`);
    }
    
    try {
      let accounts;
      
      if (wallet.type === 'injected') {
        accounts = await wallet.provider.request({
          method: 'eth_requestAccounts'
        });
      } else if (wallet.type === 'walletconnect') {
        // Initialize WalletConnect provider
        const WalletConnect = await import('@walletconnect/client').then(m => m.default);
        const connector = new WalletConnect({
          bridge: 'https://bridge.walletconnect.org',
          qrcodeModal: true
        });
        
        await connector.createSession();
        accounts = connector.accounts;
        wallet.provider = connector;
      }
      
      if (accounts && accounts.length > 0) {
        this.isConnected = true;
        this.currentAccount = accounts[0];
        this.currentWallet = walletId;
        
        await this.setupEventListeners(wallet);
        await this.updateNetworkInfo();
        
        return {
          account: this.currentAccount,
          network: this.currentNetwork,
          wallet: walletId
        };
      }
      
      throw new Error('No accounts found');
    } catch (error) {
      console.error('Wallet connection failed:', error);
      this.handleConnectionError(error);
      throw error;
    }
  }
  
  async setupEventListeners(wallet) {
    if (wallet.type === 'injected') {
      wallet.provider.on('accountsChanged', this.handleAccountChange.bind(this));
      wallet.provider.on('chainChanged', this.handleChainChange.bind(this));
      wallet.provider.on('disconnect', this.handleDisconnect.bind(this));
    }
  }
  
  async handleAccountChange(accounts) {
    if (accounts.length === 0) {
      await this.disconnect();
    } else {
      this.currentAccount = accounts[0];
      this.emit('accountChanged', this.currentAccount);
    }
  }
  
  async handleChainChange(chainId) {
    this.currentNetwork = chainId;
    await this.updateNetworkInfo();
    this.emit('networkChanged', this.currentNetwork);
  }
  
  async handleDisconnect() {
    await this.disconnect();
  }
  
  async disconnect() {
    this.isConnected = false;
    this.currentAccount = null;
    this.currentNetwork = null;
    this.currentWallet = null;
    
    this.emit('disconnected');
  }
  
  async updateNetworkInfo() {
    if (!this.isConnected) return;
    
    const wallet = this.supportedWallets.get(this.currentWallet);
    if (wallet && wallet.provider) {
      try {
        const chainId = await wallet.provider.request({
          method: 'eth_chainId'
        });
        this.currentNetwork = chainId;
      } catch (error) {
        console.error('Failed to get network info:', error);
      }
    }
  }
  
  // Event emitter functionality
  on(event, callback) {
    if (!this.eventListeners.has(event)) {
      this.eventListeners.set(event, []);
    }
    this.eventListeners.get(event).push(callback);
  }
  
  emit(event, data) {
    const listeners = this.eventListeners.get(event) || [];
    listeners.forEach(callback => callback(data));
  }
  
  // Transaction management
  async sendTransaction(transactionParams) {
    if (!this.isConnected) {
      throw new Error('Wallet not connected');
    }
    
    const wallet = this.supportedWallets.get(this.currentWallet);
    
    try {
      // Validate transaction parameters
      this.validateTransactionParams(transactionParams);
      
      // Estimate gas if not provided
      if (!transactionParams.gas) {
        const gasEstimate = await this.estimateGas(transactionParams);
        transactionParams.gas = gasEstimate;
      }
      
      // Send transaction
      const txHash = await wallet.provider.request({
        method: 'eth_sendTransaction',
        params: [transactionParams]
      });
      
      // Track transaction
      this.trackTransaction(txHash, transactionParams);
      
      return txHash;
    } catch (error) {
      console.error('Transaction failed:', error);
      this.handleTransactionError(error);
      throw error;
    }
  }
  
  validateTransactionParams(params) {
    if (!params.to || !params.from) {
      throw new Error('Transaction must include to and from addresses');
    }
    
    if (!params.value && !params.data) {
      throw new Error('Transaction must include either value or data');
    }
    
    // Validate address format
    const addressRegex = /^0x[a-fA-F0-9]{40}$/;
    if (!addressRegex.test(params.to) || !addressRegex.test(params.from)) {
      throw new Error('Invalid address format');
    }
  }
  
  async estimateGas(transactionParams) {
    const wallet = this.supportedWallets.get(this.currentWallet);
    
    try {
      const gasEstimate = await wallet.provider.request({
        method: 'eth_estimateGas',
        params: [transactionParams]
      });
      
      // Add 20% buffer to gas estimate
      const gasWithBuffer = Math.floor(parseInt(gasEstimate, 16) * 1.2);
      return `0x${gasWithBuffer.toString(16)}`;
    } catch (error) {
      console.error('Gas estimation failed:', error);
      // Return default gas limit as fallback
      return '0x5208'; // 21000 in hex
    }
  }
  
  trackTransaction(txHash, params) {
    const transaction = {
      hash: txHash,
      timestamp: Date.now(),
      status: 'pending',
      params: params
    };
    
    // Store in local storage or state management
    this.emit('transactionCreated', transaction);
    
    // Start monitoring transaction status
    this.monitorTransaction(txHash);
  }
  
  async monitorTransaction(txHash) {
    const wallet = this.supportedWallets.get(this.currentWallet);
    const maxAttempts = 120; // 10 minutes with 5-second intervals
    let attempts = 0;
    
    const checkStatus = async () => {
      try {
        const receipt = await wallet.provider.request({
          method: 'eth_getTransactionReceipt',
          params: [txHash]
        });
        
        if (receipt) {
          const status = receipt.status === '0x1' ? 'success' : 'failed';
          this.emit('transactionCompleted', {
            hash: txHash,
            status: status,
            receipt: receipt
          });
          return;
        }
        
        attempts++;
        if (attempts < maxAttempts) {
          setTimeout(checkStatus, 5000);
        } else {
          this.emit('transactionTimeout', { hash: txHash });
        }
      } catch (error) {
        console.error('Transaction monitoring error:', error);
        attempts++;
        if (attempts < maxAttempts) {
          setTimeout(checkStatus, 5000);
        }
      }
    };
    
    checkStatus();
  }
  
  handleConnectionError(error) {
    let userMessage = 'Failed to connect to wallet';
    
    if (error.code === 4001) {
      userMessage = 'Connection rejected by user';
    } else if (error.code === -32002) {
      userMessage = 'Connection request already pending';
    } else if (error.message.includes('No Ethereum provider')) {
      userMessage = 'No wallet found. Please install a wallet extension.';
    }
    
    this.emit('connectionError', {
      error: error,
      userMessage: userMessage
    });
  }
  
  handleTransactionError(error) {
    let userMessage = 'Transaction failed';
    
    if (error.code === 4001) {
      userMessage = 'Transaction rejected by user';
    } else if (error.code === -32603) {
      userMessage = 'Transaction failed due to insufficient funds or gas';
    } else if (error.message.includes('gas')) {
      userMessage = 'Transaction failed due to gas issues';
    }
    
    this.emit('transactionError', {
      error: error,
      userMessage: userMessage
    });
  }
}

// React hook for wallet integration
import { useState, useEffect, useCallback } from 'react';

export function useWallet() {
  const [walletManager] = useState(() => new WalletManager());
  const [isConnected, setIsConnected] = useState(false);
  const [currentAccount, setCurrentAccount] = useState(null);
  const [currentNetwork, setCurrentNetwork] = useState(null);
  const [availableWallets, setAvailableWallets] = useState([]);
  const [isConnecting, setIsConnecting] = useState(false);
  const [error, setError] = useState(null);
  
  useEffect(() => {
    // Set up event listeners
    walletManager.on('accountChanged', setCurrentAccount);
    walletManager.on('networkChanged', setCurrentNetwork);
    walletManager.on('disconnected', () => {
      setIsConnected(false);
      setCurrentAccount(null);
      setCurrentNetwork(null);
    });
    walletManager.on('connectionError', (errorInfo) => {
      setError(errorInfo.userMessage);
      setIsConnecting(false);
    });
    walletManager.on('transactionError', (errorInfo) => {
      setError(errorInfo.userMessage);
    });
    
    // Detect available wallets
    walletManager.detectWallets().then(setAvailableWallets);
    
    return () => {
      // Cleanup event listeners
      walletManager.eventListeners.clear();
    };
  }, [walletManager]);
  
  const connectWallet = useCallback(async (walletId) => {
    setIsConnecting(true);
    setError(null);
    
    try {
      const connection = await walletManager.connectWallet(walletId);
      setIsConnected(true);
      setCurrentAccount(connection.account);
      setCurrentNetwork(connection.network);
    } catch (error) {
      console.error('Wallet connection failed:', error);
    } finally {
      setIsConnecting(false);
    }
  }, [walletManager]);
  
  const disconnectWallet = useCallback(async () => {
    await walletManager.disconnect();
  }, [walletManager]);
  
  const sendTransaction = useCallback(async (params) => {
    return await walletManager.sendTransaction(params);
  }, [walletManager]);
  
  return {
    isConnected,
    currentAccount,
    currentNetwork,
    availableWallets,
    isConnecting,
    error,
    connectWallet,
    disconnectWallet,
    sendTransaction,
    clearError: () => setError(null)
  };
}
```

##### Smart Contract Integration

```javascript
// Smart contract management system
class ContractManager {
  constructor(provider, contractConfigs) {
    this.provider = provider;
    this.contractConfigs = contractConfigs;
    this.contracts = new Map();
    this.eventListeners = new Map();
  }
  
  getContract(contractName, signerAddress = null) {
    const cacheKey = `${contractName}_${signerAddress || 'readonly'}`;
    
    if (!this.contracts.has(cacheKey)) {
      const config = this.contractConfigs[contractName];
      if (!config) {
        throw new Error(`Contract configuration not found: ${contractName}`);
      }
      
      let contract;
      if (signerAddress) {
        const signer = this.provider.getSigner(signerAddress);
        contract = new ethers.Contract(config.address, config.abi, signer);
      } else {
        contract = new ethers.Contract(config.address, config.abi, this.provider);
      }
      
      this.contracts.set(cacheKey, contract);
    }
    
    return this.contracts.get(cacheKey);
  }
  
  async callMethod(contractName, methodName, params = [], signerAddress = null) {
    const contract = this.getContract(contractName, signerAddress);
    
    try {
      if (signerAddress) {
        // This is a transaction (write operation)
        const tx = await contract[methodName](...params);
        return tx;
      } else {
        // This is a call (read operation)
        const result = await contract[methodName](...params);
        return result;
      }
    } catch (error) {
      console.error(`Contract method call failed: ${contractName}.${methodName}`, error);
      throw error;
    }
  }
  
  async estimateGas(contractName, methodName, params = [], signerAddress) {
    const contract = this.getContract(contractName, signerAddress);
    
    try {
      const gasEstimate = await contract.estimateGas[methodName](...params);
      return gasEstimate;
    } catch (error) {
      console.error(`Gas estimation failed: ${contractName}.${methodName}`, error);
      throw error;
    }
  }
  
  subscribeToEvents(contractName, eventName, callback, filter = {}) {
    const contract = this.getContract(contractName);
    const event = contract.filters[eventName](...Object.values(filter));
    
    contract.on(event, callback);
    
    const subscriptionKey = `${contractName}_${eventName}_${JSON.stringify(filter)}`;
    this.eventListeners.set(subscriptionKey, { contract, event, callback });
    
    return subscriptionKey;
  }
  
  unsubscribeFromEvents(subscriptionKey) {
    const subscription = this.eventListeners.get(subscriptionKey);
    if (subscription) {
      subscription.contract.off(subscription.event, subscription.callback);
      this.eventListeners.delete(subscriptionKey);
    }
  }
  
  async getEventHistory(contractName, eventName, fromBlock = 0, toBlock = 'latest', filter = {}) {
    const contract = this.getContract(contractName);
    const eventFilter = contract.filters[eventName](...Object.values(filter));
    
    try {
      const events = await contract.queryFilter(eventFilter, fromBlock, toBlock);
      return events.map(event => ({
        blockNumber: event.blockNumber,
        transactionHash: event.transactionHash,
        args: event.args,
        event: event.event
      }));
    } catch (error) {
      console.error(`Event history query failed: ${contractName}.${eventName}`, error);
      throw error;
    }
  }
}

// React hook for smart contract interaction
export function useContract(contractName, signerAddress = null) {
  const [contractManager] = useState(() => {
    // Contract configurations would typically be loaded from environment
    const contractConfigs = {
      ERC20Token: {
        address: process.env.REACT_APP_TOKEN_CONTRACT_ADDRESS,
        abi: ERC20_ABI
      },
      NFTCollection: {
        address: process.env.REACT_APP_NFT_CONTRACT_ADDRESS,
        abi: NFT_ABI
      }
    };
    
    const provider = new ethers.providers.Web3Provider(window.ethereum);
    return new ContractManager(provider, contractConfigs);
  });
  
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState(null);
  
  const callMethod = useCallback(async (methodName, params = []) => {
    setIsLoading(true);
    setError(null);
    
    try {
      const result = await contractManager.callMethod(
        contractName,
        methodName,
        params,
        signerAddress
      );
      return result;
    } catch (error) {
      setError(error.message);
      throw error;
    } finally {
      setIsLoading(false);
    }
  }, [contractManager, contractName, signerAddress]);
  
  const estimateGas = useCallback(async (methodName, params = []) => {
    try {
      return await contractManager.estimateGas(
        contractName,
        methodName,
        params,
        signerAddress
      );
    } catch (error) {
      console.error('Gas estimation failed:', error);
      throw error;
    }
  }, [contractManager, contractName, signerAddress]);
  
  const subscribeToEvents = useCallback((eventName, callback, filter = {}) => {
    return contractManager.subscribeToEvents(contractName, eventName, callback, filter);
  }, [contractManager, contractName]);
  
  const unsubscribeFromEvents = useCallback((subscriptionKey) => {
    contractManager.unsubscribeFromEvents(subscriptionKey);
  }, [contractManager]);
  
  const getEventHistory = useCallback(async (eventName, fromBlock = 0, toBlock = 'latest', filter = {}) => {
    return await contractManager.getEventHistory(
      contractName,
      eventName,
      fromBlock,
      toBlock,
      filter
    );
  }, [contractManager, contractName]);
  
  return {
    callMethod,
    estimateGas,
    subscribeToEvents,
    unsubscribeFromEvents,
    getEventHistory,
    isLoading,
    error,
    clearError: () => setError(null)
  };
}
```

### Working with AI Coding Agents

#### Effective Prompting Strategies

When working with AI coding agents like GitHub Copilot, Claude, or Gemini, effective prompting is crucial:

##### For Code Generation

```javascript
// Example: Effective prompt as comment for generating React component
/**
 * Create a responsive ProductCard component that:
 * - Displays product image with lazy loading
 * - Shows product title, price, and description
 * - Includes "Add to Cart" button with loading state
 * - Handles out-of-stock products gracefully
 * - Uses TypeScript with proper interfaces
 * - Includes proper accessibility attributes
 * - Supports different sizes (small, medium, large)
 */
interface ProductCardProps {
  product: Product;
  size?: 'small' | 'medium' | 'large';
  onAddToCart: (productId: string) => Promise<void>;
  className?: string;
}

const ProductCard: React.FC<ProductCardProps> = ({ 
  product, 
  size = 'medium', 
  onAddToCart, 
  className 
}) => {
  // AI will generate the component implementation based on the detailed comment
};
```

##### For Complex Business Logic

```python
def process_payment_with_wallet(
    wallet_address: str, 
    amount: Decimal, 
    token_contract: str,
    user_id: int
) -> PaymentResult:
    """
    Process a payment using blockchain wallet integration.
    
    Requirements:
    - Validate wallet address format and ownership
    - Check token balance and allowance
    - Create payment transaction with proper gas estimation
    - Handle transaction failures and retries
    - Log all payment attempts for audit
    - Send confirmation email on success
    - Update user's payment history
    - Handle different token types (ERC20, native ETH)
    
    Security considerations:
    - Validate all input parameters
    - Use secure transaction signing
    - Implement rate limiting
    - Check for potential reentrancy attacks
    """
    # AI will generate comprehensive implementation based on detailed requirements
```

#### Code Review with AI Assistance

When using AI for code review, provide comprehensive context:

```python
"""
Please review this user authentication function for:
1. Security vulnerabilities (SQL injection, password handling, session management)
2. Performance issues (database queries, caching opportunities)
3. Error handling completeness
4. Code maintainability and readability
5. Testing gaps that should be addressed

Context: This is part of a web application handling sensitive user data,
deployed on AWS with PostgreSQL database, using JWT tokens for session management.
"""

def authenticate_user(username: str, password: str, request_ip: str) -> AuthResult:
    # Function implementation to be reviewed
```

### Performance and Security Best Practices

#### Performance Optimization Strategies

1. **Database Optimization**
   - Use connection pooling for database connections
   - Implement query optimization with proper indexing
   - Use pagination for large data sets
   - Implement caching strategies (Redis, Memcached)
   - Monitor slow queries and optimize them

2. **Caching Strategies**
   - Implement multi-level caching (browser, CDN, application, database)
   - Use appropriate cache invalidation strategies
   - Consider cache warming for critical data
   - Monitor cache hit rates and effectiveness

3. **Code Performance**
   - Profile critical code paths regularly
   - Optimize algorithmic complexity where possible
   - Use asynchronous processing for I/O operations
   - Implement proper resource cleanup and garbage collection

#### Security Implementation

1. **Input Validation and Sanitization**
   - Validate all inputs at system boundaries
   - Use parameterized queries to prevent SQL injection
   - Implement proper output encoding to prevent XSS
   - Validate file uploads and restrict file types

2. **Authentication and Authorization**
   - Implement strong password policies
   - Use multi-factor authentication where appropriate
   - Implement proper session management
   - Use role-based access control (RBAC)

3. **Data Protection**
   - Encrypt sensitive data at rest and in transit
   - Use environment variables for configuration secrets
   - Implement proper key management
   - Regular security audits and vulnerability assessments

### Advanced Development Patterns

#### Microservices Architecture

When building distributed systems, consider these patterns:

```python
# Example: Service communication pattern with proper error handling
import asyncio
import aiohttp
import logging
from typing import Optional, Dict, Any
from dataclasses import dataclass
from enum import Enum

class ServiceStatus(Enum):
    HEALTHY = "healthy"
    DEGRADED = "degraded"
    UNHEALTHY = "unhealthy"

@dataclass
class ServiceResponse:
    status_code: int
    data: Optional[Dict[str, Any]]
    error: Optional[str]
    service_name: str
    response_time_ms: int

class ServiceClient:
    def __init__(self, service_name: str, base_url: str, timeout: int = 30):
        self.service_name = service_name
        self.base_url = base_url.rstrip('/')
        self.timeout = timeout
        self.circuit_breaker = CircuitBreaker(service_name)
        self.logger = logging.getLogger(f"service_client.{service_name}")
    
    async def make_request(
        self, 
        method: str, 
        endpoint: str, 
        data: Optional[Dict] = None,
        headers: Optional[Dict] = None,
        retry_count: int = 3
    ) -> ServiceResponse:
        """
        Make HTTP request to service with circuit breaker and retry logic.
        """
        start_time = asyncio.get_event_loop().time()
        
        if not self.circuit_breaker.can_execute():
            return ServiceResponse(
                status_code=503,
                data=None,
                error=f"Circuit breaker open for {self.service_name}",
                service_name=self.service_name,
                response_time_ms=0
            )
        
        url = f"{self.base_url}{endpoint}"
        default_headers = {'Content-Type': 'application/json'}
        if headers:
            default_headers.update(headers)
        
        for attempt in range(retry_count + 1):
            try:
                async with aiohttp.ClientSession(timeout=aiohttp.ClientTimeout(total=self.timeout)) as session:
                    async with session.request(
                        method=method.upper(),
                        url=url,
                        json=data,
                        headers=default_headers
                    ) as response:
                        response_data = None
                        try:
                            response_data = await response.json()
                        except:
                            response_data = await response.text()
                        
                        end_time = asyncio.get_event_loop().time()
                        response_time_ms = int((end_time - start_time) * 1000)
                        
                        service_response = ServiceResponse(
                            status_code=response.status,
                            data=response_data if response.status < 400 else None,
                            error=response_data if response.status >= 400 else None,
                            service_name=self.service_name,
                            response_time_ms=response_time_ms
                        )
                        
                        # Update circuit breaker
                        if response.status < 500:
                            self.circuit_breaker.record_success()
                        else:
                            self.circuit_breaker.record_failure()
                        
                        return service_response
                        
            except asyncio.TimeoutError:
                self.logger.warning(f"Timeout on attempt {attempt + 1} for {url}")
                self.circuit_breaker.record_failure()
                if attempt == retry_count:
                    return ServiceResponse(
                        status_code=504,
                        data=None,
                        error=f"Request timeout after {retry_count + 1} attempts",
                        service_name=self.service_name,
                        response_time_ms=int((asyncio.get_event_loop().time() - start_time) * 1000)
                    )
                await asyncio.sleep(2 ** attempt)  # Exponential backoff
                
            except Exception as e:
                self.logger.error(f"Request failed on attempt {attempt + 1}: {str(e)}")
                self.circuit_breaker.record_failure()
                if attempt == retry_count:
                    return ServiceResponse(
                        status_code=500,
                        data=None,
                        error=f"Service request failed: {str(e)}",
                        service_name=self.service_name,
                        response_time_ms=int((asyncio.get_event_loop().time() - start_time) * 1000)
                    )
                await asyncio.sleep(2 ** attempt)

class CircuitBreaker:
    def __init__(self, name: str, failure_threshold: int = 5, timeout: int = 60):
        self.name = name
        self.failure_threshold = failure_threshold
        self.timeout = timeout
        self.failure_count = 0
        self.last_failure_time = None
        self.state = "closed"  # closed, open, half-open
    
    def can_execute(self) -> bool:
        if self.state == "closed":
            return True
        elif self.state == "open":
            if time.time() - self.last_failure_time > self.timeout:
                self.state = "half-open"
                return True
            return False
        elif self.state == "half-open":
            return True
        return False
    
    def record_success(self):
        self.failure_count = 0
        self.state = "closed"
    
    def record_failure(self):
        self.failure_count += 1
        self.last_failure_time = time.time()
        if self.failure_count >= self.failure_threshold:
            self.state = "open"
```

#### Event-Driven Architecture

```javascript
// Event-driven system with proper error handling and observability
class EventBus {
  constructor() {
    this.subscribers = new Map();
    this.middleware = [];
    this.metrics = new EventMetrics();
  }
  
  subscribe(eventType, handler, options = {}) {
    if (!this.subscribers.has(eventType)) {
      this.subscribers.set(eventType, []);
    }
    
    const subscription = {
      id: this.generateId(),
      handler,
      options: {
        priority: options.priority || 0,
        maxRetries: options.maxRetries || 3,
        retryDelay: options.retryDelay || 1000,
        timeout: options.timeout || 30000
      }
    };
    
    this.subscribers.get(eventType).push(subscription);
    
    // Sort by priority (higher priority first)
    this.subscribers.get(eventType).sort((a, b) => b.options.priority - a.options.priority);
    
    return subscription.id;
  }
  
  unsubscribe(eventType, subscriptionId) {
    if (this.subscribers.has(eventType)) {
      const subscriptions = this.subscribers.get(eventType);
      const index = subscriptions.findIndex(sub => sub.id === subscriptionId);
      if (index !== -1) {
        subscriptions.splice(index, 1);
      }
    }
  }
  
  async publish(eventType, data, metadata = {}) {
    const event = {
      id: this.generateId(),
      type: eventType,
      data,
      metadata: {
        ...metadata,
        timestamp: new Date().toISOString(),
        source: metadata.source || 'unknown'
      }
    };
    
    // Apply middleware
    for (const middleware of this.middleware) {
      await middleware(event);
    }
    
    const subscribers = this.subscribers.get(eventType) || [];
    const promises = subscribers.map(subscription => 
      this.executeHandler(event, subscription)
    );
    
    const results = await Promise.allSettled(promises);
    
    // Record metrics
    this.metrics.recordEvent(eventType, results);
    
    return {
      eventId: event.id,
      subscribersNotified: subscribers.length,
      successCount: results.filter(r => r.status === 'fulfilled').length,
      failureCount: results.filter(r => r.status === 'rejected').length
    };
  }
  
  async executeHandler(event, subscription, attempt = 1) {
    const startTime = Date.now();
    
    try {
      // Apply timeout
      const timeoutPromise = new Promise((_, reject) => {
        setTimeout(() => reject(new Error('Handler timeout')), subscription.options.timeout);
      });
      
      const handlerPromise = subscription.handler(event);
      
      await Promise.race([handlerPromise, timeoutPromise]);
      
      // Record success metrics
      this.metrics.recordHandlerExecution(
        event.type, 
        subscription.id, 
        'success', 
        Date.now() - startTime
      );
      
    } catch (error) {
      console.error(`Event handler failed for ${event.type}:`, error);
      
      // Record failure metrics
      this.metrics.recordHandlerExecution(
        event.type, 
        subscription.id, 
        'failure', 
        Date.now() - startTime,
        error.message
      );
      
      // Retry logic
      if (attempt <= subscription.options.maxRetries) {
        await new Promise(resolve => 
          setTimeout(resolve, subscription.options.retryDelay * attempt)
        );
        return this.executeHandler(event, subscription, attempt + 1);
      }
      
      throw error;
    }
  }
  
  addMiddleware(middleware) {
    this.middleware.push(middleware);
  }
  
  generateId() {
    return Math.random().toString(36).substr(2, 9);
  }
}

class EventMetrics {
  constructor() {
    this.eventCounts = new Map();
    this.handlerMetrics = new Map();
  }
  
  recordEvent(eventType, results) {
    if (!this.eventCounts.has(eventType)) {
      this.eventCounts.set(eventType, { total: 0, successful: 0, failed: 0 });
    }
    
    const stats = this.eventCounts.get(eventType);
    stats.total++;
    stats.successful += results.filter(r => r.status === 'fulfilled').length;
    stats.failed += results.filter(r => r.status === 'rejected').length;
  }
  
  recordHandlerExecution(eventType, handlerId, status, duration, error = null) {
    const key = `${eventType}:${handlerId}`;
    if (!this.handlerMetrics.has(key)) {
      this.handlerMetrics.set(key, {
        executions: 0,
        successes: 0,
        failures: 0,
        totalDuration: 0,
        averageDuration: 0,
        lastError: null
      });
    }
    
    const metrics = this.handlerMetrics.get(key);
    metrics.executions++;
    metrics.totalDuration += duration;
    metrics.averageDuration = metrics.totalDuration / metrics.executions;
    
    if (status === 'success') {
      metrics.successes++;
    } else {
      metrics.failures++;
      metrics.lastError = error;
    }
  }
  
  getEventStats(eventType) {
    return this.eventCounts.get(eventType) || { total: 0, successful: 0, failed: 0 };
  }
  
  getHandlerStats(eventType, handlerId) {
    const key = `${eventType}:${handlerId}`;
    return this.handlerMetrics.get(key);
  }
}

// Usage example with proper error handling
const eventBus = new EventBus();

// Add logging middleware
eventBus.addMiddleware(async (event) => {
  console.log(`Publishing event: ${event.type}`, event.metadata);
});

// Add validation middleware
eventBus.addMiddleware(async (event) => {
  if (!event.data || typeof event.data !== 'object') {
    throw new Error('Event data must be an object');
  }
});

// Subscribe to events with different priorities
eventBus.subscribe('user.created', async (event) => {
  // High priority: Send welcome email
  await emailService.sendWelcomeEmail(event.data.email);
}, { priority: 10, maxRetries: 5 });

eventBus.subscribe('user.created', async (event) => {
  // Lower priority: Update analytics
  await analyticsService.trackUserCreation(event.data);
}, { priority: 5, maxRetries: 2 });

// Publish events
eventBus.publish('user.created', {
  userId: '123',
  email: 'user@example.com',
  name: 'John Doe'
}, {
  source: 'registration-service'
});
```

#### Database Patterns and Best Practices

```python
# Advanced database patterns with connection pooling and transaction management
import asyncpg
import asyncio
from contextlib import asynccontextmanager
from typing import List, Dict, Any, Optional, Union
import logging
from dataclasses import dataclass
from datetime import datetime, timezone

@dataclass
class DatabaseConfig:
    host: str
    port: int
    database: str
    username: str
    password: str
    min_connections: int = 5
    max_connections: int = 20
    connection_timeout: int = 30
    command_timeout: int = 60

class DatabaseManager:
    def __init__(self, config: DatabaseConfig):
        self.config = config
        self.pool = None
        self.logger = logging.getLogger(__name__)
    
    async def initialize(self):
        """Initialize database connection pool"""
        try:
            self.pool = await asyncpg.create_pool(
                host=self.config.host,
                port=self.config.port,
                database=self.config.database,
                user=self.config.username,
                password=self.config.password,
                min_size=self.config.min_connections,
                max_size=self.config.max_connections,
                timeout=self.config.connection_timeout,
                command_timeout=self.config.command_timeout
            )
            self.logger.info("Database connection pool initialized")
        except Exception as e:
            self.logger.error(f"Failed to initialize database pool: {e}")
            raise
    
    async def close(self):
        """Close database connection pool"""
        if self.pool:
            await self.pool.close()
            self.logger.info("Database connection pool closed")
    
    @asynccontextmanager
    async def get_connection(self):
        """Get database connection from pool"""
        if not self.pool:
            raise RuntimeError("Database pool not initialized")
        
        async with self.pool.acquire() as connection:
            try:
                yield connection
            except Exception as e:
                self.logger.error(f"Database operation failed: {e}")
                raise
    
    @asynccontextmanager
    async def get_transaction(self):
        """Get database transaction"""
        async with self.get_connection() as connection:
            async with connection.transaction():
                yield connection
    
    async def execute_query(
        self, 
        query: str, 
        *args, 
        fetch_mode: str = 'none'
    ) -> Union[List[Dict], Dict, Any, None]:
        """
        Execute database query with proper error handling.
        
        Args:
            query: SQL query string
            *args: Query parameters
            fetch_mode: 'none', 'one', 'all', 'scalar'
        """
        async with self.get_connection() as connection:
            try:
                if fetch_mode == 'none':
                    result = await connection.execute(query, *args)
                    return result
                elif fetch_mode == 'one':
                    result = await connection.fetchrow(query, *args)
                    return dict(result) if result else None
                elif fetch_mode == 'all':
                    results = await connection.fetch(query, *args)
                    return [dict(row) for row in results]
                elif fetch_mode == 'scalar':
                    result = await connection.fetchval(query, *args)
                    return result
                else:
                    raise ValueError(f"Invalid fetch_mode: {fetch_mode}")
                    
            except asyncpg.PostgresError as e:
                self.logger.error(f"PostgreSQL error: {e}")
                raise
            except Exception as e:
                self.logger.error(f"Database query failed: {e}")
                raise

class Repository:
    """Base repository class with common database operations"""
    
    def __init__(self, db_manager: DatabaseManager, table_name: str):
        self.db = db_manager
        self.table_name = table_name
        self.logger = logging.getLogger(f"repository.{table_name}")
    
    async def find_by_id(self, id: Union[int, str]) -> Optional[Dict]:
        """Find record by ID"""
        query = f"SELECT * FROM {self.table_name} WHERE id = $1"
        return await self.db.execute_query(query, id, fetch_mode='one')
    
    async def find_all(
        self, 
        filters: Optional[Dict] = None, 
        limit: Optional[int] = None,
        offset: Optional[int] = None,
        order_by: Optional[str] = None
    ) -> List[Dict]:
        """Find all records with optional filtering and pagination"""
        where_clause = ""
        params = []
        param_count = 0
        
        if filters:
            conditions = []
            for key, value in filters.items():
                param_count += 1
                conditions.append(f"{key} = ${param_count}")
                params.append(value)
            where_clause = f" WHERE {' AND '.join(conditions)}"
        
        order_clause = f" ORDER BY {order_by}" if order_by else ""
        limit_clause = f" LIMIT {limit}" if limit else ""
        offset_clause = f" OFFSET {offset}" if offset else ""
        
        query = f"SELECT * FROM {self.table_name}{where_clause}{order_clause}{limit_clause}{offset_clause}"
        
        return await self.db.execute_query(query, *params, fetch_mode='all')
    
    async def create(self, data: Dict) -> Dict:
        """Create new record"""
        columns = list(data.keys())
        placeholders = [f"${i+1}" for i in range(len(columns))]
        values = list(data.values())
        
        query = f"""
            INSERT INTO {self.table_name} ({', '.join(columns)}) 
            VALUES ({', '.join(placeholders)}) 
            RETURNING *
        """
        
        result = await self.db.execute_query(query, *values, fetch_mode='one')
        self.logger.info(f"Created record in {self.table_name}: {result['id']}")
        return result
    
    async def update(self, id: Union[int, str], data: Dict) -> Optional[Dict]:
        """Update existing record"""
        if not data:
            return await self.find_by_id(id)
        
        # Add updated_at timestamp
        data['updated_at'] = datetime.now(timezone.utc)
        
        set_clauses = []
        params = []
        for i, (key, value) in enumerate(data.items(), 1):
            set_clauses.append(f"{key} = ${i}")
            params.append(value)
        
        params.append(id)  # For WHERE clause
        
        query = f"""
            UPDATE {self.table_name} 
            SET {', '.join(set_clauses)} 
            WHERE id = ${len(params)} 
            RETURNING *
        """
        
        result = await self.db.execute_query(query, *params, fetch_mode='one')
        if result:
            self.logger.info(f"Updated record in {self.table_name}: {id}")
        return result
    
    async def delete(self, id: Union[int, str]) -> bool:
        """Delete record by ID"""
        query = f"DELETE FROM {self.table_name} WHERE id = $1"
        result = await self.db.execute_query(query, id)
        
        # Check if any rows were affected
        rows_affected = result.split()[-1] if isinstance(result, str) else 0
        if int(rows_affected) > 0:
            self.logger.info(f"Deleted record from {self.table_name}: {id}")
            return True
        return False
    
    async def count(self, filters: Optional[Dict] = None) -> int:
        """Count records with optional filtering"""
        where_clause = ""
        params = []
        
        if filters:
            conditions = []
            for i, (key, value) in enumerate(filters.items(), 1):
                conditions.append(f"{key} = ${i}")
                params.append(value)
            where_clause = f" WHERE {' AND '.join(conditions)}"
        
        query = f"SELECT COUNT(*) FROM {self.table_name}{where_clause}"
        return await self.db.execute_query(query, *params, fetch_mode='scalar')

# Example usage with proper error handling and transactions
class UserRepository(Repository):
    def __init__(self, db_manager: DatabaseManager):
        super().__init__(db_manager, 'users')
    
    async def find_by_email(self, email: str) -> Optional[Dict]:
        """Find user by email address"""
        query = "SELECT * FROM users WHERE email = $1"
        return await self.db.execute_query(query, email, fetch_mode='one')
    
    async def create_user_with_profile(
        self, 
        user_data: Dict, 
        profile_data: Dict
    ) -> Dict:
        """Create user and profile in a single transaction"""
        async with self.db.get_transaction() as connection:
            # Create user
            user_query = """
                INSERT INTO users (name, email, password_hash, created_at) 
                VALUES ($1, $2, $3, $4) 
                RETURNING *
            """
            user = await connection.fetchrow(
                user_query,
                user_data['name'],
                user_data['email'],
                user_data['password_hash'],
                datetime.now(timezone.utc)
            )
            
            # Create profile
            profile_query = """
                INSERT INTO user_profiles (user_id, bio, avatar_url, created_at) 
                VALUES ($1, $2, $3, $4) 
                RETURNING *
            """
            profile = await connection.fetchrow(
                profile_query,
                user['id'],
                profile_data.get('bio'),
                profile_data.get('avatar_url'),
                datetime.now(timezone.utc)
            )
            
            return {
                'user': dict(user),
                'profile': dict(profile)
            }
```

### Advanced AI Integration Patterns

#### Contextual Code Generation

When working with AI coding agents, providing comprehensive context leads to better results:

```python
"""
Context: E-commerce order processing system
Requirements: 
- Process orders with multiple items
- Handle inventory checking and reservation
- Calculate shipping costs based on location
- Support multiple payment methods
- Send order confirmation emails
- Handle failed payments gracefully
- Log all order events for audit
- Support order cancellation within 30 minutes

Database schema:
- orders: id, user_id, status, total_amount, created_at
- order_items: id, order_id, product_id, quantity, price
- products: id, name, price, inventory_count
- users: id, name, email, shipping_address
"""

class OrderProcessor:
    def __init__(
        self, 
        db_manager: DatabaseManager, 
        inventory_service: InventoryService,
        payment_service: PaymentService,
        notification_service: NotificationService,
        shipping_service: ShippingService
    ):
        # AI will generate comprehensive initialization based on context
        pass
    
    async def process_order(self, order_data: Dict) -> OrderResult:
        """
        Process a complete order with all validations and side effects.
        
        Steps:
        1. Validate order data and user information
        2. Check inventory availability for all items
        3. Calculate total amount including taxes and shipping
        4. Reserve inventory items
        5. Process payment
        6. Create order record with items
        7. Send confirmation email
        8. Schedule inventory update
        
        Error handling:
        - Roll back inventory reservations on payment failure
        - Log all failures for investigation
        - Provide meaningful error messages to users
        """
        # AI will generate comprehensive implementation
        pass
```

#### Error Handling Patterns with AI Assistance

```javascript
/**
 * Context: Real-time chat application with WebSocket connections
 * Requirements:
 * - Handle connection drops gracefully
 * - Implement automatic reconnection with exponential backoff
 * - Queue messages when disconnected
 * - Sync message state on reconnection
 * - Handle different types of errors (network, server, validation)
 * - Provide user feedback for connection status
 * - Support multiple chat rooms
 * - Handle message ordering and deduplication
 */

class ChatClient {
  constructor(config) {
    // AI will generate robust initialization
    this.config = config;
    this.websocket = null;
    this.connectionState = 'disconnected';
    this.messageQueue = [];
    this.reconnectAttempts = 0;
    this.maxReconnectAttempts = 10;
    this.reconnectDelay = 1000; // Start with 1 second
    this.heartbeatInterval = null;
    this.eventListeners = new Map();
  }

  /**
   * Connect to chat server with comprehensive error handling.
   * 
   * Error scenarios to handle:
   * - Network connectivity issues
   * - Server unavailable
   * - Authentication failures
   * - Rate limiting
   * - Protocol version mismatches
   */
  async connect() {
    // AI will generate robust connection logic with error handling
  }

  /**
   * Send message with queue management and error recovery.
   * 
   * Features:
   * - Queue messages when disconnected
   * - Retry failed sends
   * - Deduplicate messages
   * - Handle rate limiting
   * - Validate message format
   */
  async sendMessage(message) {
    // AI will generate comprehensive message sending logic
  }

  /**
   * Handle various WebSocket errors and implement recovery strategies.
   */
  handleWebSocketError(error) {
    // AI will generate comprehensive error handling
  }
}
```

## Support

For questions about GitHub Copilot, refer to the official documentation or your team's coding standards.

Additional instruction files available:
- [General Development Instructions](instructions/general.instructions.md) - Basic development standards
- [Development Instructions](instructions/development.instructions.md) - Comprehensive development practices  
- [Testing Instructions](instructions/testing.instructions.md) - Testing strategies and frameworks
- [Python Development Instructions](instructions/python.instructions.md) - Python-specific development
- [JavaScript Development Instructions](instructions/javascript.instructions.md) - JavaScript-specific development
- [Wallet Integration Instructions](instructions/wallet-integration.instructions.md) - Blockchain wallet integration