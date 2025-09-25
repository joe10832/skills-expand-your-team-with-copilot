# Python Development Instructions

## Code Style

- Follow PEP 8 style guidelines
- Use type hints for function signatures
- Write docstrings for modules, classes, and functions
- Use meaningful variable names

## Testing

- Use pytest for testing
- Place tests in `tests/` directory
- Use fixtures for test setup
- Mock external dependencies

## Dependencies

- Use virtual environments
- Pin dependency versions in requirements.txt
- Separate dev and production dependencies

## Error Handling

- Use specific exception types
- Implement proper logging
- Handle edge cases gracefully

## Example Code Structure

```python
from typing import Optional, List
import logging

logger = logging.getLogger(__name__)

def process_user_data(user_id: int) -> Optional[dict]:
    """
    Process user data for the given user ID.
    
    Args:
        user_id: The ID of the user to process
        
    Returns:
        Processed user data or None if user not found
        
    Raises:
        ValueError: If user_id is invalid
    """
    if user_id <= 0:
        raise ValueError("User ID must be positive")
    
    try:
        # Process user data here
        return {"id": user_id, "status": "processed"}
    except Exception as e:
        logger.error(f"Failed to process user {user_id}: {e}")
        return None
```