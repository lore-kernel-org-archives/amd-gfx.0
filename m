Return-Path: <SRS0=thZ3=2A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9B5C43603
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2019 15:10:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DE5C207FF
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2019 15:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eb+I5EAS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DE5C207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 208F889D67;
	Tue, 10 Dec 2019 15:10:21 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB6DF6E110
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2019 12:53:02 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id q9so3056053wmj.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2019 04:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=38IjIk3BePCjKYW8Qb46Kq9ag6+LzxbR/3yvn7bocuc=;
 b=eb+I5EASVFMoRqD7JtGsAMVONwvQNgklSg/lVsUcmziN7L9FzNPyKLGtH1dzixMuf5
 i95jkksuHx7QChJjc5m2jrVFHMNK5zNia4J8B+b/oAmduZmPNb6X7SOPNq7XUlPNi1Fs
 QMrLWm4RxaQtjMYC5L3D9XU9Cp4BkfI77t8LMtkDic20lYkTlxuZDFi7TSxG5Pt7Zw6y
 oyaTGkGYHtSVpL/hDuB9IY7fq567uWzGigawsqO1/RpL2z65zVWbk1n+Y+1K8oXit9pU
 u9gMlWoR+DBywLWt1gXc9BVm7ntosPbdcHXhSujy9WoOlJqPo7Dri6CUEUeSUQslccqn
 qFxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=38IjIk3BePCjKYW8Qb46Kq9ag6+LzxbR/3yvn7bocuc=;
 b=U5ji9l6lUHY75eXnX+r3Y21vwqGd19LyDE0l52pRBIGVFbcV4Sa98dSMn2I/1M1t39
 3Frw3RA1Na1JlYeGb5Zk+8ZBVlQ5gEwk4DGHM8iQqXnw0IWVlMs8SP9q6TCCf8h7+EZ7
 /JKA/zBETsdas6NB3mqKCBfPCNMthKLVNlBdCVLHcqF8SWIVEGIW8Otxfz9o9SvtyzPD
 VcCPU0zTm4LoamX94UXOyMmdDfdjZb3R3LCDELWwHpWCafu+N4Keyt2jMet3b2IrO1pA
 xazXMU+JGXK32caRsPc/TdQU2WG3rQVxnIx4ZZzva30LN/bUAJqPu/0QPNNN21oCWfOr
 6GvQ==
X-Gm-Message-State: APjAAAV7zQrpsLB4oE3rVDcqOrlWWcrfK84LH14MmwKg/0fHvw5TCr3J
 LKIdHsgkkWvY19iD8mwwX9g=
X-Google-Smtp-Source: APXvYqywBh4RHvmxpgr1/s1Dm/T1gRaF00jY66SXs0lTWDICoISekqSXHfzUYVm96fiqaoVS2TqWVQ==
X-Received: by 2002:a1c:6707:: with SMTP id b7mr5291986wmc.54.1575982381486;
 Tue, 10 Dec 2019 04:53:01 -0800 (PST)
Received: from brihaspati.fritz.box
 (p200300C58F2CCF00F7EF6DD58F2D73FD.dip0.t-ipconnect.de.
 [2003:c5:8f2c:cf00:f7ef:6dd5:8f2d:73fd])
 by smtp.gmail.com with ESMTPSA id a16sm3178589wrt.37.2019.12.10.04.53.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2019 04:53:00 -0800 (PST)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: alexander.deucher@amd.com,
	kenny.ho@amd.com,
	christian.koenig@amd.com
Subject: [PATCH 3/4 v2] amd/amdgpu: add sched array to IPs with multiple
 run-queues
Date: Tue, 10 Dec 2019 13:52:59 +0100
Message-Id: <20191210125300.3800-3-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191210125300.3800-1-nirmoy.das@amd.com>
References: <20191210125300.3800-1-nirmoy.das@amd.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 10 Dec 2019 15:10:18 +0000
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
Cc: nirmoy.das@amd.com, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This sched array can be passed on to entity creation routine
instead of manually creating such sched array on every context creation.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c    | 113 +++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h    |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h   |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h   |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h    |   9 +-
 7 files changed, 89 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 1d6850af9908..165d1a397266 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -74,7 +74,7 @@ static int amdgpu_ctx_init(struct amdgpu_device *adev,
 			   struct amdgpu_ctx *ctx)
 {
 	unsigned num_entities = amdgpu_ctx_total_num_entities();
-	unsigned i, j, k;
+	unsigned i, j;
 	int r;

 	if (priority < 0 || priority >= DRM_SCHED_PRIORITY_MAX)
@@ -121,73 +121,56 @@ static int amdgpu_ctx_init(struct amdgpu_device *adev,
 	ctx->override_priority = DRM_SCHED_PRIORITY_UNSET;

 	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
-		struct amdgpu_ring *rings[AMDGPU_MAX_RINGS];
-		struct drm_gpu_scheduler *sched_list[AMDGPU_MAX_RINGS];
-		unsigned num_rings = 0;
-		unsigned num_rqs = 0;
+		struct drm_gpu_scheduler **scheds;
+		struct drm_gpu_scheduler *sched;
+		unsigned num_scheds = 0;

 		switch (i) {
 		case AMDGPU_HW_IP_GFX:
-			rings[0] = &adev->gfx.gfx_ring[0];
-			num_rings = 1;
+			scheds = adev->gfx.gfx_sched;
+			num_scheds = 1;
 			break;
 		case AMDGPU_HW_IP_COMPUTE:
-			for (j = 0; j < adev->gfx.num_compute_rings; ++j)
-				rings[j] = &adev->gfx.compute_ring[j];
-			num_rings = adev->gfx.num_compute_rings;
+			scheds = adev->gfx.compute_sched;
+			num_scheds = adev->gfx.num_compute_sched;
 			break;
 		case AMDGPU_HW_IP_DMA:
-			for (j = 0; j < adev->sdma.num_instances; ++j)
-				rings[j] = &adev->sdma.instance[j].ring;
-			num_rings = adev->sdma.num_instances;
+			scheds = adev->sdma.sdma_sched;
+			num_scheds = adev->sdma.num_sdma_sched;
 			break;
 		case AMDGPU_HW_IP_UVD:
-			rings[0] = &adev->uvd.inst[0].ring;
-			num_rings = 1;
+			sched = &adev->uvd.inst[0].ring.sched;
+			scheds = &sched;
+			num_scheds = 1;
 			break;
 		case AMDGPU_HW_IP_VCE:
-			rings[0] = &adev->vce.ring[0];
-			num_rings = 1;
+			sched = &adev->vce.ring[0].sched;
+			scheds = &sched;
+			num_scheds = 1;
 			break;
 		case AMDGPU_HW_IP_UVD_ENC:
-			rings[0] = &adev->uvd.inst[0].ring_enc[0];
-			num_rings = 1;
+			sched = &adev->uvd.inst[0].ring_enc[0].sched;
+			scheds = &sched;
+			num_scheds = 1;
 			break;
 		case AMDGPU_HW_IP_VCN_DEC:
-			for (j = 0; j < adev->vcn.num_vcn_inst; ++j) {
-				if (adev->vcn.harvest_config & (1 << j))
-					continue;
-				rings[num_rings++] = &adev->vcn.inst[j].ring_dec;
-			}
+			scheds = adev->vcn.vcn_dec_sched;
+			num_scheds =  adev->vcn.num_vcn_dec_sched;
 			break;
 		case AMDGPU_HW_IP_VCN_ENC:
-			for (j = 0; j < adev->vcn.num_vcn_inst; ++j) {
-				if (adev->vcn.harvest_config & (1 << j))
-					continue;
-				for (k = 0; k < adev->vcn.num_enc_rings; ++k)
-					rings[num_rings++] = &adev->vcn.inst[j].ring_enc[k];
-			}
+			scheds = adev->vcn.vcn_enc_sched;
+			num_scheds =  adev->vcn.num_vcn_enc_sched;
 			break;
 		case AMDGPU_HW_IP_VCN_JPEG:
-			for (j = 0; j < adev->jpeg.num_jpeg_inst; ++j) {
-				if (adev->vcn.harvest_config & (1 << j))
-					continue;
-				rings[num_rings++] = &adev->jpeg.inst[j].ring_dec;
-			}
+			scheds = adev->jpeg.jpeg_sched;
+			num_scheds =  adev->jpeg.num_jpeg_sched;
 			break;
 		}

-		for (j = 0; j < num_rings; ++j) {
-			if (!rings[j]->adev)
-				continue;
-
-			sched_list[num_rqs++] = &rings[j]->sched;
-		}
-
 		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j)
 			r = drm_sched_entity_init(&ctx->entities[i][j].entity,
-						  priority, sched_list,
-						  num_rqs, &ctx->guilty);
+						  priority, scheds,
+						  num_scheds, &ctx->guilty);
 		if (r)
 			goto error_cleanup_entities;
 	}
@@ -631,3 +614,45 @@ void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr)
 	idr_destroy(&mgr->ctx_handles);
 	mutex_destroy(&mgr->lock);
 }
+
+void amdgpu_ctx_init_sched(struct amdgpu_device *adev)
+{
+	int i, j;
+
+	for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
+		adev->gfx.gfx_sched[i] = &adev->gfx.gfx_ring[i].sched;
+		adev->gfx.num_gfx_sched++;
+	}
+
+	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
+		adev->gfx.compute_sched[i] = &adev->gfx.compute_ring[i].sched;
+		adev->gfx.num_compute_sched++;
+	}
+
+	for (i = 0; i < adev->sdma.num_instances; i++) {
+		adev->sdma.sdma_sched[i] = &adev->sdma.instance[i].ring.sched;
+		adev->sdma.num_sdma_sched++;
+	}
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->vcn.harvest_config & (1 << i))
+			continue;
+		adev->vcn.vcn_dec_sched[adev->vcn.num_vcn_dec_sched++] =
+			&adev->vcn.inst[i].ring_dec.sched;
+	}
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->vcn.harvest_config & (1 << i))
+			continue;
+		for (j = 0; j < adev->vcn.num_enc_rings; ++j)
+			adev->vcn.vcn_enc_sched[adev->vcn.num_vcn_enc_sched++] =
+				&adev->vcn.inst[i].ring_enc[j].sched;
+	}
+
+	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
+		if (adev->jpeg.harvest_config & (1 << i))
+			continue;
+		adev->jpeg.jpeg_sched[adev->jpeg.num_jpeg_sched++] =
+			&adev->jpeg.inst[i].ring_dec.sched;
+	}
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
index da808633732b..4ad90a44dc3c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
@@ -87,4 +87,7 @@ void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr);
 long amdgpu_ctx_mgr_entity_flush(struct amdgpu_ctx_mgr *mgr, long timeout);
 void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr);

+void amdgpu_ctx_init_sched(struct amdgpu_device *adev);
+
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index cf4953c4e2cf..c609776b74df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3024,6 +3024,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		goto failed;
 	}

+	amdgpu_ctx_init_sched(adev);
+
 	adev->accel_working = true;

 	amdgpu_vm_check_compute_bug(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 0ae0a2715b0d..8e88e0411662 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -269,8 +269,12 @@ struct amdgpu_gfx {
 	bool				me_fw_write_wait;
 	bool				cp_fw_write_wait;
 	struct amdgpu_ring		gfx_ring[AMDGPU_MAX_GFX_RINGS];
+	struct drm_gpu_scheduler	*gfx_sched[AMDGPU_MAX_GFX_RINGS];
+	uint32_t			num_gfx_sched;
 	unsigned			num_gfx_rings;
 	struct amdgpu_ring		compute_ring[AMDGPU_MAX_COMPUTE_RINGS];
+	struct drm_gpu_scheduler	*compute_sched[AMDGPU_MAX_COMPUTE_RINGS];
+	uint32_t			num_compute_sched;
 	unsigned			num_compute_rings;
 	struct amdgpu_irq_src		eop_irq;
 	struct amdgpu_irq_src		priv_reg_irq;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
index 5131a0a1bc8a..bd9ef9cc86de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
@@ -43,6 +43,8 @@ struct amdgpu_jpeg {
 	uint8_t	num_jpeg_inst;
 	struct amdgpu_jpeg_inst inst[AMDGPU_MAX_JPEG_INSTANCES];
 	struct amdgpu_jpeg_reg internal;
+	struct drm_gpu_scheduler *jpeg_sched[AMDGPU_MAX_JPEG_INSTANCES];
+	uint32_t num_jpeg_sched;
 	unsigned harvest_config;
 	struct delayed_work idle_work;
 	enum amd_powergating_state cur_state;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index b3134655789f..957791673fcd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -52,6 +52,8 @@ struct amdgpu_sdma_instance {

 struct amdgpu_sdma {
 	struct amdgpu_sdma_instance instance[AMDGPU_MAX_SDMA_INSTANCES];
+	struct drm_gpu_scheduler    *sdma_sched[AMDGPU_MAX_SDMA_INSTANCES];
+	uint32_t		    num_sdma_sched;
 	struct amdgpu_irq_src	trap_irq;
 	struct amdgpu_irq_src	illegal_inst_irq;
 	struct amdgpu_irq_src	ecc_irq;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 402a5046b985..3d73dbefcac6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -31,6 +31,7 @@
 #define AMDGPU_VCN_MAX_ENC_RINGS	3

 #define AMDGPU_MAX_VCN_INSTANCES	2
+#define AMDGPU_MAX_VCN_ENC_RINGS  AMDGPU_VCN_MAX_ENC_RINGS * AMDGPU_MAX_VCN_INSTANCES

 #define AMDGPU_VCN_HARVEST_VCN0 (1 << 0)
 #define AMDGPU_VCN_HARVEST_VCN1 (1 << 1)
@@ -186,8 +187,12 @@ struct amdgpu_vcn {
 	uint32_t		*dpg_sram_curr_addr;

 	uint8_t	num_vcn_inst;
-	struct amdgpu_vcn_inst	inst[AMDGPU_MAX_VCN_INSTANCES];
-	struct amdgpu_vcn_reg	internal;
+	struct amdgpu_vcn_inst	 inst[AMDGPU_MAX_VCN_INSTANCES];
+	struct amdgpu_vcn_reg	 internal;
+	struct drm_gpu_scheduler *vcn_enc_sched[AMDGPU_MAX_VCN_ENC_RINGS];
+	struct drm_gpu_scheduler *vcn_dec_sched[AMDGPU_MAX_VCN_INSTANCES];
+	uint32_t		 num_vcn_enc_sched;
+	uint32_t		 num_vcn_dec_sched;

 	unsigned	harvest_config;
 	int (*pause_dpg_mode)(struct amdgpu_device *adev,
--
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
