Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 480C5C79FB9
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2026 10:52:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80A9F10F0B9;
	Wed,  9 Sep 2026 10:52:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="pFuEJG1D";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB67E10F0B9
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Sep 2026 10:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=HaU0W9K+BSseFQjRxTy9ilMm2PsrR0IFz2rJvhlT1p4=; b=pFuEJG1DoyzC3pd/IFk4r3EhUp
 yC7z1/vAyUW/eYg49hkW602q1JG4r3yVYUk/0l38jHwX3na3Za8hpTfCPQxveefpDqVdTCHtzCfXz
 oT5AfxfhrIPdYFn1oSdpes3RPlgvX8lymtJ7B3XggaX1aF1CUAFG5PUtV1MWAg0RTWmGXIzU14w6x
 ddQ4+pf7Jqb89tjeN3JrmN7BA685RW4hb7f8KiqH1RkMxEOwDK8SNVAO1xyb8JdJgJCBXwrE+v9bv
 hKphdOqQz2a4CRRHpkokNVKXHlHbiQdNuzGLdtgTSExTh8y1VP9k/Xzztm/aX8p4ayDSkOMQ928bO
 Zv173gAA==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1x4Fug-00Gyk9-Pc; Wed, 09 Sep 2026 12:52:22 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 4/6] drm/amdgpu: Cache the SDMA CSA address
Date: Wed,  9 Sep 2026 11:52:13 +0100
Message-ID: <20260909105215.88242-5-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909105215.88242-1-tvrtko.ursulin@igalia.com>
References: <20260909105215.88242-1-tvrtko.ursulin@igalia.com>
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c      | 23 ++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h      | 10 +++++++-
 .../gpu/drm/amd/amdgpu/amdgpu_sdma_types.h    |  2 ++
 3 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 68a92ce49ac2..687e9863f11f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -40,6 +40,7 @@
 int amdgpu_sdma_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 			  const char *prefix, unsigned int index)
 {
+	struct amdgpu_sdma_instance *sdma;
 	int r;
 
 	ring->ring_obj = NULL;
@@ -53,23 +54,17 @@ int amdgpu_sdma_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 	if (r)
 		return r;
 
-	return 0;
-}
-
-uint64_t amdgpu_sdma_get_csa_mc_addr(struct amdgpu_ring *ring,
-				     unsigned int vmid)
-{
-	struct amdgpu_device *adev = ring->adev;
+	sdma = amdgpu_sdma_get_instance_from_ring(ring);
 
 	/* don't enable OS preemption on SDMA under SRIOV */
-	if (amdgpu_sriov_vf(adev) || vmid == 0 || !adev->gfx.mcbp)
-		return 0;
+	if (amdgpu_sriov_vf(adev) || !adev->gfx.mcbp)
+		sdma->csa_addr = 0;
+	else
+		sdma->csa_addr = amdgpu_csa_vaddr(adev) +
+				 AMDGPU_CSA_SDMA_OFFSET +
+				 ring->me * AMDGPU_CSA_SDMA_SIZE;
 
-	if (ring->me > 31)
-		return 0;
-
-	return amdgpu_csa_vaddr(adev) + AMDGPU_CSA_SDMA_OFFSET +
-	       ring->me * AMDGPU_CSA_SDMA_SIZE;
+	return 0;
 }
 
 int amdgpu_sdma_ras_late_init(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 14c67e46515f..0142edba7817 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -54,7 +54,15 @@ amdgpu_sdma_get_instance_from_ring(struct amdgpu_ring *ring)
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

