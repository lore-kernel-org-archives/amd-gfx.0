Return-Path: <SRS0=uap9=5Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2193C43331
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2020 13:54:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76B8D20784
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2020 13:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sgzfBvnZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76B8D20784
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 393D26E837;
	Tue, 31 Mar 2020 13:54:49 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EC886E842
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2020 13:54:47 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id z14so2129375wmf.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2020 06:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pomWPEJBIQ/wTyj/YqKb09kZIKVgFKXSNRkUfajwqVY=;
 b=sgzfBvnZ4jDlp9DJcPefaIpEqahnTKvgoXC4+Qa/P474vvIRldiua6A5OR27q9lLek
 xzzzioA90JKdKjE54bELZahIm7WaFTKUJcJ/V5X0R10s94/BOIeXc34omRtdCxGo6zxk
 oaO0A9rMAEK8m+ZNHgPvAUYGUWRxPQwyXz3tl0AQCiENllvVvHxVFumeknDxnEN/klUf
 e9kYr6ZIY8dPSFPcIaeBQL+XK3dsLT81mOzuliqHokghkXGd0AR5vllSAwadMNw1zSbM
 8rxOdzTziAVLslyRJ6kd2Yz2/qnAVAnfsN35/MaVtQcqd4tfwfd+QOkeNx6ElfcMpFcM
 YpRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pomWPEJBIQ/wTyj/YqKb09kZIKVgFKXSNRkUfajwqVY=;
 b=tbRzLRyU4AOUGugRa69rTLy48nkqVY8UyaCCXiAbDIWTvMsCUbb3qjWpkWz0Nj/1gO
 bLvvoXM2kITjZ4ZD8pZxVJ3HCXsHUvsiBGGjjNTKhwHWmrb/cd4C8rKrTb0DKkbBh6vu
 RAgORBjnr3YEL248NXHdDft0AuUSV6+muQtb9J9mZk4ZrHrSrh+pxIXw9PYHAmmdnFf5
 QCA1JMRA+rYRcABUvqiz8yT8cp2Mo5A718gi2GOYdc5rRTq/2HHt68+teioXYEkmh2Pt
 SVG7BgAHne9h3kTw7GwnEF/dD9lZvgCdon+pej6gGzMr/AlOOkvPox0T+OpF9Hm1bC0C
 bIYA==
X-Gm-Message-State: ANhLgQ1aIqfWrTCLhlryYoTKYA/P/fX8qLepQ2QbbTDWiaoZWNI/VhsX
 XG98ECITjIrKazajoRB7KtHwFk/L
X-Google-Smtp-Source: ADFU+vuJyCmzulSqFi+btFRZzEbo3pVlJPmRdbJkm/LMfeamDVorkEZLSgcoIB8Vuz/TP04KFTPBgg==
X-Received: by 2002:a1c:2c85:: with SMTP id s127mr3625554wms.18.1585662884759; 
 Tue, 31 Mar 2020 06:54:44 -0700 (PDT)
Received: from brihaspati.fritz.box
 (p200300C58F2E74000298C664B0CADE76.dip0.t-ipconnect.de.
 [2003:c5:8f2e:7400:298:c664:b0ca:de76])
 by smtp.gmail.com with ESMTPSA id p10sm27415546wrm.6.2020.03.31.06.54.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2020 06:54:44 -0700 (PDT)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v5 2/2] drm/amdgpu: rework sched_list generation
Date: Tue, 31 Mar 2020 15:59:05 +0200
Message-Id: <20200331135905.13045-2-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200331135905.13045-1-nirmoy.das@amd.com>
References: <20200331135905.13045-1-nirmoy.das@amd.com>
MIME-Version: 1.0
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
Cc: alexander.deucher@amd.com, ray.huang@amd.com, nirmoy.das@amd.com,
 christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Generate HW IP's sched_list in amdgpu_ring_init() instead of
amdgpu_ctx.c. This makes amdgpu_ctx_init_compute_sched(),
ring.has_high_prio and amdgpu_ctx_init_sched() unnecessary.
This patch also stores sched_list for all HW IPs in one big
array in struct amdgpu_device which makes amdgpu_ctx_init_entity()
much more leaner.

v2:
fix a coding style issue
do not use drm hw_ip const to populate amdgpu_ring_type enum

v3:
remove ctx reference and move sched array and num_sched to a struct
use num_scheds to detect uninitialized scheduler list

v4:
use array_index_nospec for user space controlled variables
fix possible checkpatch.pl warnings

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c    | 160 +++++----------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h    |   3 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |   5 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h   |   2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c   |  14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |  14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h   |   2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h    |   4 -
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c      |   3 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     |  14 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c      |   7 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c      |   7 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c      |  11 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      |  13 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c     |   3 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c     |   3 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c     |   3 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c     |   3 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c     |   3 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c     |   6 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c     |   3 +-
 drivers/gpu/drm/amd/amdgpu/si_dma.c        |   3 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c      |   3 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c      |   3 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c      |   7 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c      |   8 +-
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c      |   3 +-
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c      |   3 +-
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c      |   3 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c      |   6 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c      |   6 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c      |   7 +-
 35 files changed, 144 insertions(+), 197 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 29f0a410091b..32bc2a882fd2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -858,6 +858,7 @@ struct amdgpu_device {
 	struct amdgpu_ring		*rings[AMDGPU_MAX_RINGS];
 	bool				ib_pool_ready;
 	struct amdgpu_sa_manager	ring_tmp_bo[AMDGPU_IB_POOL_MAX];
+	struct amdgpu_sched		gpu_sched[AMDGPU_HW_IP_NUM][AMDGPU_RING_PRIO_MAX];

 	/* interrupts */
 	struct amdgpu_irq		irq;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 6ed36a2c5f73..8842c55d4490 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -26,6 +26,7 @@
 #include "amdgpu.h"
 #include "amdgpu_sched.h"
 #include "amdgpu_ras.h"
+#include <linux/nospec.h>

 #define to_amdgpu_ctx_entity(e)	\
 	container_of((e), struct amdgpu_ctx_entity, entity)
@@ -72,13 +73,30 @@ static enum gfx_pipe_priority amdgpu_ctx_sched_prio_to_compute_prio(enum drm_sch
 	}
 }

-static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, const u32 hw_ip, const u32 ring)
+static unsigned int amdgpu_ctx_prio_sched_to_hw(struct amdgpu_device *adev,
+						 enum drm_sched_priority prio,
+						 u32 hw_ip)
+{
+	unsigned int hw_prio;
+
+	hw_prio = (hw_ip == AMDGPU_HW_IP_COMPUTE) ?
+			amdgpu_ctx_sched_prio_to_compute_prio(prio) :
+			AMDGPU_RING_PRIO_DEFAULT;
+	hw_ip = array_index_nospec(hw_ip, AMDGPU_HW_IP_NUM);
+	if (adev->gpu_sched[hw_ip][hw_prio].num_scheds == 0)
+		hw_prio = AMDGPU_RING_PRIO_DEFAULT;
+
+	return hw_prio;
+}
+
+static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
+				   const u32 ring)
 {
 	struct amdgpu_device *adev = ctx->adev;
 	struct amdgpu_ctx_entity *entity;
 	struct drm_gpu_scheduler **scheds = NULL, *sched = NULL;
 	unsigned num_scheds = 0;
-	enum gfx_pipe_priority hw_prio;
+	unsigned int hw_prio;
 	enum drm_sched_priority priority;
 	int r;

@@ -90,52 +108,16 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, const u32 hw_ip, const
 	entity->sequence = 1;
 	priority = (ctx->override_priority == DRM_SCHED_PRIORITY_UNSET) ?
 				ctx->init_priority : ctx->override_priority;
-	switch (hw_ip) {
-	case AMDGPU_HW_IP_GFX:
-		sched = &adev->gfx.gfx_ring[0].sched;
-		scheds = &sched;
-		num_scheds = 1;
-		break;
-	case AMDGPU_HW_IP_COMPUTE:
-		hw_prio = amdgpu_ctx_sched_prio_to_compute_prio(priority);
-		scheds = adev->gfx.compute_prio_sched[hw_prio];
-		num_scheds = adev->gfx.num_compute_sched[hw_prio];
-		break;
-	case AMDGPU_HW_IP_DMA:
-		scheds = adev->sdma.sdma_sched;
-		num_scheds = adev->sdma.num_sdma_sched;
-		break;
-	case AMDGPU_HW_IP_UVD:
-		sched = &adev->uvd.inst[0].ring.sched;
-		scheds = &sched;
-		num_scheds = 1;
-		break;
-	case AMDGPU_HW_IP_VCE:
-		sched = &adev->vce.ring[0].sched;
-		scheds = &sched;
-		num_scheds = 1;
-		break;
-	case AMDGPU_HW_IP_UVD_ENC:
-		sched = &adev->uvd.inst[0].ring_enc[0].sched;
-		scheds = &sched;
-		num_scheds = 1;
-		break;
-	case AMDGPU_HW_IP_VCN_DEC:
-		sched = drm_sched_pick_best(adev->vcn.vcn_dec_sched,
-					    adev->vcn.num_vcn_dec_sched);
-		scheds = &sched;
-		num_scheds = 1;
-		break;
-	case AMDGPU_HW_IP_VCN_ENC:
-		sched = drm_sched_pick_best(adev->vcn.vcn_enc_sched,
-					    adev->vcn.num_vcn_enc_sched);
+	hw_prio = amdgpu_ctx_prio_sched_to_hw(adev, priority, hw_ip);
+
+	hw_ip = array_index_nospec(hw_ip, AMDGPU_HW_IP_NUM);
+	scheds = adev->gpu_sched[hw_ip][hw_prio].sched;
+	num_scheds = adev->gpu_sched[hw_ip][hw_prio].num_scheds;
+
+	if (hw_ip == AMDGPU_HW_IP_VCN_ENC || hw_ip == AMDGPU_HW_IP_VCN_DEC) {
+		sched = drm_sched_pick_best(scheds, num_scheds);
 		scheds = &sched;
 		num_scheds = 1;
-		break;
-	case AMDGPU_HW_IP_VCN_JPEG:
-		scheds = adev->jpeg.jpeg_sched;
-		num_scheds =  adev->jpeg.num_jpeg_sched;
-		break;
 	}

 	r = drm_sched_entity_init(&entity->entity, priority, scheds, num_scheds,
@@ -178,7 +160,6 @@ static int amdgpu_ctx_init(struct amdgpu_device *adev,
 	ctx->override_priority = DRM_SCHED_PRIORITY_UNSET;

 	return 0;
-
 }

 static void amdgpu_ctx_fini_entity(struct amdgpu_ctx_entity *entity)
@@ -525,7 +506,7 @@ static void amdgpu_ctx_set_entity_priority(struct amdgpu_ctx *ctx,
 					    enum drm_sched_priority priority)
 {
 	struct amdgpu_device *adev = ctx->adev;
-	enum gfx_pipe_priority hw_prio;
+	unsigned int hw_prio;
 	struct drm_gpu_scheduler **scheds = NULL;
 	unsigned num_scheds;

@@ -534,9 +515,11 @@ static void amdgpu_ctx_set_entity_priority(struct amdgpu_ctx *ctx,

 	/* set hw priority */
 	if (hw_ip == AMDGPU_HW_IP_COMPUTE) {
-		hw_prio = amdgpu_ctx_sched_prio_to_compute_prio(priority);
-		scheds = adev->gfx.compute_prio_sched[hw_prio];
-		num_scheds = adev->gfx.num_compute_sched[hw_prio];
+		hw_prio = amdgpu_ctx_prio_sched_to_hw(adev, priority,
+						      AMDGPU_HW_IP_COMPUTE);
+		hw_prio = array_index_nospec(hw_prio, AMDGPU_RING_PRIO_MAX);
+		scheds = adev->gpu_sched[hw_ip][hw_prio].sched;
+		num_scheds = adev->gpu_sched[hw_ip][hw_prio].num_scheds;
 		drm_sched_entity_modify_sched(&aentity->entity, scheds,
 					      num_scheds);
 	}
@@ -665,78 +648,3 @@ void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr)
 	idr_destroy(&mgr->ctx_handles);
 	mutex_destroy(&mgr->lock);
 }
-
-
-static void amdgpu_ctx_init_compute_sched(struct amdgpu_device *adev)
-{
-	int num_compute_sched_normal = 0;
-	int num_compute_sched_high = AMDGPU_MAX_COMPUTE_RINGS - 1;
-	int i;
-
-	/* use one drm sched array, gfx.compute_sched to store both high and
-	 * normal priority drm compute schedulers */
-	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
-		if (!adev->gfx.compute_ring[i].has_high_prio)
-			adev->gfx.compute_sched[num_compute_sched_normal++] =
-				&adev->gfx.compute_ring[i].sched;
-		else
-			adev->gfx.compute_sched[num_compute_sched_high--] =
-				&adev->gfx.compute_ring[i].sched;
-	}
-
-	/* compute ring only has two priority for now */
-	i = AMDGPU_GFX_PIPE_PRIO_NORMAL;
-	adev->gfx.compute_prio_sched[i] = &adev->gfx.compute_sched[0];
-	adev->gfx.num_compute_sched[i] = num_compute_sched_normal;
-
-	i = AMDGPU_GFX_PIPE_PRIO_HIGH;
-	if (num_compute_sched_high == (AMDGPU_MAX_COMPUTE_RINGS - 1)) {
-		/* When compute has no high priority rings then use */
-		/* normal priority sched array */
-		adev->gfx.compute_prio_sched[i] = &adev->gfx.compute_sched[0];
-		adev->gfx.num_compute_sched[i] = num_compute_sched_normal;
-	} else {
-		adev->gfx.compute_prio_sched[i] =
-			&adev->gfx.compute_sched[num_compute_sched_high - 1];
-		adev->gfx.num_compute_sched[i] =
-			adev->gfx.num_compute_rings - num_compute_sched_normal;
-	}
-}
-
-void amdgpu_ctx_init_sched(struct amdgpu_device *adev)
-{
-	int i, j;
-
-	amdgpu_ctx_init_compute_sched(adev);
-	for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
-		adev->gfx.gfx_sched[i] = &adev->gfx.gfx_ring[i].sched;
-		adev->gfx.num_gfx_sched++;
-	}
-
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		adev->sdma.sdma_sched[i] = &adev->sdma.instance[i].ring.sched;
-		adev->sdma.num_sdma_sched++;
-	}
-
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
-		adev->vcn.vcn_dec_sched[adev->vcn.num_vcn_dec_sched++] =
-			&adev->vcn.inst[i].ring_dec.sched;
-	}
-
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
-		for (j = 0; j < adev->vcn.num_enc_rings; ++j)
-			adev->vcn.vcn_enc_sched[adev->vcn.num_vcn_enc_sched++] =
-				&adev->vcn.inst[i].ring_enc[j].sched;
-	}
-
-	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
-		if (adev->jpeg.harvest_config & (1 << i))
-			continue;
-		adev->jpeg.jpeg_sched[adev->jpeg.num_jpeg_sched++] =
-			&adev->jpeg.inst[i].ring_dec.sched;
-	}
-}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
index de490f183af2..f54e10314661 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
@@ -88,7 +88,4 @@ void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr);
 long amdgpu_ctx_mgr_entity_flush(struct amdgpu_ctx_mgr *mgr, long timeout);
 void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr);

-void amdgpu_ctx_init_sched(struct amdgpu_device *adev);
-
-
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 8faaa17ac296..d94eff9886a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3212,8 +3212,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 			adev->gfx.config.max_cu_per_sh,
 			adev->gfx.cu_info.number);

-	amdgpu_ctx_init_sched(adev);
-
 	adev->accel_working = true;

 	amdgpu_vm_check_compute_bug(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 6b9c9193cdfa..92f2e59056c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -320,7 +320,8 @@ int amdgpu_gfx_kiq_init_ring(struct amdgpu_device *adev,
 	ring->eop_gpu_addr = kiq->eop_gpu_addr;
 	sprintf(ring->name, "kiq_%d.%d.%d", ring->me, ring->pipe, ring->queue);
 	r = amdgpu_ring_init(adev, ring, 1024,
-			     irq, AMDGPU_CP_KIQ_IRQ_DRIVER0);
+			     irq, AMDGPU_CP_KIQ_IRQ_DRIVER0,
+			     AMDGPU_RING_PRIO_DEFAULT);
 	if (r)
 		dev_warn(adev->dev, "(%d) failed to init kiq ring\n", r);

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 5825692d07e4..634746829024 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -286,13 +286,8 @@ struct amdgpu_gfx {
 	bool				me_fw_write_wait;
 	bool				cp_fw_write_wait;
 	struct amdgpu_ring		gfx_ring[AMDGPU_MAX_GFX_RINGS];
-	struct drm_gpu_scheduler	*gfx_sched[AMDGPU_MAX_GFX_RINGS];
-	uint32_t			num_gfx_sched;
 	unsigned			num_gfx_rings;
 	struct amdgpu_ring		compute_ring[AMDGPU_MAX_COMPUTE_RINGS];
-	struct drm_gpu_scheduler        **compute_prio_sched[AMDGPU_GFX_PIPE_PRIO_MAX];
-	struct drm_gpu_scheduler	*compute_sched[AMDGPU_MAX_COMPUTE_RINGS];
-	uint32_t                        num_compute_sched[AMDGPU_GFX_PIPE_PRIO_MAX];
 	unsigned			num_compute_rings;
 	struct amdgpu_irq_src		eop_irq;
 	struct amdgpu_irq_src		priv_reg_irq;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
index bd9ef9cc86de..5131a0a1bc8a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
@@ -43,8 +43,6 @@ struct amdgpu_jpeg {
 	uint8_t	num_jpeg_inst;
 	struct amdgpu_jpeg_inst inst[AMDGPU_MAX_JPEG_INSTANCES];
 	struct amdgpu_jpeg_reg internal;
-	struct drm_gpu_scheduler *jpeg_sched[AMDGPU_MAX_JPEG_INSTANCES];
-	uint32_t num_jpeg_sched;
 	unsigned harvest_config;
 	struct delayed_work idle_work;
 	enum amd_powergating_state cur_state;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index a7e1d0425ed0..5f36bd58202a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -162,11 +162,13 @@ void amdgpu_ring_undo(struct amdgpu_ring *ring)
  * Returns 0 on success, error on failure.
  */
 int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
-		     unsigned max_dw, struct amdgpu_irq_src *irq_src,
-		     unsigned irq_type)
+		     unsigned int max_dw, struct amdgpu_irq_src *irq_src,
+		     unsigned int irq_type, unsigned int hw_prio)
 {
 	int r, i;
 	int sched_hw_submission = amdgpu_sched_hw_submission;
+	u32 *num_sched;
+	u32 hw_ip;

 	/* Set the hw submission limit higher for KIQ because
 	 * it's used for a number of gfx/compute tasks by both
@@ -258,6 +260,14 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 	ring->priority = DRM_SCHED_PRIORITY_NORMAL;
 	mutex_init(&ring->priority_mutex);

+	if (ring->funcs->type >= AMDGPU_RING_TYPE_GFX &&
+	    ring->funcs->type <= AMDGPU_RING_TYPE_VCN_JPEG) {
+		hw_ip = ring->funcs->type;
+		num_sched = &adev->gpu_sched[hw_ip][hw_prio].num_scheds;
+		adev->gpu_sched[hw_ip][hw_prio].sched[(*num_sched)++] =
+			&ring->sched;
+	}
+
 	for (i = 0; i < DRM_SCHED_PRIORITY_MAX; ++i)
 		atomic_set(&ring->num_jobs[i], 0);

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 50abc63f7cc5..bfd634aedf26 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -30,11 +30,15 @@

 /* max number of rings */
 #define AMDGPU_MAX_RINGS		28
+#define AMDGPU_MAX_HWIP_RINGS		8
 #define AMDGPU_MAX_GFX_RINGS		2
 #define AMDGPU_MAX_COMPUTE_RINGS	8
 #define AMDGPU_MAX_VCE_RINGS		3
 #define AMDGPU_MAX_UVD_ENC_RINGS	2

+#define AMDGPU_RING_PRIO_DEFAULT	1
+#define AMDGPU_RING_PRIO_MAX		AMDGPU_GFX_PIPE_PRIO_MAX
+
 /* some special values for the owner field */
 #define AMDGPU_FENCE_OWNER_UNDEFINED	((void *)0ul)
 #define AMDGPU_FENCE_OWNER_VM		((void *)1ul)
@@ -65,6 +69,11 @@ struct amdgpu_ib;
 struct amdgpu_cs_parser;
 struct amdgpu_job;

+struct amdgpu_sched {
+	u32				num_scheds;
+	struct drm_gpu_scheduler	*sched[AMDGPU_MAX_HWIP_RINGS];
+};
+
 /*
  * Fences.
  */
@@ -221,7 +230,6 @@ struct amdgpu_ring {
 	struct mutex		priority_mutex;
 	/* protected by priority_mutex */
 	int			priority;
-	bool			has_high_prio;

 #if defined(CONFIG_DEBUG_FS)
 	struct dentry *ent;
@@ -259,8 +267,8 @@ void amdgpu_ring_generic_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib);
 void amdgpu_ring_commit(struct amdgpu_ring *ring);
 void amdgpu_ring_undo(struct amdgpu_ring *ring);
 int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
-		     unsigned ring_size, struct amdgpu_irq_src *irq_src,
-		     unsigned irq_type);
+		     unsigned int ring_size, struct amdgpu_irq_src *irq_src,
+		     unsigned int irq_type, unsigned int prio);
 void amdgpu_ring_fini(struct amdgpu_ring *ring);
 void amdgpu_ring_emit_reg_write_reg_wait_helper(struct amdgpu_ring *ring,
 						uint32_t reg0, uint32_t val0,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 2f4412e030a4..e5b8fb8e75c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -61,8 +61,6 @@ struct amdgpu_sdma_ras_funcs {

 struct amdgpu_sdma {
 	struct amdgpu_sdma_instance instance[AMDGPU_MAX_SDMA_INSTANCES];
-	struct drm_gpu_scheduler    *sdma_sched[AMDGPU_MAX_SDMA_INSTANCES];
-	uint32_t		    num_sdma_sched;
 	struct amdgpu_irq_src	trap_irq;
 	struct amdgpu_irq_src	illegal_inst_irq;
 	struct amdgpu_irq_src	ecc_irq;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 6fe057329de2..2d0633d5515f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -196,10 +196,6 @@ struct amdgpu_vcn {
 	uint8_t	num_vcn_inst;
 	struct amdgpu_vcn_inst	 inst[AMDGPU_MAX_VCN_INSTANCES];
 	struct amdgpu_vcn_reg	 internal;
-	struct drm_gpu_scheduler *vcn_enc_sched[AMDGPU_MAX_VCN_ENC_RINGS];
-	struct drm_gpu_scheduler *vcn_dec_sched[AMDGPU_MAX_VCN_INSTANCES];
-	uint32_t		 num_vcn_enc_sched;
-	uint32_t		 num_vcn_dec_sched;

 	unsigned	harvest_config;
 	int (*pause_dpg_mode)(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
index cc1033784720..20f108818b2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -979,7 +979,8 @@ static int cik_sdma_sw_init(void *handle)
 				     &adev->sdma.trap_irq,
 				     (i == 0) ?
 				     AMDGPU_SDMA_IRQ_INSTANCE0 :
-				     AMDGPU_SDMA_IRQ_INSTANCE1);
+				     AMDGPU_SDMA_IRQ_INSTANCE1,
+				     AMDGPU_RING_PRIO_DEFAULT);
 		if (r)
 			return r;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 51be7aa2d5ec..19c825fc539c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -1299,7 +1299,8 @@ static int gfx_v10_0_gfx_ring_init(struct amdgpu_device *adev, int ring_id,

 	irq_type = AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP + ring->pipe;
 	r = amdgpu_ring_init(adev, ring, 1024,
-			     &adev->gfx.eop_irq, irq_type);
+			     &adev->gfx.eop_irq, irq_type,
+			     AMDGPU_RING_PRIO_DEFAULT);
 	if (r)
 		return r;
 	return 0;
@@ -1310,7 +1311,8 @@ static int gfx_v10_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
 {
 	int r;
 	unsigned irq_type;
-	struct amdgpu_ring *ring = &adev->gfx.compute_ring[ring_id];
+	struct amdgpu_ring *ring;
+	unsigned int hw_prio;

 	ring = &adev->gfx.compute_ring[ring_id];

@@ -1329,10 +1331,11 @@ static int gfx_v10_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
 	irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
 		+ ((ring->me - 1) * adev->gfx.mec.num_pipe_per_mec)
 		+ ring->pipe;
-
+	hw_prio = amdgpu_gfx_is_high_priority_compute_queue(adev, ring->queue) ?
+			AMDGPU_GFX_PIPE_PRIO_HIGH : AMDGPU_GFX_PIPE_PRIO_NORMAL;
 	/* type-2 packets are deprecated on MEC, use type-3 instead */
 	r = amdgpu_ring_init(adev, ring, 1024,
-			     &adev->gfx.eop_irq, irq_type);
+			     &adev->gfx.eop_irq, irq_type, hw_prio);
 	if (r)
 		return r;

@@ -3261,11 +3264,8 @@ static void gfx_v10_0_compute_mqd_set_priority(struct amdgpu_ring *ring, struct
 	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
 		if (amdgpu_gfx_is_high_priority_compute_queue(adev, ring->queue)) {
 			mqd->cp_hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_HIGH;
-			ring->has_high_prio = true;
 			mqd->cp_hqd_queue_priority =
 				AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM;
-		} else {
-			ring->has_high_prio = false;
 		}
 	}
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 73d2b96e02b1..96112fb9273b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -3110,7 +3110,9 @@ static int gfx_v6_0_sw_init(void *handle)
 		ring->ring_obj = NULL;
 		sprintf(ring->name, "gfx");
 		r = amdgpu_ring_init(adev, ring, 1024,
-				     &adev->gfx.eop_irq, AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP);
+				     &adev->gfx.eop_irq,
+				     AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP,
+				     AMDGPU_RING_PRIO_DEFAULT);
 		if (r)
 			return r;
 	}
@@ -3132,7 +3134,8 @@ static int gfx_v6_0_sw_init(void *handle)
 		sprintf(ring->name, "comp_%d.%d.%d", ring->me, ring->pipe, ring->queue);
 		irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP + ring->pipe;
 		r = amdgpu_ring_init(adev, ring, 1024,
-				     &adev->gfx.eop_irq, irq_type);
+				     &adev->gfx.eop_irq, irq_type,
+				     AMDGPU_RING_PRIO_DEFAULT);
 		if (r)
 			return r;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index f5ab0f1c6ca6..b2f10e39eff1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -4433,7 +4433,8 @@ static int gfx_v7_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,

 	/* type-2 packets are deprecated on MEC, use type-3 instead */
 	r = amdgpu_ring_init(adev, ring, 1024,
-			&adev->gfx.eop_irq, irq_type);
+			     &adev->gfx.eop_irq, irq_type,
+			     AMDGPU_RING_PRIO_DEFAULT);
 	if (r)
 		return r;

@@ -4505,7 +4506,9 @@ static int gfx_v7_0_sw_init(void *handle)
 		ring->ring_obj = NULL;
 		sprintf(ring->name, "gfx");
 		r = amdgpu_ring_init(adev, ring, 1024,
-				     &adev->gfx.eop_irq, AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP);
+				     &adev->gfx.eop_irq,
+				     AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP,
+				     AMDGPU_RING_PRIO_DEFAULT);
 		if (r)
 			return r;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 5e5d7bae57ec..fc6c2f2bc76c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -1894,6 +1894,7 @@ static int gfx_v8_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
 	int r;
 	unsigned irq_type;
 	struct amdgpu_ring *ring = &adev->gfx.compute_ring[ring_id];
+	unsigned int hw_prio;

 	ring = &adev->gfx.compute_ring[ring_id];

@@ -1913,9 +1914,11 @@ static int gfx_v8_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
 		+ ((ring->me - 1) * adev->gfx.mec.num_pipe_per_mec)
 		+ ring->pipe;

+	hw_prio = amdgpu_gfx_is_high_priority_compute_queue(adev, ring->queue) ?
+			AMDGPU_GFX_PIPE_PRIO_HIGH : AMDGPU_RING_PRIO_DEFAULT;
 	/* type-2 packets are deprecated on MEC, use type-3 instead */
 	r = amdgpu_ring_init(adev, ring, 1024,
-			&adev->gfx.eop_irq, irq_type);
+			     &adev->gfx.eop_irq, irq_type, hw_prio);
 	if (r)
 		return r;

@@ -2019,7 +2022,8 @@ static int gfx_v8_0_sw_init(void *handle)
 		}

 		r = amdgpu_ring_init(adev, ring, 1024, &adev->gfx.eop_irq,
-				     AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP);
+				     AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP,
+				     AMDGPU_RING_PRIO_DEFAULT);
 		if (r)
 			return r;
 	}
@@ -4432,11 +4436,8 @@ static void gfx_v8_0_mqd_set_priority(struct amdgpu_ring *ring, struct vi_mqd *m
 	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
 		if (amdgpu_gfx_is_high_priority_compute_queue(adev, ring->queue)) {
 			mqd->cp_hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_HIGH;
-			ring->has_high_prio = true;
 			mqd->cp_hqd_queue_priority =
 				AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM;
-		} else {
-			ring->has_high_prio = false;
 		}
 	}
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 1fea077ef748..2d56b06722bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2190,6 +2190,7 @@ static int gfx_v9_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
 	int r;
 	unsigned irq_type;
 	struct amdgpu_ring *ring = &adev->gfx.compute_ring[ring_id];
+	unsigned int hw_prio;

 	ring = &adev->gfx.compute_ring[ring_id];

@@ -2208,10 +2209,11 @@ static int gfx_v9_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
 	irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
 		+ ((ring->me - 1) * adev->gfx.mec.num_pipe_per_mec)
 		+ ring->pipe;
-
+	hw_prio = amdgpu_gfx_is_high_priority_compute_queue(adev, ring->queue) ?
+			AMDGPU_GFX_PIPE_PRIO_HIGH : AMDGPU_GFX_PIPE_PRIO_NORMAL;
 	/* type-2 packets are deprecated on MEC, use type-3 instead */
 	r = amdgpu_ring_init(adev, ring, 1024,
-			     &adev->gfx.eop_irq, irq_type);
+			     &adev->gfx.eop_irq, irq_type, hw_prio);
 	if (r)
 		return r;

@@ -2305,7 +2307,9 @@ static int gfx_v9_0_sw_init(void *handle)
 		ring->use_doorbell = true;
 		ring->doorbell_index = adev->doorbell_index.gfx_ring0 << 1;
 		r = amdgpu_ring_init(adev, ring, 1024,
-				     &adev->gfx.eop_irq, AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP);
+				     &adev->gfx.eop_irq,
+				     AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP,
+				     AMDGPU_RING_PRIO_DEFAULT);
 		if (r)
 			return r;
 	}
@@ -3369,11 +3373,8 @@ static void gfx_v9_0_mqd_set_priority(struct amdgpu_ring *ring, struct v9_mqd *m
 	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
 		if (amdgpu_gfx_is_high_priority_compute_queue(adev, ring->queue)) {
 			mqd->cp_hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_HIGH;
-			ring->has_high_prio = true;
 			mqd->cp_hqd_queue_priority =
 				AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM;
-		} else {
-			ring->has_high_prio = false;
 		}
 	}
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
index 0debfd9f428c..b10c95cad9a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
@@ -480,7 +480,8 @@ int jpeg_v1_0_sw_init(void *handle)

 	ring = &adev->jpeg.inst->ring_dec;
 	sprintf(ring->name, "jpeg_dec");
-	r = amdgpu_ring_init(adev, ring, 512, &adev->jpeg.inst->irq, 0);
+	r = amdgpu_ring_init(adev, ring, 512, &adev->jpeg.inst->irq,
+			     0, AMDGPU_RING_PRIO_DEFAULT);
 	if (r)
 		return r;

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index ba6aeff122da..e67d09cb1b03 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -106,7 +106,8 @@ static int jpeg_v2_0_sw_init(void *handle)
 	ring->use_doorbell = true;
 	ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 1;
 	sprintf(ring->name, "jpeg_dec");
-	r = amdgpu_ring_init(adev, ring, 512, &adev->jpeg.inst->irq, 0);
+	r = amdgpu_ring_init(adev, ring, 512, &adev->jpeg.inst->irq,
+			     0, AMDGPU_RING_PRIO_DEFAULT);
 	if (r)
 		return r;

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index c04c2078a7c1..37df3f2e587a 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -118,7 +118,8 @@ static int jpeg_v2_5_sw_init(void *handle)
 		ring->use_doorbell = true;
 		ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 1 + 8 * i;
 		sprintf(ring->name, "jpeg_dec_%d", i);
-		r = amdgpu_ring_init(adev, ring, 512, &adev->jpeg.inst[i].irq, 0);
+		r = amdgpu_ring_init(adev, ring, 512, &adev->jpeg.inst[i].irq,
+				     0, AMDGPU_RING_PRIO_DEFAULT);
 		if (r)
 			return r;

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
index 9211583adfa8..5f304d61999e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
@@ -873,7 +873,8 @@ static int sdma_v2_4_sw_init(void *handle)
 				     &adev->sdma.trap_irq,
 				     (i == 0) ?
 				     AMDGPU_SDMA_IRQ_INSTANCE0 :
-				     AMDGPU_SDMA_IRQ_INSTANCE1);
+				     AMDGPU_SDMA_IRQ_INSTANCE1,
+				     AMDGPU_RING_PRIO_DEFAULT);
 		if (r)
 			return r;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index 8077b01c1f52..c59f6f6f4c09 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -1157,7 +1157,8 @@ static int sdma_v3_0_sw_init(void *handle)
 				     &adev->sdma.trap_irq,
 				     (i == 0) ?
 				     AMDGPU_SDMA_IRQ_INSTANCE0 :
-				     AMDGPU_SDMA_IRQ_INSTANCE1);
+				     AMDGPU_SDMA_IRQ_INSTANCE1,
+				     AMDGPU_RING_PRIO_DEFAULT);
 		if (r)
 			return r;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index db03bcff3348..352cd9632770 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1859,7 +1859,8 @@ static int sdma_v4_0_sw_init(void *handle)

 		sprintf(ring->name, "sdma%d", i);
 		r = amdgpu_ring_init(adev, ring, 1024, &adev->sdma.trap_irq,
-				     AMDGPU_SDMA_IRQ_INSTANCE0 + i);
+				     AMDGPU_SDMA_IRQ_INSTANCE0 + i,
+				     AMDGPU_RING_PRIO_DEFAULT);
 		if (r)
 			return r;

@@ -1877,7 +1878,8 @@ static int sdma_v4_0_sw_init(void *handle)
 			sprintf(ring->name, "page%d", i);
 			r = amdgpu_ring_init(adev, ring, 1024,
 					     &adev->sdma.trap_irq,
-					     AMDGPU_SDMA_IRQ_INSTANCE0 + i);
+					     AMDGPU_SDMA_IRQ_INSTANCE0 + i,
+					     AMDGPU_RING_PRIO_DEFAULT);
 			if (r)
 				return r;
 		}
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index d6299786a068..5e6e4ea1a8ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1234,7 +1234,8 @@ static int sdma_v5_0_sw_init(void *handle)
 				     &adev->sdma.trap_irq,
 				     (i == 0) ?
 				     AMDGPU_SDMA_IRQ_INSTANCE0 :
-				     AMDGPU_SDMA_IRQ_INSTANCE1);
+				     AMDGPU_SDMA_IRQ_INSTANCE1,
+				     AMDGPU_RING_PRIO_DEFAULT);
 		if (r)
 			return r;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd/amdgpu/si_dma.c
index 3da3422c2d77..7d2bbcbe547b 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
@@ -504,7 +504,8 @@ static int si_dma_sw_init(void *handle)
 				     &adev->sdma.trap_irq,
 				     (i == 0) ?
 				     AMDGPU_SDMA_IRQ_INSTANCE0 :
-				     AMDGPU_SDMA_IRQ_INSTANCE1);
+				     AMDGPU_SDMA_IRQ_INSTANCE1,
+				     AMDGPU_RING_PRIO_DEFAULT);
 		if (r)
 			return r;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
index 957e14e2c155..3cafba726587 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
@@ -118,7 +118,8 @@ static int uvd_v4_2_sw_init(void *handle)

 	ring = &adev->uvd.inst->ring;
 	sprintf(ring->name, "uvd");
-	r = amdgpu_ring_init(adev, ring, 512, &adev->uvd.inst->irq, 0);
+	r = amdgpu_ring_init(adev, ring, 512, &adev->uvd.inst->irq, 0,
+			     AMDGPU_RING_PRIO_DEFAULT);
 	if (r)
 		return r;

diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
index 2aad6689823b..a566ff926e90 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
@@ -116,7 +116,8 @@ static int uvd_v5_0_sw_init(void *handle)

 	ring = &adev->uvd.inst->ring;
 	sprintf(ring->name, "uvd");
-	r = amdgpu_ring_init(adev, ring, 512, &adev->uvd.inst->irq, 0);
+	r = amdgpu_ring_init(adev, ring, 512, &adev->uvd.inst->irq, 0,
+			     AMDGPU_RING_PRIO_DEFAULT);
 	if (r)
 		return r;

diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
index 81186be66600..0a880bc101b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -418,7 +418,8 @@ static int uvd_v6_0_sw_init(void *handle)

 	ring = &adev->uvd.inst->ring;
 	sprintf(ring->name, "uvd");
-	r = amdgpu_ring_init(adev, ring, 512, &adev->uvd.inst->irq, 0);
+	r = amdgpu_ring_init(adev, ring, 512, &adev->uvd.inst->irq, 0,
+			     AMDGPU_RING_PRIO_DEFAULT);
 	if (r)
 		return r;

@@ -430,7 +431,9 @@ static int uvd_v6_0_sw_init(void *handle)
 		for (i = 0; i < adev->uvd.num_enc_rings; ++i) {
 			ring = &adev->uvd.inst->ring_enc[i];
 			sprintf(ring->name, "uvd_enc%d", i);
-			r = amdgpu_ring_init(adev, ring, 512, &adev->uvd.inst->irq, 0);
+			r = amdgpu_ring_init(adev, ring, 512,
+					     &adev->uvd.inst->irq, 0,
+					     AMDGPU_RING_PRIO_DEFAULT);
 			if (r)
 				return r;
 		}
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
index eef56211b3a2..7a55457e6f9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
@@ -452,7 +452,9 @@ static int uvd_v7_0_sw_init(void *handle)
 		if (!amdgpu_sriov_vf(adev)) {
 			ring = &adev->uvd.inst[j].ring;
 			sprintf(ring->name, "uvd_%d", ring->me);
-			r = amdgpu_ring_init(adev, ring, 512, &adev->uvd.inst[j].irq, 0);
+			r = amdgpu_ring_init(adev, ring, 512,
+					     &adev->uvd.inst[j].irq, 0,
+					     AMDGPU_RING_PRIO_DEFAULT);
 			if (r)
 				return r;
 		}
@@ -471,7 +473,9 @@ static int uvd_v7_0_sw_init(void *handle)
 				else
 					ring->doorbell_index = adev->doorbell_index.uvd_vce.uvd_ring2_3 * 2 + 1;
 			}
-			r = amdgpu_ring_init(adev, ring, 512, &adev->uvd.inst[j].irq, 0);
+			r = amdgpu_ring_init(adev, ring, 512,
+					     &adev->uvd.inst[j].irq, 0,
+					     AMDGPU_RING_PRIO_DEFAULT);
 			if (r)
 				return r;
 		}
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
index b6837fcfdba7..0e2945baf0f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
@@ -434,7 +434,8 @@ static int vce_v2_0_sw_init(void *handle)
 		ring = &adev->vce.ring[i];
 		sprintf(ring->name, "vce%d", i);
 		r = amdgpu_ring_init(adev, ring, 512,
-				     &adev->vce.irq, 0);
+				     &adev->vce.irq, 0,
+				     AMDGPU_RING_PRIO_DEFAULT);
 		if (r)
 			return r;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
index 217db187207c..6d9108fa22e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -442,7 +442,8 @@ static int vce_v3_0_sw_init(void *handle)
 	for (i = 0; i < adev->vce.num_rings; i++) {
 		ring = &adev->vce.ring[i];
 		sprintf(ring->name, "vce%d", i);
-		r = amdgpu_ring_init(adev, ring, 512, &adev->vce.irq, 0);
+		r = amdgpu_ring_init(adev, ring, 512, &adev->vce.irq, 0,
+				     AMDGPU_RING_PRIO_DEFAULT);
 		if (r)
 			return r;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
index 5e986dea4645..a0fb119240f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
@@ -476,7 +476,8 @@ static int vce_v4_0_sw_init(void *handle)
 			else
 				ring->doorbell_index = adev->doorbell_index.uvd_vce.vce_ring2_3 * 2 + 1;
 		}
-		r = amdgpu_ring_init(adev, ring, 512, &adev->vce.irq, 0);
+		r = amdgpu_ring_init(adev, ring, 512, &adev->vce.irq, 0,
+				     AMDGPU_RING_PRIO_DEFAULT);
 		if (r)
 			return r;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index f570ac72a351..1ad79155ed00 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -127,7 +127,8 @@ static int vcn_v1_0_sw_init(void *handle)

 	ring = &adev->vcn.inst->ring_dec;
 	sprintf(ring->name, "vcn_dec");
-	r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, 0);
+	r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, 0,
+			     AMDGPU_RING_PRIO_DEFAULT);
 	if (r)
 		return r;

@@ -145,7 +146,8 @@ static int vcn_v1_0_sw_init(void *handle)
 	for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
 		ring = &adev->vcn.inst->ring_enc[i];
 		sprintf(ring->name, "vcn_enc%d", i);
-		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, 0);
+		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, 0,
+				     AMDGPU_RING_PRIO_DEFAULT);
 		if (r)
 			return r;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index b3b5e5cac400..89ebeb28f499 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -133,7 +133,8 @@ static int vcn_v2_0_sw_init(void *handle)
 	ring->doorbell_index = adev->doorbell_index.vcn.vcn_ring0_1 << 1;

 	sprintf(ring->name, "vcn_dec");
-	r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, 0);
+	r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, 0,
+			     AMDGPU_RING_PRIO_DEFAULT);
 	if (r)
 		return r;

@@ -163,7 +164,8 @@ static int vcn_v2_0_sw_init(void *handle)
 		else
 			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 1 + i;
 		sprintf(ring->name, "vcn_enc%d", i);
-		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, 0);
+		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, 0,
+				     AMDGPU_RING_PRIO_DEFAULT);
 		if (r)
 			return r;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 22540265aee5..3ee8777950c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -191,7 +191,8 @@ static int vcn_v2_5_sw_init(void *handle)
 		ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
 				(amdgpu_sriov_vf(adev) ? 2*j : 8*j);
 		sprintf(ring->name, "vcn_dec_%d", j);
-		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[j].irq, 0);
+		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[j].irq,
+				     0, AMDGPU_RING_PRIO_DEFAULT);
 		if (r)
 			return r;

@@ -203,7 +204,9 @@ static int vcn_v2_5_sw_init(void *handle)
 					(amdgpu_sriov_vf(adev) ? (1 + i + 2*j) : (2 + i + 8*j));

 			sprintf(ring->name, "vcn_enc_%d.%d", j, i);
-			r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[j].irq, 0);
+			r = amdgpu_ring_init(adev, ring, 512,
+					     &adev->vcn.inst[j].irq, 0,
+					     AMDGPU_RING_PRIO_DEFAULT);
 			if (r)
 				return r;
 		}
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
