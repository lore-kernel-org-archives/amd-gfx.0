Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D33C77B70
	for <amd-gfx@archiver.kernel.org>; Sun,  9 Apr 2023 14:46:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D616410E110;
	Sun,  9 Apr 2023 14:46:55 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2643B10E110
 for <amd-gfx@lists.freedesktop.org>; Sun,  9 Apr 2023 14:46:55 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-94706a972f3so45718866b.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 09 Apr 2023 07:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google; t=1681051611; x=1683643611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9vbRGZzKjUYn3Zx6ww6ERRejqqAxmlmY/HVplNrYcSg=;
 b=Xg1H1yJslQ764DsN9Yy4V7NqSMElscuZ1zrk6e12NR1h2UFlkj3wbI3iMWDrCmbEzF
 hID0+hfRtliqjlZ0+73wt0GohlADTZDmnTChBHrloiZUdzMVACNRxqAkrUdsLP7KqGuB
 vYt0d6SbRaWsOFAxsmWAfl0LhozrdUOm7coA+sNEYK+bnlOwjPQ+dRB2EVLacKuLcDjJ
 OKWXENdZPfqPTopa2e7j+94pyEwljxrjvqvtnUsC1xx3NJ/plE4dbdpLSgfw2eDkFMcU
 AsGX2j6iXZXJhLli3ccerwHYKm5WJGooqo0xKhR5kxtsOF/d745l5X8rOUGQDYa5oxHl
 SURg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681051611; x=1683643611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9vbRGZzKjUYn3Zx6ww6ERRejqqAxmlmY/HVplNrYcSg=;
 b=FqOGcQzOm0KShhM/oJtt0fExSAtpewZKeT/lD5dFjX8+MiTWcRFPv9tr1Wky0NideX
 tbPm3MGkq+kbZkCEPn/PCisAME/MjB5G/JgtcHJwhcFl2c6/nczPXwuBIluCOiTchjGf
 J5cgBwI5eG9UBNFYc6PJZDNr8Ybp20WmXlZ7HMQdFECfKy0c6zcg34bcVNr1JJsrWgr/
 /q+MTYl8Cpp0YnkuLVVNeXgHipGMZP2mWl6rt7ofzx+XuP+jPylCWRyiA8FWbfgv51tX
 OYho8oatY0652vU0pbsrceQnCFtDLRVaaSqQL0WZwPpTFZkMPI80c4jepAalwyF9PsJ9
 1Jvw==
X-Gm-Message-State: AAQBX9e7pRvyUEVcuF417f1RzkL9Lxnp6S4E83bJ6U0DcRI4w5etfnjp
 ShV6JMm5FPtCcQDksQ+igmRoxdHOsyVHFcQd17S2DA==
X-Google-Smtp-Source: AKy350aTIoLoUOvpBOwgvghEsDjy1k37SxXvJDaoAvC5kIVtOk5XWyNKOtqJSq/dYSiPPPuCFEEPmg==
X-Received: by 2002:a17:906:74cc:b0:933:23c4:820b with SMTP id
 z12-20020a17090674cc00b0093323c4820bmr4464675ejl.4.1681051611282; 
 Sun, 09 Apr 2023 07:46:51 -0700 (PDT)
Received: from bas-workstation.. ([2a02:aa12:a782:cc00::ab])
 by smtp.gmail.com with ESMTPSA id
 xj5-20020a170906db0500b00924d38bbdc0sm4155587ejb.105.2023.04.09.07.46.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Apr 2023 07:46:50 -0700 (PDT)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amdgpu: Simplify amdgpu_hw_ip_info.
Date: Sun,  9 Apr 2023 16:44:44 +0200
Message-Id: <20230409144445.374816-2-bas@basnieuwenhuizen.nl>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230409144445.374816-1-bas@basnieuwenhuizen.nl>
References: <20230409144445.374816-1-bas@basnieuwenhuizen.nl>
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
Cc: alexander.deucher@amd.com, Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 christian.koenig@amd.com, maraeo@gmail.com, timur.kristof@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We have a list of all rings, so no sense writing the same loop N
times. With how often this gets called and how small the ring list
is the performance of this shouldn't matter.

Note that some of the loops included some checking wrt harvesting.
That is redundant now, as those rings never get initialized and
hence never added to the adev->rings array.

Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 61 ++++++-------------------
 1 file changed, 15 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 0efb38539d70..89689b940493 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -366,7 +366,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 	uint32_t ib_size_alignment = 0;
 	enum amd_ip_block_type type;
 	unsigned int num_rings = 0;
-	unsigned int i, j;
+	unsigned int i;
 
 	if (info->query_hw_ip.ip_instance >= AMDGPU_HW_IP_INSTANCE_MAX_COUNT)
 		return -EINVAL;
@@ -374,83 +374,49 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 	switch (info->query_hw_ip.type) {
 	case AMDGPU_HW_IP_GFX:
 		type = AMD_IP_BLOCK_TYPE_GFX;
-		for (i = 0; i < adev->gfx.num_gfx_rings; i++)
-			if (adev->gfx.gfx_ring[i].sched.ready)
-				++num_rings;
+
 		ib_start_alignment = 32;
 		ib_size_alignment = 32;
 		break;
 	case AMDGPU_HW_IP_COMPUTE:
 		type = AMD_IP_BLOCK_TYPE_GFX;
-		for (i = 0; i < adev->gfx.num_compute_rings; i++)
-			if (adev->gfx.compute_ring[i].sched.ready)
-				++num_rings;
+
 		ib_start_alignment = 32;
 		ib_size_alignment = 32;
 		break;
 	case AMDGPU_HW_IP_DMA:
 		type = AMD_IP_BLOCK_TYPE_SDMA;
-		for (i = 0; i < adev->sdma.num_instances; i++)
-			if (adev->sdma.instance[i].ring.sched.ready)
-				++num_rings;
+
 		ib_start_alignment = 256;
 		ib_size_alignment = 4;
 		break;
 	case AMDGPU_HW_IP_UVD:
 		type = AMD_IP_BLOCK_TYPE_UVD;
-		for (i = 0; i < adev->uvd.num_uvd_inst; i++) {
-			if (adev->uvd.harvest_config & (1 << i))
-				continue;
 
-			if (adev->uvd.inst[i].ring.sched.ready)
-				++num_rings;
-		}
 		ib_start_alignment = 64;
 		ib_size_alignment = 64;
 		break;
 	case AMDGPU_HW_IP_VCE:
 		type = AMD_IP_BLOCK_TYPE_VCE;
-		for (i = 0; i < adev->vce.num_rings; i++)
-			if (adev->vce.ring[i].sched.ready)
-				++num_rings;
+
 		ib_start_alignment = 4;
 		ib_size_alignment = 1;
 		break;
 	case AMDGPU_HW_IP_UVD_ENC:
 		type = AMD_IP_BLOCK_TYPE_UVD;
-		for (i = 0; i < adev->uvd.num_uvd_inst; i++) {
-			if (adev->uvd.harvest_config & (1 << i))
-				continue;
 
-			for (j = 0; j < adev->uvd.num_enc_rings; j++)
-				if (adev->uvd.inst[i].ring_enc[j].sched.ready)
-					++num_rings;
-		}
 		ib_start_alignment = 64;
 		ib_size_alignment = 64;
 		break;
 	case AMDGPU_HW_IP_VCN_DEC:
 		type = AMD_IP_BLOCK_TYPE_VCN;
-		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-			if (adev->vcn.harvest_config & (1 << i))
-				continue;
 
-			if (adev->vcn.inst[i].ring_dec.sched.ready)
-				++num_rings;
-		}
 		ib_start_alignment = 16;
 		ib_size_alignment = 16;
 		break;
 	case AMDGPU_HW_IP_VCN_ENC:
 		type = AMD_IP_BLOCK_TYPE_VCN;
-		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-			if (adev->vcn.harvest_config & (1 << i))
-				continue;
 
-			for (j = 0; j < adev->vcn.num_enc_rings; j++)
-				if (adev->vcn.inst[i].ring_enc[j].sched.ready)
-					++num_rings;
-		}
 		ib_start_alignment = 64;
 		ib_size_alignment = 1;
 		break;
@@ -458,13 +424,6 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 		type = (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_JPEG)) ?
 			AMD_IP_BLOCK_TYPE_JPEG : AMD_IP_BLOCK_TYPE_VCN;
 
-		for (i = 0; i < adev->jpeg.num_jpeg_inst; i++) {
-			if (adev->jpeg.harvest_config & (1 << i))
-				continue;
-
-			if (adev->jpeg.inst[i].ring_dec.sched.ready)
-				++num_rings;
-		}
 		ib_start_alignment = 16;
 		ib_size_alignment = 16;
 		break;
@@ -472,6 +431,16 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 		return -EINVAL;
 	}
 
+	for (i = 0; i < adev->num_rings; ++i) {
+		/* Note that this uses that ring types alias the equivalent
+		 * HW IP exposes to userspace.
+		 */
+		if (adev->rings[i]->funcs->type == info->query_hw_ip.type &&
+		    adev->rings[i]->sched.ready) {
+			++num_rings;
+		}
+	}
+
 	for (i = 0; i < adev->num_ip_blocks; i++)
 		if (adev->ip_blocks[i].version->type == type &&
 		    adev->ip_blocks[i].status.valid)
-- 
2.40.0

