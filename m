Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FDEAD1A628
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jan 2026 13:33:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B26910E8CA;
	Fri,  9 Jan 2026 13:33:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="WJ4yP4qm";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8712810E8C5
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jan 2026 13:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=iFMFYWiKiuTTwoBmAApL9Ftyr2WRZH8BO+G2b24CkQU=; b=WJ4yP4qmOYLSep6PrQUBNjKsqA
 Ud5moo5O5xaM6ewVtSm1+nyvN6lUQ5rLabQ4duUucowG2u7CgzPv6U6cqM6vXi5zAbc5zean94dRT
 1/TVomdxf+U8rgUW/WwFlgDX0wPVcdxK+v/wCfwL2Bau1LmpgHM+uEy5bsoF0tF2k/WPBV4NHGXpE
 ATxh5wCOym86yCQjt+Xb1btB8CzqkVkGod2H7zrtorT/+B/Q59wbqJDlWw7v4GJg93pOYVHvAxEtR
 9KUz1DRGfIZ7qWZk/dqik9rWudKWslVEFbtzeovvnSbwEOD/QF9k8ve++OY5bGutiO9s+nDVN4m/x
 mPj2q2Jg==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1veCcJ-003Qbv-Ow; Fri, 09 Jan 2026 14:33:27 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH v3 09/12] drm/amdgpu: Remove live context error log and skip
Date: Fri,  9 Jan 2026 13:33:11 +0000
Message-ID: <20260109133314.88548-10-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109133314.88548-1-tvrtko.ursulin@igalia.com>
References: <20260109133314.88548-1-tvrtko.ursulin@igalia.com>
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

According to Christian the skip can only cause memory leaks if it would to
trigger, while it does nothing for the fact context manager will still get
zapped with live back references from dangling contexts.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 0e02fc624cd5..64bc77134ca9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -899,14 +899,8 @@ static void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr)
 	struct amdgpu_ctx *ctx;
 	uint32_t id;
 
-	idr_for_each_entry(&mgr->ctx_handles, ctx, id) {
-		if (kref_read(&ctx->refcount) != 1) {
-			DRM_ERROR("ctx %p is still alive\n", ctx);
-			continue;
-		}
-
+	idr_for_each_entry(&mgr->ctx_handles, ctx, id)
 		amdgpu_ctx_put(ctx);
-	}
 }
 
 void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr)
-- 
2.52.0

