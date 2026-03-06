Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDDEDF01829
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 11:33:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49CB110ECFA;
	Fri,  6 Mar 2026 11:33:53 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9794C10ECFA
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 11:33:51 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 626BXk442412684; Fri, 6 Mar 2026 17:03:46 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 626BXkJd2412683;
 Fri, 6 Mar 2026 17:03:46 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v4 3/3] drm/amdgpu: push userq debugfs function in
 amdgpu_debugfs files
Date: Fri,  6 Mar 2026 17:03:44 +0530
Message-Id: <20260306113344.2412644-3-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260306113344.2412644-1-sunil.khatri@amd.com>
References: <20260306113344.2412644-1-sunil.khatri@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Debugfs files for amdgpu are better to be handled in the dedicated
amdgpu_debugfs.c/.h files.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 53 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |  4 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c   | 47 +-----------------
 3 files changed, 58 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index f51c3443159d..63b702ec972b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -39,6 +39,7 @@
 
 #include "amdgpu_reset.h"
 #include "amdgpu_psp_ta.h"
+#include "amdgpu_userq.h"
 
 #if defined(CONFIG_DEBUG_FS)
 
@@ -2156,6 +2157,53 @@ static const struct file_operations amdgpu_pt_info_fops = {
 	.release = single_release,
 };
 
+static int amdgpu_mqd_info_read(struct seq_file *m, void *unused)
+{
+	struct amdgpu_usermode_queue *queue = m->private;
+	struct amdgpu_bo *bo;
+	int r;
+
+	if (!queue || !queue->mqd.obj)
+		return -EINVAL;
+
+	bo = amdgpu_bo_ref(queue->mqd.obj);
+	r = amdgpu_bo_reserve(bo, true);
+	if (r) {
+		amdgpu_bo_unref(&bo);
+		return -EINVAL;
+	}
+
+	seq_printf(m, "queue_type: %d\n", queue->queue_type);
+	seq_printf(m, "mqd_gpu_address: 0x%llx\n", amdgpu_bo_gpu_offset(queue->mqd.obj));
+
+	amdgpu_bo_unreserve(bo);
+	amdgpu_bo_unref(&bo);
+
+	return 0;
+}
+
+static int amdgpu_mqd_info_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, amdgpu_mqd_info_read, inode->i_private);
+}
+
+static const struct file_operations amdgpu_mqd_info_fops = {
+	.owner = THIS_MODULE,
+	.open = amdgpu_mqd_info_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+void amdgpu_debugfs_userq_init(struct drm_file *file, struct amdgpu_usermode_queue *queue, int qid)
+{
+	char queue_name[32];
+
+	scnprintf(queue_name, sizeof(queue_name), "queue_%d", qid);
+	queue->debugfs_queue = debugfs_create_dir(queue_name, file->debugfs_client);
+	debugfs_create_file("mqd_info", 0444, queue->debugfs_queue, queue, &amdgpu_mqd_info_fops);
+}
+
 void amdgpu_debugfs_vm_init(struct drm_file *file)
 {
 	debugfs_create_file("vm_pagetable_info", 0444, file->debugfs_client, file,
@@ -2174,4 +2222,9 @@ int amdgpu_debugfs_regs_init(struct amdgpu_device *adev)
 void amdgpu_debugfs_vm_init(struct drm_file *file)
 {
 }
+void amdgpu_debugfs_userq_init(struct drm_file *file,
+			       struct amdgpu_usermode_queue *queue,
+			       int qid)
+{
+}
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
index e7b3c38e5186..e88b4a1e564c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
@@ -25,6 +25,7 @@
 /*
  * Debugfs
  */
+struct amdgpu_usermode_queue;
 
 int amdgpu_debugfs_regs_init(struct amdgpu_device *adev);
 int amdgpu_debugfs_init(struct amdgpu_device *adev);
@@ -34,4 +35,7 @@ void amdgpu_debugfs_firmware_init(struct amdgpu_device *adev);
 void amdgpu_debugfs_gem_init(struct amdgpu_device *adev);
 void amdgpu_debugfs_mes_event_log_init(struct amdgpu_device *adev);
 void amdgpu_debugfs_vm_init(struct drm_file *file);
+void amdgpu_debugfs_userq_init(struct drm_file *file,
+			       struct amdgpu_usermode_queue *queue,
+			       int qid);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 1543ca324f43..472936f90c19 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -709,46 +709,6 @@ static int amdgpu_userq_priority_permit(struct drm_file *filp,
 	return -EACCES;
 }
 
-#if defined(CONFIG_DEBUG_FS)
-static int amdgpu_mqd_info_read(struct seq_file *m, void *unused)
-{
-	struct amdgpu_usermode_queue *queue = m->private;
-	struct amdgpu_bo *bo;
-	int r;
-
-	if (!queue || !queue->mqd.obj)
-		return -EINVAL;
-
-	bo = amdgpu_bo_ref(queue->mqd.obj);
-	r = amdgpu_bo_reserve(bo, true);
-	if (r) {
-		amdgpu_bo_unref(&bo);
-		return -EINVAL;
-	}
-
-	seq_printf(m, "queue_type: %d\n", queue->queue_type);
-	seq_printf(m, "mqd_gpu_address: 0x%llx\n", amdgpu_bo_gpu_offset(queue->mqd.obj));
-
-	amdgpu_bo_unreserve(bo);
-	amdgpu_bo_unref(&bo);
-
-	return 0;
-}
-
-static int amdgpu_mqd_info_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, amdgpu_mqd_info_read, inode->i_private);
-}
-
-static const struct file_operations amdgpu_mqd_info_fops = {
-	.owner = THIS_MODULE,
-	.open = amdgpu_mqd_info_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-#endif
-
 static int
 amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 {
@@ -886,12 +846,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	up_read(&adev->reset_domain->sem);
 
 #if defined(CONFIG_DEBUG_FS)
-	char queue_name[32];
-
-	scnprintf(queue_name, sizeof(queue_name), "queue_%d", qid);
-	/* Queue dentry per client to hold MQD information   */
-	queue->debugfs_queue = debugfs_create_dir(queue_name, filp->debugfs_client);
-	debugfs_create_file("mqd_info", 0444, queue->debugfs_queue, queue, &amdgpu_mqd_info_fops);
+	amdgpu_debugfs_userq_init(filp, queue, qid);
 #endif
 	amdgpu_userq_init_hang_detect_work(queue);
 
-- 
2.34.1

