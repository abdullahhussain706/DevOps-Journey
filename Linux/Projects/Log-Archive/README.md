# Log Archive Tool

A simple Bash CLI tool that compresses log directories into timestamped `.tar.gz` archives. This project was built as part of the roadmap.sh DevOps learning path.

## Project URL

https://roadmap.sh/projects/log-archive-tool

---

## Features

- Archive any log directory provided as a command-line argument.
- Creates compressed `.tar.gz` archives.
- Automatically creates an `archives/` directory if it does not exist.
- Generates timestamped archive filenames.
- Maintains an `archive_history.log` file for archive records.
- Validates user input and directory existence.
- Returns proper exit codes for success and failure.

---

## Project Structure

```
Log-Archive/
├── archive.sh
├── archive_history.log
├── archives/
│   └── logs_archive_YYYYMMDD_HHMMSS.tar.gz
└── README.md
```

---

## Requirements

- Linux
- Bash
- tar

---

## Usage

Make the script executable:

```bash
chmod +x archive.sh
```

Run the script:

```bash
./archive.sh <log-directory>
```

Example:

```bash
./archive.sh /var/log
```

> Some system log directories require root privileges.

```bash
sudo ./archive.sh /var/log
```

---

## Example Output

```
Archive created successfully:
archives/logs_archive_20260804_173245.tar.gz
```

Archive history:

```
20260804_173245 | Source: /var/log | Archive: archives/logs_archive_20260804_173245.tar.gz
```

---

## Error Handling

The script checks for:

- Missing command-line arguments
- Invalid directory paths
- Archive creation failures

---

## Concepts Practiced

- Bash scripting
- Command-line arguments
- Conditional statements
- Exit status codes
- Variables
- File and directory management
- tar command
- Logging
- Linux permissions

---

## Learning Outcome

This project helped me practice building a real-world Bash automation tool while improving my understanding of Linux file handling, scripting, and command-line utilities.

---

## License

This project is for learning purposes.
