Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60D4AC9EC64
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jan 2026 10:22:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDF2410E333;
	Mon, 12 Jan 2026 10:22:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="OzxOtDas";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A073B10E0C1
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jan 2026 10:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=jbdxM3SeSr1YjCV5Pr0Kxwkc9F71WWovNIeqJvbtPk0=; b=OzxOtDas5BQzxRIzp5x0uSmwlo
 WxOpRWBnUEDnq7HEEwYTHiPLxEwqM0/8i+7K3Ck/5p9R2f8aXFrTyJcVOILKcZf/7oHFi6WlTOQ16
 U9b1OMNRPbqqBEFB4EpRIfRcuqUfylR0E6fuyqKrwhoad8t9Zaq62HBBQfKJ3T2KiRJ9Z2OEe/8pQ
 4josuBnjUMCdNayCDX2MoLASkjpDKPvmPZjxWRlIkDq1v054RXJh1q/s6n/uR6HjwaxaHLaMzOojQ
 WDDy7u2T69i9Y5EziMPMz5Jbd5E2+i3w+C4niv1b9tmIUqs/rL+6fGT0o0L62FQFmj/6JkN/ZB0Fj
 YtFg9k4w==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vfF4U-004LcV-Ss; Mon, 12 Jan 2026 11:22:50 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH v4 05/12] drm/amdgpu: Remove a few holes from struct amdgpu_ctx
Date: Mon, 12 Jan 2026 10:22:37 +0000
Message-ID: <20260112102244.63308-6-tvrtko.ursulin@igalia.com>
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

Re-order the struct members a bit to avoid some holes:

 /* size: 408, cachelines: 7, members: 15 */
 /* sum members: 393, holes: 4, sum holes: 15 */
 /* last cacheline: 24 bytes */

 /* size: 400, cachelines: 7, members: 15 */
 /* sum members: 393, holes: 1, sum holes: 7 */
 /* last cacheline: 16 bytes */

While doing so we notice a duplicate but will address than in the
following patch.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
index 090dfe86f75b..aed758d0acaa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
@@ -44,20 +44,20 @@ struct amdgpu_ctx_entity {
 
 struct amdgpu_ctx {
 	struct kref			refcount;
-	struct amdgpu_ctx_mgr		*mgr;
+	spinlock_t			ring_lock;
 	unsigned			reset_counter;
 	unsigned			reset_counter_query;
-	uint64_t			generation;
-	spinlock_t			ring_lock;
-	struct amdgpu_ctx_entity	*entities[AMDGPU_HW_IP_NUM][AMDGPU_MAX_ENTITY_NUM];
-	bool				preamble_presented;
 	int32_t				init_priority;
 	int32_t				override_priority;
+	uint32_t			stable_pstate;
 	atomic_t			guilty;
+	bool				preamble_presented;
+	uint64_t			generation;
 	unsigned long			ras_counter_ce;
 	unsigned long			ras_counter_ue;
-	uint32_t			stable_pstate;
+	struct amdgpu_ctx_mgr		*mgr;
 	struct amdgpu_ctx_mgr		*ctx_mgr;
+	struct amdgpu_ctx_entity	*entities[AMDGPU_HW_IP_NUM][AMDGPU_MAX_ENTITY_NUM];
 };
 
 struct amdgpu_ctx_mgr {
-- 
2.52.0

