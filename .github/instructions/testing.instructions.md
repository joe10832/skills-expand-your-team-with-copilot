# Testing Instructions

Comprehensive testing strategies and practices for development with AI coding agents.

*For related guidance, see:*
- [Development Instructions](development.instructions.md) - General development practices
- [General Development Instructions](general.instructions.md) - Basic development standards
- [Python Development Instructions](python.instructions.md) - Python testing with pytest
- [JavaScript Development Instructions](javascript.instructions.md) - JavaScript testing with Jest
- [Wallet Integration Instructions](wallet-integration.instructions.md) - Testing blockchain integrations

## Testing Philosophy

### Test-Driven Development (TDD)

1. **Red-Green-Refactor Cycle**
   - Write failing tests first
   - Implement minimal code to pass
   - Refactor while maintaining tests
   - Repeat for each feature

2. **Benefits of TDD**
   - Better design decisions
   - Comprehensive test coverage
   - Living documentation
   - Confidence in changes

### Testing Pyramid

#### Unit Tests (Foundation)
- Test individual functions/methods
- Fast execution
- High test coverage
- Minimal dependencies

#### Integration Tests (Middle)
- Test component interactions
- Database and API integrations
- Service-to-service communication
- Moderate execution time

#### End-to-End Tests (Top)
- Test complete user workflows
- UI and system integration
- Slower execution
- Fewer tests, critical paths only

## Test Types and Strategies

### Unit Testing

#### Best Practices
- Test one thing at a time
- Use descriptive test names
- Follow AAA pattern (Arrange, Act, Assert)
- Keep tests independent
- Use mocks for external dependencies

#### Example Structure
```
describe('UserService', () => {
  describe('createUser', () => {
    it('should create user with valid data', () => {
      // Arrange
      const userData = { name: 'John', email: 'john@example.com' };
      
      // Act
      const result = userService.createUser(userData);
      
      // Assert
      expect(result).toBeDefined();
      expect(result.id).toBeTruthy();
    });
  });
});
```

### Integration Testing

#### Database Testing
- Use test databases
- Implement data seeding
- Clean up between tests
- Test transactions and rollbacks

#### API Testing
- Test all HTTP methods
- Validate request/response formats
- Test error conditions
- Verify authentication/authorization

#### Service Integration
- Mock external services
- Test service boundaries
- Validate data transformation
- Test failure scenarios

### End-to-End Testing

#### UI Testing
- Test critical user journeys
- Use page object patterns
- Handle asynchronous operations
- Test across different browsers

#### System Testing
- Test complete workflows
- Verify system performance
- Test with realistic data volumes
- Validate business requirements

## Testing Tools and Frameworks

### JavaScript/TypeScript

#### Jest
- Unit and integration testing
- Built-in mocking capabilities
- Snapshot testing
- Code coverage reporting

#### Cypress
- End-to-end testing
- Real browser automation
- Time-travel debugging
- Visual testing capabilities

#### Testing Library
- Component testing utilities
- Accessibility testing
- User-centric test approach
- Framework-agnostic tools

### Python

#### pytest
- Flexible test discovery
- Fixture management
- Parametrized testing
- Plugin ecosystem

#### unittest
- Standard library testing
- Test case organization
- Mock object support
- Test suite management

#### Selenium
- Web application testing
- Cross-browser support
- Mobile testing capabilities
- Grid testing support

### Performance Testing

#### Load Testing
- Test system under expected load
- Identify performance bottlenecks
- Validate response times
- Test resource utilization

#### Stress Testing
- Test beyond normal capacity
- Identify breaking points
- Test recovery mechanisms
- Validate error handling

#### Tools
- Apache JMeter
- Artillery
- k6
- Locust

## Test Data Management

### Test Data Strategy

#### Static Test Data
- Consistent across test runs
- Version controlled fixtures
- Known expected outcomes
- Minimal maintenance overhead

#### Dynamic Test Data
- Generated for each test run
- Realistic data patterns
- Avoids test coupling
- Requires cleanup strategies

#### Test Data Factories
- Generate consistent test objects
- Support different test scenarios
- Maintain data relationships
- Enable data variation

### Data Seeding

#### Database Seeding
- Consistent initial state
- Realistic data volumes
- Referential integrity
- Easy cleanup procedures

#### API Data Setup
- Pre-populate required data
- Create test user accounts
- Set up test configurations
- Establish baseline state

## Mocking and Test Doubles

### Types of Test Doubles

#### Mocks
- Verify interactions
- Set expectations
- Validate call patterns
- Test behavior verification

#### Stubs
- Provide predetermined responses
- Control test conditions
- Isolate system under test
- Simplify test setup

#### Fakes
- Working implementations
- In-memory databases
- File system simulators
- Network service simulators

### Mocking Best Practices

- Mock at service boundaries
- Keep mocks simple
- Verify mock setup
- Reset mocks between tests
- Use real objects when possible

## Test Environment Management

### Environment Setup

#### Local Testing
- Consistent developer environments
- Quick test execution
- Easy debugging
- Offline capability

#### CI/CD Testing
- Automated test execution
- Consistent environment state
- Parallel test execution
- Result reporting

#### Staging Testing
- Production-like environment
- Complete system integration
- Performance validation
- User acceptance testing

### Environment Configuration

#### Database Management
- Test database per environment
- Automated schema migrations
- Data seeding procedures
- Backup and restore processes

#### Service Dependencies
- Mock external services
- Service virtualization
- Contract testing
- Environment isolation

## Testing with AI Coding Agents

### AI-Generated Test Code

#### Best Practices
- Review all generated tests
- Ensure proper test coverage
- Validate test logic
- Maintain test quality standards

#### Prompt Engineering
- Specify testing framework
- Include test requirements
- Request edge case coverage
- Ask for maintainable tests

### Test Case Generation

#### Automated Test Creation
- Generate test cases from requirements
- Create test data variations
- Identify edge cases
- Suggest test scenarios

#### Test Maintenance
- Update tests with code changes
- Refactor test duplication
- Improve test readability
- Optimize test performance

## Quality Metrics and Reporting

### Test Coverage

#### Code Coverage
- Line coverage metrics
- Branch coverage analysis
- Function coverage tracking
- Statement coverage validation

#### Coverage Tools
- Istanbul (JavaScript)
- coverage.py (Python)
- JaCoCo (Java)
- Built-in IDE tools

### Test Quality Metrics

#### Test Reliability
- Test flakiness detection
- Consistent test results
- Proper test isolation
- Minimal false positives

#### Test Performance
- Test execution time
- Resource utilization
- Parallel execution capability
- Test suite optimization

### Reporting and Analytics

#### Test Results
- Pass/fail statistics
- Trend analysis
- Failure root cause analysis
- Test history tracking

#### Quality Dashboards
- Real-time test status
- Coverage trends
- Performance metrics
- Team productivity insights

## Continuous Testing

### CI/CD Integration

#### Automated Test Execution
- Commit-triggered testing
- Pull request validation
- Deployment verification
- Scheduled test runs

#### Test Pipeline Design
- Fast feedback loops
- Parallel test execution
- Smart test selection
- Failure fast strategies

### Test Automation Strategy

#### Automation Levels
- Unit test automation
- Integration test automation
- UI test automation
- Performance test automation

#### Maintenance Practices
- Regular test review
- Test refactoring
- Obsolete test removal
- Test documentation updates

## Specialized Testing Areas

For blockchain and wallet integration testing, see [Wallet Integration Instructions](wallet-integration.instructions.md).

For language-specific testing practices, refer to:
- [Python Development Instructions](python.instructions.md)
- [JavaScript Development Instructions](javascript.instructions.md)