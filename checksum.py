import argparse

def calculate_checksum(input_string: str) -> int:
    """
    Calculate a simple checksum for a given string.

    The checksum is calculated by:
    - Multiplying the character's position (1-indexed) by its Unicode value.
    - Adding the length of the string to the result.
    """
    return sum((i + 1) * ord(char) for i, char in enumerate(input_string)) + len(input_string)


def pad_repeat_until(input: int, length: int) -> str:
    """
    Repeat the number as a string until it reaches the desired length.
    """
    input_str = str(input)
    repeated_str = input_str * (length // len(input_str) + 1)
    return repeated_str[:length]


def main():
    parser = argparse.ArgumentParser(description="Calculate a checksum for a given string.")
    parser.add_argument("input_string", type=str, help="The string to calculate the checksum for.")
    args = parser.parse_args()

    result = pad_repeat_until(calculate_checksum(args.input_string), 12)

    print(f"Checksum for '{args.input_string}': {result}")


if __name__ == "__main__":
    main()