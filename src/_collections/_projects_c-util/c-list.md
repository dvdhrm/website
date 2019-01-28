---
title: c-list
description: Circular Intrusive Double Linked List Collection
licenses:
  - Apache Software License 2.0
  - Lesser General Public License 2.1+
---
The *c-list* project implements an *intrusive* collection based on *circular
double linked lists* in *ISO-C11*.

## Example

A typical use-case for *c-list* is a single collection of objects of a custom
data-structure. This example shows how you could insert, remove, and iterate
custom objects in a list based on *c-list*:

```c
typedef struct {
        int ..some-fields..;
        CList link;
        int ..more-fields..;
} MyData;

int main(int argc, char **argv) {
        CList *iter, list = C_LIST_INIT(list);
        MyData *node, node1, node2;

        c_list_link_tail(&list, &node1->link);
        c_list_link_tail(&list, &node2->link);

        /* open-coded iterator */
        for (iter = list.first; iter != &list; iter = iter->next) {
                /* ..visitor.. */
        }

        c_list_unlink(&node1->link);

        /* alternative iterator */
        c_list_for_each_entry(node, &list, link) {
                /* ..visitor.. */
        }

        c_list_unlink(&node2->link);

        assert(c_list_is_empty(&list));
        return 0;
}
```
