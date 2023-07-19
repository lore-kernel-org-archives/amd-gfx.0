Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2800C001B0
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jul 2023 12:12:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04B0910E47E;
	Wed, 19 Jul 2023 12:12:40 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A84110E408;
 Wed, 19 Jul 2023 07:40:08 +0000 (UTC)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.57])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4R5SPg5zCWz18Ljp;
 Wed, 19 Jul 2023 15:39:19 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 19 Jul 2023 15:40:02 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 1/4] mm: factor out VMA stack and heap checks
Date: Wed, 19 Jul 2023 15:51:11 +0800
Message-ID: <20230719075127.47736-2-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230719075127.47736-1-wangkefeng.wang@huawei.com>
References: <20230719075127.47736-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="yes"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Wed, 19 Jul 2023 12:12:37 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>,
 David Hildenbrand <david@redhat.com>, selinux@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-perf-users@vger.kernel.org, linux-mm@kvack.org,
 amd-gfx@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Factor out VMA stack and heap checks and name them
vma_is_initial_stack() and vma_is_initial_heap() for
general use.

Cc: Christian Göttsche <cgzones@googlemail.com>
Cc: David Hildenbrand <david@redhat.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 fs/proc/task_mmu.c   | 24 ++++--------------------
 fs/proc/task_nommu.c | 15 +--------------
 include/linux/mm.h   | 21 +++++++++++++++++++++
 3 files changed, 26 insertions(+), 34 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 507cd4e59d07..bf25178ae66a 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -236,21 +236,6 @@ static int do_maps_open(struct inode *inode, struct file *file,
 				sizeof(struct proc_maps_private));
 }
 
-/*
- * Indicate if the VMA is a stack for the given task; for
- * /proc/PID/maps that is the stack of the main task.
- */
-static int is_stack(struct vm_area_struct *vma)
-{
-	/*
-	 * We make no effort to guess what a given thread considers to be
-	 * its "stack".  It's not even well-defined for programs written
-	 * languages like Go.
-	 */
-	return vma->vm_start <= vma->vm_mm->start_stack &&
-		vma->vm_end >= vma->vm_mm->start_stack;
-}
-
 static void show_vma_header_prefix(struct seq_file *m,
 				   unsigned long start, unsigned long end,
 				   vm_flags_t flags, unsigned long long pgoff,
@@ -327,13 +312,12 @@ show_map_vma(struct seq_file *m, struct vm_area_struct *vma)
 			goto done;
 		}
 
-		if (vma->vm_start <= mm->brk &&
-		    vma->vm_end >= mm->start_brk) {
+		if (vma_is_initial_heap(vma)) {
 			name = "[heap]";
 			goto done;
 		}
 
-		if (is_stack(vma)) {
+		if (vma_is_initial_stack(vma)) {
 			name = "[stack]";
 			goto done;
 		}
@@ -1971,9 +1955,9 @@ static int show_numa_map(struct seq_file *m, void *v)
 	if (file) {
 		seq_puts(m, " file=");
 		seq_file_path(m, file, "\n\t= ");
-	} else if (vma->vm_start <= mm->brk && vma->vm_end >= mm->start_brk) {
+	} else if (vma_is_initial_heap(vma)) {
 		seq_puts(m, " heap");
-	} else if (is_stack(vma)) {
+	} else if (vma_is_initial_stack(vma)) {
 		seq_puts(m, " stack");
 	}
 
diff --git a/fs/proc/task_nommu.c b/fs/proc/task_nommu.c
index 2c8b62265981..a8ac0dd8041e 100644
--- a/fs/proc/task_nommu.c
+++ b/fs/proc/task_nommu.c
@@ -121,19 +121,6 @@ unsigned long task_statm(struct mm_struct *mm,
 	return size;
 }
 
-static int is_stack(struct vm_area_struct *vma)
-{
-	struct mm_struct *mm = vma->vm_mm;
-
-	/*
-	 * We make no effort to guess what a given thread considers to be
-	 * its "stack".  It's not even well-defined for programs written
-	 * languages like Go.
-	 */
-	return vma->vm_start <= mm->start_stack &&
-		vma->vm_end >= mm->start_stack;
-}
-
 /*
  * display a single VMA to a sequenced file
  */
@@ -171,7 +158,7 @@ static int nommu_vma_show(struct seq_file *m, struct vm_area_struct *vma)
 	if (file) {
 		seq_pad(m, ' ');
 		seq_file_path(m, file, "");
-	} else if (mm && is_stack(vma)) {
+	} else if (mm && vma_is_initial_stack(vma)) {
 		seq_pad(m, ' ');
 		seq_puts(m, "[stack]");
 	}
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 2dd73e4f3d8e..51f8c573db74 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -822,6 +822,27 @@ static inline bool vma_is_anonymous(struct vm_area_struct *vma)
 	return !vma->vm_ops;
 }
 
+static inline bool vma_is_initial_heap(const struct vm_area_struct *vma)
+{
+       return vma->vm_start <= vma->vm_mm->brk &&
+		vma->vm_end >= vma->vm_mm->start_brk;
+}
+
+/*
+ * Indicate if the VMA is a stack for the given task; for
+ * /proc/PID/maps that is the stack of the main task.
+ */
+static inline bool vma_is_initial_stack(const struct vm_area_struct *vma)
+{
+	/*
+	 * We make no effort to guess what a given thread considers to be
+	 * its "stack".  It's not even well-defined for programs written
+	 * languages like Go.
+	 */
+       return vma->vm_start <= vma->vm_mm->start_stack &&
+	       vma->vm_end >= vma->vm_mm->start_stack;
+}
+
 static inline bool vma_is_temporary_stack(struct vm_area_struct *vma)
 {
 	int maybe_stack = vma->vm_flags & (VM_GROWSDOWN | VM_GROWSUP);
-- 
2.27.0

