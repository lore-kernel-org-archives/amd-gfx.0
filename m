Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59BFCC021A6
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2025 13:35:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF74110E38B;
	Mon, 24 Feb 2025 13:35:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="W4aN5Zi6";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D781D10E363
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2025 12:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=A756kZ2ToYPgqBzIF36klkoIMA6/Y4skU/xfX6i8lW8=; b=W4aN5Zi69V18GlH+x/n2sZ8V68
 mmRxojvApv38QfvRI2EKwd8Mm7u73FI9lGqOjmbPX5n0HIWJzCfceQTIKFnl40B8ddx0WKG7ntwg0
 jmwfrpurqHMW668tYIUyZF2rR5v8XmCJXAbDhy94VG55gusrSE4ussV8D4zGaCXNadn0PxP2jYrOt
 qQhAOD0QlqgIvzXaHX4ydW3I69APF64HtLe1TfjxEwMiOPvooGVFikukDiTFLwv4oNUR4/u0xp0Ii
 +EMZXYDfenZ6MRioRnfYIc7HyHLnC00fqYr08oRl8M20+SP37WedB0L2sYYVgmd2VhBhK1haPIBgY
 SKGcZsfg==;
Received: from [90.241.98.187] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1tmXEg-00HTAj-9E; Mon, 24 Feb 2025 13:07:04 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH 1/2] drm/amdgpu: Remove hole from struct amdgpu_ib
Date: Mon, 24 Feb 2025 12:06:43 +0000
Message-ID: <20250224120644.40148-2-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250224120644.40148-1-tvrtko.ursulin@igalia.com>
References: <20250224120644.40148-1-tvrtko.ursulin@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 24 Feb 2025 13:35:11 +0000
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

Group the 32- vs 64- members together to remove hole from the struct.

Before:

        /* size: 40, cachelines: 1, members: 5 */
        /* sum members: 32, holes: 1, sum holes: 4 */
        /* padding: 4 */
        /* last cacheline: 40 bytes */

After:
        /* size: 32, cachelines: 1, members: 5 */
        /* last cacheline: 32 bytes */

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index e13407cbb040..9a7ffbc53363 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -97,9 +97,9 @@ enum amdgpu_ib_pool_type {
 
 struct amdgpu_ib {
 	struct drm_suballoc		*sa_bo;
-	uint32_t			length_dw;
-	uint64_t			gpu_addr;
 	uint32_t			*ptr;
+	uint64_t			gpu_addr;
+	uint32_t			length_dw;
 	uint32_t			flags;
 };
 
-- 
2.48.0

