# csv-db-rb
Project to work with a local database stored as a csv

## Usage
```rb
db = Csvdb.new('database.csv')

new_data = [
  {
    key1: 'value1a',
    key2: 'value2a',
  },
  {
    key1: 'value1b',
    key2: 'value2b',
  },
]

# returns merged dataset in current environment
combined = db.merge(new_data)

# writes new combined dataset back to original db file
db.write(combined)
```

## Roadmap
- [x] read from csv
- [x] write new hash
- [x] merge new hash with existing data (existing keys)
- [ ] merge new hash with existing data (new keys)
