Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9170AC282DE
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Mar 2025 14:59:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A89410E166;
	Fri,  7 Mar 2025 14:59:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mZS6nRtc";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E49710E166
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Mar 2025 14:59:32 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-43bccfa7b89so16375305e9.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 07 Mar 2025 06:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741359571; x=1741964371; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=NPpDiLzjEPaLoKFnG8J771fSubCXvBcueGIn91RJ8lM=;
 b=mZS6nRtchr6BfqO5u14MAdx5O8KahBySaxfbTcvJ/ynRgFWLLHNiPDszV93rU4JA4F
 /kTVhsAZp4lOJcgsTodTrq7QBfB3q58pflyOiK362Km6W5VXFUyF61SWnOOF/ffXo0NR
 +xLiWj9Dhr0JJ0sRDx8ZDTbvJyl88Tfp8tqS1E0EHFe/4O5rWkgWb6AoKGR5BWtxVXNL
 j8FEkDnfeAHpSEY8Cl/wzJHGBR3dka1IFmjB/eHp1gaxrym93NoJqWpzU9MEGw++kPxn
 bUnTNpQXG1AjtoT86S+KmxeNaNYLru464ttEVjA1sQFxSM324t9IWsY6z0tTep6JCA/6
 5Amw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741359571; x=1741964371;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NPpDiLzjEPaLoKFnG8J771fSubCXvBcueGIn91RJ8lM=;
 b=OgkhmBMlozrVqnZmc7nRSEf7npi4wAArHn5l2oCQ0dA7JgDpHHRXbGJZiQ0esdKa2Z
 po5Jz/KJYUsvduE7kgZjmrzRwYXcSilVvf7TFFYbGb93T6/yC96sF3Lg0jC1Ytz+n6LL
 Wk++KTazykT0+6qEvtp8X5LNVL79qTf9ujYMCHc44m+sBT+/IKxSZ4G9/h5gVJGHkZqy
 4yTQMpjRbF2e62cPEs9qcPou0f0JRe4XhGelC6AgliCpkGi5F1cLBqTyCTHSFmM1bILq
 lA8bjtA1qr8BJBMVLhgph/i0go3l6TbW0tXrj63pRAJc90yxpWhU3OgO3n34zRySVL+l
 htSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTsfPHGLJvQe3Wygm/bnWsbk4HcLTWqDASwocyC9fFMXiTIJPzTCJyhB0r7Dy0NFnJCAY9FNFW@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxhdBw3troV6DV4oCcU+sfPdhbCyBaMMAcDPYGQN8kBiQlAkjN9
 DqT6G6oUk0zfkyXOufubBSzB6Z1lfztwfUuCUXOo+JUsOItb0Df1
X-Gm-Gg: ASbGncsz4gtQFFRGHlT9fdevD10soCL+sUcuBqHvAqoERaieTe6fiRuftXoCUKuXn7x
 dAg7vShY24pfUkMvcf0n9mY2JE4/rCyz1RRbuZ03FD4fvMCDuQDdfCVyp0DfBAG0QFJH9WLBsQ7
 XhtqdA2rmnga5UpDSvktjlBUJqBZ3PBzJgM1v+rLUGZwdy71W5EF1jiDvqZLuTqev6VLA/2V+Iy
 N8WXy6Krfiqkfjyx2wNxSQYy4tQ+CuaPGsfKsk/LNdvNR9LbEKyK61SWCLpW4iKf2Ot0Hfa3a8A
 EHKXiBRv/xaJW91dN7cI5YWIwzxFCcYGv+ixJBFB/VZVjTIxBt9GcYeuAQ==
X-Google-Smtp-Source: AGHT+IGPzDKDQPJqwBV5UHCftg0MChVb7sN+S3Sm2G4Sy6f+f5SAQGKNfcsQhiOHTdY8iCBjPPI28Q==
X-Received: by 2002:a05:600c:1c92:b0:43b:c284:5bc2 with SMTP id
 5b1f17b1804b1-43c54a13899mr30064295e9.0.1741359570594; 
 Fri, 07 Mar 2025 06:59:30 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:14d3:5e00:ab55:e6a0:3a3d:9571])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd42c55e6sm83132565e9.23.2025.03.07.06.59.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 06:59:30 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Alexander.Deucher@amd.com, phasta@mailbox.org, dakr@kernel.org,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: deprecate guilty handling
Date: Fri,  7 Mar 2025 15:59:29 +0100
Message-Id: <20250307145929.9104-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
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
index 5df21529b3b1..fcace736f208 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -59,11 +59,6 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p,
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
index c43d1b6e5d66..0b6eb718577a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -250,7 +250,7 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
 	}
 
 	r = drm_sched_entity_init(&entity->entity, drm_prio, scheds, num_scheds,
-				  &ctx->guilty);
+				  NULL);
 	if (r)
 		goto error_free_entity;
 
@@ -572,6 +572,27 @@ static int amdgpu_ctx_query(struct amdgpu_device *adev,
 
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
@@ -600,7 +621,7 @@ static int amdgpu_ctx_query2(struct amdgpu_device *adev,
 	if (ctx->generation != amdgpu_vm_generation(adev, &fpriv->vm))
 		out->state.flags |= AMDGPU_CTX_QUERY2_FLAGS_VRAMLOST;
 
-	if (atomic_read(&ctx->guilty))
+	if (amdgpu_ctx_guilty(ctx))
 		out->state.flags |= AMDGPU_CTX_QUERY2_FLAGS_GUILTY;
 
 	if (amdgpu_in_reset(adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
index 85376baaa92f..45569cce484e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
@@ -53,7 +53,6 @@ struct amdgpu_ctx {
 	bool				preamble_presented;
 	int32_t				init_priority;
 	int32_t				override_priority;
-	atomic_t			guilty;
 	unsigned long			ras_counter_ce;
 	unsigned long			ras_counter_ue;
 	uint32_t			stable_pstate;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 198d29faa754..ed65c14a4ed7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5467,14 +5467,10 @@ int amdgpu_device_mode1_reset(struct amdgpu_device *adev)
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
@@ -5499,9 +5495,6 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 
 	amdgpu_fence_driver_isr_toggle(adev, false);
 
-	if (job && job->vm)
-		drm_sched_increase_karma(&job->base);
-
 	r = amdgpu_reset_prepare_hwcontext(adev, reset_context);
 	/* If reset handler not implemented, continue; otherwise return */
 	if (r == -EOPNOTSUPP)
-- 
2.34.1

