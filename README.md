# Projekt MS

Metoda do implementacji: `Romano-Wolf` :wolf:

## Praca z repo

Pobieracie GitHub Desktop, i pobieracie sobie to repozytorium do jakiego katalogu chcecie,
potem w R Studio można wybrać ten folder z tego prawego dolnego okna.

Aby dodać zmiany, wpisujemy co zmieniliśmy, zaznaczamy wszystkie pliki, Commit > Push.

Aby zaczytać nowe zmiany, robimy fetch i pull

Visual Studio Code, setup do debuggowania

1. Pobierz Visual Studio Code: [Link](https://code.visualstudio.com/)
2. Pobierz `R` oraz `RStudio`
3. W Visual Studio Codzie pobierz rozszerzenia: `R`, `R Debugger` oraz `Live Share`
4. W samym R zainstaluj pakiet według linijki jak poniżej
5. Po otworzeniu pliku można Debuggować po wciśnięciu `ctrl+shift+s`

```R
install.packages("vscDebugger", repos = "https://manuelhentschel.r-universe.dev")
```


W przypadku linii poleceń:

```sh
git clone git@github.com:eRgo35/polsl-ms.git
```

```sh
cd posls-ms
```

Dodawanie nowych zmian:

```sh
git add .
```

```sh
git commit -m "<co zostało zmienione>"
```

```sh
git push
```

Pobieranie najnowszych zmian

```sh
git pull
```
