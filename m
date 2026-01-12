Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E66AFC9EC68
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jan 2026 10:22:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D18ED10E359;
	Mon, 12 Jan 2026 10:22:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="FJH677nH";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BA5B10E333
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jan 2026 10:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=lgU7rV/YO4zybVzmayQUNvV5tA7xuLHT7lKg367+PUA=; b=FJH677nHonnIoTqV8FhfBxb08U
 W0TThcaVXg1iJtStxD2I3z99uSrvc8L6WEh0mzMrWhrh3VlR2MwonqHtd7+udU0mT/RsL7NY9t0AA
 LOx7999uufuSHUwaoL+nf9ZmLUAdsO1OYqqRRvpCGyactgcBpsNHmORBh+z9zfiEOUCbol7gG1I2v
 T9ZIWX4IJpFjglqXli5mGkLTCnYUoCAikZ80OFG28MnYjac6pN25dyDrqMsGHXPIH5RfN1BWAm7uc
 KglfuJDy2PlxkZEa6tgJwht87Rlw1nJ+vXT+lsb0r2KRBEY7IQJDGYyvAebHtaaYMf3XG6NG82zOH
 dBKVtdPA==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vfF4X-004Ld1-P2; Mon, 12 Jan 2026 11:22:53 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH v4 09/12] drm/amdgpu: Remove live context error log and skip
Date: Mon, 12 Jan 2026 10:22:41 +0000
Message-ID: <20260112102244.63308-10-tvrtko.ursulin@igalia.com>
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
index cc69ad0f03d5..93b1fb4d1b8a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -903,14 +903,8 @@ static void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr)
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

