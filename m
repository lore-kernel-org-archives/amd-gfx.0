Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D13F4C2D0CD
	for <amd-gfx@archiver.kernel.org>; Mon, 19 May 2025 16:37:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D92310E2DC;
	Mon, 19 May 2025 16:37:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="b5iTsyNA";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70B9810E2B2
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 May 2025 16:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6HJUYcwpIAuqwj1IzeM/LzQSzaSRkd+jwNVsevNksXw=; b=b5iTsyNA8TIqoK8JsoAS+Qglsg
 rpOvC77ks8Jf2pbxGO+eHJIh69aDBO51A+tw4rGWtuE5q8BimlNWJEwqkbcqmJ7XPJ4owPT22FWLH
 C9skhMAjvDSYht27uV+gPAkcc/fwEjQNkf21DSzrSRS44kGiMtavBqWHRidl+GyKmgY2QAnO8VoJB
 7X+jC+Dr4eAo8QJfr79a6Jfw9i5RZpnjnHDW7QBXbIyGeTyzC0cVfAwW1wGm0VjNznf/bAHtAQldU
 KJH+/VsF9lhKMR6aLsNj/9soQFU9cpV/A4dUMyN5ZsjlKHM9mhBTuIhrd19hp/tJKtDCnZzxRlzH3
 PV9/gchg==;
Received: from [81.79.92.254] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uH3UR-00AKJ6-LP; Mon, 19 May 2025 18:37:23 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [RFC 2/3] drm/amdgpu: Remove duplicated "context still alive" check
Date: Mon, 19 May 2025 17:37:12 +0100
Message-ID: <20250519163713.11367-3-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250519163713.11367-1-tvrtko.ursulin@igalia.com>
References: <20250519163713.11367-1-tvrtko.ursulin@igalia.com>
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

When amdgpu_ctx_mgr_fini() calls amdgpu_ctx_mgr_entity_fini() it contains
the exact same "context still alive" check as it will do next. Remove the
duplicated copy.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 4ff8552e872d..85567d0d9545 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -949,19 +949,7 @@ static void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr)
 
 void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr)
 {
-	struct amdgpu_ctx *ctx;
-	struct idr *idp;
-	uint32_t id;
-
 	amdgpu_ctx_mgr_entity_fini(mgr);
-
-	idp = &mgr->ctx_handles;
-
-	idr_for_each_entry(idp, ctx, id) {
-		if (kref_put(&ctx->refcount, amdgpu_ctx_fini) != 1)
-			DRM_ERROR("ctx %p is still alive\n", ctx);
-	}
-
 	idr_destroy(&mgr->ctx_handles);
 	mutex_destroy(&mgr->lock);
 }
-- 
2.48.0

