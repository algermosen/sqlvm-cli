Some instructions to make a release to github.

---

## ✅ 1. **Install GitHub CLI**

If you haven’t already:

```bash
brew install gh
```

---

## 🛠️ 2. **Authenticate `gh`**

Run this once:

```bash
gh auth login
```

And follow the prompts:

* Choose: `GitHub.com`
* Method: `HTTPS`
* Login: `Login with browser`
* Paste the token when prompted (it’ll open the browser for you)

---

## 🧪 3. **Test your setup**

```bash
gh auth status
```

You should see:

```
✓ Logged in to github.com as <your-username>
✓ Git operations for github.com configured to use https
```

---

## 🚀 4. **Publish a release**

After bumping version in `version.sh`, run:

```bash
bash release.sh --gh --message "🧪 First public CLI release!"
```

You’ll get:

* A Git tag (`v0.0.x`)
* A GitHub release at:

  ```
  https://github.com/<your-username>/<repo-name>/releases/tag/v0.0.x
  ```

---

That’s it! If your repo is private, it still works — GitHub will show the release to collaborators only. Let me know if you want to automate attaching a changelog or `.zip`.
