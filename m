Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 954D3C78849
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Sep 2024 13:59:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42B6C10E04D;
	Fri, 20 Sep 2024 13:59:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GnPN15iC";
	dkim-atps=neutral
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com
 [209.85.208.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF1C610E04D
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Sep 2024 13:58:59 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-5c27067b81aso2523832a12.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Sep 2024 06:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726840738; x=1727445538; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=U9sRyxkp/SCwquYGmCpT7MSHvhE98Cx1iTp4lpdcDeo=;
 b=GnPN15iC6OVm0AG4e9bDSOe+m6EQYG0JGvxh0spksNj1O4KHEyEW6BGW1KwHaqVN09
 KWmAoju/CWIzsbuwqbgBbTkl9Kjr/3MuwaSVWGexFYyr6RxvuGNyy+g2c5qF15A2UHiY
 lz4LQR7VnFhvEJ1AdDDaG+3lFEGAQI0OhuqJCuHaYi+Arg9PeCeRu0YRqO3qvyBBSOIG
 lXXCEHxtzBp4M5ocOiBhwwhtd0pdy0J3fRJHDe8YZOfuS0ITjt4iAe05D9jWF4jRUJYl
 OlRGcSb2WXMIAnbXMq1MYDjvQctGfHIHwzuhNi6cjESh6N7Xy7fnKCdbXERIrU5ivU79
 iOKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726840738; x=1727445538;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U9sRyxkp/SCwquYGmCpT7MSHvhE98Cx1iTp4lpdcDeo=;
 b=lFtCwni6lLVuZOkVIJrZH0bw7KB5m2/sD6d0nOEVz1hPwu+oaq7eWXrwm8DepbCd5G
 Fgzo+sEAXB3ep8BqK42F7rMa6ZZk5e3vm1CUV48G5LaD3EDcpm+TAIVjBxLkag6QvEHj
 Up8EFXFLHpZ/8rGN+uJyYIWY9srF9iFIckzLAUSh7SXQA8Z2Z7pW9tu5RUR4gOfIJFGd
 fMcEyCtzCOvY8quUjuaar7hrJknwMalproHQ5YJRdjv+l5YrqEMYewGVAs//aTlZYADL
 LtVTzMzang5kM+ACjMFhkJtETp4dZaKsM758ZW9Rc2xKZl0I1jQnCr2tRk3tkXeP72QL
 +mLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGojl+quvz1pdyn7CQUyeGukvie7MJpaX4ZQPuPE9AXO4Q78kfCgE613wshganISokDQapzYoB@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxIX/9Dl9BTsg35zLbqN3Ym8nhqWjCx3xjAcCKPNdmfFshiB44v
 +NnDXBmI8MvtD8KmvGKt/iIebJfCgCQRLWZmHcB4zLydeG6f/GkeGr36YpDS
X-Google-Smtp-Source: AGHT+IH1tSFP2/ZVjUmepv68WknNDL5Z2vx66yxV6YEKLP5ELDFT9ph5GirIyG21wTBzQkEfmPy9Kg==
X-Received: by 2002:a05:6402:5113:b0:5c2:6311:8445 with SMTP id
 4fb4d7f45d1cf-5c464a3855dmr1695988a12.2.1726840737451; 
 Fri, 20 Sep 2024 06:58:57 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1586:1d00:e988:9fc2:6e17:c927])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c42bc88d02sm7222871a12.80.2024.09.20.06.58.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 06:58:56 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Alexander.Deucher@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: deprecate guilty handling
Date: Fri, 20 Sep 2024 15:58:55 +0200
Message-Id: <20240920135855.11786-1-christian.koenig@amd.com>
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
index 1e475eb01417..5c8a6396d924 100644
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
index c43d1b6e5d66..39fe7cc6e34e 100644
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
+	int i, j;
+
+	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
+		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
+			struct amdgpu_ctx_entity *ctx_entity;
+
+			ctx_entity = ctx->entities[i][j];
+			if (ctx_entity)
+				continue;
+
+			if (drm_sched_entity_error(&ctx_entity->entity) ==
+			    -ETIME)
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
index df19271130c6..26f72b8afde9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5330,14 +5330,10 @@ int amdgpu_device_mode1_reset(struct amdgpu_device *adev)
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
@@ -5362,9 +5358,6 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 
 	amdgpu_fence_driver_isr_toggle(adev, false);
 
-	if (job && job->vm)
-		drm_sched_increase_karma(&job->base);
-
 	r = amdgpu_reset_prepare_hwcontext(adev, reset_context);
 	/* If reset handler not implemented, continue; otherwise return */
 	if (r == -EOPNOTSUPP)
-- 
2.34.1

