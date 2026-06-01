Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9A20CD6E65
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 14:08:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E05321133B3;
	Mon,  1 Jun 2026 14:08:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="oZzRqziS";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BC771133AD
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 14:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=NE0r8qc1ewywjYYEyhOUZAscPY7Es5Ze2TSStqCYXtA=; b=oZzRqziSN0kCyBLZpekQN1d+qN
 AuovgW6PA9mV1JbfKVLAouhMaHy4V9jcx56Q8GRsngWC8GsiPMTM4L3zyg6wfKJ+6HODoqneQSY3C
 VQ7+mH28o9VBcjckQ5Y3c5rnkFIOLrgOAKu0h8yqqIyHFgJF35Ynl8T9OTNbdG66/axF2H4XDFIDU
 iN6YYzcc7esKLCSdf5FLMg8AiUOlhNnPjvdoeMSt6cmAZ0NmrRn129LweFgOJkaUWTonC281yeIcu
 ebp2a1/Cfyw7yxWV0xQmJeecLg2SricBnB/iE8/QA4zfErmXeGItLwt8MG3jJodq9JZqFXzc8qYcB
 FzGZIY1g==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wU3Jm-00B2vU-T6; Mon, 01 Jun 2026 16:08:38 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH 5/7] drm/amdgpu: Simplify amdgpu_ctx_get_stable_pstate()
Date: Mon,  1 Jun 2026 15:08:26 +0100
Message-ID: <20260601140828.27779-6-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601140828.27779-1-tvrtko.ursulin@igalia.com>
References: <20260601140828.27779-1-tvrtko.ursulin@igalia.com>
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

amdgpu_ctx_get_stable_pstate() can never return other than success so
instead of returning the pstate via a pointer we can simply return the
pstate directly.

While at it, rename the function to amdgpu_get_stable_pstate() to make it
obvious it is not operating on the context at all.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 38 +++++++++----------------
 1 file changed, 13 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 342ff257decf..4f4552c7732f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -296,32 +296,20 @@ static ktime_t amdgpu_ctx_fini_entity(struct amdgpu_device *adev,
 	return res;
 }
 
-static int amdgpu_ctx_get_stable_pstate(struct amdgpu_ctx *ctx,
-					u32 *stable_pstate)
+static u32 amdgpu_get_stable_pstate(struct amdgpu_device *adev)
 {
-	struct amdgpu_device *adev = ctx->mgr->adev;
-	enum amd_dpm_forced_level current_level;
-
-	current_level = amdgpu_dpm_get_performance_level(adev);
-
-	switch (current_level) {
+	switch (amdgpu_dpm_get_performance_level(adev)) {
 	case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
-		*stable_pstate = AMDGPU_CTX_STABLE_PSTATE_STANDARD;
-		break;
+		return AMDGPU_CTX_STABLE_PSTATE_STANDARD;
 	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
-		*stable_pstate = AMDGPU_CTX_STABLE_PSTATE_MIN_SCLK;
-		break;
+		return AMDGPU_CTX_STABLE_PSTATE_MIN_SCLK;
 	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
-		*stable_pstate = AMDGPU_CTX_STABLE_PSTATE_MIN_MCLK;
-		break;
+		return AMDGPU_CTX_STABLE_PSTATE_MIN_MCLK;
 	case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
-		*stable_pstate = AMDGPU_CTX_STABLE_PSTATE_PEAK;
-		break;
+		return AMDGPU_CTX_STABLE_PSTATE_PEAK;
 	default:
-		*stable_pstate = AMDGPU_CTX_STABLE_PSTATE_NONE;
-		break;
+		return AMDGPU_CTX_STABLE_PSTATE_NONE;
 	}
-	return 0;
 }
 
 static int amdgpu_ctx_init(struct amdgpu_ctx_mgr *mgr, int32_t priority,
@@ -357,7 +345,7 @@ static int __amdgpu_ctx_set_stable_pstate(struct amdgpu_ctx *ctx,
 	enum amd_dpm_forced_level level;
 	struct amdgpu_ctx *current_ctx;
 	u32 current_stable_pstate;
-	int r = 0;
+	int r;
 
 	lockdep_assert_held(&adev->pm.stable_pstate_ctx_lock);
 
@@ -385,9 +373,9 @@ static int __amdgpu_ctx_set_stable_pstate(struct amdgpu_ctx *ctx,
 	if (current_ctx && current_ctx != ctx)
 		return -EBUSY;
 
-	r = amdgpu_ctx_get_stable_pstate(ctx, &current_stable_pstate);
-	if (r || current_stable_pstate == stable_pstate)
-		return r;
+	current_stable_pstate = amdgpu_get_stable_pstate(adev);
+	if (current_stable_pstate == stable_pstate)
+		return 0;
 
 	r = amdgpu_dpm_force_performance_level(adev, level);
 	if (r)
@@ -643,7 +631,7 @@ static int amdgpu_ctx_stable_pstate(struct amdgpu_device *adev,
 {
 	struct amdgpu_ctx *ctx;
 	struct amdgpu_ctx_mgr *mgr;
-	int r;
+	int r = 0;
 
 	if (!fpriv)
 		return -EINVAL;
@@ -659,7 +647,7 @@ static int amdgpu_ctx_stable_pstate(struct amdgpu_device *adev,
 	if (set)
 		r = amdgpu_ctx_set_stable_pstate(ctx, *stable_pstate);
 	else
-		r = amdgpu_ctx_get_stable_pstate(ctx, stable_pstate);
+		*stable_pstate = amdgpu_get_stable_pstate(adev);
 
 	mutex_unlock(&mgr->lock);
 	return r;
-- 
2.54.0

