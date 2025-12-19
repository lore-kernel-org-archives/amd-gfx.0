Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDED7D78771
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Dec 2025 13:42:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DCA710EF9C;
	Fri, 19 Dec 2025 13:42:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="c1j6ZJ1e";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B154410EF96
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Dec 2025 13:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=SlkNfiWXaKueYwThyKKyvBJgF56QcM/YH3R9J9IAMyc=; b=c1j6ZJ1elCkPjsigjcI4ejEizM
 zEq/fZohv2DYfuFWg4UhP2N3gbgVrRyysaLyoaVf2bxNHyTgCcIr4HZRDupf8ds6iLy0I+tCFY87o
 fWvNxgXjIgSaiauwYcqUmASi2CYHzCw1hBRSaHCkV9Tx+Z0VlsXqcUSL6tqBX91hcgUXeELS6+ua9
 o6ziUbqSQURolzsQ27cpzhD42DASh/jcqNUIXtbIQRq7+2hKg4qX6x3hPHJjMXZ8SDOjCzx+aWsui
 /0ACxZslEKyQ6iUQOam8lN3V6pJH/bkyv2Ej6GVUDW0GqrKrIK41/WDi9Ygw53aUtQOF/czgmutfU
 bwnqHbJA==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with utf8esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vWakF-00EeQx-V0; Fri, 19 Dec 2025 14:42:12 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH v2 06/12] drm/amdgpu: Remove duplicate struct member
Date: Fri, 19 Dec 2025 13:41:59 +0000
Message-ID: <20251219134205.25450-7-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251219134205.25450-1-tvrtko.ursulin@igalia.com>
References: <20251219134205.25450-1-tvrtko.ursulin@igalia.com>
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

Struct amdgpu_ctx contains two copies of the pointer to the context
manager. Remove one.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 3 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index afedea02188d..41c05358d86d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -232,7 +232,7 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
 	} else {
 		struct amdgpu_fpriv *fpriv;
 
-		fpriv = container_of(ctx->ctx_mgr, struct amdgpu_fpriv, ctx_mgr);
+		fpriv = container_of(ctx->mgr, struct amdgpu_fpriv, ctx_mgr);
 		r = amdgpu_xcp_select_scheds(adev, hw_ip, hw_prio, fpriv,
 						&num_scheds, &scheds);
 		if (r)
@@ -349,7 +349,6 @@ static int amdgpu_ctx_init(struct amdgpu_ctx_mgr *mgr, int32_t priority,
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
2.51.1

