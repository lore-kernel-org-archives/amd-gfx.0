Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A16DAC0218C
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jan 2025 05:20:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43EFE10E8CE;
	Fri, 24 Jan 2025 05:20:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wk4P+Em7";
	dkim-atps=neutral
Received: from out30-98.freemail.mail.aliyun.com
 (out30-98.freemail.mail.aliyun.com [115.124.30.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D034710E8CE
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jan 2025 05:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1737695963; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=FrGPKFDGyLBIJsRK37A+WsX0IXttI76sH0JFgl0teMM=;
 b=wk4P+Em7veI5ARzqKdAo6k/f2GYlJPqBfK55Z0WJp2IL7GV0c9JA1Fm+4DUvsO6F8v9lS19cQ/BpxWSDimGRT2dTtfDpzJ15mtGjkc/R1H6T/EPJYmKNNqmH2B4UU3cTh99aBnSMe8PeGpBGPgYPVSX8a72Pj/hm5mfy9NHNTzE=
Received: from i32d02263.sqa.eu95.tbsite.net(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WODTwjm_1737695962 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 24 Jan 2025 13:19:23 +0800
From: Jiang Liu <gerry@linux.alibaba.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, simona@ffwll.ch, sunil.khatri@amd.com,
 lijo.lazar@amd.com, Hawking.Zhang@amd.com, mario.limonciello@amd.com,
 xiaogang.chen@amd.com, Kent.Russell@amd.com, shuox.liu@linux.alibaba.com,
 amd-gfx@lists.freedesktop.org
Cc: Jiang Liu <gerry@linux.alibaba.com>
Subject: [v6 5/5] drm/amdgpu: fix invalid memory access in
 amdgpu_fence_driver_sw_fini()
Date: Fri, 24 Jan 2025 13:19:18 +0800
Message-ID: <7276c3a97155647d7a9e00c6e70e3ba21324352a.1737695869.git.gerry@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1737695869.git.gerry@linux.alibaba.com>
References: <cover.1737695869.git.gerry@linux.alibaba.com>
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

Introduce amdgpu_device_fini_schedulers() to clean scheduler related
resources, and avoid possible invalid memory access.

Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 29 +++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  |  9 -------
 2 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index ee695e70fb4f..1619bd2473c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2857,27 +2857,48 @@ static int amdgpu_device_init_schedulers(struct amdgpu_device *adev)
 		if (r) {
 			DRM_ERROR("Failed to create scheduler on ring %s.\n",
 				  ring->name);
-			return r;
+			goto out_err;
 		}
 		r = amdgpu_uvd_entity_init(adev, ring);
 		if (r) {
 			DRM_ERROR("Failed to create UVD scheduling entity on ring %s.\n",
 				  ring->name);
-			return r;
+			goto out_sched_fini;
 		}
 		r = amdgpu_vce_entity_init(adev, ring);
 		if (r) {
 			DRM_ERROR("Failed to create VCE scheduling entity on ring %s.\n",
 				  ring->name);
-			return r;
+			goto out_sched_fini;
 		}
 	}
 
 	amdgpu_xcp_update_partition_sched_list(adev);
 
 	return 0;
+
+out_sched_fini:
+	drm_sched_fini(&adev->rings[i]->sched);
+out_err:
+	while (i--)
+		if (adev->rings[i] && !adev->rings[i]->no_scheduler)
+			drm_sched_fini(&adev->rings[i]->sched);
+	return r;
 }
 
+static void amdgpu_device_fini_schedulers(struct amdgpu_device *adev)
+{
+	int i;
+
+	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
+		struct amdgpu_ring *ring = adev->rings[i];
+
+		if (!ring || ring->no_scheduler)
+			continue;
+
+		drm_sched_fini(&ring->sched);
+	}
+}
 
 /**
  * amdgpu_device_ip_init - run init for hardware IPs
@@ -3424,6 +3445,8 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
 
 	amdgpu_amdkfd_device_fini_sw(adev);
 
+	amdgpu_device_fini_schedulers(adev);
+
 	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
 		if (!adev->ip_blocks[i].status.sw)
 			continue;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 2f24a6aa13bf..c95895a7b888 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -650,15 +650,6 @@ void amdgpu_fence_driver_sw_fini(struct amdgpu_device *adev)
 		if (!ring || !ring->fence_drv.initialized)
 			continue;
 
-		/*
-		 * Notice we check for sched.ops since there's some
-		 * override on the meaning of sched.ready by amdgpu.
-		 * The natural check would be sched.ready, which is
-		 * set as drm_sched_init() finishes...
-		 */
-		if (ring->sched.ops)
-			drm_sched_fini(&ring->sched);
-
 		for (j = 0; j <= ring->fence_drv.num_fences_mask; ++j)
 			dma_fence_put(ring->fence_drv.fences[j]);
 		kfree(ring->fence_drv.fences);
-- 
2.43.5

