Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5B8CCCF9E3
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 14:06:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D7C010E5E7;
	Tue,  4 Nov 2025 14:06:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Y3LeFVqM";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1FCC10E5F1
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 14:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=pNBBCY6DCE/B17Umf34LSjrCBLbIvo2neg8sFZXfHhw=; b=Y3LeFVqMyys4+6j4uj0Z5MkMwR
 MKgUnGaI5BHEpd6H4HYsbxB/K5D/oY75ucOEkonAiu6xq3rkjYFXaaCOURdwvFOfS56jly2tX3bTf
 oXNGvJTLkcJUyEKY3rSZA898lnBQ6BwTuCk9FjRYXM0eL0N956XTvVXeV+Kncj7zoQ85U+liYTqCu
 pE8b4WLANiQF+Z92OSCnkJX3TsnitHwx1rUuxzv5UjyH4dCo61MNTfLarLMc0T12C/qB1y1ISIPCR
 0XtPXVjROaAneOgOOlw47XVH+AVMVE1960qJ+Q7XzhnRFHZDYyjHaLCxRaXbgO6wOSLRaeLDqQFP2
 k+RfmGSA==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vGHg7-001OEM-5m; Tue, 04 Nov 2025 15:06:31 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [RFC 02/25] drm/amdgpu/jpeg3.0 Simplify idle check
Date: Tue,  4 Nov 2025 14:03:58 +0000
Message-ID: <20251104140421.88520-3-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20251104140421.88520-1-tvrtko.ursulin@igalia.com>
References: <20251104140421.88520-1-tvrtko.ursulin@igalia.com>
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

Simplify the idle check by looking at the done bit directly instead of
clearing the assumed idle status if not done.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index d1a011c40ba2..e1b579451982 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -476,13 +476,10 @@ static void jpeg_v3_0_dec_ring_set_wptr(struct amdgpu_ring *ring)
 static bool jpeg_v3_0_is_idle(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int ret = 1;
 
-	ret &= (((RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS) &
+	return (RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS) &
 		UVD_JRBC_STATUS__RB_JOB_DONE_MASK) ==
-		UVD_JRBC_STATUS__RB_JOB_DONE_MASK));
-
-	return ret;
+		UVD_JRBC_STATUS__RB_JOB_DONE_MASK;
 }
 
 static int jpeg_v3_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
-- 
2.48.0

