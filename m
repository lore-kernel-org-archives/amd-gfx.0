Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A885AC52D71
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Aug 2024 01:09:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D053010E03C;
	Thu,  8 Aug 2024 01:09:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=basnieuwenhuizen.nl header.i=@basnieuwenhuizen.nl header.b="N1QVi8lw";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 802D810E029
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Aug 2024 01:09:10 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4280921baa2so476235e9.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Aug 2024 18:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google; t=1723079348; x=1723684148;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ozxQDjawcuuRETBkceg0aDmbspBVS/rCHDlGRpYPEt0=;
 b=N1QVi8lwO0FE9PIpa/ARQu+WUiHpweIXpoLuKZmLLxMjwDUb0nMVZNsq7wVOd/l2zI
 FYlZcByAq7K+FNXNKv3hGufrzZrtF3hLChZcO9p6Xi8KvEw/O3jbJjNt6qCKaqKq8mkG
 mCmYjb8d+ClqDFfqkImXve5ojVNk+iBqdS9yQjAxHahwE45mOzbNMJALA8x0mKQssY6S
 h8CqBlrowP9tEMcpBxNSWdvxTV/233+BQ1G3rVEQSeiAdXcRZ5K1unli0cqAids0zQip
 MeRu1kntTSOTv3yfy9PEgRPAAsJVcWk5rfLWgOFxoSGzSjhzV6EzoV8yFyX3Gh1a1K2C
 d6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723079348; x=1723684148;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ozxQDjawcuuRETBkceg0aDmbspBVS/rCHDlGRpYPEt0=;
 b=w6jUjoilkZCyTbnQ2LOj6kwBlulI0EdY8GX6QvPgzMPJHrt8AbdrOCNyZ9rd43bPSt
 iUKKX4WH/79Hqf1unADd2/bZpSPuooeSaZSZ6mCpdpIAqXCgIY9waoR+8qjUbe04FEG2
 pMSDDDdbuRfyyIdkAyuns9BVaLQa9561XWjbHEigi8chzf+Vh7q3CDyxXlw+CwYA8txh
 Jh/zbn1FibnUMkLlIcGArK2RjBdJtOqBhfoFZMF8WpW0zhDLWgIN8fyF9WCtVAskN0Tw
 HVlQd0rUTwH68bCI1ZkT/ZtwZEPvcsN6JNIAIBpIpHQk2YgHHLOPxmbnF/n7NvjeZlpU
 FP2A==
X-Gm-Message-State: AOJu0YwLnTjty3wp+OmM84KgX0kjgPtVSeUaW70DCXv16w2LK6JG+v97
 EZSuf38zgbtrKTVz6ShwYLIyD6nebxzBe3uo0Qm1RAQHHkBX4w1c28Q37lyI7k9BT1LG5ZKfdKb
 S0EM=
X-Google-Smtp-Source: AGHT+IGNzmH7AKKSbDpiwvwdX/700vSL5Ntws3h299/ZfTa4wHDYs5MwCU3wxYmkd2iLqvLPN2Bx/A==
X-Received: by 2002:a05:6000:1789:b0:36b:b2a1:ef74 with SMTP id
 ffacd0b85a97d-36d27672301mr81259f8f.8.1723079348189; 
 Wed, 07 Aug 2024 18:09:08 -0700 (PDT)
Received: from bas-workstation.. ([2a02:aa12:a781:a500:aaa1:59ff:feea:fd4f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36d272095b9sm240753f8f.68.2024.08.07.18.09.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 18:09:07 -0700 (PDT)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, airlied@gmail.com, faith@gfxstrand.net,
 friedrich.vock@gmx.de, Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Subject: [PATCH 1/6] amdgpu: Add usage argument to amdgpu_sync_resv.
Date: Thu,  8 Aug 2024 03:09:00 +0200
Message-ID: <20240808010905.439060-2-bas@basnieuwenhuizen.nl>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240808010905.439060-1-bas@basnieuwenhuizen.nl>
References: <20240808010905.439060-1-bas@basnieuwenhuizen.nl>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c           | 3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c       | 3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c         | 7 +++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h         | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c      | 3 ++-
 6 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 48ad0c04aa72..a5f517f18903 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1341,6 +1341,7 @@ static int process_sync_pds_resv(struct amdkfd_process_info *process_info,
 		struct amdgpu_bo *pd = peer_vm->root.bo;
 
 		ret = amdgpu_sync_resv(NULL, sync, pd->tbo.base.resv,
+				       DMA_RESV_USAGE_BOOKKEEP,
 				       AMDGPU_SYNC_NE_OWNER,
 				       AMDGPU_FENCE_OWNER_KFD);
 		if (ret)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index ec888fc6ead8..a578da8e2da5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1198,7 +1198,8 @@ static int amdgpu_cs_sync_rings(struct amdgpu_cs_parser *p)
 
 		sync_mode = amdgpu_bo_explicit_sync(bo) ?
 			AMDGPU_SYNC_EXPLICIT : AMDGPU_SYNC_NE_OWNER;
-		r = amdgpu_sync_resv(p->adev, &p->sync, resv, sync_mode,
+		r = amdgpu_sync_resv(p->adev, &p->sync, resv,
+				     DMA_RESV_USAGE_BOOKKEEP, sync_mode,
 				     &fpriv->vm);
 		if (r)
 			return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index c556c8b653fa..66d666c03aed 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1484,7 +1484,8 @@ int amdgpu_bo_sync_wait_resv(struct amdgpu_device *adev, struct dma_resv *resv,
 	int r;
 
 	amdgpu_sync_create(&sync);
-	amdgpu_sync_resv(adev, &sync, resv, sync_mode, owner);
+	amdgpu_sync_resv(adev, &sync, resv, DMA_RESV_USAGE_BOOKKEEP, sync_mode,
+			 owner);
 	r = amdgpu_sync_wait(&sync, intr);
 	amdgpu_sync_free(&sync);
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
index bdf1ef825d89..429602d6b65a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
@@ -233,8 +233,8 @@ static bool amdgpu_sync_test_fence(struct amdgpu_device *adev,
  * Sync to the fence
  */
 int amdgpu_sync_resv(struct amdgpu_device *adev, struct amdgpu_sync *sync,
-		     struct dma_resv *resv, enum amdgpu_sync_mode mode,
-		     void *owner)
+		     struct dma_resv *resv, enum dma_resv_usage usage,
+		     enum amdgpu_sync_mode mode, void *owner)
 {
 	struct dma_resv_iter cursor;
 	struct dma_fence *f;
@@ -243,8 +243,7 @@ int amdgpu_sync_resv(struct amdgpu_device *adev, struct amdgpu_sync *sync,
 	if (resv == NULL)
 		return -EINVAL;
 
-	/* TODO: Use DMA_RESV_USAGE_READ here */
-	dma_resv_for_each_fence(&cursor, resv, DMA_RESV_USAGE_BOOKKEEP, f) {
+	dma_resv_for_each_fence(&cursor, resv, usage, f) {
 		dma_fence_chain_for_each(f, f) {
 			struct dma_fence *tmp = dma_fence_chain_contained(f);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
index cf1e9e858efd..a6fa8e1e8e17 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
@@ -49,8 +49,8 @@ struct amdgpu_sync {
 void amdgpu_sync_create(struct amdgpu_sync *sync);
 int amdgpu_sync_fence(struct amdgpu_sync *sync, struct dma_fence *f);
 int amdgpu_sync_resv(struct amdgpu_device *adev, struct amdgpu_sync *sync,
-		     struct dma_resv *resv, enum amdgpu_sync_mode mode,
-		     void *owner);
+		     struct dma_resv *resv, enum dma_resv_usage usage,
+		     enum amdgpu_sync_mode mode, void *owner);
 struct dma_fence *amdgpu_sync_peek_fence(struct amdgpu_sync *sync,
 				     struct amdgpu_ring *ring);
 struct dma_fence *amdgpu_sync_get_fence(struct amdgpu_sync *sync);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
index 66e8a016126b..259c241f55a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
@@ -98,7 +98,8 @@ static int amdgpu_vm_sdma_prepare(struct amdgpu_vm_update_params *p,
 		return 0;
 
 	amdgpu_sync_create(&sync);
-	r = amdgpu_sync_resv(p->adev, &sync, resv, sync_mode, p->vm);
+	r = amdgpu_sync_resv(p->adev, &sync, resv, DMA_RESV_USAGE_BOOKKEEP,
+			     sync_mode, p->vm);
 	if (!r)
 		r = amdgpu_sync_push_to_job(&sync, p->job);
 	amdgpu_sync_free(&sync);
-- 
2.45.2

