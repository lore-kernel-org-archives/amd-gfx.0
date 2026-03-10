Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7081FD4F2A
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2026 19:13:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7256210E77F;
	Tue, 10 Mar 2026 19:13:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E18PGdmB";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8D2F10E77F
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2026 19:13:39 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-48529c325f0so31724255e9.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2026 12:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773170018; x=1773774818; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8FB5qahsoj4Lp6E47t/joa45nd7y5/Oshsj4a0TEuw4=;
 b=E18PGdmBa8qdDyapVm9f/ubvTNmBDFr3Z2UPLZXONGZGtNYoVDhcxKqPyU/kp+7Tux
 SaXgsXpItJO4omDBBdXSRbtDZyoOjFm0OiVWsRlU6cW4iKoi97QyXSkMnC+fpsYqx/ds
 hKsv2IV/bYd97+85CVr8m74d7HsQJouQ27AZ4OXTKEddZ87PdQmnxwDjzN9orR5B+7Pw
 JyUlcAI/5gS4BTxSdUL5O1yCGN7GXh5tihphjx0HDiBHGzYcSe4BcrPG8HfPAkdmdYDY
 ap5T9KfPgC1nLpN32XWp2XtxJHrkDILHOYHK28yFQINK1wmPg0Asr6JlV60BjmoYz9bd
 u3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773170018; x=1773774818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8FB5qahsoj4Lp6E47t/joa45nd7y5/Oshsj4a0TEuw4=;
 b=k7ikO79ySPiFiZ4AnacEJJ/H1lliWwSTx+NJ+LZfLZ36B8UBKnHQbR7jX8ARFL50+b
 1djmPTZoAY1hBLbeiYL2NiAFTb/4TVvMsLjJRcxQEcxWokdnlRFCsbQZdY57FaOSFGMc
 jqyf4630N/x9l+u43d+v0hlqXQQoV7GP6E1DZASstEGsytxaGJqcLKO8xXWleF5ao++c
 B3NelzRKRZ+EmueP+E2Ya5K3DNu1tLQi4KALY0ABiIi3jzfF01tKBFBZs5VAJY8o15Hu
 HZO4w8HvqwrBde+xxsdiBSkyDng7kkUs6yyDufrRsTCQhodoLBwWO47+ZsQw1tS/XgcS
 7iVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZraKrPXp200X+7+l+/Y++TUZtau5tKq00neXtkDuxZDcxTBpPMRpj4Wm4pGKisxOjrlHtV62D@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwRRUBkSzd/PTKyUyPLCPB72hxa0XQTus4MLZSsE5rzxOD4P479
 4dwnGhAD565V9QNKX2g6xfDbmieg5sQGZd4xCC90IRFzfJfpAYiIIsp2
X-Gm-Gg: ATEYQzyUV/+bMhFXi0Lw1BFw4jNHOipj3Es5nQcNdGeQfuZkTdAjixji2I2Adjcre0P
 UNUIae/h7HQNF9AeQUvPJvHupgJveTr97LXWYq3bn2p5+loq7xPbr+DsuNrV/NK6QkPbmdJaxWB
 Ay9YjH2FguOA5yqRRQz/sbVecD6xEWCsoHr6eMoiTE2ScqO3hA4YjofrwJoTt89/h7bdCVkbdHO
 NEeCgc6/yBXfTA4jxvaYStQvpcRhve5wE9kNO0SnAcl3EE2fKo4hk7d4Y/qTJtU2zEEaAPj08po
 uAk8U3eC1O7aMq//iAYxEM3MvSkvTNlDE304pie599wn63mBJgxDs2kDoEAdhuYVPTjFh8z17l9
 MLh3UbZumW5OEnd/Lm1uZRnT88h5qv21ZgnyWg+wPUv60f/Qv+NihMDZ3BvtmH6ucCZhcd2+v2X
 AWghJIwXaaEeYONhviLh6AWP06briGy2jNpOo=
X-Received: by 2002:a05:600c:871b:b0:485:3ee1:eba5 with SMTP id
 5b1f17b1804b1-4853ee1ed59mr102316405e9.27.1773170018178; 
 Tue, 10 Mar 2026 12:13:38 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15d0:d800:5198:df3e:59ca:cf4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854a3079efsm2601625e9.7.2026.03.10.12.13.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 12:13:37 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: tursulin@ursulin.net, Alexander.Deucher@amd.com, Prike.Liang@amd.com,
 Yogesh.Mohanmarimuthu@amd.com, SRINIVASAN.SHANMUGAM@amd.com,
 Sunil.Khatri@amd.com, amd-gfx@lists.freedesktop.org
Subject: [PATCH 11/11] drm/amdgpu: WIP sync amdgpu_ttm_fill_mem only to kernel
 fences
Date: Tue, 10 Mar 2026 20:13:27 +0100
Message-ID: <20260310191327.2279-11-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260310191327.2279-1-christian.koenig@amd.com>
References: <20260310191327.2279-1-christian.koenig@amd.com>
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

That's not even remotely correct, but should unblock testing for now.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 714fd8d12ca5..69f52a078022 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2428,12 +2428,14 @@ static int amdgpu_ttm_prepare_job(struct amdgpu_device *adev,
 				  struct amdgpu_ttm_buffer_entity *entity,
 				  unsigned int num_dw,
 				  struct dma_resv *resv,
+				  enum dma_resv_usage usage,
 				  bool vm_needs_flush,
 				  struct amdgpu_job **job,
 				  u64 k_job_id)
 {
 	enum amdgpu_ib_pool_type pool = AMDGPU_IB_POOL_DELAYED;
 	int r;
+
 	r = amdgpu_job_alloc_with_ib(adev, &entity->base,
 				     AMDGPU_FENCE_OWNER_UNDEFINED,
 				     num_dw * 4, pool, job, k_job_id);
@@ -2449,8 +2451,7 @@ static int amdgpu_ttm_prepare_job(struct amdgpu_device *adev,
 	if (!resv)
 		return 0;
 
-	return drm_sched_job_add_resv_dependencies(&(*job)->base, resv,
-						   DMA_RESV_USAGE_BOOKKEEP);
+	return drm_sched_job_add_resv_dependencies(&(*job)->base, resv, usage);
 }
 
 int amdgpu_copy_buffer(struct amdgpu_device *adev,
@@ -2479,9 +2480,9 @@ int amdgpu_copy_buffer(struct amdgpu_device *adev,
 	max_bytes = adev->mman.buffer_funcs->copy_max_bytes;
 	num_loops = DIV_ROUND_UP(byte_count, max_bytes);
 	num_dw = ALIGN(num_loops * adev->mman.buffer_funcs->copy_num_dw, 8);
-	r = amdgpu_ttm_prepare_job(adev, entity, num_dw,
-				   resv, vm_needs_flush, &job,
-				   AMDGPU_KERNEL_JOB_ID_TTM_COPY_BUFFER);
+	r = amdgpu_ttm_prepare_job(adev, entity, num_dw, resv,
+				   DMA_RESV_USAGE_BOOKKEEP, vm_needs_flush,
+				   &job, AMDGPU_KERNEL_JOB_ID_TTM_COPY_BUFFER);
 	if (r)
 		goto error_free;
 
@@ -2524,6 +2525,7 @@ static int amdgpu_ttm_fill_mem(struct amdgpu_device *adev,
 	num_loops = DIV_ROUND_UP_ULL(byte_count, max_bytes);
 	num_dw = ALIGN(num_loops * adev->mman.buffer_funcs->fill_num_dw, 8);
 	r = amdgpu_ttm_prepare_job(adev, entity, num_dw, resv,
+				   DMA_RESV_USAGE_KERNEL,
 				   vm_needs_flush, &job, k_job_id);
 	if (r)
 		return r;
-- 
2.43.0

