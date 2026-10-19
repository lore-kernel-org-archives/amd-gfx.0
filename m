Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE5F5CCF2DE
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 13:02:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5523D10ECF3;
	Mon, 19 Oct 2026 13:02:28 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECE6A10ECF3
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 13:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=MBzefxJjSehIiXV7MP/rE+sn8b55QNnwWbl4rmGfcSE=; b=
 QGA1cCBvHGXG5OVJHKARjJQSBq+UIR9YvruHNptMPL3HJ2NxJCKpYrzidjBBl11wGSHful+RKEUYk
 3muGMkdF/dMyb1ErLzbPfQ7Hl8Bd0Z3w26YX1WNHaN6Bbypi54ld3q4NoM9DpDYoGsj75JK5VtW2x
 GR2GWGkzVWYsFUpQHGJk/AXrP8gKCUp1cMOqmqRSdb3/s9zOLd+MvQNJTfBBGsh97ydFCzPq+Eaw8
 uHYFDkt6qNxLvhUFSibWehA9jPGrV91+Jbo3MCQYiqxJg+LofKthjC/PEoIHUNy+Mfpwvk7i/roEt
 1ZAvmKf1hIW6YtISqVE9Nha33fud+Li19Q==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xIn0L-003UKv-2I; Mon, 19 Oct 2026 15:02:17 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, David Francis <David.Francis@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH v4 6/7] drm/amdgpu: Add context handle renaming operation
Date: Mon, 19 Oct 2026 14:01:58 +0100
Message-ID: <20261019130159.11739-7-tvrtko.ursulin@igalia.com>
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

Identical in principle to DRM_IOCTL_GEM_CHANGE_HANDLE, we need a method
for renaming the driver specific context handles.

We add a new operation (AMDGPU_CTX_OP_CHANGE_HANDLE) to the
DRM_IOCTL_AMDGPU_CTX ioctl.

Source handle is given in the existing input handle field, while the
destination handle needs to be passed in the existing flags field.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 41 +++++++++++++++++++++++++
 include/uapi/drm/amdgpu_drm.h           |  1 +
 2 files changed, 42 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 5eb156d72db9..d47ccbe7ab52 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -518,6 +518,44 @@ static int amdgpu_ctx_free(struct amdgpu_fpriv *fpriv, uint32_t id)
 	return ctx ? 0 : -EINVAL;
 }
 
+static int amdgpu_ctx_change_handle(struct amdgpu_fpriv *fpriv,
+				    uint32_t old, uint32_t id)
+{
+	struct amdgpu_ctx_mgr *mgr = &fpriv->ctx_mgr;
+	XA_STATE(xas, &mgr->ctx_handles, id);
+	struct amdgpu_ctx *ctx;
+	int r;
+
+	if (!old || !id || old == id)
+		return -EINVAL;
+
+	do {
+		xas_lock(&xas);
+
+		ctx = xa_load(&mgr->ctx_handles, old);
+		if (!ctx) {
+			r = -EINVAL;
+			goto unlock;
+		}
+
+		if (xas_load(&xas)) {
+			r = -EBUSY;
+			goto unlock;
+		}
+
+		xas_store(&xas, ctx);
+		r = xas_error(&xas);
+		if (r)
+			goto unlock;
+
+		__xa_erase(&mgr->ctx_handles, old);
+unlock:
+		xas_unlock(&xas);
+	} while (xas_nomem(&xas, GFP_KERNEL));
+
+	return r;
+}
+
 static int amdgpu_ctx_query(struct amdgpu_device *adev,
 			    struct amdgpu_fpriv *fpriv, uint32_t id,
 			    union drm_amdgpu_ctx_out *out)
@@ -716,6 +754,9 @@ int amdgpu_ctx_ioctl(struct drm_device *dev, void *data,
 			return -EINVAL;
 		r = amdgpu_ctx_stable_pstate(adev, fpriv, id, true, &stable_pstate);
 		break;
+	case AMDGPU_CTX_OP_CHANGE_HANDLE:
+		r = amdgpu_ctx_change_handle(fpriv, id, args->in.flags);
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 7f7aae3c2498..ac0e7811c389 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -261,6 +261,7 @@ union drm_amdgpu_bo_list {
 #define AMDGPU_CTX_OP_QUERY_STATE2	4
 #define AMDGPU_CTX_OP_GET_STABLE_PSTATE	5
 #define AMDGPU_CTX_OP_SET_STABLE_PSTATE	6
+#define AMDGPU_CTX_OP_CHANGE_HANDLE	7
 
 /* GPU reset status */
 #define AMDGPU_CTX_NO_RESET		0
-- 
2.56.0

