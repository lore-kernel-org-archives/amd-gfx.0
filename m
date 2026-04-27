Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D15AEFF8860
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 18:27:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 723D210E8C1;
	Mon, 27 Apr 2026 18:27:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Mh/A7k6M";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1F9B10E8BC
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 18:27:30 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4890098abbaso83870575e9.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 11:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777314449; x=1777919249; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=FXOIxAVnbDqcBbL8Oow0AZzgIVnEysY5ba/JO00V+ak=;
 b=Mh/A7k6MCa7r/eIMfncDVoGlUTJ/6cO6dk6d/I6Ri0jhv65QkQvKi/aWoQp46m+dKH
 ECYCcRpXw4lAuOcS7qVEjbQY7IQUMk03c7yj2DC7jrCsYX+QbGB+vSyP9ajQokQUVgor
 7OPzJXlelOtALNOmQM5XD3nLy32tY8gReQlMo6YQ3VdOGs7q4PXIIeYIn5R1u+gIEEGb
 D9A1nozqD9EGAd1F3Yeh8W+8VzP5VTXIHpFWW0fEav2mWGRBg7UskV/5uI1rBvXFhnVS
 c8ymT1+I25dYK4VNhdooovZb3YZZZStus3oUSlCCFCPJy5tRX4vV2qWgicKBi1lHCWk7
 GR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777314449; x=1777919249;
 h=content-transfer-encoding:reply-to:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FXOIxAVnbDqcBbL8Oow0AZzgIVnEysY5ba/JO00V+ak=;
 b=YKQSVh1KT2a5d2BitOv35Ono1VDpz3fGHeV5sJ6KWnjT+TTNoCRbVrCapgntRkzn1b
 l9+niUhjQ9DqMhqxDHsVBG2S26k+a5apydluJgdzTpUwXgJ9OXZG6LT+Tthh/ZmE03OR
 tOi61g6Z87tnWKegudSQaOoBDg0fljczMaQ29bTiXEpzicQc1Q8aDG7f+b8dxWhAgIR3
 xqJVMLRwN1yXtPIgTFCHyeLcc41ijLawMZPKKTh6+a4xFTeOGgqDIMc3W22C3i8yDIal
 Vl8E/p8GTeVfoR2OH05RxWuhEABavC3aWNFtet7vkIgOYaimACYklaCyMSuAYIlfasMq
 T20g==
X-Gm-Message-State: AOJu0YwG3M4j92B3a9bLthLKYCyI0wRcXdqk8DaBu8SjEZCvrYnVovFT
 aK5DwTdlsGdUP4G/9/GdlCBf6lrzM4HXlMRM8zb3Xk+WEQYVcbwVISKt
X-Gm-Gg: AeBDieuCmUJdQuidcXlxVRSxvVcsJaG1YaF6x1cDhtuEeKhaLAyBd0neAQHg73P/Gv2
 x6k0u+i2P3BQqSI7MOUxEdFAu3UflGDEmvSId1TAnTkoD4Emuz9EznUBepH3Ohx8Ir1A9tE7xhw
 svlDa8u3sjrlv8KfZBRTVdKo2uF3cS14BlyT5lK8jCorKy3xYp0n9sqL4UCSUncdifNghrMFEUG
 6tYNOqpqBgJowGVSHKfMfs3wQNUy+r4D5zizbgYHhJxssNY1fZoo0S7XA/iP7IAPRf6RHhtv0rm
 AHy0LSo9zNrLEP93bLWLX3Sj0nm2dnRrZykEihrzczalgPJt/ZDFU61F0ub6FjbM9kOR5c9ihSC
 lQ+ONNl6J3veWSHSoPHP1L7sSNAIfc5fu+Q+RGrMiy6nXqXAMoQddWxt7EoGGqxOhGLq0P8+gUJ
 JapI90UALzGModEmAFHk3yRFrAUT+IzLX8iYZSbpO/ithlRQ==
X-Received: by 2002:a05:600c:470a:b0:48a:7772:c26b with SMTP id
 5b1f17b1804b1-48a7772c28emr234845e9.26.1777314449209; 
 Mon, 27 Apr 2026 11:27:29 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:153b:d200:96aa:46be:4d7:72d2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a773af5c5sm6046165e9.5.2026.04.27.11.27.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 11:27:28 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: alexander.deucher@amd.com, Prike.Liang@amd.com, sukhatri@amd.com,
 jesse.zhang@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 7/8] drm/amdgpu: fix handling in amdgpu_userq_create
Date: Mon, 27 Apr 2026 20:27:22 +0200
Message-ID: <20260427182723.1715-7-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427182723.1715-1-christian.koenig@amd.com>
References: <20260427182723.1715-1-christian.koenig@amd.com>
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

Well mostly the same issues the other code had as well:

1. Memory allocation while holding the userq_mutex lock is forbidden!
2. Things were created/started/published in the wrong order.
3. Error messages on invalid input parameters can spam the logs.
4. Error messages on memory allocation failures are usually superflous
   as well.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 118 ++++++++++------------
 1 file changed, 52 insertions(+), 66 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 0374a70b631c..28e0695b53e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -718,14 +718,14 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	const struct amdgpu_userq_funcs *uq_funcs;
 	struct amdgpu_usermode_queue *queue;
 	struct amdgpu_db_info db_info;
-	bool skip_map_queue;
-	u32 qid;
 	uint64_t index;
-	int r = 0;
-	int priority =
-		(args->in.flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_MASK) >>
-		AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_SHIFT;
+	int priority;
+	u32 qid;
+	int r;
 
+	priority =
+		(args->in.flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_MASK)
+		>> AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_SHIFT;
 	r = amdgpu_userq_priority_permit(filp, priority);
 	if (r)
 		return r;
@@ -738,40 +738,43 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 
 	uq_funcs = adev->userq_funcs[args->in.ip_type];
 	if (!uq_funcs) {
-		drm_file_err(uq_mgr->file, "Usermode queue is not supported for this IP (%u)\n",
-			     args->in.ip_type);
 		r = -EINVAL;
 		goto err_pm_runtime;
 	}
 
 	queue = kzalloc(sizeof(struct amdgpu_usermode_queue), GFP_KERNEL);
 	if (!queue) {
-		drm_file_err(uq_mgr->file, "Failed to allocate memory for queue\n");
 		r = -ENOMEM;
 		goto err_pm_runtime;
 	}
 
+	kref_init(&queue->refcount);
 	INIT_LIST_HEAD(&queue->userq_va_list);
 	queue->doorbell_handle = args->in.doorbell_handle;
 	queue->queue_type = args->in.ip_type;
 	queue->vm = &fpriv->vm;
 	queue->priority = priority;
-
-	db_info.queue_type = queue->queue_type;
-	db_info.doorbell_handle = queue->doorbell_handle;
-	db_info.db_obj = &queue->db_obj;
-	db_info.doorbell_offset = args->in.doorbell_offset;
-
 	queue->userq_mgr = uq_mgr;
+	INIT_DELAYED_WORK(&queue->hang_detect_work,
+			  amdgpu_userq_hang_detect_work);
 
-	/* Validate the userq virtual address.*/
-	r = amdgpu_bo_reserve(fpriv->vm.root.bo, false);
+	mutex_init(&queue->fence_drv_lock);
+	xa_init_flags(&queue->fence_drv_xa, XA_FLAGS_ALLOC);
+	r = amdgpu_userq_fence_driver_alloc(adev, &queue->fence_drv);
 	if (r)
 		goto free_queue;
 
-	if (amdgpu_userq_input_va_validate(adev, queue, args->in.queue_va, args->in.queue_size) ||
-	    amdgpu_userq_input_va_validate(adev, queue, args->in.rptr_va, AMDGPU_GPU_PAGE_SIZE) ||
-	    amdgpu_userq_input_va_validate(adev, queue, args->in.wptr_va, AMDGPU_GPU_PAGE_SIZE)) {
+	/* Make sure the queue can actually run with those virtual addresses. */
+	r = amdgpu_bo_reserve(fpriv->vm.root.bo, false);
+	if (r)
+		goto free_fence_drv;
+
+	if (amdgpu_userq_input_va_validate(adev, queue, args->in.queue_va,
+					   args->in.queue_size) ||
+	    amdgpu_userq_input_va_validate(adev, queue, args->in.rptr_va,
+					   AMDGPU_GPU_PAGE_SIZE) ||
+	    amdgpu_userq_input_va_validate(adev, queue, args->in.wptr_va,
+					   AMDGPU_GPU_PAGE_SIZE)) {
 		r = -EINVAL;
 		amdgpu_bo_unreserve(fpriv->vm.root.bo);
 		goto clean_mapping;
@@ -779,6 +782,10 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	amdgpu_bo_unreserve(fpriv->vm.root.bo);
 
 	/* Convert relative doorbell offset into absolute doorbell index */
+	db_info.queue_type = queue->queue_type;
+	db_info.doorbell_handle = queue->doorbell_handle;
+	db_info.db_obj = &queue->db_obj;
+	db_info.doorbell_offset = args->in.doorbell_offset;
 	index = amdgpu_userq_get_doorbell_index(uq_mgr, &db_info, filp);
 	if (index == (uint64_t)-EINVAL) {
 		drm_file_err(uq_mgr->file, "Failed to get doorbell for queue\n");
@@ -787,82 +794,61 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	}
 
 	queue->doorbell_index = index;
-	mutex_init(&queue->fence_drv_lock);
-	xa_init_flags(&queue->fence_drv_xa, XA_FLAGS_ALLOC);
-	r = amdgpu_userq_fence_driver_alloc(adev, &queue->fence_drv);
-	if (r) {
-		drm_file_err(uq_mgr->file, "Failed to alloc fence driver\n");
-		goto clean_mapping;
-	}
-
 	r = uq_funcs->mqd_create(queue, &args->in);
 	if (r) {
 		drm_file_err(uq_mgr->file, "Failed to create Queue\n");
-		goto clean_fence_driver;
+		goto clean_mapping;
 	}
 
+	r = xa_err(xa_store_irq(&adev->userq_doorbell_xa, index, queue,
+				GFP_KERNEL));
+	if (r)
+		goto clean_mqd;
+
 	amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
 
 	/* don't map the queue if scheduling is halted */
-	if (adev->userq_halt_for_enforce_isolation &&
-	    ((queue->queue_type == AMDGPU_HW_IP_GFX) ||
-	     (queue->queue_type == AMDGPU_HW_IP_COMPUTE)))
-		skip_map_queue = true;
-	else
-		skip_map_queue = false;
-	if (!skip_map_queue) {
+	if (!adev->userq_halt_for_enforce_isolation ||
+	    ((queue->queue_type != AMDGPU_HW_IP_GFX) &&
+	     (queue->queue_type != AMDGPU_HW_IP_COMPUTE))) {
 		r = amdgpu_userq_map_helper(queue);
 		if (r) {
 			drm_file_err(uq_mgr->file, "Failed to map Queue\n");
-			goto clean_mqd;
+			mutex_unlock(&uq_mgr->userq_mutex);
+			goto clean_doorbell;
 		}
 	}
 
-	/* drop this refcount during queue destroy */
-	kref_init(&queue->refcount);
-
-	/* Wait for mode-1 reset to complete */
-	down_read(&adev->reset_domain->sem);
+	atomic_inc(&uq_mgr->userq_count[queue->queue_type]);
+	mutex_unlock(&uq_mgr->userq_mutex);
 
 	r = xa_alloc(&uq_mgr->userq_xa, &qid, queue,
-		     XA_LIMIT(1, AMDGPU_MAX_USERQ_COUNT), GFP_KERNEL);
-	if (r) {
-		if (!skip_map_queue)
-			amdgpu_userq_unmap_helper(queue);
-		r = -ENOMEM;
-		goto clean_reset_domain;
-	}
-
-	r = xa_err(xa_store_irq(&adev->userq_doorbell_xa, index, queue, GFP_KERNEL));
+		     XA_LIMIT(1, AMDGPU_MAX_USERQ_COUNT),
+		     GFP_KERNEL);
 	if (r) {
-		xa_erase(&uq_mgr->userq_xa, qid);
-		if (!skip_map_queue)
-			amdgpu_userq_unmap_helper(queue);
-		goto clean_reset_domain;
+		/*
+		 * This drops the last reference which should take care of
+		 * all cleanup.
+		 */
+		amdgpu_userq_put(queue);
+		return r;
 	}
-	up_read(&adev->reset_domain->sem);
 
 	amdgpu_debugfs_userq_init(filp, queue, qid);
-	INIT_DELAYED_WORK(&queue->hang_detect_work,
-			  amdgpu_userq_hang_detect_work);
-
 	args->out.queue_id = qid;
-	atomic_inc(&uq_mgr->userq_count[queue->queue_type]);
-	mutex_unlock(&uq_mgr->userq_mutex);
 	return 0;
 
-clean_reset_domain:
-	up_read(&adev->reset_domain->sem);
+clean_doorbell:
+	xa_erase_irq(&adev->userq_doorbell_xa, index);
 clean_mqd:
-	mutex_unlock(&uq_mgr->userq_mutex);
 	uq_funcs->mqd_destroy(queue);
-clean_fence_driver:
-	amdgpu_userq_fence_driver_free(queue);
 clean_mapping:
 	amdgpu_bo_reserve(fpriv->vm.root.bo, true);
 	amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
 	amdgpu_bo_unreserve(fpriv->vm.root.bo);
 	mutex_destroy(&queue->fence_drv_lock);
+free_fence_drv:
+	amdgpu_userq_fence_driver_free(queue);
 free_queue:
 	kfree(queue);
 err_pm_runtime:
-- 
2.43.0

