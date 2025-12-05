Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8717DD2F7EF
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Dec 2025 13:40:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED8FD10EB36;
	Fri,  5 Dec 2025 13:40:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="nKDd76ME";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 194C510EB31
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Dec 2025 13:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=54JCvGN3FpDV14FimaVGKnUYoAABXFXxTXJY+m1r7IY=; b=nKDd76MEGMFWpReObzJJM1U0jd
 Ik4UQwTFo0kA9JF8J45JUbCjv2Y9T08JUrfieYZyyGXa50JAWBpjYhdK4PsZqxNAgwuzS/kiFEcUl
 p77bzPI+1qFUTC4Hpb/tBHXEFFPxGhF8e34XDSi2KUWAEogrYQmbXxpLB1BBp9uDabWIxOP4YJFAG
 jYir2LpC3I1pT2eQJBz+8yZl1yFc0Y5eJXlhWdPIsF43xJhDOg8ONcIz7iOhYLvhpbwwPGmz+NNZf
 soY0kNPwWgRckx9U0wBUx/k1v+YJ5/qkE0Y3LbfRPd7BLEp9NmJ9YMgpXR4koLIZDJapkN/arkiRt
 sxRABiVA==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with utf8esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vRW36-0095gj-CJ; Fri, 05 Dec 2025 14:40:40 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH 04/12] drm/amdgpu/userq: Use drm_gem_objects_lookup in
 amdgpu_userq_signal_ioctl
Date: Fri,  5 Dec 2025 13:40:27 +0000
Message-ID: <20251205134035.91551-5-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251205134035.91551-1-tvrtko.ursulin@igalia.com>
References: <20251205134035.91551-1-tvrtko.ursulin@igalia.com>
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
index 61b4258af2ff..c28abc556907 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -455,20 +455,19 @@ amdgpu_userq_fence_driver_force_completion(struct amdgpu_usermode_queue *userq)
 int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 			      struct drm_file *filp)
 {
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
 
 	num_syncobj_handles = args->num_syncobj_handles;
@@ -492,51 +491,19 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
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
 	queue = xa_load(&userq_mgr->userq_mgr_xa, args->queue_id);
@@ -614,17 +581,13 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
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
2.51.1

