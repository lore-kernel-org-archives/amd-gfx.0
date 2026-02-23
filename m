Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6B33EA4FAE
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Feb 2026 12:41:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CCC810E391;
	Mon, 23 Feb 2026 12:41:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="FAgJT0d0";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A1FA10E382
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Feb 2026 12:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=D2E0fS/9SEDCeZnGAN73t/yGI9LdkuOYJgLMi5istug=; b=FAgJT0d0pOMygFX6Sj8SpQ3SM/
 uKREIQTNZey922spil4pHHQUtji4LbTC2Va2+Ciw0tJJbXo2IS3lz9CBalEOfTSbvBSxy1nb9Wu+n
 YKNMdRcwnFTUWycVSKAb/smLkQ6kps2XbHGbUDge6CisUxmiUPIdt3li3tTa9g4vgFtHoVa2GvtQT
 vwr3CF5wQTCDx94fyFme02+GFsS7TkrN++nllFvFOq1CeAqbUl2W8YySmJ9X1mVVXe/ZPJXZDUt2Z
 +dLbpL6PlwnECBoGZD+o5Sk5W6qJUXEQqSjxeIwEc6rJVT4VxYXmciDQBySEPjlLEku995yDXW8cU
 y5lrOPGw==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vuVG1-004EKL-R0; Mon, 23 Feb 2026 13:41:49 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: Sunil Khatri <sunil.khatri@amd.com>, kernel-dev@igalia.com,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH v2 04/12] drm/amdgpu/userq: Use drm_gem_objects_lookup in
 amdgpu_userq_signal_ioctl
Date: Mon, 23 Feb 2026 12:41:33 +0000
Message-ID: <20260223124141.10641-5-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260223124141.10641-1-tvrtko.ursulin@igalia.com>
References: <20260223124141.10641-1-tvrtko.ursulin@igalia.com>
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

Use the existing helper instead of open coding it.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 81 +++++--------------
 1 file changed, 22 insertions(+), 59 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 67911e6c552f..ee6f03f75b41 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -459,20 +459,19 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 			      struct drm_file *filp)
 {
 	struct amdgpu_device *adev = drm_to_adev(dev);
-	struct amdgpu_fpriv *fpriv = filp->driver_priv;
-	struct amdgpu_userq_mgr *userq_mgr = &fpriv->userq_mgr;
 	struct drm_amdgpu_userq_signal *args = data;
-	struct drm_gem_object **gobj_write = NULL;
-	struct drm_gem_object **gobj_read = NULL;
-	struct amdgpu_usermode_queue *queue;
+	const unsigned int num_write_bo_handles = args->num_bo_write_handles;
+	const unsigned int num_read_bo_handles = args->num_bo_read_handles;
+	struct amdgpu_fpriv *fpriv = filp->driver_priv;
+	struct amdgpu_userq_mgr *userq_mgr = &fpriv->userq_mgr;
+	struct drm_gem_object **gobj_write, **gobj_read;
+	u32 *syncobj_handles, num_syncobj_handles;
 	struct amdgpu_userq_fence *userq_fence;
+	struct amdgpu_usermode_queue *queue;
 	struct drm_syncobj **syncobj = NULL;
-	u32 *bo_handles_write, num_write_bo_handles;
-	u32 *syncobj_handles, num_syncobj_handles;
-	u32 *bo_handles_read, num_read_bo_handles;
-	int r, i, entry, rentry, wentry;
 	struct dma_fence *fence;
 	struct drm_exec exec;
+	int r, i, entry;
 	u64 wptr;
 
 	if (!amdgpu_userq_enabled(dev))
@@ -499,51 +498,19 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 		}
 	}
 
-	num_read_bo_handles = args->num_bo_read_handles;
-	bo_handles_read = memdup_user(u64_to_user_ptr(args->bo_read_handles),
-				      sizeof(u32) * num_read_bo_handles);
-	if (IS_ERR(bo_handles_read)) {
-		r = PTR_ERR(bo_handles_read);
+	r = drm_gem_objects_lookup(filp,
+				   u64_to_user_ptr(args->bo_read_handles),
+				   num_read_bo_handles,
+				   &gobj_read);
+	if (r)
 		goto free_syncobj;
-	}
 
-	/* Array of pointers to the GEM read objects */
-	gobj_read = kmalloc_array(num_read_bo_handles, sizeof(*gobj_read), GFP_KERNEL);
-	if (!gobj_read) {
-		r = -ENOMEM;
-		goto free_bo_handles_read;
-	}
-
-	for (rentry = 0; rentry < num_read_bo_handles; rentry++) {
-		gobj_read[rentry] = drm_gem_object_lookup(filp, bo_handles_read[rentry]);
-		if (!gobj_read[rentry]) {
-			r = -ENOENT;
-			goto put_gobj_read;
-		}
-	}
-
-	num_write_bo_handles = args->num_bo_write_handles;
-	bo_handles_write = memdup_user(u64_to_user_ptr(args->bo_write_handles),
-				       sizeof(u32) * num_write_bo_handles);
-	if (IS_ERR(bo_handles_write)) {
-		r = PTR_ERR(bo_handles_write);
+	r = drm_gem_objects_lookup(filp,
+				   u64_to_user_ptr(args->bo_write_handles),
+				   num_write_bo_handles,
+				   &gobj_write);
+	if (r)
 		goto put_gobj_read;
-	}
-
-	/* Array of pointers to the GEM write objects */
-	gobj_write = kmalloc_array(num_write_bo_handles, sizeof(*gobj_write), GFP_KERNEL);
-	if (!gobj_write) {
-		r = -ENOMEM;
-		goto free_bo_handles_write;
-	}
-
-	for (wentry = 0; wentry < num_write_bo_handles; wentry++) {
-		gobj_write[wentry] = drm_gem_object_lookup(filp, bo_handles_write[wentry]);
-		if (!gobj_write[wentry]) {
-			r = -ENOENT;
-			goto put_gobj_write;
-		}
-	}
 
 	/* Retrieve the user queue */
 	queue = xa_load(&userq_mgr->userq_xa, args->queue_id);
@@ -622,17 +589,13 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 exec_fini:
 	drm_exec_fini(&exec);
 put_gobj_write:
-	while (wentry-- > 0)
-		drm_gem_object_put(gobj_write[wentry]);
+	for (i = 0; i < num_write_bo_handles; i++)
+		drm_gem_object_put(gobj_write[i]);
 	kfree(gobj_write);
-free_bo_handles_write:
-	kfree(bo_handles_write);
 put_gobj_read:
-	while (rentry-- > 0)
-		drm_gem_object_put(gobj_read[rentry]);
+	for (i = 0; i < num_read_bo_handles; i++)
+		drm_gem_object_put(gobj_read[i]);
 	kfree(gobj_read);
-free_bo_handles_read:
-	kfree(bo_handles_read);
 free_syncobj:
 	while (entry-- > 0)
 		if (syncobj[entry])
-- 
2.52.0

