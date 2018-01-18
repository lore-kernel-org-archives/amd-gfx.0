From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Subject: [PATCH 2/4] oom: take per file badness into account
Date: Thu, 18 Jan 2018 11:47:50 -0500
Message-ID: <1516294072-17841-3-git-send-email-andrey.grodzovsky@amd.com>
References: <1516294072-17841-1-git-send-email-andrey.grodzovsky@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1516294072-17841-1-git-send-email-andrey.grodzovsky@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc: Christian.Koenig@amd.com, Andrey Grodzovsky <andrey.grodzovsky@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

Try to make better decisions which process to kill based on
per file OOM badness

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 mm/oom_kill.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 29f8555..825ed52 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -49,6 +49,8 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/oom.h>
 
+#include <linux/fdtable.h>
+
 int sysctl_panic_on_oom;
 int sysctl_oom_kill_allocating_task;
 int sysctl_oom_dump_tasks = 1;
@@ -182,6 +184,21 @@ static bool is_dump_unreclaim_slabs(void)
 }
 
 /**
+ * oom_file_badness - add per file badness
+ * @points: pointer to summed up badness points
+ * @file: tasks open file
+ * @n: file descriptor id (unused)
+ */
+static int oom_file_badness(const void *points, struct file *file, unsigned n)
+{
+	if (file->f_op->oom_file_badness)
+		*((long *)points) += file->f_op->oom_file_badness(file);
+
+	return 0;
+}
+
+
+/**
  * oom_badness - heuristic function to determine which candidate task to kill
  * @p: task struct of which task we should calculate
  * @totalpages: total present RAM allowed for page allocation
@@ -222,6 +239,12 @@ unsigned long oom_badness(struct task_struct *p, struct mem_cgroup *memcg,
 	 */
 	points = get_mm_rss(p->mm) + get_mm_counter(p->mm, MM_SWAPENTS) +
 		mm_pgtables_bytes(p->mm) / PAGE_SIZE;
+
+	/*
+	 * Add how much memory a task uses in opened files, e.g. device drivers.
+	 */
+	iterate_fd(p->files, 0, oom_file_badness, &points);
+
 	task_unlock(p);
 
 	/*
-- 
2.7.4
