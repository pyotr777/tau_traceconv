# jumpshot, traceconv.sh and tau2slog2

Trace visualisation and conversion tools for TAU.

## Usage

### Convert a large trace file to SLOG2 format

After creating a merged tau trace file, set JAVA_MEMORY to desired size in Megabytes 
and use traconv.sh with the name of merged trace file.
E.g.:
```
$ export JAVA_MEMORY=1024
$ tauconv.sh tau.trc
```

### Run jumpshot

```
$ export JAVA_MEMORY=4000
$ jumpshot
```
