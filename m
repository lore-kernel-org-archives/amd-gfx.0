Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E01FC19776
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2025 10:10:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6FDE10E222;
	Wed, 26 Feb 2025 10:10:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="LAOEK73E";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9F4810E1BC
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2025 10:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=A756kZ2ToYPgqBzIF36klkoIMA6/Y4skU/xfX6i8lW8=; b=LAOEK73E3GdWGvSjPpDcEI9YJb
 DHivEu6GhfZ5yQI28/U78cLWVJtTGWVBCPYwxBluvfD5dk256Oe1MyE++JFZvrkuqBg1ktmXCqPSP
 zh0MIxYXnHPzpZOGiauXEpdUgGbfyUJRVKox19u4leJQsm5I/7UPyrtTxUmVg8BHCphRvGjlwBSVW
 Ari4mxXgvBeWG51H51Chc93/fqgnT7v+5FGKsswnuyNZsY6caBlvbOMSe4e9JhSXVAOkpr/2TP0wq
 ouwFh0rtFSC9NHElTLDGYtcLg86t4g2hUlBpXcOR5NUHZzc/wHcABs+L/nscjbNMhvTj6R+esC/XJ
 GlQS35Pg==;
Received: from [90.241.98.187] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1tnEMl-000tOJ-Qz; Wed, 26 Feb 2025 11:10:17 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH 1/3] drm/amdgpu: Remove hole from struct amdgpu_ib
Date: Wed, 26 Feb 2025 10:10:13 +0000
Message-ID: <20250226101015.27117-2-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250226101015.27117-1-tvrtko.ursulin@igalia.com>
References: <20250226101015.27117-1-tvrtko.ursulin@igalia.com>
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

