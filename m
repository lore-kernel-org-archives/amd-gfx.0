Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F828E7719A
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2025 02:08:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B58E10EF74;
	Fri, 10 Jan 2025 02:08:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xHqLDr+p";
	dkim-atps=neutral
Received: from out30-119.freemail.mail.aliyun.com
 (out30-119.freemail.mail.aliyun.com [115.124.30.119])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8431B10E4BB
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2025 02:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1736474933; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=qQRr9WLw4pGx4FAg2snuWQFxgz+e5RD7z8bqxmMnxQY=;
 b=xHqLDr+p1uk7ypZH6336agTES8wJDbtKlw6ykM8TqahtTshYpc6dZ4sy4L9AW6mCWDMqmLctB5eIiyXbjb0ocVjU9FbS50YdBLLPqDsjb1Om52oWzItNTDPd+mcRZ4HfFHy8yp9k1rqoi7K82YRdYbztIYzy1kL5cy6KcirEBd8=
Received: from i32d02263.sqa.eu95.tbsite.net(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WNJ5WB-_1736474932 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 10 Jan 2025 10:08:52 +0800
From: Jiang Liu <gerry@linux.alibaba.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, simona@ffwll.ch, sunil.khatri@amd.com,
 lijo.lazar@amd.com, Hawking.Zhang@amd.com, mario.limonciello@amd.com,
 xiaogang.chen@amd.com, Kent.Russell@amd.com, shuox.liu@linux.alibaba.com,
 amd-gfx@lists.freedesktop.org
Cc: Jiang Liu <gerry@linux.alibaba.com>
Subject: [v4 5/5] drm/amdgpu: fix invalid memory access in
 amdgpu_fence_driver_sw_fini()
Date: Fri, 10 Jan 2025 10:08:47 +0800
Message-ID: <b824d12a9636ac43066d731c514de8abbf1d115e.1736474822.git.gerry@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1736474822.git.gerry@linux.alibaba.com>
References: <cover.1736474822.git.gerry@linux.alibaba.com>
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

Function detects initialization status by checking sched->ops, so set
sched->ops to non-NULL just before return in function
amdgpu_fence_driver_sw_fini() and amdgpu_device_init_schedulers()
to avoid possible invalid memory access on error recover path.

Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f29a4ad3c6d0..3688e9eb949b 100644
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

