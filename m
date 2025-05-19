Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF1CC54754
	for <amd-gfx@archiver.kernel.org>; Mon, 19 May 2025 16:37:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36E4210E32E;
	Mon, 19 May 2025 16:37:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="psJPzomo";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3728110E2BE
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 May 2025 16:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=xdKL5cqHe03msyfk4mkm1ZmkD12QrWHGEdqcBbK64ts=; b=psJPzomolaPb4ybB3Ay1+mq1VN
 7iMVonjaWoxKOML+TrAhqUTRWF9Wr3bvW5MchAQatElFEj0RhkXhzEY9qNkkyj19slIlIqC7b1/QT
 u7TJcNn7vPh1/ydImme8gs43sLkZCQO1Mgp469hA5imqftjNq3eXRyRxwcS0LpZUKqBpWGmE81zlA
 Vwh8bEK1g/wvzSn8Pay8moSJA9c5yND9YBzglQFDt/9Si4jgU64P/4f0/WAS+qMS2j2yPm+wLMh/t
 ZFHUhxuTCG+kOR9AG3QQiCgHqRFoejqq4Ca8zHQuris2kLnYpyui0HXd0zpPO6o5YzWienmPglUxc
 PS4AcEhw==;
Received: from [81.79.92.254] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uH3US-00AKJD-DR; Mon, 19 May 2025 18:37:24 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [RFC 3/3] drm/amdgpu: Add locking to amdgpu_ctx_mgr_entity_fini()
Date: Mon, 19 May 2025 17:37:13 +0100
Message-ID: <20250519163713.11367-4-tvrtko.ursulin@igalia.com>
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

Amdgpu_ctx_mgr_entity_fini() walks the context IDR unlocked so question is
could it in theory see a stale entry and attempt to destroy the
drm_sched_entity twice?

Problem is I have hit this on a KASAN enabled kernel only _once_ and never
since. In that case it reported amdgpu_ctx_ioctl() had freed the entity
already which would mean the question is could we possibly go through the
mutex_unlock() on one CPU, and another CPU to follow immediately with
file->release (DRM postclose) and see the stale entry.

Throwing it out there not to forget about it, since I have manage to
lose the KASAN trace already..

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 85567d0d9545..95b005ed839e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -927,6 +927,7 @@ static void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr)
 
 	idp = &mgr->ctx_handles;
 
+	mutex_lock(&mgr->lock);
 	idr_for_each_entry(idp, ctx, id) {
 		if (kref_read(&ctx->refcount) != 1) {
 			DRM_ERROR("ctx %p is still alive\n", ctx);
@@ -945,6 +946,7 @@ static void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr)
 			}
 		}
 	}
+	mutex_unlock(&mgr->lock);
 }
 
 void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr)
-- 
2.48.0

