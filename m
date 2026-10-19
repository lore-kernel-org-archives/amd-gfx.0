Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9009CCCF2D6
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 13:02:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A21D10ECF9;
	Mon, 19 Oct 2026 13:02:29 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFE7210ECF6
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 13:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=oEgXCI74Bzje84bI/1DrZrhqp+GlI6C9mkXEKpcmpzk=; b=
 QPKy+gJj/7M5HLiSsnJA2T+JqiGJ8SSACrAs/hA1NvgC4YRqw8Jd9/Pqi0+bdPBD/R0rMpSGuwImI
 tesIDTl+oOXa7FpNGkKvi0x+m9oK8a/7tNEZajVRyzhtTnhSqNVBF659+SIp8kTyxMqc//3VI5ciu
 ydmp+7zGE3alZyCxu8oviEi3vqQofXksP8/m0NBx4Q1H0llRGLwel8jODTk1soOT+7/S44G+MLerx
 3ZYnykZZBsM4t6jkiwaXJs9Jl+E0g9ZKZsojbIMUYsK0mWzUdZFJmwQyGOKA4b78zd+wZem/1NrgQ
 rr8pusgsb/VCTYXaOVHt4ZP+i85dETc3Og==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xIn0L-003ULE-Q8; Mon, 19 Oct 2026 15:02:17 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, David Francis <David.Francis@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH v4 7/7] drm/amdgpu: Add driver managed buffer copy
Date: Mon, 19 Oct 2026 14:01:59 +0100
Message-ID: <20261019130159.11739-8-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019130159.11739-1-tvrtko.ursulin@igalia.com>
References: <20261019130159.11739-1-tvrtko.ursulin@igalia.com>
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
index 79d57659d748..c78e8c048c63 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3141,6 +3141,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_PROC_OPTIONS, amdgpu_proc_options_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_UALINK_HANDLE, amdgpu_gem_ualink_handle_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_CONTEXTS, amdgpu_gem_list_contexts_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_COPY_BUFFER, amdgpu_gem_copy_buffer_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 };
 
 static const struct drm_driver amdgpu_kms_driver = {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index e3d3e205a4fa..7ad14bdfa292 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -30,6 +30,7 @@
 #include <linux/pagemap.h>
 #include <linux/pci.h>
 #include <linux/dma-buf.h>
+#include <linux/dma-fence-chain.h>
 #include <linux/dma-fence-unwrap.h>
 #include <linux/uaccess.h>
 #include <linux/pm_runtime.h>
@@ -1300,6 +1301,130 @@ int amdgpu_gem_list_handles_ioctl(struct drm_device *dev, void *data,
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
index c1b972258e93..0254a006e2f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -308,13 +308,13 @@ static int amdgpu_ttm_map_buffer(struct amdgpu_ttm_buffer_entity *entity,
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
index 6967b5a06d20..0bdf28a00398 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -276,4 +276,11 @@ void amdgpu_ttm_mmio_remap_free_sgt(struct device *dev,
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
index ac0e7811c389..8de748f37e2f 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -61,6 +61,7 @@ extern "C" {
 #define DRM_AMDGPU_PROC_OPTIONS		0x1A
 #define DRM_AMDGPU_UALINK_HANDLE	0x1B
 #define DRM_AMDGPU_GEM_LIST_CONTEXTS	0x1C
+#define DRM_AMDGPU_GEM_COPY_BUFFER	0x1D
 
 #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
 #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
@@ -85,6 +86,7 @@ extern "C" {
 #define DRM_IOCTL_AMDGPU_PROC_OPTIONS	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_PROC_OPTIONS, struct drm_amdgpu_proc_options)
 #define DRM_IOCTL_AMDGPU_UALINK_HANDLE DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_UALINK_HANDLE, union drm_amdgpu_ualink_handle)
 #define DRM_IOCTL_AMDGPU_GEM_LIST_CONTEXTS DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_CONTEXTS, struct drm_amdgpu_gem_list_contexts)
+#define DRM_IOCTL_AMDGPU_GEM_COPY_BUFFER DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_COPY_BUFFER, struct drm_amdgpu_gem_copy_buffer)
 
 /**
  * DOC: memory domains
@@ -216,6 +218,17 @@ union drm_amdgpu_gem_create {
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
2.56.0

