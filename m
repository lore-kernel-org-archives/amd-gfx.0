Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D747FD707A
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 10:55:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2888E10E5D2;
	Tue, 17 Mar 2026 10:55:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UnAABQfX";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 818C010E5CD
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 10:55:12 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-43b45bb7548so1375830f8f.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 03:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773744911; x=1774349711; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8FB5qahsoj4Lp6E47t/joa45nd7y5/Oshsj4a0TEuw4=;
 b=UnAABQfXUkmua6xZ9xp/zQ/G8o1QRpR6w6O9J9Fnn+n+zFy+wPiEJYKpzqDFs37PJe
 2H2NivpaivREp/gJ1Pt1KToxsiNHwfJulyfbtzmkb3ciH8KUxaVCU50ADAVjqWsLvg0M
 I9XZ797k+0hbvZB8aozFVvfusOCfaKy/muVVKhqx7zx/90mIbEL/xGcqU2sjM0SaMjPR
 FFnaQDlCCvrtgNlfu+Zv6C65Qsq0AtoiFp8+lhFhP0p1w9O9su3DsrGDwEcCi7WFgRl7
 ovoBtkP6+pn4X09qpQf7ggN34TdFqhhPuOziyDzXe8mjAVWULZ4d29WBmJmLWK8CfEeL
 Kg3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773744911; x=1774349711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8FB5qahsoj4Lp6E47t/joa45nd7y5/Oshsj4a0TEuw4=;
 b=Qg1AMduqXOmUngSGBweSEFsroBn75CwAMbOUTut+6gG7HZWBf7HsG2ZFOcEyOjIbx/
 1fqAQ6bkbIV6n88OZhTpURAihxoZGc5VsSZGnR7By7Mh2RihXrXHu99uQgLJZnR5QiuB
 E+ARpPht0m93xgrwjByKe5RtZebwAeexilP92yF3WXrgXb08SDKecmbiOwNzCHmh0zgu
 z+OSZnHPOK+x6aIInAkI5nkE48yc7zxl3vlK1nYM5p7Rz4aCYP1obDmV68Ymm+4Ozqnx
 B3Cl6iXYmSM7nMiW0DftkPJX7lOVT1TtJkP988Z2lXZOL73U5sSxp7MnjM8wZyGxeDhS
 z3lg==
X-Gm-Message-State: AOJu0YySiUZ4IIguRqnm73sS9axdBM1lpqas22vF7BsvikBojrkax1sc
 hoYX9GSW5XnjfLseLFDHuF6RbwkQNjUmMBII5lj6AoRF1+dk0621JcUf
X-Gm-Gg: ATEYQzzswjdN8/ZTkoCJSvxNiXioaF78aYf8HpA2PM/poa5lWNghvs6NiCvDj8t+4eK
 EkCrWmHUBrYn/ZvsAWDh/RYKYel7IqFqLp1SLFZSk5Ra/TqRkxTtA7M4eFLR3y6RLENWrLQpFiP
 TMTQei6zEA5Xc1ImEwwnsfHGLRrnphqAryvAkmQXEkQ3pOE/XvUvuuwcDBr1NOoqvNTgoj9xBUz
 ApbTLIn0TVNbnFNT7AxpIVX0S47ES/4MDWZOcQeP9RJFrqNAj3OQ8qwf/GaA+zfpNDLGm+3xz41
 qZ0HuPiIEBFZPug6MgT/oZnps68MB0srRyZxfKrj/YFdwxdvktBskblgKkCSZJDWbAQU3Q1qSgu
 kaPxIKEX5uO9DyG4IT6Jz7OBAAB13+lu4sW5jOnIgukoys0aO/Z+WB9201pjzeC/k7U7yWOXpfn
 vZqQRm1vrlt9vCASyjrXdNvWgny7lMrxT4dzM9
X-Received: by 2002:a05:6000:2288:b0:439:b79d:b9a5 with SMTP id
 ffacd0b85a97d-43a04dae73dmr30335342f8f.37.1773744910943; 
 Tue, 17 Mar 2026 03:55:10 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1570:2300:fbdd:8811:84b7:347c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe20bd9csm49852223f8f.21.2026.03.17.03.55.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 03:55:10 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: sukhatri@amd.com, tursulin@ursulin.net, Alexander.Deucher@amd.com,
 Prike.Liang@amd.com, SRINIVASAN.SHANMUGAM@amd.com, christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 10/10] drm/amdgpu: WIP sync amdgpu_ttm_fill_mem only to kernel
 fences
Date: Tue, 17 Mar 2026 11:55:00 +0100
Message-ID: <20260317105501.21479-10-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317105501.21479-1-christian.koenig@amd.com>
References: <20260317105501.21479-1-christian.koenig@amd.com>
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

