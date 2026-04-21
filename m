Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2787FF8FA73
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2026 12:55:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B491910E897;
	Tue, 21 Apr 2026 12:55:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B63pjvRe";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C19610EC91
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2026 12:55:31 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so37632625e9.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2026 05:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776776130; x=1777380930; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BfCRylRFQ5Cz4IhdE+8OiwYfz1E71aUntkRQVnnAv9E=;
 b=B63pjvReg/OBmBVDW4XR3EWXUjMAcKEwT2BMMgdJMIYEyNLy1FynzqGJeeiLGzkajA
 cYHgSB2dMRTMgDMctA2B5LHPvS+A72svpYDxwPpM7fXJ41MeR5266uP3rT0qRBwle0TM
 dTv5oibRqf9h7pe9qTmBg9W+TYaUdRtfeE9kZzJa55EeQo53IZZdwye79Ep9K1L+iyTa
 U1IBaGUo2ilqrn6s6kJpA+9KRBGxmux5E9guBGaRvN0bP4KM7qyGlH5Nf9GdXwC99+oa
 TC0joNn/QhpdjHLeClsl58IhQxDZn/hGFbOjYcK5FZECx8DzCv2attSDCDF3gT9SVhXs
 Og5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776776130; x=1777380930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BfCRylRFQ5Cz4IhdE+8OiwYfz1E71aUntkRQVnnAv9E=;
 b=MTirWnPr4JQuiW4XPljXqm90/i6qUNaAVsJ3E1A915snVqZvPkydMOJg3W8K/cyEjj
 TtYNz/lAyvU58oyhRov3CL+0xX8p3NQQnnDtlXNqFJVCpoqsfdNSi/DJfYj54/+JFi6Q
 hj610XeapqdedZhv0oj5HY2M+nVotxQvUO6TTQr0tIZsxR5M/Z64OfPHBKLkYcEbjm7e
 CojntoQDEmIZqErVL2cpzzbVfPdD69WW0FHygz06khTN3i546SSSKjZ5ihwUixfXiVUY
 67o02N6Qe+pSdWlIQ9TC93m/t19maH3Gv4IcrpVXHVxgw2fFMjB7zWFPic4whxMhAfRU
 uhKw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+HSJl6brtyvDrzSzVFc/hpao8fkYSysIYe5X57M+SNqEi8X/S2MxTSxX8ncVzgZkDCw1hyimOU@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwM4hyl37vQR31v8gQd7dhOf7kp5VWlDCqf2kzwnyNRlRvSpSE6
 hgJIWznzy3qDctkaMn2LCK0cZdiqAkCpOeZTfSSvZYjnF9j3LwLXXJ/F
X-Gm-Gg: AeBDieu6QOKDLgfkYXSKdb1qYAxnLu2rZWaUDI9mqMsGgel+avx0wrZY5qrhVDeOoKT
 gpwFBdIzPSMQXyBg843vxKh/EE18CWS1HahcPtCZuDLzFRtpOWlmyfayh87CMapmXucX/oDPh8Z
 rrKFh3NmKJp4D17ryFr2gdAGnVlwmVcuAATUf87qc/ECcuAwPxoafSYtOm8xBv471w+UOURZkx7
 sv1Rxacm1U0J9KhEOFtJRcCLMRBroIWjlvQ4T+OcczwRZ4e3Oogf2JrFWx5LfexNOLUiPPJjSpn
 CYesejUULcNncmwtMLXseyLYxlKLNOaN6iVUHwycqCu5aHUjZKO20jnEPXfwaOrFXYWUdpgyGtJ
 y0mnvnuhlHD/lWqGcr/P1Ccm8I3IJCpszQutiEoAnbjDnRxE59A4ognUrYOUD94jKVgLpIDrSO6
 WzbN+CVjSUbtl82jnCH100ha31/qRPeFSrLRuYGlEamor9BSM=
X-Received: by 2002:a05:600c:3110:b0:485:3abe:ab86 with SMTP id
 5b1f17b1804b1-488fb739ce4mr254012975e9.4.1776776129555; 
 Tue, 21 Apr 2026 05:55:29 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15aa:5a00:935c:42ec:dfce:89a2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb79ecb9sm154777915e9.8.2026.04.21.05.55.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 05:55:29 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: alexander.deucher@amd.com, Prike.Liang@amd.com, sukhatri@amd.com,
 amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com
Subject: [PATCH 11/11] drm/amdgpu: WIP sync amdgpu_ttm_fill_mem only to kernel
 fences
Date: Tue, 21 Apr 2026 14:55:13 +0200
Message-ID: <20260421125513.4545-11-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421125513.4545-1-christian.koenig@amd.com>
References: <20260421125513.4545-1-christian.koenig@amd.com>
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
index 4c7d1917d9bb..5130f77b7543 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2417,12 +2417,14 @@ static int amdgpu_ttm_prepare_job(struct amdgpu_device *adev,
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
@@ -2438,8 +2440,7 @@ static int amdgpu_ttm_prepare_job(struct amdgpu_device *adev,
 	if (!resv)
 		return 0;
 
-	return drm_sched_job_add_resv_dependencies(&(*job)->base, resv,
-						   DMA_RESV_USAGE_BOOKKEEP);
+	return drm_sched_job_add_resv_dependencies(&(*job)->base, resv, usage);
 }
 
 int amdgpu_copy_buffer(struct amdgpu_device *adev,
@@ -2468,9 +2469,9 @@ int amdgpu_copy_buffer(struct amdgpu_device *adev,
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
 
@@ -2513,6 +2514,7 @@ static int amdgpu_ttm_fill_mem(struct amdgpu_device *adev,
 	num_loops = DIV_ROUND_UP_ULL(byte_count, max_bytes);
 	num_dw = ALIGN(num_loops * adev->mman.buffer_funcs->fill_num_dw, 8);
 	r = amdgpu_ttm_prepare_job(adev, entity, num_dw, resv,
+				   DMA_RESV_USAGE_KERNEL,
 				   vm_needs_flush, &job, k_job_id);
 	if (r)
 		return r;
-- 
2.43.0

