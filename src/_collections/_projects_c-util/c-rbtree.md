---
title: c-rbtree
description: Intrusive Red-Black Tree Collection
licenses:
  - Apache Software License 2.0
  - Lesser General Public License 2.1+
---
The *c-rbtree* project implements an *intrusive* collection based on
*red-black-trees* in *ISO-C11*. Its API guarantees the user full control over
its data-structures, and rather limits itself to just the tree-specific
rebalancing and coloring operations.

The API exposes two major types, a tree type **CRBTree** and a node type
**CRBNode**. Both are open coded structures, with 1 and 3 member pointers
respectively. They can be accessed freely, and they provide the user a simple
binary tree, that can be traversed by following the member pointers. 

## Example

A typical use-case for *c-rbtree* is a lookup map for a custom data-structure.
This example shows how you could insert, remove, and find your custom objects
in a lookup map based on *c-rbtree*:

```c
typedef struct {
        int ..some-fields..;
        int key;
        CRBNode rb;
        int ..more-fields..;
} MyData;

/*
 * Link @node into @tree. In case there is already a
 * different element with the same key, skip the
 * insertion and return false.
 * You could very well insert duplicates. But for the
 * purpose of this example, we avoid inserting two
 * elements with the same key.
 */
bool link(CRBTree *tree, MyData *node) {
        CRBNode *parent, **i;
        MyData *entry;

        parent = NULL;
        i = &tree->root;

        while (*i) {
                p = *i;
                entry = c_rbnode_entry(*i, MyData, rb);

                if (node->key < entry->key)
                        *i = &p->left;
                else if (node->key > entry->key)
                        *i = &p->right;
                else
                        return false;
        }

        c_rbtree_add(tree, parent, i, &node->rb);
        return true;
}

/*
 * Unlink @node from the tree it is currently linked
 * on. If @node is marked as unlinked, this is a no-op.
 */
void unlink(MyData *node) {
        c_rbnode_unlink(&node->rb);
}

/*
 * Search through @tree for an element that matches
 * the key given as @key. If none is found, NULL is
 * returned.
 */
MyData *find(CRBTree *tree, int key) {
        CRBNode *i;
        MyData *entry;

        i = tree->root;
        while (i) {
                entry = c_rbnode_entry(i, MyData, rb);

                if (key < entry->key)
                        i = i->left;
                else if (key > entry->key)
                        i = i->right;
                else
                        return entry;
        }

        return NULL;
}
```
