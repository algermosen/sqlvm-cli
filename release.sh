#!/bin/bash
set -e

# Load version from version.sh
VERSION=$(bash ./version.sh)

if [[ -z "$VERSION" ]]; then
  echo "❌ version.sh did not return a version."
  exit 1
fi

RELEASE_MSG="Version $VERSION"
CREATE_GH_RELEASE=false

# Parse flags
while [[ $# -gt 0 ]]; do
  case "$1" in
    --message)
      RELEASE_MSG="$2"
      shift 2
      ;;
    --gh)
      CREATE_GH_RELEASE=true
      shift
      ;;
    *)
      echo "❌ Unknown option: $1"
      exit 1
      ;;
  esac
done

# Update version.txt
echo "$VERSION" > version.txt
echo "📄 Updated version.txt to $VERSION"

# Commit changes
git add version.txt
git commit -m "🔖 Release v$VERSION"

# Tag
git tag -a "v$VERSION" -m "$RELEASE_MSG"
echo "🏷️ Created git tag: v$VERSION"

# Push to origin
git push origin main
git push origin "v$VERSION"
echo "🚀 Pushed commit and tag to origin"

# Optional: Create GitHub release
if $CREATE_GH_RELEASE; then
  gh release create "v$VERSION" --title "v$VERSION" --notes "$RELEASE_MSG"
  echo "🌍 GitHub release published: v$VERSION"
fi
