From: "Zhang, Jerry(Junwei)" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/8] drm/amdgpu: add some VM PD/PT iterators v2
Date: Thu, 13 Sep 2018 10:51:44 +0800
Message-ID: <c69449cb-c9fc-6239-4561-ced4e8828d38@amd.com>
References: <20180912085445.3245-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0842462807=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180912085445.3245-1-christian.koenig-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============0842462807==
Content-Type: multipart/alternative;
	boundary="------------F066445D7F70B4810C6DBE18"
Content-Language: en-US

--------------F066445D7F70B4810C6DBE18
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit

On 09/12/2018 04:54 PM, Christian König wrote:
> Both a leaf as well as dfs iterator to walk over all the PDs/PTs. v2: 
> update comments and fix for_each_amdgpu_vm_pt_dfs_safe Signed-off-by: 
> Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Reviewed-by: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
> --- drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 224 
> +++++++++++++++++++++++++++++++++ 1 file changed, 224 insertions(+) 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c index 
> 136b00412dc8..787a200cf796 100644 --- 
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c +++ 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c @@ -355,6 +355,230 @@ static 
> struct amdgpu_vm_pt *amdgpu_vm_pt_parent(struct amdgpu_vm_pt *pt) 
> return list_first_entry(&parent->va, struct amdgpu_vm_pt, 
> base.bo_list); } +/** + * amdgpu_vm_pt_cursor - state for 
> for_each_amdgpu_vm_pt + */ +struct amdgpu_vm_pt_cursor { + uint64_t 
> pfn; + struct amdgpu_vm_pt *parent; + struct amdgpu_vm_pt *entry; + 
> unsigned level; +}; + +/** + * amdgpu_vm_pt_start - start PD/PT walk + 
> * + * @adev: amdgpu_device pointer + * @vm: amdgpu_vm structure + * 
> @start: start address of the walk + * @cursor: state to initialize + * 
> + * Initialize a amdgpu_vm_pt_cursor to start a walk. + */ +static 
> void amdgpu_vm_pt_start(struct amdgpu_device *adev, + struct amdgpu_vm 
> *vm, uint64_t start, + struct amdgpu_vm_pt_cursor *cursor) +{ + 
> cursor->pfn = start; + cursor->parent = NULL; + cursor->entry = 
> &vm->root; + cursor->level = adev->vm_manager.root_level; +} + +/** + 
> * amdgpu_vm_pt_descendant - go to child node + * + * @adev: 
> amdgpu_device pointer + * @cursor: current state + * + * Walk to the 
> child node of the current node. + * Returns: + * True if the walk was 
> possible, false otherwise. + */ +static bool 
> amdgpu_vm_pt_descendant(struct amdgpu_device *adev, + struct 
> amdgpu_vm_pt_cursor *cursor) +{ + unsigned num_entries, shift, idx; + 
> + if (!cursor->entry->entries) + return false; + + 
> BUG_ON(!cursor->entry->base.bo); + num_entries = 
> amdgpu_vm_num_entries(adev, cursor->level); + shift = 
> amdgpu_vm_level_shift(adev, cursor->level); + + ++cursor->level; + idx 
> = (cursor->pfn >> shift) % num_entries; + cursor->parent = 
> cursor->entry; + cursor->entry = &cursor->entry->entries[idx]; + 
> return true; +} + +/** + * amdgpu_vm_pt_sibling - go to sibling node + 
> * + * @adev: amdgpu_device pointer + * @cursor: current state + * + * 
> Walk to the sibling node of the current node. + * Returns: + * True if 
> the walk was possible, false otherwise. + */ +static bool 
> amdgpu_vm_pt_sibling(struct amdgpu_device *adev, + struct 
> amdgpu_vm_pt_cursor *cursor) +{ + unsigned shift, num_entries; + + /* 
> Root doesn't have a sibling */ + if (!cursor->parent) + return false; 
> + + /* Go to our parents and see if we got a sibling */ + shift = 
> amdgpu_vm_level_shift(adev, cursor->level - 1); + num_entries = 
> amdgpu_vm_num_entries(adev, cursor->level - 1); + + if (cursor->entry 
> == &cursor->parent->entries[num_entries - 1]) + return false; + + 
> cursor->pfn += 1ULL << shift; + cursor->pfn &= ~((1ULL << shift) - 1); 
> + ++cursor->entry; + return true; +} + +/** + * amdgpu_vm_pt_ancestor 
> - go to parent node + * + * @cursor: current state + * + * Walk to the 
> parent node of the current node. + * Returns: + * True if the walk was 
> possible, false otherwise. + */ +static bool 
> amdgpu_vm_pt_ancestor(struct amdgpu_vm_pt_cursor *cursor) +{ + if 
> (!cursor->parent) + return false; + + --cursor->level; + cursor->entry 
> = cursor->parent; + cursor->parent = 
> amdgpu_vm_pt_parent(cursor->parent); + return true; +} + +/** + * 
> amdgpu_vm_pt_next - get next PD/PT in hieratchy + * + * @adev: 
> amdgpu_device pointer + * @cursor: current state + * + * Walk the 
> PD/PT tree to the next node. + */ +static void 
> amdgpu_vm_pt_next(struct amdgpu_device *adev, + struct 
> amdgpu_vm_pt_cursor *cursor) +{ + /* First try a newborn child */ + if 
> (amdgpu_vm_pt_descendant(adev, cursor)) + return; + + /* If that 
> didn't worked try to find a sibling */ + while 
> (!amdgpu_vm_pt_sibling(adev, cursor)) { + /* No sibling, go to our 
> parents and grandparents */ + if (!amdgpu_vm_pt_ancestor(cursor)) { + 
> cursor->pfn = ~0ll; + return; + } + } +} + +/** + * 
> amdgpu_vm_pt_first_leaf - get first leaf PD/PT + * + * @adev: 
> amdgpu_device pointer + * @vm: amdgpu_vm structure + * @start: start 
> addr of the walk + * @cursor: state to initialize + * + * Start a walk 
> and go directly to the leaf node. + */ +static void 
> amdgpu_vm_pt_first_leaf(struct amdgpu_device *adev, + struct amdgpu_vm 
> *vm, uint64_t start, + struct amdgpu_vm_pt_cursor *cursor) +{ + 
> amdgpu_vm_pt_start(adev, vm, start, cursor); + while 
> (amdgpu_vm_pt_descendant(adev, cursor)); +} + +/** + * 
> amdgpu_vm_pt_next_leaf - get next leaf PD/PT + * + * @adev: 
> amdgpu_device pointer + * @cursor: current state + * + * Walk the 
> PD/PT tree to the next leaf node. + */ +static void 
> amdgpu_vm_pt_next_leaf(struct amdgpu_device *adev, + struct 
> amdgpu_vm_pt_cursor *cursor) +{ + amdgpu_vm_pt_next(adev, cursor); + 
> while (amdgpu_vm_pt_descendant(adev, cursor)); +} + +/** + * 
> for_each_amdgpu_vm_pt_leaf - walk over all leaf PDs/PTs in the 
> hierarchy + */ +#define for_each_amdgpu_vm_pt_leaf(adev, vm, start, 
> end, cursor) \ + for (amdgpu_vm_pt_first_leaf((adev), (vm), (start), 
> &(cursor)); \ + (cursor).pfn <= end; amdgpu_vm_pt_next_leaf((adev), 
> &(cursor))) + +/** + * amdgpu_vm_pt_first_dfs - start a deep first 
> search + * + * @adev: amdgpu_device structure + * @vm: amdgpu_vm 
> structure + * @cursor: state to initialize + * + * Starts a deep first 
> traversal of the PD/PT tree. + */ +static void 
> amdgpu_vm_pt_first_dfs(struct amdgpu_device *adev, + struct amdgpu_vm 
> *vm, + struct amdgpu_vm_pt_cursor *cursor) +{ + 
> amdgpu_vm_pt_start(adev, vm, 0, cursor); + while 
> (amdgpu_vm_pt_descendant(adev, cursor)); +} + +/** + * 
> amdgpu_vm_pt_next_dfs - get the next node for a deep first search + * 
> + * @adev: amdgpu_device structure + * @cursor: current state + * + * 
> Move the cursor to the next node in a deep first search. + */ +static 
> void amdgpu_vm_pt_next_dfs(struct amdgpu_device *adev, + struct 
> amdgpu_vm_pt_cursor *cursor) +{ + if (!cursor->entry) + return; + + if 
> (!cursor->parent) + cursor->entry = NULL; + else if 
> (amdgpu_vm_pt_sibling(adev, cursor)) + while 
> (amdgpu_vm_pt_descendant(adev, cursor)); + else + 
> amdgpu_vm_pt_ancestor(cursor); +} + +/** + * 
> for_each_amdgpu_vm_pt_dfs_safe - safe deep first search of all PDs/PTs 
> + */ +#define for_each_amdgpu_vm_pt_dfs_safe(adev, vm, cursor, entry) 
> \ + for (amdgpu_vm_pt_first_dfs((adev), (vm), &(cursor)), \ + (entry) 
> = (cursor).entry, amdgpu_vm_pt_next_dfs((adev), &(cursor));\ + 
> (entry); (entry) = (cursor).entry, \ + amdgpu_vm_pt_next_dfs((adev), 
> &(cursor))) + /** * amdgpu_vm_get_pd_bo - add the VM PD to a 
> validation list *


--------------F066445D7F70B4810C6DBE18
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body link="#0B6CDA" vlink="#551A8B" text="#000000" bgcolor="#cce8cf"
    alink="#EE0000">
    <font size="+1">On 09/12/2018 04:54 PM, Christian König wrote:<br>
    </font>
    <blockquote type="cite"
      cite="mid:20180912085445.3245-1-christian.koenig-5C7GfCeVMHo@public.gmane.org">
      <pre wrap=""><font size="+1">Both a leaf as well as dfs iterator to walk over all the PDs/PTs.

v2: update comments and fix for_each_amdgpu_vm_pt_dfs_safe

Signed-off-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a></font></pre>
    </blockquote>
    <font size="+1">Reviewed-by: Junwei Zhang
      <a class="moz-txt-link-rfc2396E" href="mailto:Jerry.Zhang-5C7GfCeVMHo@public.gmane.org">&lt;Jerry.Zhang-5C7GfCeVMHo@public.gmane.org&gt;</a></font><br>
    <blockquote type="cite"
      cite="mid:20180912085445.3245-1-christian.koenig-5C7GfCeVMHo@public.gmane.org">
      <pre wrap=""><font size="+1">
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 224 +++++++++++++++++++++++++++++++++
 1 file changed, 224 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 136b00412dc8..787a200cf796 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -355,6 +355,230 @@ static struct amdgpu_vm_pt *amdgpu_vm_pt_parent(struct amdgpu_vm_pt *pt)
 	return list_first_entry(&amp;parent-&gt;va, struct amdgpu_vm_pt, base.bo_list);
 }
 
+/**
+ * amdgpu_vm_pt_cursor - state for for_each_amdgpu_vm_pt
+ */
+struct amdgpu_vm_pt_cursor {
+	uint64_t pfn;
+	struct amdgpu_vm_pt *parent;
+	struct amdgpu_vm_pt *entry;
+	unsigned level;
+};
+
+/**
+ * amdgpu_vm_pt_start - start PD/PT walk
+ *
+ * @adev: amdgpu_device pointer
+ * @vm: amdgpu_vm structure
+ * @start: start address of the walk
+ * @cursor: state to initialize
+ *
+ * Initialize a amdgpu_vm_pt_cursor to start a walk.
+ */
+static void amdgpu_vm_pt_start(struct amdgpu_device *adev,
+			       struct amdgpu_vm *vm, uint64_t start,
+			       struct amdgpu_vm_pt_cursor *cursor)
+{
+	cursor-&gt;pfn = start;
+	cursor-&gt;parent = NULL;
+	cursor-&gt;entry = &amp;vm-&gt;root;
+	cursor-&gt;level = adev-&gt;vm_manager.root_level;
+}
+
+/**
+ * amdgpu_vm_pt_descendant - go to child node
+ *
+ * @adev: amdgpu_device pointer
+ * @cursor: current state
+ *
+ * Walk to the child node of the current node.
+ * Returns:
+ * True if the walk was possible, false otherwise.
+ */
+static bool amdgpu_vm_pt_descendant(struct amdgpu_device *adev,
+				    struct amdgpu_vm_pt_cursor *cursor)
+{
+	unsigned num_entries, shift, idx;
+
+	if (!cursor-&gt;entry-&gt;entries)
+		return false;
+
+	BUG_ON(!cursor-&gt;entry-&gt;base.bo);
+	num_entries = amdgpu_vm_num_entries(adev, cursor-&gt;level);
+	shift = amdgpu_vm_level_shift(adev, cursor-&gt;level);
+
+	++cursor-&gt;level;
+	idx = (cursor-&gt;pfn &gt;&gt; shift) % num_entries;
+	cursor-&gt;parent = cursor-&gt;entry;
+	cursor-&gt;entry = &amp;cursor-&gt;entry-&gt;entries[idx];
+	return true;
+}
+
+/**
+ * amdgpu_vm_pt_sibling - go to sibling node
+ *
+ * @adev: amdgpu_device pointer
+ * @cursor: current state
+ *
+ * Walk to the sibling node of the current node.
+ * Returns:
+ * True if the walk was possible, false otherwise.
+ */
+static bool amdgpu_vm_pt_sibling(struct amdgpu_device *adev,
+				 struct amdgpu_vm_pt_cursor *cursor)
+{
+	unsigned shift, num_entries;
+
+	/* Root doesn't have a sibling */
+	if (!cursor-&gt;parent)
+		return false;
+
+	/* Go to our parents and see if we got a sibling */
+	shift = amdgpu_vm_level_shift(adev, cursor-&gt;level - 1);
+	num_entries = amdgpu_vm_num_entries(adev, cursor-&gt;level - 1);
+
+	if (cursor-&gt;entry == &amp;cursor-&gt;parent-&gt;entries[num_entries - 1])
+		return false;
+
+	cursor-&gt;pfn += 1ULL &lt;&lt; shift;
+	cursor-&gt;pfn &amp;= ~((1ULL &lt;&lt; shift) - 1);
+	++cursor-&gt;entry;
+	return true;
+}
+
+/**
+ * amdgpu_vm_pt_ancestor - go to parent node
+ *
+ * @cursor: current state
+ *
+ * Walk to the parent node of the current node.
+ * Returns:
+ * True if the walk was possible, false otherwise.
+ */
+static bool amdgpu_vm_pt_ancestor(struct amdgpu_vm_pt_cursor *cursor)
+{
+	if (!cursor-&gt;parent)
+		return false;
+
+	--cursor-&gt;level;
+	cursor-&gt;entry = cursor-&gt;parent;
+	cursor-&gt;parent = amdgpu_vm_pt_parent(cursor-&gt;parent);
+	return true;
+}
+
+/**
+ * amdgpu_vm_pt_next - get next PD/PT in hieratchy
+ *
+ * @adev: amdgpu_device pointer
+ * @cursor: current state
+ *
+ * Walk the PD/PT tree to the next node.
+ */
+static void amdgpu_vm_pt_next(struct amdgpu_device *adev,
+			      struct amdgpu_vm_pt_cursor *cursor)
+{
+	/* First try a newborn child */
+	if (amdgpu_vm_pt_descendant(adev, cursor))
+		return;
+
+	/* If that didn't worked try to find a sibling */
+	while (!amdgpu_vm_pt_sibling(adev, cursor)) {
+		/* No sibling, go to our parents and grandparents */
+		if (!amdgpu_vm_pt_ancestor(cursor)) {
+			cursor-&gt;pfn = ~0ll;
+			return;
+		}
+	}
+}
+
+/**
+ * amdgpu_vm_pt_first_leaf - get first leaf PD/PT
+ *
+ * @adev: amdgpu_device pointer
+ * @vm: amdgpu_vm structure
+ * @start: start addr of the walk
+ * @cursor: state to initialize
+ *
+ * Start a walk and go directly to the leaf node.
+ */
+static void amdgpu_vm_pt_first_leaf(struct amdgpu_device *adev,
+				    struct amdgpu_vm *vm, uint64_t start,
+				    struct amdgpu_vm_pt_cursor *cursor)
+{
+	amdgpu_vm_pt_start(adev, vm, start, cursor);
+	while (amdgpu_vm_pt_descendant(adev, cursor));
+}
+
+/**
+ * amdgpu_vm_pt_next_leaf - get next leaf PD/PT
+ *
+ * @adev: amdgpu_device pointer
+ * @cursor: current state
+ *
+ * Walk the PD/PT tree to the next leaf node.
+ */
+static void amdgpu_vm_pt_next_leaf(struct amdgpu_device *adev,
+				   struct amdgpu_vm_pt_cursor *cursor)
+{
+	amdgpu_vm_pt_next(adev, cursor);
+	while (amdgpu_vm_pt_descendant(adev, cursor));
+}
+
+/**
+ * for_each_amdgpu_vm_pt_leaf - walk over all leaf PDs/PTs in the hierarchy
+ */
+#define for_each_amdgpu_vm_pt_leaf(adev, vm, start, end, cursor)		\
+	for (amdgpu_vm_pt_first_leaf((adev), (vm), (start), &amp;(cursor));		\
+	     (cursor).pfn &lt;= end; amdgpu_vm_pt_next_leaf((adev), &amp;(cursor)))
+
+/**
+ * amdgpu_vm_pt_first_dfs - start a deep first search
+ *
+ * @adev: amdgpu_device structure
+ * @vm: amdgpu_vm structure
+ * @cursor: state to initialize
+ *
+ * Starts a deep first traversal of the PD/PT tree.
+ */
+static void amdgpu_vm_pt_first_dfs(struct amdgpu_device *adev,
+				   struct amdgpu_vm *vm,
+				   struct amdgpu_vm_pt_cursor *cursor)
+{
+	amdgpu_vm_pt_start(adev, vm, 0, cursor);
+	while (amdgpu_vm_pt_descendant(adev, cursor));
+}
+
+/**
+ * amdgpu_vm_pt_next_dfs - get the next node for a deep first search
+ *
+ * @adev: amdgpu_device structure
+ * @cursor: current state
+ *
+ * Move the cursor to the next node in a deep first search.
+ */
+static void amdgpu_vm_pt_next_dfs(struct amdgpu_device *adev,
+				  struct amdgpu_vm_pt_cursor *cursor)
+{
+	if (!cursor-&gt;entry)
+		return;
+
+	if (!cursor-&gt;parent)
+		cursor-&gt;entry = NULL;
+	else if (amdgpu_vm_pt_sibling(adev, cursor))
+		while (amdgpu_vm_pt_descendant(adev, cursor));
+	else
+		amdgpu_vm_pt_ancestor(cursor);
+}
+
+/**
+ * for_each_amdgpu_vm_pt_dfs_safe - safe deep first search of all PDs/PTs
+ */
+#define for_each_amdgpu_vm_pt_dfs_safe(adev, vm, cursor, entry)			\
+	for (amdgpu_vm_pt_first_dfs((adev), (vm), &amp;(cursor)),			\
+	     (entry) = (cursor).entry, amdgpu_vm_pt_next_dfs((adev), &amp;(cursor));\
+	     (entry); (entry) = (cursor).entry,					\
+	     amdgpu_vm_pt_next_dfs((adev), &amp;(cursor)))
+
 /**
  * amdgpu_vm_get_pd_bo - add the VM PD to a validation list
  *
</font></pre>
    </blockquote>
    <font size="+1"><br>
    </font>
  </body>
</html>

--------------F066445D7F70B4810C6DBE18--

--===============0842462807==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0842462807==--
