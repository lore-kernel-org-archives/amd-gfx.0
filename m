Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7412C5AC7A
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2026 13:47:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99B8710F1BF;
	Thu,  6 Aug 2026 13:47:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="rVbvdOXG";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C094610F1DA
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Aug 2026 13:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=8GI5qbnQKpWwgNQVs+zZt1v9qohIhNOWn2sUyBLzri4=; b=
 rVbvdOXG0Tp3MG8zcIEZQ4hoaIOpYCZGuoHsPtzJPftGoRsUI+mp3ndlw/P/mWG1jXPc3ZEs+rCi9
 Vae9ANH+OrtkZ7uB91YBivxN7UheMaqTIAs5NOntmLLrK9HkInrWS7FPVK7Dh6nelw9iIEFY2lolw
 fxbokQ7gXTGZu2HZSjWc7KF8tcMyMBTlCvbjr+heReUpwiWYvjZo2uaWmeUbtEIHda6J0Uhn2cJki
 GG0rsGVYpmbWKhT3AHsT/veAONXPxwUhiWRZxhXNwG99EjFpAQCoIVYnXzy7ufj/tCMvFuvX27TwE
 ShusMSXQunQhZpeQtvKOATrb0/ttF4t7/g==;
Received: from [83.105.121.4] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wryRQ-00Ewr8-U4; Thu, 06 Aug 2026 15:47:25 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, David Francis <David.Francis@amd.com>,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH v3 5/7] drm/amdgpu: Add a new ioctl for listing client contexts
Date: Thu,  6 Aug 2026 14:47:10 +0100
Message-ID: <20260806134712.91816-6-tvrtko.ursulin@igalia.com>
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

Similar in principle to DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES, we need a new
ioctl to list any contexts created by the client.

Lets add it as DRM_IOCTL_AMDGPU_GEM_LIST_CONTEXTS, and the respective uapi
data structures.

Structures contain all information required to re-create the context,
modulo the handle id replication, which will be handled in a following
patch.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 102 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h |   2 +
 include/uapi/drm/amdgpu_drm.h           |  31 +++++++
 4 files changed, 136 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index d53259a5b82f..59ea6153f4a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -717,6 +717,108 @@ int amdgpu_ctx_ioctl(struct drm_device *dev, void *data,
 	return r;
 }
 
+/**
+ * amdgpu_gem_list_contexts_ioctl - get information about clients contexts
+ *
+ * @dev: drm device pointer
+ * @data: drm_amdgpu_gem_list_handles
+ * @filp: drm file pointer
+ *
+ * Returns:
+ * 0 for success, -errno for errors.
+ */
+int amdgpu_gem_list_contexts_ioctl(struct drm_device *dev, void *data,
+				   struct drm_file *filp)
+{
+	struct drm_amdgpu_gem_list_contexts *args = data;
+	struct drm_amdgpu_gem_list_contexts_entry *contexts;
+	struct amdgpu_fpriv *fpriv = filp->driver_priv;
+	struct amdgpu_ctx_mgr *mgr = &fpriv->ctx_mgr;
+	struct amdgpu_device *adev = mgr->adev;
+	unsigned long id, idx = 0, num = 0;
+	struct amdgpu_ctx *ctx;
+	int ret = 0;
+
+	if (args->padding)
+		return -EINVAL;
+
+	xa_for_each(&mgr->ctx_handles, id, ctx)
+		num++;
+
+	if (num == 0 || args->num_contexts < num) {
+		args->num_contexts = num;
+		return 0;
+	}
+
+	contexts = kvzalloc_objs(*contexts, num);
+	if (!contexts)
+		return -ENOMEM;
+
+	xa_lock(&mgr->ctx_handles);
+	xa_for_each(&mgr->ctx_handles, id, ctx) {
+		struct drm_amdgpu_gem_list_contexts_entry *context;
+		enum amd_dpm_forced_level level;
+
+		if (idx >= num) {
+			ret = -EAGAIN;
+			break;
+		}
+
+		kref_get(&ctx->refcount);
+		xa_unlock(&mgr->ctx_handles);
+
+		context = &contexts[idx];
+
+		context->handle = id;
+		context->init_priority = ctx->init_priority;
+		context->override_priority = ctx->override_priority;
+
+		mutex_lock(&adev->pm.stable_pstate_ctx_lock);
+		if (ctx == adev->pm.stable_pstate_ctx) {
+			level = amdgpu_dpm_get_performance_level(adev);
+
+			switch (level) {
+			case AMD_DPM_FORCED_LEVEL_AUTO:
+				context->pstate_flags = AMDGPU_CTX_STABLE_PSTATE_NONE;
+				break;
+			case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
+				context->pstate_flags = AMDGPU_CTX_STABLE_PSTATE_STANDARD;
+				break;
+			case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
+				context->pstate_flags = AMDGPU_CTX_STABLE_PSTATE_MIN_SCLK;
+				break;
+			case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
+				context->pstate_flags = AMDGPU_CTX_STABLE_PSTATE_MIN_MCLK;
+				break;
+			case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
+				context->pstate_flags = AMDGPU_CTX_STABLE_PSTATE_PEAK;
+				break;
+			default:
+				ret = -EIO;
+				break;
+			};
+
+		}
+		mutex_unlock(&adev->pm.stable_pstate_ctx_lock);
+
+		idx++;
+		amdgpu_ctx_put(ctx);
+		xa_lock(&mgr->ctx_handles);
+	}
+	xa_unlock(&mgr->ctx_handles);
+
+	args->num_contexts = idx;
+
+	if (!ret)
+		if (copy_to_user(u64_to_user_ptr(args->contexts), contexts,
+				 num * sizeof(*contexts)))
+			ret = -EFAULT;
+
+	kvfree(contexts);
+
+	return ret;
+}
+
 struct amdgpu_ctx *amdgpu_ctx_get(struct amdgpu_fpriv *fpriv, uint32_t id)
 {
 	struct amdgpu_ctx *ctx;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 0ab380ca7e64..5f0abdfe0063 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3104,6 +3104,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_PROC_OPTIONS, amdgpu_proc_options_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_CONTEXTS, amdgpu_gem_list_contexts_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 };
 
 static const struct drm_driver amdgpu_kms_driver = {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
index b558336bc4c6..0e17d9fc665f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
@@ -69,6 +69,8 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 			struct drm_file *filp);
 int amdgpu_gem_list_handles_ioctl(struct drm_device *dev, void *data,
 				  struct drm_file *filp);
+int amdgpu_gem_list_contexts_ioctl(struct drm_device *dev, void *data,
+				   struct drm_file *filp);
 
 int amdgpu_gem_metadata_ioctl(struct drm_device *dev, void *data,
 				struct drm_file *filp);
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 9baa9a4b6b3d..27b32eed6f3a 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -59,6 +59,7 @@ extern "C" {
 #define DRM_AMDGPU_USERQ_WAIT		0x18
 #define DRM_AMDGPU_GEM_LIST_HANDLES	0x19
 #define DRM_AMDGPU_PROC_OPTIONS		0x1A
+#define DRM_AMDGPU_GEM_LIST_CONTEXTS	0x1B
 
 #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
 #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
@@ -81,6 +82,7 @@ extern "C" {
 #define DRM_IOCTL_AMDGPU_USERQ_WAIT	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
 #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
 #define DRM_IOCTL_AMDGPU_PROC_OPTIONS	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_PROC_OPTIONS, struct drm_amdgpu_proc_options)
+#define DRM_IOCTL_AMDGPU_GEM_LIST_CONTEXTS DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_CONTEXTS, struct drm_amdgpu_gem_list_contexts)
 
 /**
  * DOC: memory domains
@@ -875,6 +877,35 @@ struct drm_amdgpu_gem_list_handles_entry {
 	};
 };
 
+struct drm_amdgpu_gem_list_contexts {
+	/* User pointer to array of drm_amdgpu_gem_list_contexts_entry */
+	__u64 contexts;
+
+	/* Size of the contexts buffer / Number of contexts in the client (if larger than size of buffer, must retry) */
+	__u32 num_contexts;
+
+	__u32 padding;
+};
+
+struct drm_amdgpu_gem_list_contexts_entry {
+	/* gem context handle */
+	__u32 handle;
+
+	/* AMDGPU_GEM_LIST_CONTEXTS_FLAG_* */
+	__u32 flags;
+
+	/* context initial priority */
+	__s32 init_priority;
+
+	/* context override priority */
+	__s32 override_priority;
+
+	/* pstate flags */
+	__u32 pstate_flags;
+
+	__u32 padding;
+};
+
 #define AMDGPU_VA_OP_MAP			1
 #define AMDGPU_VA_OP_UNMAP			2
 #define AMDGPU_VA_OP_CLEAR			3
-- 
2.54.0

