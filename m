Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7C1FCCFA06
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 14:06:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A9D010E5FB;
	Tue,  4 Nov 2025 14:06:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="B8lIaCqb";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AD7110E5F5
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 14:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vcNFe5eBwZMiWSJodRtH69SY8/7KDzdq8YsD/Dmy72Y=; b=B8lIaCqbC4/xXmsNF0js5zFctK
 FKBJJc/X7bWXxRfFVCFFIgSqWjzLHjU3QLDDyyH7691KzEi07+8XWqAGb73gyZeryRR/RwEvllPov
 PiocfPi1MGAwcqXqcY4yh6eFRPbaI7RmMKFZKbleIjYgb7vh6ST+m79kNmQaLAbfbnLGjjeYJ01Y7
 Fi+Jhwab+TsL0kTIVMpUp1VVbf9IBhbePF+YjRb+U3addb2q49MRchAUOcwY6+oQRTLzIKOExarFR
 4d7+CLBLo2BPNLABh8K82o6qKjXurW0NJruMN8AisG5ceVqKdTRwhKeq81duLNAkP2sFsVsqvph+Y
 amJ2H0gA==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vGHgD-001OFF-BT; Tue, 04 Nov 2025 15:06:37 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [RFC 10/25] drm/amdgpu/jpeg: Use more local variables
Date: Tue,  4 Nov 2025 14:04:06 +0000
Message-ID: <20251104140421.88520-11-tvrtko.ursulin@igalia.com>
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

Compact some very long and repetitive lines of code by caching the
respective object in local variables. This is a concept which is already
used at places, but not consistently so.

add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-45 (-45)
Function                                     old     new   delta
amdgpu_jpeg_dec_ring_test_ring               382     337     -45
Total: Before=8977332, After=8977287, chg -0.00%

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index 620dc338e0a6..fc43e8668b6a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -153,6 +153,8 @@ void amdgpu_jpeg_ring_end_use(struct amdgpu_ring *ring)
 int amdgpu_jpeg_dec_ring_test_ring(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_jpeg_reg *external = &adev->jpeg.inst[ring->me].external;
+	unsigned int pipe = ring->pipe;
 	uint32_t tmp = 0;
 	unsigned i;
 	int r;
@@ -165,16 +167,16 @@ int amdgpu_jpeg_dec_ring_test_ring(struct amdgpu_ring *ring)
 	if (r)
 		return r;
 
-	WREG32(adev->jpeg.inst[ring->me].external.jpeg_pitch[ring->pipe], 0xCAFEDEAD);
+	WREG32(external->jpeg_pitch[pipe], 0xCAFEDEAD);
 	/* Add a read register to make sure the write register is executed. */
-	RREG32(adev->jpeg.inst[ring->me].external.jpeg_pitch[ring->pipe]);
+	RREG32(external->jpeg_pitch[pipe]);
 
-	amdgpu_ring_write(ring, PACKET0(adev->jpeg.internal.jpeg_pitch[ring->pipe], 0));
+	amdgpu_ring_write(ring, PACKET0(adev->jpeg.internal.jpeg_pitch[pipe], 0));
 	amdgpu_ring_write(ring, 0xABADCAFE);
 	amdgpu_ring_commit(ring);
 
 	for (i = 0; i < adev->usec_timeout; i++) {
-		tmp = RREG32(adev->jpeg.inst[ring->me].external.jpeg_pitch[ring->pipe]);
+		tmp = RREG32(external->jpeg_pitch[pipe]);
 		if (tmp == 0xABADCAFE)
 			break;
 		udelay(1);
-- 
2.48.0

