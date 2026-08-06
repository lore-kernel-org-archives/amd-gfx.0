Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F5AC5AC7C
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2026 13:47:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01CB910F1D1;
	Thu,  6 Aug 2026 13:47:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="e+eDwjQv";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C8AC10F1D1
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Aug 2026 13:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=LM7rj5Qq+brB++tpwZiyovG/nOp+kU13mpdYx2WFsSc=; b=
 e+eDwjQvax0+WSS+4ZVL7PLaUS4flcw9EF9RWk6NZKA6tHV7o1eRWQU4uOC8n36w8RsbPtGiYR/Xx
 UN7dY6LZDn/pD6YyqfH44jls1MS2NuGGMYVxVvQkPn1QK97CowLwao6texdIklz7LylECHeL5/qn0
 TyTJSk6vPWABXQf+QJt3YW7NVfXILhRc+gOezIV7dJvfm73mapZ3CNhr6XgRiHLQTHHP6JyzH+eZf
 Xr62w4p3AWe5oixy8jnIwLbil+VIAYmnkp3uPAZpUUvBQQtlaSDpYnW8ltBrQq/1ZBBclmplvHZ7b
 GANeRRQnnT3nR2W0Ux16++iQgeW6tK+kdw==;
Received: from [83.105.121.4] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wryRS-00EwrU-BR; Thu, 06 Aug 2026 15:47:26 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, David Francis <David.Francis@amd.com>,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH v3 7/7] drm/amdgpu: Add driver managed buffer copy
Date: Thu,  6 Aug 2026 14:47:12 +0100
Message-ID: <20260806134712.91816-8-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260806134712.91816-1-tvrtko.ursulin@igalia.com>
References: <20260806134712.91816-1-tvrtko.ursulin@igalia.com>
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

Saving and restoring buffer object content poses a challenge for the
checkpoint and restore process for at least two reasons.

For example not all objects can be exported as dma-buf to enable copying
from a separate client context, neither can any objects be easily copied
from the same context since the injected CRIU code is unaware of the GPU
virtual memory free and allocated ranges.

Lets bypass both problems by simply exposing access to the already present
fast kernel copy via a new DRM_IOCTL_AMDGPU_GEM_COPY_BUFFER ioctl.

By giving the kernel simply the source and destination handles it is able
to copy them without the need for objects to be mapped, or shared with a
separate client.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 125 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |  14 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h |   7 ++
 include/uapi/drm/amdgpu_drm.h           |  13 +++
 6 files changed, 155 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 5f0abdfe0063..e00b4b6f3730 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3105,6 +3105,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_PROC_OPTIONS, amdgpu_proc_options_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_CONTEXTS, amdgpu_gem_list_contexts_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_COPY_BUFFER, amdgpu_gem_copy_buffer_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 };
 
 static const struct drm_driver amdgpu_kms_driver = {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index fad7bbd00edd..28e662d41d16 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -31,6 +31,7 @@
 #include <linux/pagemap.h>
 #include <linux/pci.h>
 #include <linux/dma-buf.h>
+#include <linux/dma-fence-chain.h>
 #include <linux/dma-fence-unwrap.h>
 #include <linux/uaccess.h>
 
@@ -1237,6 +1238,130 @@ int amdgpu_gem_list_handles_ioctl(struct drm_device *dev, void *data,
 	return ret;
 }
 
+/**
+ * amdgpu_gem_copy_buffer_ioctl - copy buffer object content
+ *
+ * @dev: drm device pointer
+ * @data: drm_amdgpu_gem_copy_buffer
+ * @filp: drm file pointer
+ *
+ * Returns:
+ * 0 for success, -errno for errors.
+ */
+int amdgpu_gem_copy_buffer_ioctl(struct drm_device *dev, void *data,
+				 struct drm_file *filp)
+{
+	struct amdgpu_copy_mem src_mem = {}, dst_mem = {};
+	struct drm_amdgpu_gem_copy_buffer *args = data;
+	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct drm_gem_object *src_gobj, *dst_gobj;
+	struct amdgpu_bo *src_bo, *dst_bo;
+	struct dma_fence *fence = NULL;
+	struct dma_fence_chain *chain;
+	struct drm_syncobj *syncobj;
+	struct drm_exec exec;
+	unsigned int e;
+	u64 end;
+	int r;
+
+	if (args->mbz)
+		return -EINVAL;
+
+	if (!args->syncobj_handle || !args->timeline_point)
+		return -EINVAL;
+
+	src_gobj = drm_gem_object_lookup(filp, args->src_handle);
+	if (!src_gobj)
+		return -ENOENT;
+
+	dst_gobj = drm_gem_object_lookup(filp, args->dst_handle);
+	if (!dst_gobj) {
+		r = -ENOENT;
+		goto err_dst;
+	}
+
+	syncobj = drm_syncobj_find(filp, args->syncobj_handle);
+	if (!syncobj) {
+		r = -EINVAL;
+		goto err_syncobj;
+	}
+
+	chain = dma_fence_chain_alloc();
+	if (!chain) {
+		r = -ENOMEM;
+		goto err_chain;
+	}
+
+	src_bo = gem_to_amdgpu_bo(src_gobj);
+	dst_bo = gem_to_amdgpu_bo(dst_gobj);
+
+	if (check_add_overflow(args->src_offset, args->copy_size, &end) ||
+	    end > amdgpu_bo_size(src_bo)) {
+		r = -E2BIG;
+		goto err_sizes;
+	}
+
+	if (check_add_overflow(args->dst_offset, args->copy_size, &end) ||
+	    end > amdgpu_bo_size(dst_bo)) {
+		r = -E2BIG;
+		goto err_sizes;
+	}
+
+	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
+
+	drm_exec_until_all_locked(&exec) {
+		r = drm_exec_prepare_obj(&exec, &src_bo->tbo.base, 1);
+		drm_exec_retry_on_contention(&exec);
+		if (r)
+			goto err_unlock;
+
+		r = drm_exec_prepare_obj(&exec, &dst_bo->tbo.base, 1);
+		drm_exec_retry_on_contention(&exec);
+		if (r)
+			goto err_unlock;
+	}
+
+	src_mem.bo = &src_bo->tbo;
+	src_mem.mem = src_bo->tbo.resource;
+	src_mem.offset = args->src_offset;
+	dst_mem.bo = &dst_bo->tbo;
+	dst_mem.mem = dst_bo->tbo.resource;
+	dst_mem.offset = args->dst_offset;
+
+	e = atomic_inc_return(&adev->mman.next_move_entity) %
+			      adev->mman.num_move_entities;
+
+	r = amdgpu_ttm_copy_mem_to_mem(adev, &adev->mman.move_entities[e],
+				       &src_mem, &dst_mem,
+				       args->copy_size,
+				       amdgpu_bo_encrypted(src_bo),
+				       dst_bo->tbo.base.resv, &fence);
+	if (r) {
+		goto err_unlock;
+	} else if (!fence) {
+		r = -ENXIO;
+		goto err_unlock;
+	}
+
+	dma_resv_add_fence(src_bo->tbo.base.resv, fence, DMA_RESV_USAGE_BOOKKEEP);
+	dma_resv_add_fence(dst_bo->tbo.base.resv, fence, DMA_RESV_USAGE_BOOKKEEP);
+	drm_syncobj_add_point(syncobj, chain, fence, args->timeline_point);
+	dma_fence_put(fence);
+
+err_unlock:
+	drm_exec_fini(&exec);
+err_sizes:
+	if (r)
+		dma_fence_chain_free(chain);
+err_chain:
+	drm_syncobj_put(syncobj);
+err_syncobj:
+	drm_gem_object_put(dst_gobj);
+err_dst:
+	drm_gem_object_put(src_gobj);
+	return r;
+}
+
 static unsigned int amdgpu_gem_align_pitch(struct amdgpu_device *adev,
 					   unsigned int width,
 					   unsigned int cpp,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
index 0e17d9fc665f..64529680fdad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
@@ -71,6 +71,8 @@ int amdgpu_gem_list_handles_ioctl(struct drm_device *dev, void *data,
 				  struct drm_file *filp);
 int amdgpu_gem_list_contexts_ioctl(struct drm_device *dev, void *data,
 				   struct drm_file *filp);
+int amdgpu_gem_copy_buffer_ioctl(struct drm_device *dev, void *data,
+				 struct drm_file *filp);
 
 int amdgpu_gem_metadata_ioctl(struct drm_device *dev, void *data,
 				struct drm_file *filp);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index deaae26fe982..6cfded0acad2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -296,13 +296,13 @@ static int amdgpu_ttm_map_buffer(struct amdgpu_ttm_buffer_entity *entity,
  *
  */
 __attribute__((nonnull))
-static int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
-				      struct amdgpu_ttm_buffer_entity *entity,
-				      const struct amdgpu_copy_mem *src,
-				      const struct amdgpu_copy_mem *dst,
-				      uint64_t size, bool tmz,
-				      struct dma_resv *resv,
-				      struct dma_fence **f)
+int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
+			       struct amdgpu_ttm_buffer_entity *entity,
+			       const struct amdgpu_copy_mem *src,
+			       const struct amdgpu_copy_mem *dst,
+			       uint64_t size, bool tmz,
+			       struct dma_resv *resv,
+			       struct dma_fence **f)
 {
 	struct amdgpu_res_cursor src_mm, dst_mm;
 	struct dma_fence *fence = NULL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 82f3b9fdfe83..fa2189571fff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -273,4 +273,11 @@ void amdgpu_ttm_mmio_remap_free_sgt(struct device *dev,
 				    enum dma_data_direction dir,
 				    struct sg_table *sgt);
 
+int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
+			       struct amdgpu_ttm_buffer_entity *entity,
+			       const struct amdgpu_copy_mem *src,
+			       const struct amdgpu_copy_mem *dst,
+			       uint64_t size, bool tmz,
+			       struct dma_resv *resv,
+			       struct dma_fence **f);
 #endif
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 28cebf7a3cd6..0c6829589d56 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -60,6 +60,7 @@ extern "C" {
 #define DRM_AMDGPU_GEM_LIST_HANDLES	0x19
 #define DRM_AMDGPU_PROC_OPTIONS		0x1A
 #define DRM_AMDGPU_GEM_LIST_CONTEXTS	0x1B
+#define DRM_AMDGPU_GEM_COPY_BUFFER	0x1C
 
 #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
 #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
@@ -83,6 +84,7 @@ extern "C" {
 #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
 #define DRM_IOCTL_AMDGPU_PROC_OPTIONS	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_PROC_OPTIONS, struct drm_amdgpu_proc_options)
 #define DRM_IOCTL_AMDGPU_GEM_LIST_CONTEXTS DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_CONTEXTS, struct drm_amdgpu_gem_list_contexts)
+#define DRM_IOCTL_AMDGPU_GEM_COPY_BUFFER DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_COPY_BUFFER, struct drm_amdgpu_gem_copy_buffer)
 
 /**
  * DOC: memory domains
@@ -208,6 +210,17 @@ union drm_amdgpu_gem_create {
 	struct drm_amdgpu_gem_create_out	out;
 };
 
+struct drm_amdgpu_gem_copy_buffer {
+	__u32	src_handle;
+	__u32	dst_handle;
+	__u64	src_offset;
+	__u64	dst_offset;
+	__u64	copy_size;
+	__u32	syncobj_handle;
+	__u32   mbz;
+	__u64   timeline_point;
+};
+
 /** Opcode to create new residency list.  */
 #define AMDGPU_BO_LIST_OP_CREATE	0
 /** Opcode to destroy previously created residency list */
-- 
2.54.0

