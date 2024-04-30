Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 109AEC4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 17:27:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F583112D66;
	Tue, 30 Apr 2024 17:27:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Ustg2iBE";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A35D5112D66
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 17:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=PABhWfAXx1TLyoTKhGoE1IMqnSV0LiP9mbNMP0eO5I0=; b=Ustg2iBECBU0PkDNIOPfb6Tbai
 qKYHXSPYeWibvw3DSuux6OdfO61pmOAtO3NHD8eUFTmBIPzfo/LXm9DVMVMZNqRmU94Gwvlxi0nmI
 mflArA20922Rq0/yfEZrbe627lL/EI2m2Dy03XcXN8bB/i3X1sfRtmmBoI1/WMaMg9kg7lppYCo9Y
 x+X7ialkNiuaIlWbLx1jdpz9FcpeVfh3vPA5w54O0QI70w7K6u9hgko+t8mdM9UPubmXcz99QZRRb
 psaqvB8MawLzOBRKIvLfYZyQb6SLup/Majtj+VwmjhoK5G07Cn+u/0lbenxlI5WR5hzgw2Wt4NgQd
 B8Xpw6jg==;
Received: from [84.65.0.132] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1s1rGk-001sRW-42; Tue, 30 Apr 2024 19:27:53 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [RFC 2/5] drm/amdgpu: Use cached number of rings from the
 AMDGPU_INFO_HW_IP_INFO ioctl
Date: Tue, 30 Apr 2024 18:27:45 +0100
Message-ID: <20240430172748.61576-3-tursulin@igalia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430172748.61576-1-tursulin@igalia.com>
References: <20240430172748.61576-1-tursulin@igalia.com>
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

From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Now that we keep a cached value it is no longer required to walk the
arrays and check the fuses.

Open however is whether at runtime this query is supposed to report if a
ring has disappeared due for example amdgpu_ib_ring_tests() turning it
off.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 62 +++----------------------
 1 file changed, 6 insertions(+), 56 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index a0ea6fe8d060..b6f411c0801a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -376,114 +376,64 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 	uint32_t ib_start_alignment = 0;
 	uint32_t ib_size_alignment = 0;
 	enum amd_ip_block_type type;
-	unsigned int num_rings = 0;
-	unsigned int i, j;
+	unsigned int num_rings;
+	unsigned int i;
 
 	if (info->query_hw_ip.ip_instance >= AMDGPU_HW_IP_INSTANCE_MAX_COUNT)
 		return -EINVAL;
 
+	if (info->query_hw_ip.type >= ARRAY_SIZE(adev->num_ip_rings))
+		return -EINVAL;
+
 	switch (info->query_hw_ip.type) {
 	case AMDGPU_HW_IP_GFX:
 		type = AMD_IP_BLOCK_TYPE_GFX;
-		for (i = 0; i < adev->gfx.num_gfx_rings; i++)
-			if (adev->gfx.gfx_ring[i].sched.ready)
-				++num_rings;
 		ib_start_alignment = 32;
 		ib_size_alignment = 32;
 		break;
 	case AMDGPU_HW_IP_COMPUTE:
 		type = AMD_IP_BLOCK_TYPE_GFX;
-		for (i = 0; i < adev->gfx.num_compute_rings; i++)
-			if (adev->gfx.compute_ring[i].sched.ready)
-				++num_rings;
 		ib_start_alignment = 32;
 		ib_size_alignment = 32;
 		break;
 	case AMDGPU_HW_IP_DMA:
 		type = AMD_IP_BLOCK_TYPE_SDMA;
-		for (i = 0; i < adev->sdma.num_instances; i++)
-			if (adev->sdma.instance[i].ring.sched.ready)
-				++num_rings;
 		ib_start_alignment = 256;
 		ib_size_alignment = 4;
 		break;
 	case AMDGPU_HW_IP_UVD:
 		type = AMD_IP_BLOCK_TYPE_UVD;
-		for (i = 0; i < adev->uvd.num_uvd_inst; i++) {
-			if (adev->uvd.harvest_config & (1 << i))
-				continue;
-
-			if (adev->uvd.inst[i].ring.sched.ready)
-				++num_rings;
-		}
 		ib_start_alignment = 256;
 		ib_size_alignment = 64;
 		break;
 	case AMDGPU_HW_IP_VCE:
 		type = AMD_IP_BLOCK_TYPE_VCE;
-		for (i = 0; i < adev->vce.num_rings; i++)
-			if (adev->vce.ring[i].sched.ready)
-				++num_rings;
 		ib_start_alignment = 256;
 		ib_size_alignment = 4;
 		break;
 	case AMDGPU_HW_IP_UVD_ENC:
 		type = AMD_IP_BLOCK_TYPE_UVD;
-		for (i = 0; i < adev->uvd.num_uvd_inst; i++) {
-			if (adev->uvd.harvest_config & (1 << i))
-				continue;
-
-			for (j = 0; j < adev->uvd.num_enc_rings; j++)
-				if (adev->uvd.inst[i].ring_enc[j].sched.ready)
-					++num_rings;
-		}
 		ib_start_alignment = 256;
 		ib_size_alignment = 4;
 		break;
 	case AMDGPU_HW_IP_VCN_DEC:
 		type = AMD_IP_BLOCK_TYPE_VCN;
-		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-			if (adev->vcn.harvest_config & (1 << i))
-				continue;
-
-			if (adev->vcn.inst[i].ring_dec.sched.ready)
-				++num_rings;
-		}
 		ib_start_alignment = 256;
 		ib_size_alignment = 64;
 		break;
 	case AMDGPU_HW_IP_VCN_ENC:
 		type = AMD_IP_BLOCK_TYPE_VCN;
-		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-			if (adev->vcn.harvest_config & (1 << i))
-				continue;
-
-			for (j = 0; j < adev->vcn.num_enc_rings; j++)
-				if (adev->vcn.inst[i].ring_enc[j].sched.ready)
-					++num_rings;
-		}
 		ib_start_alignment = 256;
 		ib_size_alignment = 4;
 		break;
 	case AMDGPU_HW_IP_VCN_JPEG:
 		type = (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_JPEG)) ?
 			AMD_IP_BLOCK_TYPE_JPEG : AMD_IP_BLOCK_TYPE_VCN;
-
-		for (i = 0; i < adev->jpeg.num_jpeg_inst; i++) {
-			if (adev->jpeg.harvest_config & (1 << i))
-				continue;
-
-			for (j = 0; j < adev->jpeg.num_jpeg_rings; j++)
-				if (adev->jpeg.inst[i].ring_dec[j].sched.ready)
-					++num_rings;
-		}
 		ib_start_alignment = 256;
 		ib_size_alignment = 64;
 		break;
 	case AMDGPU_HW_IP_VPE:
 		type = AMD_IP_BLOCK_TYPE_VPE;
-		if (adev->vpe.ring.sched.ready)
-			++num_rings;
 		ib_start_alignment = 256;
 		ib_size_alignment = 4;
 		break;
@@ -500,7 +450,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 		return 0;
 
 	num_rings = min(amdgpu_ctx_num_entities[info->query_hw_ip.type],
-			num_rings);
+			adev->num_ip_rings[info->query_hw_ip.type]);
 
 	result->hw_ip_version_major = adev->ip_blocks[i].version->major;
 	result->hw_ip_version_minor = adev->ip_blocks[i].version->minor;
-- 
2.44.0

