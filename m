Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D798CCF9E5
	for <amd-gfx@archiver.kernel.org>; Sun, 26 Oct 2025 04:30:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E83210E2A2;
	Sun, 26 Oct 2025 04:30:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NaBGoX+e";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4375510E049
 for <amd-gfx@lists.freedesktop.org>; Sun, 26 Oct 2025 04:30:04 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id B282860194
 for <amd-gfx@lists.freedesktop.org>; Sun, 26 Oct 2025 04:30:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B92C4CEE7;
 Sun, 26 Oct 2025 04:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1761453003;
 bh=t0w89Y4VNsi+1xPGy9O9CJ3CDplDQazAKNOcEshNVqM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NaBGoX+eR3aLqodt5Jl4xOjwkTz/cCmFbxtUnzAf5wUEWtFYv6hZv2F2m5WvhVTQl
 8RHL8Sk3SNrbm8WS1I4TUzA9mJi/BTdjexjNeuzIgJfRK61HTXtwTL/sdz6qqKxOT7
 vULeKdlFH5qRmJtMUbzQrpLt7aWHlAn40riKNpziJr6V9ChC0q16XLcLPn7Wl9ajID
 MqannOb8vAFgKQWZSMhUrWLhgvW4vxsPYpgnv/rcF90wVDnYRX41Qb5kDAEjS6WQ+u
 ocFSl9cX5mwwXzdsuuYikYrB9zRdVTBAVgZ/xIZFMu6kxrNM3Qk1Q0LTkQ2K9a+/vJ
 vmvl0hbopo/XQ==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH v5 4/5] drm/amd: Unwind for failed device suspend
Date: Sat, 25 Oct 2025 23:29:39 -0500
Message-ID: <20251026042942.549389-5-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251026042942.549389-1-superm1@kernel.org>
References: <20251026042942.549389-1-superm1@kernel.org>
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

If device suspend has failed, add a recovery flow that will attempt
to unwind the suspend and get things back up and running.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4627
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
v5:
 * Add missing drm client notification (should fix console resume)
 * Add missing RAS notification
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 65 +++++++++++++++++++---
 1 file changed, 58 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5945f441d01e..d8a2dcf6100a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5274,7 +5274,7 @@ void amdgpu_device_complete(struct drm_device *dev)
 int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 {
 	struct amdgpu_device *adev = drm_to_adev(dev);
-	int r = 0;
+	int r, rec;
 
 	if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
 		return 0;
@@ -5290,8 +5290,9 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 			return r;
 	}
 
-	if (amdgpu_acpi_smart_shift_update(adev, AMDGPU_SS_DEV_D3))
-		dev_warn(adev->dev, "smart shift update failed\n");
+	r = amdgpu_acpi_smart_shift_update(adev, AMDGPU_SS_DEV_D3);
+	if (r)
+		goto unwind_sriov;
 
 	if (notify_clients)
 		drm_client_dev_suspend(adev_to_drm(adev), false);
@@ -5302,16 +5303,16 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 
 	r = amdgpu_device_ip_suspend_phase1(adev);
 	if (r)
-		return r;
+		goto unwind_smartshift;
 
 	amdgpu_amdkfd_suspend(adev, !amdgpu_sriov_vf(adev) && !adev->in_runpm);
 	r = amdgpu_userq_suspend(adev);
 	if (r)
-		return r;
+		goto unwind_ip_phase1;
 
 	r = amdgpu_device_evict_resources(adev);
 	if (r)
-		return r;
+		goto unwind_userq;
 
 	amdgpu_ttm_set_buffer_funcs_status(adev, false);
 
@@ -5319,12 +5320,62 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 
 	r = amdgpu_device_ip_suspend_phase2(adev);
 	if (r)
-		return r;
+		goto unwind_evict;
 
 	if (amdgpu_sriov_vf(adev))
 		amdgpu_virt_release_full_gpu(adev, false);
 
 	return 0;
+
+unwind_evict:
+	if (adev->mman.buffer_funcs_ring->sched.ready)
+		amdgpu_ttm_set_buffer_funcs_status(adev, true);
+	amdgpu_fence_driver_hw_init(adev);
+
+unwind_userq:
+	rec = amdgpu_userq_resume(adev);
+	if (rec) {
+		dev_warn(adev->dev, "failed to re-initialize user queues: %d\n", rec);
+		return r;
+	}
+	rec = amdgpu_amdkfd_resume(adev, !amdgpu_sriov_vf(adev) && !adev->in_runpm);
+	if (rec) {
+		dev_warn(adev->dev, "failed to re-initialize kfd: %d\n", rec);
+		return r;
+	}
+
+unwind_ip_phase1:
+	/* suspend phase 1 = resume phase 3 */
+	rec = amdgpu_device_ip_resume_phase3(adev);
+	if (rec) {
+		dev_warn(adev->dev, "failed to re-initialize IPs phase1: %d\n", rec);
+		return r;
+	}
+
+unwind_smartshift:
+	rec = amdgpu_acpi_smart_shift_update(adev, AMDGPU_SS_DEV_D0);
+	if (rec) {
+		dev_warn(adev->dev, "failed to re-update smart shift: %d\n", rec);
+		return r;
+	}
+
+	if (notify_clients)
+		drm_client_dev_resume(adev_to_drm(adev), false);
+
+	amdgpu_ras_resume(adev);
+
+unwind_sriov:
+	if (amdgpu_sriov_vf(adev)) {
+		rec = amdgpu_virt_request_full_gpu(adev, true);
+		if (rec) {
+			dev_warn(adev->dev, "failed to reinitialize sriov: %d\n", rec);
+			return r;
+		}
+	}
+
+	adev->in_suspend = adev->in_s0ix = adev->in_s3 = false;
+
+	return r;
 }
 
 static inline int amdgpu_virt_resume(struct amdgpu_device *adev)
-- 
2.51.1

