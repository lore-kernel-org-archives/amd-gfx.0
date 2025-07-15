Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF03C83F17
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jul 2025 21:24:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34B2710E054;
	Tue, 15 Jul 2025 21:24:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Omee0rbN";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C425510E054
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jul 2025 21:24:28 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id C09CA60051;
 Tue, 15 Jul 2025 21:24:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D22BEC4CEE3;
 Tue, 15 Jul 2025 21:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1752614667;
 bh=nehgjhGHveNZYNMqQh5+XJMZOAc+evQvat03ABQVnMw=;
 h=From:To:Cc:Subject:Date:From;
 b=Omee0rbNzuX/VcF2SY3FzZkOgJImHSHjxBjsUmbwDQP6dltpgXwq1MqI8EsQFUS1B
 HCCZi1B2rCWOwhSSu8rRioxDuA9x38wgeCoLptkLlPLz3/hVP9y3McBqlNMRimOiMl
 b6uCQQHwc7JIOugWLpEkYrFL4Pnkvh/gRa1dga0BHtWvpFmj1qC5Kua6RNY/ynDfO3
 c81kC62mCKfVX+J2+Z6evfVYhjCviZm+9Iz6Pr8yTjMBCrANhE4aPW8BrXJcF9fBMI
 6gEBs+xQciPaHaTr1NsMc6CsuydOLQohdQhVcnoZoEa3IJJsqlT+fRCpXbhnfDC/h9
 9p5NEVlFy6H3A==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2] drm/amd: Use drm_*() macros instead of DRM_*() for
 amdgpu_cs
Date: Tue, 15 Jul 2025 16:24:20 -0500
Message-ID: <20250715212420.2254925-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
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

From: Mario Limonciello <mario.limonciello@amd.com>

Some of the IOCTL messages can be called for different GPUs and it might
not be obvious which one called them from a problem.  Using the drm_*()
macros the correct device will be shown in the messages.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2:
 * use adev_to_drm (Lijo)
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 9ea0d9b71f48..e1e48e6f1f35 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -395,7 +395,7 @@ static int amdgpu_cs_p2_ib(struct amdgpu_cs_parser *p,
 			   chunk_ib->ib_bytes : 0,
 			   AMDGPU_IB_POOL_DELAYED, ib);
 	if (r) {
-		DRM_ERROR("Failed to get ib !\n");
+		drm_err(adev_to_drm(p->adev), "Failed to get ib !\n");
 		return r;
 	}
 
@@ -467,7 +467,7 @@ static int amdgpu_syncobj_lookup_and_add(struct amdgpu_cs_parser *p,
 
 	r = drm_syncobj_find_fence(p->filp, handle, point, flags, &fence);
 	if (r) {
-		DRM_ERROR("syncobj %u failed to find fence @ %llu (%d)!\n",
+		drm_err(adev_to_drm(p->adev), "syncobj %u failed to find fence @ %llu (%d)!\n",
 			  handle, point, r);
 		return r;
 	}
@@ -901,7 +901,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 					 sizeof(struct page *),
 					 GFP_KERNEL);
 		if (!e->user_pages) {
-			DRM_ERROR("kvmalloc_array failure\n");
+			drm_err(adev_to_drm(p->adev), "kvmalloc_array failure\n");
 			r = -ENOMEM;
 			goto out_free_user_pages;
 		}
@@ -982,7 +982,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 	r = amdgpu_vm_validate(p->adev, &fpriv->vm, NULL,
 			       amdgpu_cs_bo_validate, p);
 	if (r) {
-		DRM_ERROR("amdgpu_vm_validate() failed.\n");
+		drm_err(adev_to_drm(p->adev), "amdgpu_vm_validate() failed.\n");
 		goto out_free_user_pages;
 	}
 
@@ -1060,13 +1060,13 @@ static int amdgpu_cs_patch_ibs(struct amdgpu_cs_parser *p,
 		va_start = ib->gpu_addr & AMDGPU_GMC_HOLE_MASK;
 		r = amdgpu_cs_find_mapping(p, va_start, &aobj, &m);
 		if (r) {
-			DRM_ERROR("IB va_start is invalid\n");
+			drm_err(adev_to_drm(p->adev), "IB va_start is invalid\n");
 			return r;
 		}
 
 		if ((va_start + ib->length_dw * 4) >
 		    (m->last + 1) * AMDGPU_GPU_PAGE_SIZE) {
-			DRM_ERROR("IB va_start+ib_bytes is invalid\n");
+			drm_err(adev_to_drm(p->adev), "IB va_start+ib_bytes is invalid\n");
 			return -EINVAL;
 		}
 
@@ -1234,7 +1234,7 @@ static int amdgpu_cs_sync_rings(struct amdgpu_cs_parser *p)
 	r = amdgpu_ctx_wait_prev_fence(p->ctx, p->entities[p->gang_leader_idx]);
 	if (r) {
 		if (r != -ERESTARTSYS)
-			DRM_ERROR("amdgpu_ctx_wait_prev_fence failed.\n");
+			drm_err(adev_to_drm(p->adev), "amdgpu_ctx_wait_prev_fence failed.\n");
 		return r;
 	}
 
@@ -1447,7 +1447,7 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 
 	r = amdgpu_cs_parser_init(&parser, adev, filp, data);
 	if (r) {
-		DRM_ERROR_RATELIMITED("Failed to initialize parser %d!\n", r);
+		drm_err_ratelimited(dev, "Failed to initialize parser %d!\n", r);
 		return r;
 	}
 
@@ -1462,9 +1462,9 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 	r = amdgpu_cs_parser_bos(&parser, data);
 	if (r) {
 		if (r == -ENOMEM)
-			DRM_ERROR("Not enough memory for command submission!\n");
+			drm_err(dev, "Not enough memory for command submission!\n");
 		else if (r != -ERESTARTSYS && r != -EAGAIN)
-			DRM_DEBUG("Failed to process the buffer list %d!\n", r);
+			drm_dbg(dev, "Failed to process the buffer list %d!\n", r);
 		goto error_fini;
 	}
 
-- 
2.49.0

