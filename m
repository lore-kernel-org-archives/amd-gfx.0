Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35840C55ABF
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2026 13:47:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B41910F1DA;
	Thu,  6 Aug 2026 13:47:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="h1sEWhx9";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CA6E10F1D1
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Aug 2026 13:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=/MZFKWDgQv9dfhvF4v113RTSuhBBE1kC2uDKOJZOtVg=; b=
 h1sEWhx9Y3YVSgxupMm/SrjGsASLvOn4R8hekGzW5GPcLob9UJZJbGlNZQWJ9RlxOcvOrEzrrFi3O
 asf9iExmAIdamgAzLr4ObIT+QxM0xrFf7sLZiHbvF3uDzZ55UNVUTq9LNMf5XfUxNKNWudDKrHo+S
 HAWzWLFHgxXok6c/8ZRZAm8rCq/mSHdcO+eKqFQN9vvnQygnXN6rD50qKjZSxquUF1Ha41+TkILcs
 vqf2Zlxxp//20f62209WVpjW+4YV+A37l6cqLC/DdXQAnB/hc+E0MerM+dcLm9xNXijpUVp9YSYMD
 VwQ0VAPzmca2r1Vqd+O3Npt33D4RC3GCRw==;
Received: from [83.105.121.4] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wryRR-00EwrK-KH; Thu, 06 Aug 2026 15:47:25 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, David Francis <David.Francis@amd.com>,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH v3 6/7] drm/amdgpu: Add context handle renaming operation
Date: Thu,  6 Aug 2026 14:47:11 +0100
Message-ID: <20260806134712.91816-7-tvrtko.ursulin@igalia.com>
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
index 59ea6153f4a2..771c128571fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -517,6 +517,44 @@ static int amdgpu_ctx_free(struct amdgpu_fpriv *fpriv, uint32_t id)
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
@@ -710,6 +748,9 @@ int amdgpu_ctx_ioctl(struct drm_device *dev, void *data,
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
index 27b32eed6f3a..28cebf7a3cd6 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -253,6 +253,7 @@ union drm_amdgpu_bo_list {
 #define AMDGPU_CTX_OP_QUERY_STATE2	4
 #define AMDGPU_CTX_OP_GET_STABLE_PSTATE	5
 #define AMDGPU_CTX_OP_SET_STABLE_PSTATE	6
+#define AMDGPU_CTX_OP_CHANGE_HANDLE	7
 
 /* GPU reset status */
 #define AMDGPU_CTX_NO_RESET		0
-- 
2.54.0

