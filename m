Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 235A3CD98F2
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2026 14:13:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D77F10EB73;
	Tue, 23 Jun 2026 14:13:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="MLDxtC1w";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DE9D10EB73
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2026 14:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=EADXHzTtWrJUYMGNWHV4JPm2widJcW2w7ThTdOkUmWI=; b=MLDxtC1wzJvCdqQzEZ9uNRMd1z
 SpBGwzd+jLBUxPB/fFpI9MPctHQ3/HRyaEm1JwBquXkQy2vOjYH/M891qf0yqjhKuDeU+62YAQlyn
 5QyMWkwl4Z+lSZm/aAWUicnRchf33NeWR1lIKyc/VaXnhQL6MiJhQLIWCzUVzPrmraexY04alTdn/
 B866P5bcLp1l6cAz/k9xTeB0p6Oc4UfSeFm4ybbdPNfHxGAPvgK5uNmF6I9f/4GsC++lL5y+JSVkU
 G6ioKkZ4U0wKDmyrK5C7LTfcDk/YQIsZmFnziH2z8J3LCxLt8fDTq1JUr0HQ+DGeWSsipyhyMYm0q
 dNxHAN2g==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wc1sW-004DC9-Cy; Tue, 23 Jun 2026 16:13:28 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, David Francis <David.Francis@amd.com>,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [RFC v2 2/4] drm/amdgpu: Add a new ioctl for listing client contexts
Date: Tue, 23 Jun 2026 15:12:55 +0100
Message-ID: <20260623141257.66086-3-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623141257.66086-1-tvrtko.ursulin@igalia.com>
References: <20260623141257.66086-1-tvrtko.ursulin@igalia.com>
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 100 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h |   2 +
 include/uapi/drm/amdgpu_drm.h           |  31 ++++++++
 4 files changed, 134 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index ce35b415093d..b9bbf8677174 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -768,6 +768,106 @@ int amdgpu_ctx_ioctl(struct drm_device *dev, void *data,
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
+	unsigned long num = 0, idx = 0;
+	struct amdgpu_ctx *ctx;
+	int ret = 0;
+	u32 id;
+
+	if (args->padding)
+		return -EINVAL;
+
+	mutex_lock(&mgr->lock);
+	idr_for_each_entry(&mgr->ctx_handles, ctx, id)
+		num++;
+	mutex_unlock(&mgr->lock);
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
+	mutex_lock(&mgr->lock);
+	idr_for_each_entry(&mgr->ctx_handles, ctx, id) {
+		struct drm_amdgpu_gem_list_contexts_entry *context;
+		enum amd_dpm_forced_level level;
+
+		if (idx >= num) {
+			ret = -EAGAIN;
+			break;
+		}
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
+	}
+	mutex_unlock(&mgr->lock);
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
index bf4260269681..f61f0ddd3ccf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3076,6 +3076,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL, amdgpu_userq_signal_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
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
index 24f2dffc0789..3191ae1a0549 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -58,6 +58,7 @@ extern "C" {
 #define DRM_AMDGPU_USERQ_SIGNAL		0x17
 #define DRM_AMDGPU_USERQ_WAIT		0x18
 #define DRM_AMDGPU_GEM_LIST_HANDLES	0x19
+#define DRM_AMDGPU_GEM_LIST_CONTEXTS	0x20
 
 #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
 #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
@@ -79,6 +80,7 @@ extern "C" {
 #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
 #define DRM_IOCTL_AMDGPU_USERQ_WAIT	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
 #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
+#define DRM_IOCTL_AMDGPU_GEM_LIST_CONTEXTS DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_CONTEXTS, struct drm_amdgpu_gem_list_contexts)
 
 /**
  * DOC: memory domains
@@ -873,6 +875,35 @@ struct drm_amdgpu_gem_list_handles_entry {
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

