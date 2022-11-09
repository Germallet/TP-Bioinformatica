# TP Bioinformática

## Ejercicio 1

```bash
./Ex1.pm NM_000441.gb NM_000441.fas
```

## Ejercicio 2

Usando la base de datos remota:

```bash
./Ex2.pm NM_000441.fas blast.out
```

Usando una base de datos local:

```bash
./Ex2.pm NM_000441.fas blast.out '$HOME/blast/db/FASTA/data'
```

## Ejercicio 3

```bash
./Ex4.pm blast.out "Mus musculus"
```