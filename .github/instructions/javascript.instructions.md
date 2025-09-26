# JavaScript Development Instructions

*For related guidance, see:*
- [General Development Instructions](general.instructions.md) - Basic development standards
- [Development Instructions](development.instructions.md) - Comprehensive development practices
- [Testing Instructions](testing.instructions.md) - Testing strategies and frameworks
- [Python Development Instructions](python.instructions.md) - Python-specific development
- [Wallet Integration Instructions](wallet-integration.instructions.md) - Blockchain wallet integration

## Code Style

- Use ES6+ features when appropriate
- Prefer `const` and `let` over `var`
- Use arrow functions for short anonymous functions
- Implement proper error handling with try-catch

## Testing

- Use Jest for unit testing
- Write tests in `__tests__/` directories or `.test.js` files
- Mock external API calls
- Aim for high test coverage

## Dependencies

- Keep dependencies up to date
- Use exact versions for production dependencies
- Document any peer dependencies

## Performance

- Avoid unnecessary re-renders in React
- Use async/await for asynchronous operations
- Implement proper loading states
- Consider code splitting for large applications

## Example Code Structure

```javascript
// Good: Clear function with proper error handling
async function fetchUserData(userId) {
  try {
    const response = await api.get(`/users/${userId}`);
    return response.data;
  } catch (error) {
    console.error('Failed to fetch user data:', error);
    throw new Error('User data unavailable');
  }
}
```