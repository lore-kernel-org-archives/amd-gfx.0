Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7CC2CD6E68
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2026 07:03:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFD8511271A;
	Thu,  4 Jun 2026 07:03:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pEGEKlrQ";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6802F1126D6
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2026 06:42:42 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2bf1f074a12so3982905ad.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 03 Jun 2026 23:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780555362; x=1781160162; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ERlLtZnynL1JYR1BCmWJV8DFDr7q66lNokSGTMbdgUo=;
 b=pEGEKlrQA1CjTeLdDb+tKZYQMVjP4SeMffrl1evnzhV6w8YbrWULELv+crRTO3M05u
 1iDX4VjSG0kS4a0N+TSQIZmzdIgZncc3SHN0PzJ1eC5fy2xNAnsgz6z0zdW4Cr6yf4jO
 sXM1bQSQGD6lpAZHPakbSbb2otbiWxp1D2mNe5dh10o7wXOI0Cy9J821TY8AGurpmk8P
 qSSPQ7aC2+mCDNBG7o1hl/9U0uMGDHhUccFn6ieKfnOPLt1ewKvkUXvJ0660jmXtC6bT
 hYPTz/UcnFJRbWqv4Qrrf/cqdzS8v0dCdybmM/SNUNZZN0X13j0XWq8bYODdjNYVEP93
 gYLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780555362; x=1781160162;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ERlLtZnynL1JYR1BCmWJV8DFDr7q66lNokSGTMbdgUo=;
 b=j/CKbDBMs9UfDrWzzRF+S+iyB9w9KIUVUOISxM52Nr6UHxBzdYqmt+Z1xXm87/+kZy
 UNDrOLNFXoxQwPc8p6bC010x44zoB0Eg35hh+iM5eCxncHSq6IESL9DViJU2CcRznoBP
 xk/SnCe5xugEDq5F63e4B4kSnk2jopE1t3dq9Hcy83b/SEcDilQkXZY/7myBDpatHOqS
 69AsaS90T42H22jvuulm0F3dFz68+W8plBb8sO6omi3SRppyxhqjh8/rz1x6iOkV+0SZ
 aV+QOZwuOLKoYHb3pxChHnXqYdYFi4I1u9qYVgasD0qGinFNzkDxZ4h6Q5iW/ITUGWZf
 pivg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/HeTDqhHbDPU4M8dGyaCw04uiEe0YzobUiuMBY3SdvoS4MiTuXRlgKDIq48ienZViWgw1/krj5@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy0q0BJFBDy1QpeQGv2uFfumdDerk/e+HMGI0fpntz7Ib5wjEWt
 sjMqnRhcUt1yI1huGP++8B2oPLF7blWtSOuOZ9+yvhYd91JrREdTIS/A
X-Gm-Gg: Acq92OHJ7dxq3SI6KUuHjjiGSpZ5x+yfievFcBwxRytopKfhX8OFmOQYx7NQpsQ9BDr
 jxrR/kAuDc9auHS5WtTMn2FL9omLLC4Opjei21GvhN1n/ldlrAErHA3p6q7z7zUg2sPJLBO69oq
 5AyMseLXcumsXK16qucH5VO95GVQW4swYWnBmUOkXKd+N2MpOI7b+HwP3Ieo2ISddFTVBKNHqXG
 nxvMkdZvAa7Dw7EJsl2QPPOxpGlktZfTitmxnP6IYHEaBEDjFbZvxboTOuEpYJGmg26fM/bQxuH
 BJ06OV26wStA15HnlvD33OBn9vPiIyzES8ZVlVkt4sa0L9PQlqBGUGFtdYEKv7fjMj0XtSd9/9V
 RDBgk+YK9QgqBdFchxMzCDPVbHuui3vPXvEjParrA1QUOVhQqOTUxIz+gVKW9bdxu8pwbUbbh25
 MFxeng2pk+MRGLwy2/
X-Received: by 2002:a17:903:41cf:b0:2c0:ca93:1303 with SMTP id
 d9443c01a7336-2c1639ee9e7mr70998755ad.6.1780555361754; 
 Wed, 03 Jun 2026 23:42:41 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164f6dc92sm43801515ad.13.2026.06.03.23.42.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 23:42:41 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Prike Liang <Prike.Liang@amd.com>, Sunil Khatri <sunil.khatri@amd.com>,
 "Jesse.Zhang" <Jesse.Zhang@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH] drm/amdgpu/userq: clean up VA state on create failure
Date: Thu,  4 Jun 2026 14:39:43 +0800
Message-ID: <20260604063943.1412955-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 04 Jun 2026 07:03:56 +0000
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

amdgpu_userq_input_va_validate() is not a side-effect-free validator.
When it succeeds, it allocates a VA cursor, links it on
queue->userq_va_list and marks the corresponding bo_va as userq mapped.

The user queue create path validates queue_va, rptr_va and wptr_va with a
short-circuit OR expression. If an earlier validation succeeds and a
later validation fails, the error path frees the queue directly. The VA
cursor added by the successful validation is leaked and
bo_va->userq_va_mapped remains set even though no user queue was created.

The same stale VA tracking state can also survive later create failures
after all VA validations have succeeded, because those paths also free
the queue without unwinding queue->userq_va_list.

Route the create error paths through common unwind labels and call
amdgpu_userq_buffer_vas_list_cleanup() before freeing the queue. This
releases any VA cursors added during validation and clears the stale
userq VA mapping state.

Fixes: 9e46b8bb0539 ("drm/amdgpu: validate userq buffer virtual address and size")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 32 +++++++++++------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 0a1b93259887..dba0f786ae4a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -826,17 +826,15 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	    amdgpu_userq_input_va_validate(adev, queue, args->in.rptr_va, AMDGPU_GPU_PAGE_SIZE) ||
 	    amdgpu_userq_input_va_validate(adev, queue, args->in.wptr_va, AMDGPU_GPU_PAGE_SIZE)) {
 		r = -EINVAL;
-		kfree(queue);
-		goto unlock;
+		goto free_queue;
 	}
 
 	/* Convert relative doorbell offset into absolute doorbell index */
 	index = amdgpu_userq_get_doorbell_index(uq_mgr, &db_info, filp);
 	if (index == (uint64_t)-EINVAL) {
 		drm_file_err(uq_mgr->file, "Failed to get doorbell for queue\n");
-		kfree(queue);
 		r = -EINVAL;
-		goto unlock;
+		goto free_queue;
 	}
 
 	queue->doorbell_index = index;
@@ -844,15 +842,14 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	r = amdgpu_userq_fence_driver_alloc(adev, queue);
 	if (r) {
 		drm_file_err(uq_mgr->file, "Failed to alloc fence driver\n");
-		goto unlock;
+		goto free_queue;
 	}
 
 	r = uq_funcs->mqd_create(queue, &args->in);
 	if (r) {
 		drm_file_err(uq_mgr->file, "Failed to create Queue\n");
 		amdgpu_userq_fence_driver_free(queue);
-		kfree(queue);
-		goto unlock;
+		goto free_queue;
 	}
 
 	/* drop this refcount during queue destroy */
@@ -862,21 +859,17 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	down_read(&adev->reset_domain->sem);
 	r = xa_err(xa_store_irq(&adev->userq_doorbell_xa, index, queue, GFP_KERNEL));
 	if (r) {
-		kfree(queue);
 		up_read(&adev->reset_domain->sem);
-		goto unlock;
+		goto free_queue;
 	}
 
 	r = xa_alloc(&uq_mgr->userq_xa, &qid, queue,
 		     XA_LIMIT(1, AMDGPU_MAX_USERQ_COUNT), GFP_KERNEL);
 	if (r) {
 		drm_file_err(uq_mgr->file, "Failed to allocate a queue id\n");
-		amdgpu_userq_fence_driver_free(queue);
-		uq_funcs->mqd_destroy(queue);
-		kfree(queue);
 		r = -ENOMEM;
 		up_read(&adev->reset_domain->sem);
-		goto unlock;
+		goto free_queue;
 	}
 	up_read(&adev->reset_domain->sem);
 
@@ -892,10 +885,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		if (r) {
 			drm_file_err(uq_mgr->file, "Failed to map Queue\n");
 			xa_erase(&uq_mgr->userq_xa, qid);
-			amdgpu_userq_fence_driver_free(queue);
-			uq_funcs->mqd_destroy(queue);
-			kfree(queue);
-			goto unlock;
+			goto free_queue;
 		}
 	}
 
@@ -915,7 +905,15 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 
 	args->out.queue_id = qid;
 	atomic_inc(&uq_mgr->userq_count[queue->queue_type]);
+	goto unlock;
 
+free_mqd:
+	uq_funcs->mqd_destroy(queue);
+free_fence_driver:
+	amdgpu_userq_fence_driver_free(queue);
+free_queue:
+	amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
+	kfree(queue);
 unlock:
 	mutex_unlock(&uq_mgr->userq_mutex);
 
-- 
2.43.0

