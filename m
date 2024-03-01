Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 536E8C5475B
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Mar 2024 12:50:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08E1C10E855;
	Fri,  1 Mar 2024 12:50:52 +0000 (UTC)
X-Greylist: delayed 376 seconds by postgrey-1.36 at gabe;
 Fri, 01 Mar 2024 12:50:50 UTC
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A3ED10E1A8
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Mar 2024 12:50:49 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 421CiNdu2595068; Fri, 1 Mar 2024 18:14:23 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 421CiNOx2595067;
 Fri, 1 Mar 2024 18:14:23 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH] drm/amdgpu: add ring timeout information in devcoredump
Date: Fri,  1 Mar 2024 18:13:44 +0530
Message-Id: <20240301124344.2594714-1-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
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

Add ring timeout related information in the amdgpu
devcoredump file for debugging purposes.

During the gpu recovery process the registered call
is triggered and add the debug information in data
file created by devcoredump framework under the
directory /sys/class/devcoredump/devcdx/

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h       | 15 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c   | 11 +++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c | 12 +++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h |  1 +
 4 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 9246bca0a008..9f57c7795c47 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -816,6 +816,17 @@ struct amdgpu_reset_info {
 #endif
 };
 
+/*
+ *  IP and Queue information during timeout
+ */
+struct amdgpu_ring_timeout_info {
+	bool timeout;
+	char ring_name[32];
+	enum amdgpu_ring_type ip_type;
+	bool soft_recovery;
+};
+
+
 /*
  * Non-zero (true) if the GPU has VRAM. Zero (false) otherwise.
  */
@@ -1150,6 +1161,10 @@ struct amdgpu_device {
 	bool                            debug_largebar;
 	bool                            debug_disable_soft_recovery;
 	bool                            debug_use_vram_fw_buf;
+
+#ifdef CONFIG_DEV_COREDUMP
+	struct amdgpu_ring_timeout_info ring_timeout_info;
+#endif
 };
 
 static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 71a5cf37b472..e36b7352b2de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -51,8 +51,19 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	memset(&ti, 0, sizeof(struct amdgpu_task_info));
 	adev->job_hang = true;
 
+#ifdef CONFIG_DEV_COREDUMP
+	/* Update the ring timeout info for coredump*/
+	adev->ring_timeout_info.timeout = TRUE;
+	sprintf(adev->ring_timeout_info.ring_name, s_job->sched->name);
+	adev->ring_timeout_info.ip_type = ring->funcs->type;
+	adev->ring_timeout_info.soft_recovery = FALSE;
+#endif
+
 	if (amdgpu_gpu_recovery &&
 	    amdgpu_ring_soft_recovery(ring, job->vmid, s_job->s_fence->parent)) {
+#ifdef CONFIG_DEV_COREDUMP
+		adev->ring_timeout_info.soft_recovery = TRUE;
+#endif
 		DRM_ERROR("ring %s timeout, but soft recovered\n",
 			  s_job->sched->name);
 		goto exit;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index 4baa300121d8..d4f892ed105f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -196,8 +196,16 @@ amdgpu_devcoredump_read(char *buffer, loff_t offset, size_t count,
 			   coredump->reset_task_info.process_name,
 			   coredump->reset_task_info.pid);
 
+	if (coredump->timeout_info.timeout) {
+		drm_printf(&p, "\nRing timed out details\n");
+		drm_printf(&p, "IP Type: %d Ring Name: %s Soft Recovery: %s\n",
+				coredump->timeout_info.ip_type,
+				coredump->timeout_info.ring_name,
+				coredump->timeout_info.soft_recovery ? "Successful":"Failed");
+	}
+
 	if (coredump->reset_vram_lost)
-		drm_printf(&p, "VRAM is lost due to GPU reset!\n");
+		drm_printf(&p, "\nVRAM is lost due to GPU reset!\n");
 	if (coredump->adev->reset_info.num_regs) {
 		drm_printf(&p, "AMDGPU register dumps:\nOffset:     Value:\n");
 
@@ -228,6 +236,7 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool vram_lost,
 		return;
 	}
 
+	coredump->timeout_info = adev->ring_timeout_info;
 	coredump->reset_vram_lost = vram_lost;
 
 	if (reset_context->job && reset_context->job->vm)
@@ -236,6 +245,7 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool vram_lost,
 	coredump->adev = adev;
 
 	ktime_get_ts64(&coredump->reset_time);
+	memset(&adev->ring_timeout_info, 0, sizeof(adev->ring_timeout_info));
 
 	dev_coredumpm(dev->dev, THIS_MODULE, coredump, 0, GFP_NOWAIT,
 		      amdgpu_devcoredump_read, amdgpu_devcoredump_free);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
index 19899f6b9b2b..37172d6e1f94 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -97,6 +97,7 @@ struct amdgpu_coredump_info {
 	struct amdgpu_task_info         reset_task_info;
 	struct timespec64               reset_time;
 	bool                            reset_vram_lost;
+	struct amdgpu_ring_timeout_info timeout_info;
 };
 #endif
 
-- 
2.34.1

