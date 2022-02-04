Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97508C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Feb 2022 02:45:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 294D510E7CB;
	Fri,  4 Feb 2022 02:45:18 +0000 (UTC)
Received: from ubuntu2004-NV21-clean.amd.com (unknown [165.204.54.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC10610E7CB
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Feb 2022 02:45:16 +0000 (UTC)
Received: by ubuntu2004-NV21-clean.amd.com (Postfix, from userid 0)
 id DBDCF161D80; Thu,  3 Feb 2022 21:45:13 -0500 (EST)
From: Surbhi Kakarya <surbhi.kakarya@amd.com>
To: amd-gfx@lists.freedesktop.org, Bokun.Zhang@amd.com, HaiJun.Chang@amd.com,
 Monk.Liu@amd.com, Alexander.Deucher@amd.com, Kelly.Zytaruk@amd.com,
 Andrey.Grodzovsky@amd.com
Subject: [Patch V2] drm/amdgpu: Handle the GPU recovery failure in SRIOV
 environment.
Date: Thu,  3 Feb 2022 21:45:11 -0500
Message-Id: <20220204024512.5986-1-surbhi.kakarya@amd.com>
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

This patch handles the GPU recovery failure in sriov environment by
retrying the reset if the first reset fails. To determine the condition
of retry, a new macro AMDGPU_RETRY_SRIOV_RESET is added which returns
true if failure is due to ETIMEDOUT, EINVAL or EBUSY, otherwise return
false.A new macro AMDGPU_MAX_RETRY_LIMIT is used to limit the retry to 2.

It also handles the return status in Post Asic Reset by updating the return
code with asic_reset_res and eventually return the return code in
amdgpu_job_timedout().

Signed-off-by: Surbhi Kakarya <surbhi.kakarya@amd.com>
---
Changes in V2:
 * Added the macro AMDGPU_RETRY_SRIOV_RESET to determine the retry condition.
 * Moved the reset retry in amdgpu_device_reset_sriov() to avoid duplicacy.
 * Added the AMDGPU_ prefix in new defines.
 * Verfied the coding style with checkpatch.pl
 * Added the retry limit as 2

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 15 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    |  6 +++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 53af2623c58f..59310ca398f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -89,6 +89,8 @@ MODULE_FIRMWARE("amdgpu/vangogh_gpu_info.bin");
 MODULE_FIRMWARE("amdgpu/yellow_carp_gpu_info.bin");
 
 #define AMDGPU_RESUME_MS		2000
+#define AMDGPU_MAX_RETRY_LIMIT		2
+#define AMDGPU_RETRY_SRIOV_RESET(r) ((r) == -EBUSY || (r) == -ETIMEDOUT || (r) == -EINVAL)
 
 const char *amdgpu_asic_name[] = {
 	"TAHITI",
@@ -4456,7 +4458,9 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 {
 	int r;
 	struct amdgpu_hive_info *hive = NULL;
+	int retry_limit = 0;
 
+retry:
 	amdgpu_amdkfd_pre_reset(adev);
 
 	if (from_hypervisor)
@@ -4503,6 +4507,14 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 	}
 	amdgpu_virt_release_full_gpu(adev, true);
 
+	if (AMDGPU_RETRY_SRIOV_RESET(r)) {
+		if (retry_limit < AMDGPU_MAX_RETRY_LIMIT) {
+			retry_limit++;
+			goto retry;
+		} else
+			DRM_ERROR("GPU reset retry is beyond the retry limit\n");
+	}
+
 	return r;
 }
 
@@ -5341,6 +5353,9 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 			drm_helper_resume_force_mode(adev_to_drm(tmp_adev));
 		}
 
+		if (tmp_adev->asic_reset_res)
+			r = tmp_adev->asic_reset_res;
+
 		tmp_adev->asic_reset_res = 0;
 
 		if (r) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index e0730ea56a8c..4b9d62f375ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -37,6 +37,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	struct amdgpu_task_info ti;
 	struct amdgpu_device *adev = ring->adev;
 	int idx;
+	int r;
 
 	if (!drm_dev_enter(adev_to_drm(adev), &idx)) {
 		DRM_INFO("%s - device unplugged skipping recovery on scheduler:%s",
@@ -63,7 +64,10 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		  ti.process_name, ti.tgid, ti.task_name, ti.pid);
 
 	if (amdgpu_device_should_recover_gpu(ring->adev)) {
-		amdgpu_device_gpu_recover(ring->adev, job);
+		r = amdgpu_device_gpu_recover(ring->adev, job);
+		if (r)
+			DRM_ERROR("GPU Recovery Failed: %d\n", r);
+
 	} else {
 		drm_sched_suspend_timeout(&ring->sched);
 		if (amdgpu_sriov_vf(adev))
-- 
2.25.1

