Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36B70C9EC63
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jan 2026 10:22:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E118610E340;
	Mon, 12 Jan 2026 10:22:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="qShCahpg";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FB7E10E332
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jan 2026 10:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=F/G8F/KYdq5LZVgcnTcUzn+jTBBHeFcee3+kMktnSA0=; b=qShCahpgpzmFF4S+8R0oD0Ejyi
 K5SKMKiaBiw9EZthOO477ums91mp5ejfKK8UWHoBxiwyIin6oiJS1EMmjE34Lnikb1WQ02biroK0S
 1tGz9QXelPS0cX8Ev5Iy6EsU0W0SQpNhQM3LMo2Mg0z3q/2nL1orMg/dTY4agJNfjerFG/rXiDcem
 NkuG9MLVN+PVXDQJZWdx5RMNawXTZzwwyxi+hSvn2Jycx5e3PGNSt1z/AIeoB/Yicv9I36cjtXCoG
 iaEJmBDWgVONROQmvsNfLH5ARfICYQbtBmsIyNLvI22mvoUiV2vBx9PZRU22fEarsJWM47JV/9o8o
 f4w0cuUg==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vfF4V-004Lce-JO; Mon, 12 Jan 2026 11:22:51 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH v4 06/12] drm/amdgpu: Remove duplicate struct member
Date: Mon, 12 Jan 2026 10:22:38 +0000
Message-ID: <20260112102244.63308-7-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112102244.63308-1-tvrtko.ursulin@igalia.com>
References: <20260112102244.63308-1-tvrtko.ursulin@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Struct amdgpu_ctx contains two copies of the pointer to the context
manager. Remove one.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
v2:
 * Added TODO note for improving amdgpu_xcp_select_scheds.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index a5f85ea9fbb6..02988be1fae7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -232,7 +232,8 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
 	} else {
 		struct amdgpu_fpriv *fpriv;
 
-		fpriv = container_of(ctx->ctx_mgr, struct amdgpu_fpriv, ctx_mgr);
+		/* TODO: Stop using fpriv here, we only need the xcp_id. */
+		fpriv = container_of(ctx->mgr, struct amdgpu_fpriv, ctx_mgr);
 		r = amdgpu_xcp_select_scheds(adev, hw_ip, hw_prio, fpriv,
 						&num_scheds, &scheds);
 		if (r)
@@ -354,7 +355,6 @@ static int amdgpu_ctx_init(struct amdgpu_ctx_mgr *mgr, int32_t priority,
 	else
 		ctx->stable_pstate = current_stable_pstate;
 
-	ctx->ctx_mgr = &(fpriv->ctx_mgr);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
index aed758d0acaa..cf8d700a22fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
@@ -56,7 +56,6 @@ struct amdgpu_ctx {
 	unsigned long			ras_counter_ce;
 	unsigned long			ras_counter_ue;
 	struct amdgpu_ctx_mgr		*mgr;
-	struct amdgpu_ctx_mgr		*ctx_mgr;
 	struct amdgpu_ctx_entity	*entities[AMDGPU_HW_IP_NUM][AMDGPU_MAX_ENTITY_NUM];
 };
 
-- 
2.52.0

