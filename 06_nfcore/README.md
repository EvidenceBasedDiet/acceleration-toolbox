## *nf-core*

Standardized workflows in bioinformatics:
* large community-based pipelines
* standard frameworks
* wide-range of pipelines for different bioinformatics needs

Example analysis with ```nf-core/rnaseq```

## 1. Background: The nf-core Initiative

In the era of massive genomics data, reproducibility and scalability are paramount. While **Nextflow** provides a robust domain-specific language (DSL) for writing scalable workflows, researchers often found themselves "reinventing the wheel" by writing their own custom RNA-seq, ChIP-seq, or WGS pipelines. 

**nf-core** was born out of the need to standardize these efforts. It is a community-driven project to collect a curated set of bioinformatics analysis pipelines built using Nextflow. 

**Key Principles of nf-core:**
* **Reproducibility:** Ensuring that data analyzed today will yield the exact same results years from now, regardless of the compute environment.
* **Portability:** Write once, run anywhere. Pipelines run seamlessly on a laptop, a university HPC cluster, or public clouds (AWS, GCP, Azure).
* **Community:** Developed collaboratively by institutions worldwide, ensuring pipelines represent the current best practices in bioinformatics.

---

## 2. The nf-core Platform & Infrastructure

The power of nf-core lies in how it abstracts the underlying computational platform, allowing workflow managers to focus on data rather than IT configuration.

### Containerization
Every tool used in an nf-core pipeline is containerized. nf-core mandates that pipelines support multiple software packaging tools:
* **Docker:** Ideal for local development and cloud execution.
* **Singularity / Apptainer:** The standard for High-Performance Computing (HPC) clusters due to its secure user-space execution.
* **Conda:** Provided as a fallback, though containers are highly preferred for strict reproducibility.

### Execution Environments
Through Nextflow's abstraction, an nf-core pipeline can be deployed on various infrastructures simply by changing the `-profile` flag:
* **Local:** Executing directly on a single machine.
* **HPC Schedulers:** Native integration with Slurm, PBS, SGE, LSF.
* **Cloud Batch Services:** AWS Batch, Google Cloud Life Sciences, Azure Batch.
* **Kubernetes:** For cloud-native orchestration.

### Nextflow Tower (Seqera Platform)
For enterprise workflow managers, nf-core pipelines integrate natively with Seqera Platform (formerly Nextflow Tower), providing a GUI for launching, monitoring, and auditing pipeline runs across multiple compute environments.

---

## 3. Standardized Workflows

What makes an nf-core pipeline different from a standard Nextflow script? **Strict standardization.**

To be accepted into the nf-core repository, a pipeline must pass rigorous automated testing and adhere to strict guidelines:
1.  **Continuous Integration (CI):** Every commit triggers GitHub Actions that run the pipeline on minimal test datasets to ensure no code breaks the workflow.
2.  **Linting:** The `nf-core lint` tool enforces code formatting, standard parameter naming (e.g., always using `--input` for input files, `--outdir` for output directory), and documentation standards.
3.  **Standardized Output:** All pipelines generate comprehensive MultiQC reports summarizing the run, software versions, and primary QC metrics.
4.  **Stable Releases:** Pipelines are versioned using Git tags (e.g., `3.10.1`). Users are encouraged to run a specific release (using `-r`) rather than the `master` branch to guarantee long-term reproducibility.

---

## 4. nf-core Usage

The `nf-core` Python package is the primary command-line tool for interacting with the ecosystem.

**Installation:**
