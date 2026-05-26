Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F385ECD5BB1
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 16:07:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87E2E10E6B4;
	Tue, 26 May 2026 16:07:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Hv2JHHt+";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5308110E0CC
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 16:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=riGIpcV0otuR2ImQjrSix7plvSXsp3JT51HCodGCLiI=; b=Hv2JHHt+DsE05uw3KTsQMs7wwx
 JV+1Pgcn2NqgM/5MPksrSzhfJHPuh26SFn9BT3Io0D92G7ZBEkAh8+G9++fga3FHNSRx4smOyyMUp
 pG3FQH/AaJrzoIeLdhXu1wKHIKMt+7SBNlN1VL8S+WBT4q3DCGEWz7fwifHG4rdP6xMTCv3s4GI2E
 AOKiEhVp2e7YMvp9oZLWKC/t0NHojEHsX170T1cjOP0qvHoFAbBt0LYucopUaEDzFZpNnc3s/CYCR
 GV4y1RvhsdqFADaUPu9mpsmiVTZvkIucQf/0zJaB7CcysxkBomJArO/dhPXhQREHkKChzM3TxOj5V
 V1VGw4Wg==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wRuJ0-008VbO-H0; Tue, 26 May 2026 18:06:58 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, David Francis <David.Francis@amd.com>,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [RFC 4/5] drm/amdgpu: Add context handle renaming operation
Date: Tue, 26 May 2026 17:06:29 +0100
Message-ID: <20260526160630.35562-5-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526160630.35562-1-tvrtko.ursulin@igalia.com>
References: <20260526160630.35562-1-tvrtko.ursulin@igalia.com>
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 30 +++++++++++++++++++++++++
 include/uapi/drm/amdgpu_drm.h           |  1 +
 2 files changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 15bf247c38f2..01a74eb6e721 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -541,6 +541,33 @@ static int amdgpu_ctx_free(struct amdgpu_fpriv *fpriv, uint32_t id)
 	return ctx ? 0 : -EINVAL;
 }
 
+static int amdgpu_ctx_change_handle(struct amdgpu_fpriv *fpriv,
+				    uint32_t old, uint32_t id)
+{
+	struct amdgpu_ctx_mgr *mgr = &fpriv->ctx_mgr;
+	struct amdgpu_ctx *ctx;
+	int r = -EINVAL;
+
+	if (!old || !id || old == id)
+		return -EINVAL;
+
+	mutex_lock(&mgr->lock);
+
+	ctx = idr_find(&mgr->ctx_handles, old);
+	if (!ctx)
+		goto out;
+
+	r = idr_alloc(&mgr->ctx_handles, ctx, id, id + 1, GFP_KERNEL);
+	if (r < 0)
+		goto out;
+
+	idr_remove(&mgr->ctx_handles, old);
+
+out:
+	mutex_unlock(&mgr->lock);
+	return r;
+}
+
 static int amdgpu_ctx_query(struct amdgpu_device *adev,
 			    struct amdgpu_fpriv *fpriv, uint32_t id,
 			    union drm_amdgpu_ctx_out *out)
@@ -727,6 +754,9 @@ int amdgpu_ctx_ioctl(struct drm_device *dev, void *data,
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
index 15da4d9c44fd..d2a7b4e9daed 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -251,6 +251,7 @@ union drm_amdgpu_bo_list {
 #define AMDGPU_CTX_OP_QUERY_STATE2	4
 #define AMDGPU_CTX_OP_GET_STABLE_PSTATE	5
 #define AMDGPU_CTX_OP_SET_STABLE_PSTATE	6
+#define AMDGPU_CTX_OP_CHANGE_HANDLE	7
 
 /* GPU reset status */
 #define AMDGPU_CTX_NO_RESET		0
-- 
2.54.0

