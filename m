Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0365C88E78
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2026 14:55:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A68910EF2E;
	Mon, 14 Sep 2026 14:55:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="cOLRkEnZ";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B667E10EF2F
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2026 14:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=C4/mls9n9Pgn813hpRpY2l7Hp/MXTJuCCvgS0DRIL5Y=; b=cOLRkEnZ9loXPWXq/36rD8FSz1
 B8qo5E/wYJyu3qQQDjfXVrtmWUWqpbsQVBeYqbkSC9CMMCLyl0QNday9I5QTvc8JQ9Ekp3FmLrSua
 w2IKA6hTljvVZok2ZcZHm/HEDVMBWr5Okw+aQGAdn2LHrrmWor4y+WwvDwgH6OxsQ/Hz7GUrUbPiG
 CtxbtrJGLPVXMiKExUJf/oy2fPzq3N/h1dkzp/TtelnWOFAIZVS3W4g4GwGssOsVqTCVaQDTLB+zj
 Hr45VoOEklsqrsX5dSt/3Y4Ui8mRISD88SGmb+6xvLO7mATCPIcIo+eTra7UjtXL8dqsPcTwkEZrW
 srQBfQ7w==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1x685P-001x2p-1o; Mon, 14 Sep 2026 16:55:10 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH v3 4/6] drm/amdgpu: Cache the SDMA CSA address
Date: Mon, 14 Sep 2026 15:54:24 +0100
Message-ID: <20260914145426.51458-5-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914145426.51458-1-tvrtko.ursulin@igalia.com>
References: <20260914145426.51458-1-tvrtko.ursulin@igalia.com>
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

SDMA CSA address is static while the driver is loaded so lets store it in
the SDMA instance allowing us to simplify and inline the
amdgpu_sdma_get_csa_mc_addr() helper.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Timur Kristóf <timur.kristof@gmail.com>
---
v2:
 * Consolildate local init before ring init.
v3:
 * Restore sane init order.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c      | 36 +++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h      | 10 +++++-
 .../gpu/drm/amd/amdgpu/amdgpu_sdma_types.h    |  2 ++
 3 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index d2fee2480154..d1996c695f77 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -42,7 +42,9 @@ int __printf(4, 5)
 amdgpu_sdma_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 		      unsigned int instance, const char *fmt, ...)
 {
+	struct amdgpu_sdma_instance *sdma;
 	va_list args;
+	int r;
 
 	ring->ring_obj = NULL;
 
@@ -50,25 +52,21 @@ amdgpu_sdma_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 	vsnprintf(ring->name, sizeof(ring->name), fmt, args);
 	va_end(args);
 
-	return amdgpu_ring_init(adev, ring, 1024, &adev->sdma.trap_irq,
-				AMDGPU_SDMA_IRQ_INSTANCE0 + instance,
-				AMDGPU_RING_PRIO_DEFAULT, NULL);
-}
-
-uint64_t amdgpu_sdma_get_csa_mc_addr(struct amdgpu_ring *ring,
-				     unsigned int vmid)
-{
-	struct amdgpu_device *adev = ring->adev;
-
-	/* don't enable OS preemption on SDMA under SRIOV */
-	if (amdgpu_sriov_vf(adev) || vmid == 0 || !adev->gfx.mcbp)
-		return 0;
-
-	if (ring->me > 31)
-		return 0;
-
-	return amdgpu_csa_vaddr(adev) + AMDGPU_CSA_SDMA_OFFSET +
-	       ring->me * AMDGPU_CSA_SDMA_SIZE;
+	r = amdgpu_ring_init(adev, ring, 1024, &adev->sdma.trap_irq,
+			     AMDGPU_SDMA_IRQ_INSTANCE0 + instance,
+			     AMDGPU_RING_PRIO_DEFAULT, NULL);
+	if (r)
+		return r;
+
+	sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	if (amdgpu_sriov_vf(adev) || !adev->gfx.mcbp)
+		sdma->csa_addr = 0;
+	else
+		sdma->csa_addr = amdgpu_csa_vaddr(adev) +
+				 AMDGPU_CSA_SDMA_OFFSET +
+				 ring->me * AMDGPU_CSA_SDMA_SIZE;
+
+	return r;
 }
 
 int amdgpu_sdma_ras_late_init(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 60f7faace0d0..93595520bc13 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -55,7 +55,15 @@ amdgpu_sdma_get_instance_from_ring(struct amdgpu_ring *ring)
 	return &ring->adev->sdma.instance[ring->me];
 }
 
-uint64_t amdgpu_sdma_get_csa_mc_addr(struct amdgpu_ring *ring, unsigned vmid);
+static inline uint64_t
+amdgpu_sdma_get_csa_mc_addr(struct amdgpu_ring *ring, unsigned vmid)
+{
+	if (vmid == 0)
+		return 0;
+	else
+		return amdgpu_sdma_get_instance_from_ring(ring)->csa_addr;
+}
+
 int amdgpu_sdma_ras_late_init(struct amdgpu_device *adev,
 			      struct ras_common_if *ras_block);
 int amdgpu_sdma_process_ras_data_cb(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma_types.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma_types.h
index d6e7a703c2e0..61be3d593d18 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma_types.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma_types.h
@@ -73,6 +73,8 @@ struct amdgpu_sdma_instance {
 	    uint32_t		xcc_id;
 	};
 
+	uint64_t		csa_addr;
+
 	struct amdgpu_bo	*sdma_fw_obj;
 	uint64_t		sdma_fw_gpu_addr;
 	uint32_t		*sdma_fw_ptr;
-- 
2.55.0

