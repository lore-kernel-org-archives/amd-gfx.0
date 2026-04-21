Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9024F8FA6D
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2026 12:55:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FCF710EC87;
	Tue, 21 Apr 2026 12:55:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PBL4Q65K";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1006610EC53
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2026 12:55:28 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso48111965e9.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2026 05:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776776126; x=1777380926; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=14qjBgj0a4nnUKPk7RBj9nNVk0k4m18B6ZOl27i4y/M=;
 b=PBL4Q65KHVe5SPLPb/VONSKWG7Sy16M9i2b9njcuAFX72KaVQNAz64EMKFY6UmKGZa
 6BFvdkEHle38p0Wefr8Zhrr26MTFqyS5g9MLknNzvZqVnwsi1fJPM1nbmnZgF3tbED/Z
 mej/2JiqUZmxS9qwDlMRhpd2XuiXVIH5aI62MEnVvosAs4mI8viHt5anfRicr3Tnhc7a
 ti71sbE/9QcdVnxy9BtWiXD1A7Bl9YSQh4SeQT1z/cueCvW/gDAOT5gpZsHnocKs/1ai
 sKQ1pVKGzIJVVniJvd4c4oolLbd2myo40lm39DHXAn8LGRUi/omeQLoSvFXSGlGE3juU
 Y3YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776776126; x=1777380926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=14qjBgj0a4nnUKPk7RBj9nNVk0k4m18B6ZOl27i4y/M=;
 b=bhc38Udu2lTmYxB3ZB4nhe1YAm9MhrFEi4vw/DRDafxG1kEVUSQVCe1NzztZimTyQG
 2cfkR4L08Exj2zIuwH9zw5spF6UaaWQJxekRMFuW4ShQbHdkrk88+UNUkslXob/LurRD
 WABrvnjxVi0OE8TPNqhsZOduFnwgTgEug5xFV2n+njZOIC6UqbakMai2ywQT3zxMdkdw
 nkUU2+kwZE88LYkqFibdgZ1fA+MZilT1faMUQB0fIUdF0kVmrPmDZ9H4jKO+hhBM888l
 xfyaIL4gn5ENcex4DaTLLjEXlDDHn1y552C6d0OFO1A/DkF0rtN9FVJc4WwLRLQHrXEy
 RIyA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8e0/4zONKVhkrjKu5+oJlnn9tGP2ZjrXdkijXlTOLuLzyEQi/iQ0b2iQT7Zd2l8S81llsSD0el@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyixx95oBpYPK0dSs6382WHJ19j71aN0XPRi37m/kdOaAVwZ0cA
 vn7b94+Du5S229SpDzqIbF9+sec5Lb0+H9TzWA1zGoL2y0fi1vr6wEPG
X-Gm-Gg: AeBDieuJ6W+d/hvRRw33+WBrCfwJ774xnfE3ci0vySv5QDvRgUpA305jmRMozg8S1RN
 eMlAZ9tBbvLp7qxtFrXGlcen9lG+BQaGNlkifwXiE7CxeUGYkcSaAegLMVyFuGlPUc6CJ3HFe2+
 nU9NI2FyP1wpKlFNb68trTyp8G7bZsZPERcdpZjMJCDu8WqQ1XFkLaNbAaxBxPRt3PdUOA2qESS
 lBO0WkI7pVyLTRxGPXmhvxYaJXMur0VSJMQSVSVTYggBlHnqzhPnScSrIvoHdx5IPlP7SGabRDj
 R9imeynAgx9ZAdbRPe3miNLZ3SbEZ1Iom9imcD/DpiPv6NPsDfaXzyTNKygqPHfjzaIBKEYKlDq
 eMe76M19Q71wKcd3AMfR4JkDpJE0ogMd7Yq4PyBJT0rhnZ+EYR9hMFUXPyfZyYkbXUWf39le51s
 JQB12j/0YWGLK8pOQmqT8qgySUhZ3Ki4KB/Uq0vcjSVWWz8og=
X-Received: by 2002:a05:600c:888b:b0:485:4bd1:4c64 with SMTP id
 5b1f17b1804b1-488fb796f95mr209584615e9.31.1776776126376; 
 Tue, 21 Apr 2026 05:55:26 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15aa:5a00:935c:42ec:dfce:89a2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb79ecb9sm154777915e9.8.2026.04.21.05.55.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 05:55:25 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: alexander.deucher@amd.com, Prike.Liang@amd.com, sukhatri@amd.com,
 amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com
Subject: [PATCH 08/11] drm/amdgpu: rework userq reset work handling
Date: Tue, 21 Apr 2026 14:55:10 +0200
Message-ID: <20260421125513.4545-8-christian.koenig@amd.com>
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

It is illegal to schedule reset work from another reset work!

Fix this by scheduling the userq reset work directly on the work queue
of the reset domain.

Not fully tested, I leave that to the IGT test cases.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 84 +++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  | 16 ++++-
 4 files changed, 60 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 39894e38fee4..17341e384caf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1191,7 +1191,6 @@ struct amdgpu_device {
 	bool                            apu_prefer_gtt;
 
 	bool                            userq_halt_for_enforce_isolation;
-	struct work_struct              userq_reset_work;
 	struct amdgpu_uid *uid_info;
 
 	struct amdgpu_uma_carveout_info uma_info;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b11c4b5fa8fc..cf61be17e061 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3786,7 +3786,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	}
 
 	INIT_WORK(&adev->xgmi_reset_work, amdgpu_device_xgmi_reset_func);
-	INIT_WORK(&adev->userq_reset_work, amdgpu_userq_reset_work);
 
 	amdgpu_coredump_init(adev);
 
@@ -5477,7 +5476,7 @@ static inline void amdgpu_device_stop_pending_resets(struct amdgpu_device *adev)
 	if (!amdgpu_sriov_vf(adev))
 		cancel_work(&adev->reset_work);
 #endif
-	cancel_work(&adev->userq_reset_work);
+	amdgpu_userq_mgr_cancel_reset_work(adev);
 
 	if (adev->kfd.dev)
 		cancel_work(&adev->kfd.reset_work);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 0a4c39d83adc..ad6dac17dd21 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -82,19 +82,11 @@ static bool amdgpu_userq_is_reset_type_supported(struct amdgpu_device *adev,
 	return false;
 }
 
-static void amdgpu_userq_gpu_reset(struct amdgpu_device *adev)
-{
-	if (amdgpu_device_should_recover_gpu(adev)) {
-		amdgpu_reset_domain_schedule(adev->reset_domain,
-					     &adev->userq_reset_work);
-		/* Wait for the reset job to complete */
-		flush_work(&adev->userq_reset_work);
-	}
-}
-
-static int
-amdgpu_userq_detect_and_reset_queues(struct amdgpu_userq_mgr *uq_mgr)
+static void amdgpu_userq_mgr_reset_work(struct work_struct *work)
 {
+	struct amdgpu_userq_mgr *uq_mgr =
+		container_of(work, struct amdgpu_userq_mgr,
+			     reset_work);
 	struct amdgpu_device *adev = uq_mgr->adev;
 	const int queue_types[] = {
 		AMDGPU_RING_TYPE_COMPUTE,
@@ -103,12 +95,11 @@ amdgpu_userq_detect_and_reset_queues(struct amdgpu_userq_mgr *uq_mgr)
 	};
 	const int num_queue_types = ARRAY_SIZE(queue_types);
 	bool gpu_reset = false;
-	int r = 0;
-	int i;
+	int i, r;
 
 	if (unlikely(adev->debug_disable_gpu_ring_reset)) {
 		dev_err(adev->dev, "userq reset disabled by debug mask\n");
-		return 0;
+		return;
 	}
 
 	/*
@@ -116,7 +107,7 @@ amdgpu_userq_detect_and_reset_queues(struct amdgpu_userq_mgr *uq_mgr)
 	 * skip all reset detection logic
 	 */
 	if (!amdgpu_gpu_recovery)
-		return 0;
+		return;
 
 	/*
 	 * Iterate through all queue types to detect and reset problematic queues
@@ -141,10 +132,19 @@ amdgpu_userq_detect_and_reset_queues(struct amdgpu_userq_mgr *uq_mgr)
 		}
 	}
 
-	if (gpu_reset)
-		amdgpu_userq_gpu_reset(adev);
+	if (gpu_reset) {
+		struct amdgpu_reset_context reset_context;
 
-	return r;
+		memset(&reset_context, 0, sizeof(reset_context));
+
+		reset_context.method = AMD_RESET_METHOD_NONE;
+		reset_context.reset_req_dev = adev;
+		reset_context.src = AMDGPU_RESET_SRC_USERQ;
+		set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
+		/*set_bit(AMDGPU_SKIP_COREDUMP, &reset_context.flags);*/
+
+		amdgpu_device_gpu_recover(adev, NULL, &reset_context);
+	}
 }
 
 static void amdgpu_userq_hang_detect_work(struct work_struct *work)
@@ -153,7 +153,11 @@ static void amdgpu_userq_hang_detect_work(struct work_struct *work)
 		container_of(work, struct amdgpu_usermode_queue,
 			     hang_detect_work.work);
 
-	amdgpu_userq_detect_and_reset_queues(queue->userq_mgr);
+	/*
+	 * Don't schedule the work here! Scheduling or queue work from one reset
+	 * handler to another is illegal if you don't take extra precautions!
+	 */
+	amdgpu_userq_mgr_reset_work(&queue->userq_mgr->reset_work);
 }
 
 /*
@@ -182,8 +186,8 @@ void amdgpu_userq_start_hang_detect_work(struct amdgpu_usermode_queue *queue)
 		break;
 	}
 
-	schedule_delayed_work(&queue->hang_detect_work,
-		     msecs_to_jiffies(timeout_ms));
+	queue_delayed_work(adev->reset_domain->wq, &queue->hang_detect_work,
+			   msecs_to_jiffies(timeout_ms));
 }
 
 void amdgpu_userq_process_fence_irq(struct amdgpu_device *adev, u32 doorbell)
@@ -1256,28 +1260,13 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
 	if (ret) {
 		drm_file_err(uq_mgr->file,
 			     "Couldn't unmap all the queues, eviction failed ret=%d\n", ret);
-		amdgpu_userq_detect_and_reset_queues(uq_mgr);
+		amdgpu_reset_domain_schedule(uq_mgr->adev->reset_domain,
+					     &uq_mgr->reset_work);
+		flush_work(&uq_mgr->reset_work);
 	}
 	return ret;
 }
 
-void amdgpu_userq_reset_work(struct work_struct *work)
-{
-	struct amdgpu_device *adev = container_of(work, struct amdgpu_device,
-						  userq_reset_work);
-	struct amdgpu_reset_context reset_context;
-
-	memset(&reset_context, 0, sizeof(reset_context));
-
-	reset_context.method = AMD_RESET_METHOD_NONE;
-	reset_context.reset_req_dev = adev;
-	reset_context.src = AMDGPU_RESET_SRC_USERQ;
-	set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
-	/*set_bit(AMDGPU_SKIP_COREDUMP, &reset_context.flags);*/
-
-	amdgpu_device_gpu_recover(adev, NULL, &reset_context);
-}
-
 static void
 amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
 {
@@ -1311,9 +1300,24 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *f
 	userq_mgr->file = file_priv;
 
 	INIT_DELAYED_WORK(&userq_mgr->resume_work, amdgpu_userq_restore_worker);
+	INIT_WORK(&userq_mgr->reset_work, amdgpu_userq_mgr_reset_work);
 	return 0;
 }
 
+void amdgpu_userq_mgr_cancel_reset_work(struct amdgpu_device *adev)
+{
+	struct xarray *xa = &adev->userq_doorbell_xa;
+	struct amdgpu_usermode_queue *queue;
+	unsigned long flags, queue_id;
+
+	xa_lock_irqsave(xa, flags);
+	xa_for_each(xa, queue_id, queue) {
+		cancel_delayed_work(&queue->hang_detect_work);
+		cancel_work(&queue->userq_mgr->reset_work);
+	}
+	xa_unlock_irqrestore(xa, flags);
+}
+
 void amdgpu_userq_mgr_cancel_resume(struct amdgpu_userq_mgr *userq_mgr)
 {
 	cancel_delayed_work_sync(&userq_mgr->resume_work);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 85f460e7c31b..49b33e2d6932 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -84,7 +84,13 @@ struct amdgpu_usermode_queue {
 	u32			xcp_id;
 	int			priority;
 	struct dentry		*debugfs_queue;
-	struct delayed_work hang_detect_work;
+
+	/**
+	 * @hang_detect_work:
+	 *
+	 * Delayed work which runs when userq_fences time out.
+	 */
+	struct delayed_work	hang_detect_work;
 	struct kref		refcount;
 
 	struct list_head	userq_va_list;
@@ -116,6 +122,13 @@ struct amdgpu_userq_mgr {
 	struct amdgpu_device		*adev;
 	struct delayed_work		resume_work;
 	struct drm_file			*file;
+
+	/**
+	 * @reset_work:
+	 *
+	 * Reset work which is used when eviction fails.
+	 */
+	struct work_struct		reset_work;
 	atomic_t                        userq_count[AMDGPU_RING_TYPE_MAX];
 };
 
@@ -134,6 +147,7 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp
 int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *file_priv,
 			  struct amdgpu_device *adev);
 
+void amdgpu_userq_mgr_cancel_reset_work(struct amdgpu_device *adev);
 void amdgpu_userq_mgr_cancel_resume(struct amdgpu_userq_mgr *userq_mgr);
 void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);
 
-- 
2.43.0

