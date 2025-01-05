Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B06A6E7719C
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Jan 2025 16:40:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECC0310E204;
	Sun,  5 Jan 2025 16:40:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qHHqnOqy";
	dkim-atps=neutral
Received: from out30-124.freemail.mail.aliyun.com
 (out30-124.freemail.mail.aliyun.com [115.124.30.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFAAA10E4D2
 for <amd-gfx@lists.freedesktop.org>; Sun,  5 Jan 2025 02:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1736045140; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=LR5V4dcAyJikMW6QrNiOn8FmY+8P2kwIcb0ZSg+goiY=;
 b=qHHqnOqyLt75ixjHbXYt+MpvRfCSC+W5NtAi6rt9bg3bk5uNWtI9hyy6XptHQdB4W5MTwpNOXJpwg0n/3TwTdWFRAqGJHp40m4u62FoUSnJ61yO2Eo8j9Q6MyHapjIKP2Q9Z6h7DD07fLpyhuSyPgfl6y4faXEeCGRtbUg3eH/Y=
Received: from i32d02263.sqa.eu95.tbsite.net(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WMx9YBT_1736045139 cluster:ay36) by smtp.aliyun-inc.com;
 Sun, 05 Jan 2025 10:45:40 +0800
From: Jiang Liu <gerry@linux.alibaba.com>
To: amd-gfx@lists.freedesktop.org, xiaogang.chen@amd.com, lijo.lazar@amd.com,
 Kent.Russell@amd.com, shuox.liu@linux.alibaba.com
Cc: Jiang Liu <gerry@linux.alibaba.com>
Subject: [PATCH v2 5/6] amdgpu: fix invalid memory access in
 amdgpu_fence_driver_sw_fini()
Date: Sun,  5 Jan 2025 10:45:33 +0800
Message-ID: <f19a505b4ca42302ea8b8c399c07eb8f9f06a0c6.1736044362.git.gerry@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1736044362.git.gerry@linux.alibaba.com>
References: <cover.1736044362.git.gerry@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 05 Jan 2025 16:40:26 +0000
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

Function detects initialization status by checking sched->ops, so set
sched->ops to non-NULL just before return in function drm_sched_init()
to avoid possible invalid memory access on error recover path.

Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5ff53a3b9851..475ab635c699 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2857,6 +2857,7 @@ static int amdgpu_device_init_schedulers(struct amdgpu_device *adev)
 		if (r) {
 			DRM_ERROR("Failed to create scheduler on ring %s.\n",
 				  ring->name);
+			ring->sched.ops = NULL;
 			return r;
 		}
 		r = amdgpu_uvd_entity_init(adev, ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 2f24a6aa13bf..b5e87b515139 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -656,8 +656,10 @@ void amdgpu_fence_driver_sw_fini(struct amdgpu_device *adev)
 		 * The natural check would be sched.ready, which is
 		 * set as drm_sched_init() finishes...
 		 */
-		if (ring->sched.ops)
+		if (ring->sched.ops) {
 			drm_sched_fini(&ring->sched);
+			ring->sched.ops = NULL;
+		}
 
 		for (j = 0; j <= ring->fence_drv.num_fences_mask; ++j)
 			dma_fence_put(ring->fence_drv.fences[j]);
-- 
2.43.5

