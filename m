Return-Path: <SRS0=k5/X=43=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923CFC10F27
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2020 12:21:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6733E24686
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2020 12:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gIh1/TIb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6733E24686
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C48289F03;
	Tue, 10 Mar 2020 12:21:24 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C73C89F03
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2020 12:21:23 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id a132so1163036wme.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2020 05:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xv/UAICwVD0l64A7KPfhhkf8porEhYjen3A1KMVwO2U=;
 b=gIh1/TIbuCsma0swWNAsl/XkjlCZIt8kFnDH1c9rY1lFXRBLW29+0iwetRzGHhEGx9
 /DsWHNkTltNYqYOiz1xtcpnTUSvLHHhiQMu4k4DYr7aoL5DrAPyYsHW+pntfE/vD8ojZ
 RUeOef0WhuRXlFstFgUujiqAu9/8LKTZbfKYwhY0i2I6w5nykERp2ntYp8mfH/OFX1Rs
 OiHa4WiBVhrAihCVKCx2VeVW0wJ24ToTS8z//+srz+/ICjNZ85XO6JhixcGwzfpTRbiF
 HMHaODfjkUVaFkpE1pXpdW1hX+XjdjlY0T+cdV4TuphnnEPC8KGnukKSeBU2/l5IzsfA
 hk6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xv/UAICwVD0l64A7KPfhhkf8porEhYjen3A1KMVwO2U=;
 b=pHAcmMEdgT96ZIY3wY65cnlke5lDPHrh8holGSlP8CFnU+INcLa3n5fdkIWP5oN/Tp
 eaLBYQLwVa0j3GIW8F6lPRZ8dWchPUG8QlVYangDgjTtMY9NY7L9CPlp9sWs+2F7JuMz
 7Wn7e/QMGPUCcrU+rXaEmIy3O/mTd/i54bXIXBrw2wbe/A3HqIy1thD55zJxMumEhzSU
 WhjiZKbNdVDx46Sui8uaWCm2Ozf2UH3UmM6YoEGLRgFPVVHFVx4got6fvXOWL+yvF7W5
 uQivgSoN/7Zrr2cToGeSSkAXgZjVfY0APlgewaR1HZCALtDXFLWlY0ZXENtV4vJv8X02
 mZiA==
X-Gm-Message-State: ANhLgQ3jhgoek9IHI8dzm3rc59XRNtaoHAhpp2VL6c9/BmNzHVhCzv7Z
 NxUcBLT+71j2oB09TwNQ7reY8KqQvpIc4Q==
X-Google-Smtp-Source: ADFU+vvhYLamgq8kNkbFALKLTfFGypZXSd7GHmBNjFEpO/MHw06gdOrT7/695VQAPcIRRIzoResHrA==
X-Received: by 2002:a1c:e913:: with SMTP id q19mr2027756wmc.31.1583842881727; 
 Tue, 10 Mar 2020 05:21:21 -0700 (PDT)
Received: from brihaspati.fritz.box
 (p200300C58F32A80070E0F409F1853DFD.dip0.t-ipconnect.de.
 [2003:c5:8f32:a800:70e0:f409:f185:3dfd])
 by smtp.gmail.com with ESMTPSA id z19sm3970972wma.41.2020.03.10.05.21.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 05:21:21 -0700 (PDT)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: cleanup drm_gpu_scheduler array creation
Date: Tue, 10 Mar 2020 13:24:56 +0100
Message-Id: <20200310122456.3240-2-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200310122456.3240-1-nirmoy.das@amd.com>
References: <20200310122456.3240-1-nirmoy.das@amd.com>
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
Cc: alexander.deucher@amd.com, Ray.Huang@amd.com, nirmoy.das@amd.com,
 christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Move initialization of struct drm_gpu_scheduler array,
amdgpu_ctx_init_sched() to amdgpu_ring.c.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c    | 75 -------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h    |  3 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c   | 85 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |  2 +
 5 files changed, 88 insertions(+), 79 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index fa575bdc03c8..06d151c0fe4e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -661,78 +661,3 @@ void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr)
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
index 572eb6ea8eab..b2a99f9fc223 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3092,7 +3092,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 			adev->gfx.config.max_cu_per_sh,
 			adev->gfx.cu_info.number);
 
-	amdgpu_ctx_init_sched(adev);
+	amdgpu_ring_init_sched(adev);
 
 	adev->accel_working = true;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index a7e1d0425ed0..01faeb8b4ef2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -454,3 +454,88 @@ int amdgpu_ring_test_helper(struct amdgpu_ring *ring)
 	ring->sched.ready = !r;
 	return r;
 }
+
+static void amdgpu_ring_init_compute_sched(struct amdgpu_device *adev)
+{
+	int num_compute_sched_normal = 0;
+	int num_compute_sched_high = AMDGPU_MAX_COMPUTE_RINGS - 1;
+	int i;
+
+	/* use one drm sched array, gfx.compute_sched to store both high and */
+	/* normal priority drm compute schedulers */
+	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
+		if (!adev->gfx.compute_ring[i].has_high_prio)
+			adev->gfx.compute_sched[num_compute_sched_normal++] =
+				&adev->gfx.compute_ring[i].sched;
+		else
+			adev->gfx.compute_sched[num_compute_sched_high--] =
+				&adev->gfx.compute_ring[i].sched;
+	}
+
+	/* compute ring only has two priority for now */
+	i = AMDGPU_GFX_PIPE_PRIO_NORMAL;
+	adev->gfx.compute_prio_sched[i] = &adev->gfx.compute_sched[0];
+	adev->gfx.num_compute_sched[i] = num_compute_sched_normal;
+
+	i = AMDGPU_GFX_PIPE_PRIO_HIGH;
+	if (num_compute_sched_high == (AMDGPU_MAX_COMPUTE_RINGS - 1)) {
+		/* When compute has no high priority rings then use */
+		/* normal priority sched array */
+		adev->gfx.compute_prio_sched[i] = &adev->gfx.compute_sched[0];
+		adev->gfx.num_compute_sched[i] = num_compute_sched_normal;
+	} else {
+
+		adev->gfx.compute_prio_sched[i] =
+			&adev->gfx.compute_sched[num_compute_sched_high - 1];
+		adev->gfx.num_compute_sched[i] =
+			adev->gfx.num_compute_rings - num_compute_sched_normal;
+	}
+}
+
+/**
+ * amdgpu_ring_init_sched - populate array of drm scheds for each HW IP
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Populate an array of struct drm_gpu_schedulers for each HW IP which
+ * can be use by amdgpu_ctx_get_entity() to initialize an entity.
+ *
+ */
+
+void amdgpu_ring_init_sched(struct amdgpu_device *adev)
+{
+	int i, j;
+
+	amdgpu_ring_init_compute_sched(adev);
+	for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
+		adev->gfx.gfx_sched[i] = &adev->gfx.gfx_ring[i].sched;
+		adev->gfx.num_gfx_sched++;
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
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 9a443013d70d..4ccd056d4353 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -326,4 +326,6 @@ int amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
 			     struct amdgpu_ring *ring);
 void amdgpu_debugfs_ring_fini(struct amdgpu_ring *ring);
 
+void amdgpu_ring_init_sched(struct amdgpu_device *adev);
+
 #endif
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
