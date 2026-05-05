Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8133CD3427
	for <amd-gfx@archiver.kernel.org>; Tue,  5 May 2026 13:40:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FF0410E43A;
	Tue,  5 May 2026 13:40:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JHld5Flv";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6181B10E43A
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 May 2026 13:40:08 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-488e1a8ac40so51166715e9.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 May 2026 06:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777988407; x=1778593207; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=C6T1LuRvEjKuqWYc2Dw9d3SJeIkMfRlAqp+UjGFb42w=;
 b=JHld5FlvrFo4zHsO4hUupjPH9WIZvTKoE1yM2sVMfweR7TTn99Pjp6JmiHYzMFSXlg
 /HlBMbmdkalbigt9c1VVo4YSVL9d61CAbJpG3f4EluxEyCl0f5se1aF91w/Ff9RiD6Yk
 A+nAT7WR/SQHUa/AghHQUN0RSQVVYqnRs6t5mzcLCW7BwtVeBiF2+y6OtNFRPWKzhIJt
 tC1uYjd8fqaBQnGVlD3VJmXEhS+8cDfyws1CLcJ44WQzkxQ1/Ns4pro7yA9CNWRwIJBF
 /racFbv1Kua6oKI26jlo4XeMp4PB06xU8XkNNUWH6tnz8hEnItdsrUC2ejQW0l+zaA6h
 R5Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777988407; x=1778593207;
 h=content-transfer-encoding:reply-to:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C6T1LuRvEjKuqWYc2Dw9d3SJeIkMfRlAqp+UjGFb42w=;
 b=hrTg8VKVEXQlIVppC4z96lhxp8p/IuyJ0MsW4o5020mWZh6Zha99KslWpqwNztWrF1
 N5/TKE002Wzv910tC9TexLS67fGL459DcKxeZWaqFSL8N5fdzDnL3Ab47gLmQZUE9Wbh
 Uh/ouxc0IkMA1nlp/H1wpudGqJFnyVJ+uIW/8kDb8MaRrXDrU7BxAqAKw3CrEprAXbwn
 8i78jt3M0Vu99JvQqabDDCcoEnGF6LTowEQ7TlvaqPVLo/kQ6VRCSco1flCVNmWm1+vp
 glddOVjVcoBukxNmS3os1DD1PVtKxExKi3Fk9eG5msTpaZscaId0BkSIRpHAlhsjn2ux
 RiuQ==
X-Gm-Message-State: AOJu0YzG5gGa4p1b1KBxd04sAS2SgwLd9DZ9UBCtrCkMAL5/YM3Su2dB
 zEk8QWpqbfrcJMJN5A1m/l8c+4mgtQfMUEysEL24NzyZn/Sm8eEfjCKWMFQWSw==
X-Gm-Gg: AeBDievAyD2auBynG4wHleUqlH3k/gdNctWJ9+u96bFZxYnLZIhQ7/TfwQeqWrFFBgb
 lKsqRmgDxvVU+Cv/+1lIxDbQ1EpTQ7Va4ohNtcRbr0J4RmqmJPSSLFG8C40Hb64jcTPIzdogWFD
 vYl3QNYtUHMGFjfzCec3RFh7FN4cliwWoaTEv0hlXqzci/VmW4OSxHSJTBBK49XjQwgKCPcn2A0
 4dvtY7x5p3L6HK7VNhSRCajrZUoJcyWBu92QYBqTUJDn7+cf2kD+wB1JhuCKPWilxX62iSSfwWQ
 Dmm4+yvA/vyMT2sZVQCJHkw3r2PnxFvBwE9x8+wgsF46C+epV23QgoaVG/5DdCBJn6MTZ60epEf
 ELRycsy4TJea9xPwwXXtoFweeOQmQF603EQNlELqre1nIrLLYOqvr2+r7I2KARY63/cJFnuNCey
 ShbFy55HjYEL7o51gagPU1kU3AvfXzWIsfgOpE1jxTc7l+idM=
X-Received: by 2002:a05:600c:a46:b0:48a:7a10:4f17 with SMTP id
 5b1f17b1804b1-48d186dc73emr50363385e9.6.1777988406484; 
 Tue, 05 May 2026 06:40:06 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1504:6f00:f9aa:159a:776a:f15a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48d17714dc8sm38201985e9.4.2026.05.05.06.40.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 06:40:06 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org,
	Alexander.Deucher@amd.com
Subject: [PATCH] drm/amdgpu: deprecate guilty handling
Date: Tue,  5 May 2026 15:40:04 +0200
Message-ID: <20260505134004.1502-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
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
Reply-To: christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The guilty handling tried to establish a second way of signaling problems with
the GPU back to userspace. This caused quite a bunch of issue we had to work
around, especially lifetime issues with the drm_sched_entity.

Just drop the handling altogether and use the dma_fence based approach instead.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c     |  5 -----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c    | 25 ++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h    |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  9 +-------
 4 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 10d8dcc3a972..d67c87fbf371 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -60,11 +60,6 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p,
 	if (!p->ctx)
 		return -EINVAL;
 
-	if (atomic_read(&p->ctx->guilty)) {
-		amdgpu_ctx_put(p->ctx);
-		return -ECANCELED;
-	}
-
 	amdgpu_sync_create(&p->sync);
 	drm_exec_init(&p->exec, DRM_EXEC_INTERRUPTIBLE_WAIT |
 		      DRM_EXEC_IGNORE_DUPLICATES, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index c273557fb1ae..cfb24e5d065e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -256,7 +256,7 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
 	}
 
 	r = drm_sched_entity_init(&entity->entity, drm_prio, scheds, num_scheds,
-				  &ctx->guilty);
+				  NULL);
 	if (r)
 		goto error_free_entity;
 
@@ -580,6 +580,27 @@ static int amdgpu_ctx_query(struct amdgpu_device *adev,
 
 #define AMDGPU_RAS_COUNTE_DELAY_MS 3000
 
+static bool amdgpu_ctx_guilty(struct amdgpu_ctx *ctx)
+{
+	int i, j, r;
+
+	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
+		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
+			struct amdgpu_ctx_entity *ctx_entity;
+
+			ctx_entity = ctx->entities[i][j];
+			if (ctx_entity)
+				continue;
+
+			r == drm_sched_entity_error(&ctx_entity->entity);
+			if (r == -ETIME)
+				return true;
+		}
+	}
+
+	return false;
+}
+
 static int amdgpu_ctx_query2(struct amdgpu_device *adev,
 			     struct amdgpu_fpriv *fpriv, uint32_t id,
 			     union drm_amdgpu_ctx_out *out)
@@ -608,7 +629,7 @@ static int amdgpu_ctx_query2(struct amdgpu_device *adev,
 	if (ctx->generation != amdgpu_vm_generation(adev, &fpriv->vm))
 		out->state.flags |= AMDGPU_CTX_QUERY2_FLAGS_VRAMLOST;
 
-	if (atomic_read(&ctx->guilty))
+	if (amdgpu_ctx_guilty(ctx))
 		out->state.flags |= AMDGPU_CTX_QUERY2_FLAGS_GUILTY;
 
 	if (amdgpu_in_reset(adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
index cf8d700a22fe..e444b2088d40 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
@@ -50,7 +50,6 @@ struct amdgpu_ctx {
 	int32_t				init_priority;
 	int32_t				override_priority;
 	uint32_t			stable_pstate;
-	atomic_t			guilty;
 	bool				preamble_presented;
 	uint64_t			generation;
 	unsigned long			ras_counter_ce;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 073f632f295a..1536d40bb362 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5092,14 +5092,10 @@ int amdgpu_device_link_reset(struct amdgpu_device *adev)
 int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 				 struct amdgpu_reset_context *reset_context)
 {
-	int i, r = 0;
-	struct amdgpu_job *job = NULL;
 	struct amdgpu_device *tmp_adev = reset_context->reset_req_dev;
 	bool need_full_reset =
 		test_bit(AMDGPU_NEED_FULL_RESET, &reset_context->flags);
-
-	if (reset_context->reset_req_dev == adev)
-		job = reset_context->job;
+	int i, r;
 
 	if (amdgpu_sriov_vf(adev))
 		amdgpu_virt_pre_reset(adev);
@@ -5119,9 +5115,6 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 
 	amdgpu_fence_driver_isr_toggle(adev, false);
 
-	if (job && job->vm)
-		drm_sched_increase_karma(&job->base);
-
 	r = amdgpu_reset_prepare_hwcontext(adev, reset_context);
 	/* If reset handler not implemented, continue; otherwise return */
 	if (r == -EOPNOTSUPP)
-- 
2.43.0

