# Harness — Agent Sandboxes for Tensorlake

Community-maintained Dockerfiles for agent harnesses on [harness.new](https://www.harness.new). Each harness boots a fresh, isolated Linux sandbox on [Tensorlake](https://cloud.tensorlake.ai) with the agent pre-installed and state that persists across sessions.

## Available Harnesses

| Harness | Dockerfile |
|---|---|
| Claude Code | `harnesses/Dockerfile.claude` |
| Codex | `harnesses/Dockerfile.codex` |
| Droid | `harnesses/Dockerfile.droid` |
| ForgeCode | `harnesses/Dockerfile.forge` |
| Goose | `harnesses/Dockerfile.goose` |
| Custom | `harnesses/Dockerfile.custom` |

## Contributing a Harness

### 1. Sign up for Tensorlake

Create an account at [cloud.tensorlake.ai](https://cloud.tensorlake.ai), then grab your API key from the dashboard and set it:

```bash
export TENSORLAKE_API_KEY=your-api-key-here
```

Install the CLI and log in:

```bash
pip install tensorlake
tl login
```

### 2. Write your Dockerfile

Copy `harnesses/Dockerfile.custom` as a starting point and name it `Dockerfile.<agentname>`:

```bash
cp harnesses/Dockerfile.custom harnesses/Dockerfile.<agentname>
```

Look at the existing harnesses to understand the conventions:

- Use `ubuntu-minimal` as the base image (more base images coming)
- Install your agent and make sure its binary is on `PATH` (i.e. in `/usr/local/bin`)
- Set a friendly MOTD in `/etc/motd` so users know how to start the agent
- Source `/etc/motd` from `/etc/bash.bashrc` so it prints on login

### 3. Build and test your image

```bash
tl sbx image create ./harnesses/Dockerfile.<agentname> -n <agentname>-test
```

Refer to the [Tensorlake sandbox docs](https://docs.tensorlake.ai/sandboxes/introduction) for full details on building and running sandbox images.

### 4. Open a pull request

Submit a PR with your `Dockerfile.<agentname>`. The Tensorlake team will review it and, once approved, add it to [harness.new](https://www.harness.new).

## Using a Harness from Your Laptop

Install the CLI, log in, and SSH into a running sandbox:

```bash
pip install tensorlake
tl login
tl sbx ssh <sandbox-id>
```

## Resources

- [harness.new](https://www.harness.new) — launch and manage agent sandboxes in the browser
- [Sandbox docs](https://docs.tensorlake.ai/sandboxes/introduction) — how sandboxes work, lifecycle, snapshots, and more
- [Tensorlake Cloud](https://cloud.tensorlake.ai) — sign up and manage your account

## License

Apache 2.0 — see [LICENSE](./LICENSE).
