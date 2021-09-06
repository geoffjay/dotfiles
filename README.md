## Personal dotfiles

### Build

```bash
go build -o dotfiles main.go
```

### Update

```bash
./dotfiles update
```

### Testing

```bash
mkdir output
HOME=output/ TEMPLATED_DIR=templates/ ./dotfiles update
```
