Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16DD7D2F7F1
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Dec 2025 13:40:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 504AC10EB37;
	Fri,  5 Dec 2025 13:40:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="i5yHxjT5";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D182510EB31
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Dec 2025 13:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=+waSgJeqHhL7bLcScB046nLL3bOLwz/n+ckuoqMt+nM=; b=i5yHxjT5cuKLZoUsagp1mTj+1U
 Luf8KPmIEd0CBM9ApIN3PfW3ttvbBlW/AhTxnxv8775Z7JsieTPQrarwxNJxp6Da0fGmWf1gBl+Jo
 datHkWip7JLPZ+KbHtGWp4GWnHyJ6g4fjvRef0DxUclBURPBL2tYrb2F9tK0Jjm4idNYXu+H11eez
 7ddeN3A5hbrYy3EADvar0th0s/onfZybEULEgtxIS8d76k1ozsOB0jYv2WOWxVIYB3/OMrABdqv3T
 aEP8n1nNc6e/IXlFy1/uHPJZO6PByIXNPXldqxhyf/6bmuxTn27fEzE8a7w5e1IsPdOX/SnxZr+/9
 QqZp8ghQ==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with utf8esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vRW37-0095gs-4I; Fri, 05 Dec 2025 14:40:41 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH 05/12] drm/amdgpu/userq: Use drm_gem_objects_lookup in
 amdgpu_userq_wait_ioctl
Date: Fri,  5 Dec 2025 13:40:28 +0000
Message-ID: <20251205134035.91551-6-tvrtko.ursulin@igalia.com>
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

Use the existing helper instead of open coding it

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 79 ++++++-------------
 1 file changed, 23 insertions(+), 56 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index c28abc556907..7aa26e88c8ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -602,41 +602,26 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 			    struct drm_file *filp)
 {
-	u32 *syncobj_handles, *timeline_points, *timeline_handles, *bo_handles_read, *bo_handles_write;
-	u32 num_syncobj, num_read_bo_handles, num_write_bo_handles;
-	struct drm_amdgpu_userq_fence_info *fence_info = NULL;
 	struct drm_amdgpu_userq_wait *wait_info = data;
+	const unsigned int num_write_bo_handles = wait_info->num_bo_write_handles;
+	const unsigned int num_read_bo_handles = wait_info->num_bo_read_handles;
+	struct drm_amdgpu_userq_fence_info *fence_info = NULL;
 	struct amdgpu_fpriv *fpriv = filp->driver_priv;
 	struct amdgpu_userq_mgr *userq_mgr = &fpriv->userq_mgr;
+	struct drm_gem_object **gobj_write, **gobj_read;
+	u32 *timeline_points, *timeline_handles;
 	struct amdgpu_usermode_queue *waitq;
-	struct drm_gem_object **gobj_write;
-	struct drm_gem_object **gobj_read;
+	u32 *syncobj_handles, num_syncobj;
 	struct dma_fence **fences = NULL;
 	u16 num_points, num_fences = 0;
-	int r, i, rentry, wentry, cnt;
 	struct drm_exec exec;
-
-	num_read_bo_handles = wait_info->num_bo_read_handles;
-	bo_handles_read = memdup_user(u64_to_user_ptr(wait_info->bo_read_handles),
-				      size_mul(sizeof(u32), num_read_bo_handles));
-	if (IS_ERR(bo_handles_read))
-		return PTR_ERR(bo_handles_read);
-
-	num_write_bo_handles = wait_info->num_bo_write_handles;
-	bo_handles_write = memdup_user(u64_to_user_ptr(wait_info->bo_write_handles),
-				       size_mul(sizeof(u32), num_write_bo_handles));
-	if (IS_ERR(bo_handles_write)) {
-		r = PTR_ERR(bo_handles_write);
-		goto free_bo_handles_read;
-	}
+	int r, i, cnt;
 
 	num_syncobj = wait_info->num_syncobj_handles;
 	syncobj_handles = memdup_user(u64_to_user_ptr(wait_info->syncobj_handles),
 				      size_mul(sizeof(u32), num_syncobj));
-	if (IS_ERR(syncobj_handles)) {
-		r = PTR_ERR(syncobj_handles);
-		goto free_bo_handles_write;
-	}
+	if (IS_ERR(syncobj_handles))
+		return PTR_ERR(syncobj_handles);
 
 	num_points = wait_info->num_syncobj_timeline_handles;
 	timeline_handles = memdup_user(u64_to_user_ptr(wait_info->syncobj_timeline_handles),
@@ -653,33 +638,19 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 		goto free_timeline_handles;
 	}
 
-	gobj_read = kmalloc_array(num_read_bo_handles, sizeof(*gobj_read), GFP_KERNEL);
-	if (!gobj_read) {
-		r = -ENOMEM;
+	r = drm_gem_objects_lookup(filp,
+				   u64_to_user_ptr(wait_info->bo_read_handles),
+				   num_read_bo_handles,
+				   &gobj_read);
+	if (r)
 		goto free_timeline_points;
-	}
 
-	for (rentry = 0; rentry < num_read_bo_handles; rentry++) {
-		gobj_read[rentry] = drm_gem_object_lookup(filp, bo_handles_read[rentry]);
-		if (!gobj_read[rentry]) {
-			r = -ENOENT;
-			goto put_gobj_read;
-		}
-	}
-
-	gobj_write = kmalloc_array(num_write_bo_handles, sizeof(*gobj_write), GFP_KERNEL);
-	if (!gobj_write) {
-		r = -ENOMEM;
+	r = drm_gem_objects_lookup(filp,
+				   u64_to_user_ptr(wait_info->bo_write_handles),
+				   num_write_bo_handles,
+				   &gobj_write);
+	if (r)
 		goto put_gobj_read;
-	}
-
-	for (wentry = 0; wentry < num_write_bo_handles; wentry++) {
-		gobj_write[wentry] = drm_gem_object_lookup(filp, bo_handles_write[wentry]);
-		if (!gobj_write[wentry]) {
-			r = -ENOENT;
-			goto put_gobj_write;
-		}
-	}
 
 	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
 		      (num_read_bo_handles + num_write_bo_handles));
@@ -936,12 +907,12 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 exec_fini:
 	drm_exec_fini(&exec);
 put_gobj_write:
-	while (wentry-- > 0)
-		drm_gem_object_put(gobj_write[wentry]);
+	for (i = 0; i < num_write_bo_handles; i++)
+		drm_gem_object_put(gobj_write[i]);
 	kfree(gobj_write);
 put_gobj_read:
-	while (rentry-- > 0)
-		drm_gem_object_put(gobj_read[rentry]);
+	for (i = 0; i < num_read_bo_handles; i++)
+		drm_gem_object_put(gobj_read[i]);;
 	kfree(gobj_read);
 free_timeline_points:
 	kfree(timeline_points);
@@ -949,10 +920,6 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 	kfree(timeline_handles);
 free_syncobj_handles:
 	kfree(syncobj_handles);
-free_bo_handles_write:
-	kfree(bo_handles_write);
-free_bo_handles_read:
-	kfree(bo_handles_read);
 
 	return r;
 }
-- 
2.51.1

