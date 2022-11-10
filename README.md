# TP Bioinformática

## Ejercicio 1: nucleótidos (Genbank) -> aminoácidos (FASTA)

Usando archivo de secuencia Genbank:

```bash
./Ex1.pm NM_000441.gb NM_000441.fas
```

Usando accession contra la base de datos:

```bash
./Ex1.pm NM_000441 NM_000441.fas db
```

## Ejercicio 2: aminoácidos (FASTA) -> proteínas (BLAST)

Usando la base de datos remota:

```bash
./Ex2.pm NM_000441.fas blast.out
```

Usando una base de datos local:

```bash
./Ex2.pm NM_000441.fas blast.out '$HOME/blast/db/FASTA/data'
```

## Ejercicio 3: parseo de BLAST

```bash
./Ex4.pm blast.out "Mus musculus"
```

Agregando un parámetro se puede indicar un archivo donde guardar las cadenas de aminoácidos de los resultados encontrados, obtenidos de GenBank, en formato FASTA:

```bash
./Ex4.pm blast.out "Mus musculus" ex4.fas
```
