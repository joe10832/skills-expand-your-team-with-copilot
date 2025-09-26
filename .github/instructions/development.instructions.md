# Development Instructions

This document provides comprehensive development guidance for working with AI coding agents.

*For related guidance, see:*
- [General Development Instructions](general.instructions.md) - Basic development standards
- [Python Development Instructions](python.instructions.md) - Python-specific guidance
- [JavaScript Development Instructions](javascript.instructions.md) - JavaScript-specific guidance
- [Testing Instructions](testing.instructions.md) - Testing strategies and practices
- [Wallet Integration Instructions](wallet-integration.instructions.md) - Blockchain wallet integration

## Development Workflow

### Planning and Architecture

1. **Requirements Analysis**
   - Define clear acceptance criteria
   - Identify technical constraints
   - Consider security implications
   - Plan for scalability

2. **Architecture Design**
   - Choose appropriate design patterns
   - Define API contracts
   - Plan data models
   - Consider integration points

### Code Development Practices

#### Version Control

- Use semantic commit messages
- Create feature branches for new development
- Keep commits atomic and focused
- Write descriptive commit messages

#### Code Organization

- Follow established project structure
- Separate concerns appropriately
- Use consistent naming conventions
- Group related functionality

#### Documentation

- Write self-documenting code
- Add inline comments for complex logic
- Maintain up-to-date README files
- Document API endpoints and schemas

### Development Environment Setup

#### Local Development

- Use consistent development environments
- Document environment setup procedures
- Use environment variables for configuration
- Maintain dependency isolation

#### IDE Configuration

- Configure linting and formatting tools
- Set up debugging environments
- Use code snippets for common patterns
- Configure auto-completion settings

### Code Quality Standards

#### Style Guidelines

- Enforce consistent code formatting
- Use linting tools appropriate for language
- Follow language-specific conventions
- Maintain consistent indentation

#### Performance Considerations

- Profile critical code paths
- Optimize database queries
- Implement caching strategies
- Consider resource usage

#### Security Best Practices

- Validate all user inputs
- Use parameterized queries
- Implement proper authentication
- Follow OWASP guidelines

### Collaboration Practices

#### Code Review

- Review all code changes before merging
- Focus on logic, security, and maintainability
- Provide constructive feedback
- Test changes in review environment

#### Team Communication

- Document architectural decisions
- Share knowledge through documentation
- Conduct regular code review sessions
- Maintain team coding standards

### Continuous Integration

#### Automated Testing

- Run tests on every commit
- Maintain test coverage metrics
- Use different test types (unit, integration, e2e)
- Automate test reporting

#### Build and Deployment

- Automate build processes
- Use consistent deployment procedures
- Implement rollback strategies
- Monitor deployment health

## Working with AI Coding Agents

### Effective Prompting

- Provide clear context and requirements
- Specify coding standards and conventions
- Include relevant code examples
- Ask for explanations of complex solutions

### Code Generation

- Review all AI-generated code thoroughly
- Test generated code before integration
- Ensure compliance with project standards
- Validate security implications

### Debugging with AI

- Provide complete error context
- Include relevant code snippets
- Describe expected vs actual behavior
- Ask for multiple solution approaches

### Documentation Generation

- Use AI to generate initial documentation drafts
- Review and refine AI-generated content
- Ensure accuracy and completeness
- Maintain documentation consistency

## Language-Specific Considerations

For detailed language-specific guidance, refer to:
- [Python Development Instructions](python.instructions.md)
- [JavaScript Development Instructions](javascript.instructions.md)
- [General Development Instructions](general.instructions.md)

## Testing and Quality Assurance

For comprehensive testing guidance, see [Testing Instructions](testing.instructions.md).

## Integration Patterns

For blockchain and wallet integration guidance, see [Wallet Integration Instructions](wallet-integration.instructions.md).