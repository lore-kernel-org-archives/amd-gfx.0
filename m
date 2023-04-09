Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7305DC77B6E
	for <amd-gfx@archiver.kernel.org>; Sun,  9 Apr 2023 19:02:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9974710E1ED;
	Sun,  9 Apr 2023 19:02:06 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5ACC010E1ED
 for <amd-gfx@lists.freedesktop.org>; Sun,  9 Apr 2023 19:02:05 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-94971337b10so46500766b.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 09 Apr 2023 12:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google; t=1681066921; x=1683658921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9vbRGZzKjUYn3Zx6ww6ERRejqqAxmlmY/HVplNrYcSg=;
 b=ZoX9PJsks97iNOo815ZOJxVXC55FwU+pb0jpn/Wv34W+XakQ/ncfcmnXDcJYppuR23
 W0XtaMUJAH09ZWHrVdPYqxjoM0ovrvRFkag+Rlwa56olENlHzVkIVZwXvx4nULHiAPh+
 OJ8AaMYgFitMWyKgvATyMRt+6x8BfS47PTQoV3Nacd3+h/TvzJ7hDNLKrI08V11CcHCm
 E7UwutmstoqV19laM8ypv8gIemhhaDRHAr/eCGRiwa6+Zy4IOYOoLcUXydmEDAMw//zQ
 nZyEwCbr2ciB6Kcw47oN6xOdUH2BM7t+j+ijFNHmDAUR30UsOhMLowhWeeStvkl7SqEr
 gbUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681066921; x=1683658921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9vbRGZzKjUYn3Zx6ww6ERRejqqAxmlmY/HVplNrYcSg=;
 b=KPWHEZdQ4PN7DqI4YDqwQ/UbzKzM4j714Mr1zZAQEAKmb9NRVfa2JK+mVSTgNMF1VA
 NLqemrVCjesOYC8kgAvyz+fe6iJX0TxcXgS0CDm36gWyKRFI0Niglw59FMw2EAS5W5e5
 edW3GNmMwT9/PbIoYTonBJ3Rtv9dXSzHVlVbF40Pfgi4q38kiSIss7ZOmUAzlfoiTaGM
 FnUu6VrTrdXu717MUMNwrPs+2RoGgKwxDG994VdrsoSR5nza3oI5zYGJNXkyuZBj4eIM
 BV4s2pBJ+DyMEBXuzO8KzBmZbNcYYim7t3kkwDtptAnuQS5x2CzeWCMvYbW4fsK0Q5ve
 dvRg==
X-Gm-Message-State: AAQBX9d+JDlDVhowrl0BLCZsAKUHJzBcRcMe36ripXuk4hc88kR3xH90
 jn5tExROmKOfCVxqlss7KICBvR43op4ljhNmrM5fcQ==
X-Google-Smtp-Source: AKy350a43S0zmOnOS3tCzLxTFE6axqT3ZxA8xGsnVnAnAQp3MIxHu4jN7opjCj1iUAoLt5P9c4QE4Q==
X-Received: by 2002:a17:906:208a:b0:930:aa02:f9cf with SMTP id
 10-20020a170906208a00b00930aa02f9cfmr4684070ejq.2.1681066921516; 
 Sun, 09 Apr 2023 12:02:01 -0700 (PDT)
Received: from bas-workstation.. ([2a02:aa12:a782:cc00::ab])
 by smtp.gmail.com with ESMTPSA id
 xb4-20020a170907070400b0094a71869153sm730693ejb.46.2023.04.09.12.02.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Apr 2023 12:02:00 -0700 (PDT)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 2/3] drm/amdgpu: Simplify amdgpu_hw_ip_info.
Date: Sun,  9 Apr 2023 20:59:55 +0200
Message-Id: <20230409185956.725016-2-bas@basnieuwenhuizen.nl>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230409185956.725016-1-bas@basnieuwenhuizen.nl>
References: <20230409185956.725016-1-bas@basnieuwenhuizen.nl>
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

