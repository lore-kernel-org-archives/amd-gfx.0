Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 452FBC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Jan 2022 15:27:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C193710E44F;
	Mon, 31 Jan 2022 15:27:57 +0000 (UTC)
X-Greylist: delayed 381 seconds by postgrey-1.36 at gabe;
 Mon, 31 Jan 2022 15:27:56 UTC
Received: from ubuntu2004-NV21-clean.amd.com (unknown [165.204.54.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E26A10E44F
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Jan 2022 15:27:56 +0000 (UTC)
Received: by ubuntu2004-NV21-clean.amd.com (Postfix, from userid 0)
 id 6F403161E07; Mon, 31 Jan 2022 10:21:34 -0500 (EST)
From: Surbhi Kakarya <surbhi.kakarya@amd.com>
To: amd-gfx@lists.freedesktop.org, Bokun.Zhang@amd.com, HaiJun.Chang@amd.com,
 Monk.Liu@amd.com, Alexander.Deucher@amd.com, Kelly.Zytaruk@amd.com
Subject: [PATCH] drm/amdgpu: This patch handles the GPU recovery faliure in
 sriov environment by retrying the reset if the first reset fails. To
 determine the condition of retry,
 a new function amdgpu_is_retry_sriov_reset() is added which returns true if
 failure is due to ETIMEDOUT, EINVAL or EBUSY, otherwise return false.
Date: Mon, 31 Jan 2022 10:21:31 -0500
Message-Id: <20220131152131.9099-1-surbhi.kakarya@amd.com>
X-Mailer: git-send-email 2.25.1
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
Cc: Surbhi Kakarya <surbhi.kakarya@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It also handles the return status in Post Asic Reset by updating the return code
with asic_reset_res and eventually return the return code in amdgpu_job_timedout().

Change-Id: I45b9743adb548606aef8774496527d29fb3de0af
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 34 ++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    |  6 +++-
 2 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 53af2623c58f..8a742b77eef8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5026,6 +5026,21 @@ static int amdgpu_device_suspend_display_audio(struct amdgpu_device *adev)
 	return 0;
 }
 
+/**
+ * amdgpu_is_retry_sriov_reset - check if we should retry sriov reset
+ *
+ * Check amdgpu_is_retry_sriov_reset and return status to see if we should retry reset.
+ */
+static bool amdgpu_is_retry_sriov_reset(int r)
+{
+
+        if(r == -EBUSY || r == -ETIMEDOUT || r == -EINVAL)
+                return true;
+        else
+                return false;
+
+}
+
 static void amdgpu_device_recheck_guilty_jobs(
 	struct amdgpu_device *adev, struct list_head *device_list_handle,
 	struct amdgpu_reset_context *reset_context)
@@ -5064,8 +5079,13 @@ static void amdgpu_device_recheck_guilty_jobs(
 			if (amdgpu_sriov_vf(adev)) {
 				amdgpu_virt_fini_data_exchange(adev);
 				r = amdgpu_device_reset_sriov(adev, false);
-				if (r)
+				if (r) {
 					adev->asic_reset_res = r;
+					if (amdgpu_is_retry_sriov_reset(r)) {
+						adev->asic_reset_res = 0;
+						goto retry;
+					}
+				}
 			} else {
 				clear_bit(AMDGPU_SKIP_HW_RESET,
 					  &reset_context->flags);
@@ -5299,8 +5319,13 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	/* Host driver will handle XGMI hive reset for SRIOV */
 	if (amdgpu_sriov_vf(adev)) {
 		r = amdgpu_device_reset_sriov(adev, job ? false : true);
-		if (r)
-			adev->asic_reset_res = r;
+                if (r) {
+                        adev->asic_reset_res = r;
+                        if (amdgpu_is_retry_sriov_reset(r)) {
+				adev->asic_reset_res = 0;
+				goto retry;
+                        }
+                }
 	} else {
 		r = amdgpu_do_asic_reset(device_list_handle, &reset_context);
 		if (r && r == -EAGAIN)
@@ -5341,6 +5366,9 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 			drm_helper_resume_force_mode(adev_to_drm(tmp_adev));
 		}
 
+		if (tmp_adev->asic_reset_res)
+			r = tmp_adev->asic_reset_res;
+
 		tmp_adev->asic_reset_res = 0;
 
 		if (r) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index e0730ea56a8c..1f0fb21ac15a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -37,6 +37,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	struct amdgpu_task_info ti;
 	struct amdgpu_device *adev = ring->adev;
 	int idx;
+	int r = 0;
 
 	if (!drm_dev_enter(adev_to_drm(adev), &idx)) {
 		DRM_INFO("%s - device unplugged skipping recovery on scheduler:%s",
@@ -63,7 +64,10 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		  ti.process_name, ti.tgid, ti.task_name, ti.pid);
 
 	if (amdgpu_device_should_recover_gpu(ring->adev)) {
-		amdgpu_device_gpu_recover(ring->adev, job);
+		r = amdgpu_device_gpu_recover(ring->adev, job);
+		if (r)
+			DRM_ERROR("GPU Recovery Failed: %d\n",r);
+
 	} else {
 		drm_sched_suspend_timeout(&ring->sched);
 		if (amdgpu_sriov_vf(adev))
-- 
2.25.1

