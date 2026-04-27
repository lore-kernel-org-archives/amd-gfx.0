Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 749DEFF886C
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 18:27:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1341210E8BC;
	Mon, 27 Apr 2026 18:27:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JyDXLjH+";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BFEE10E8BC
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 18:27:30 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-48909558b3aso105759485e9.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 11:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777314449; x=1777919249; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=sV4/iVjPPR499XzkH2vzTp6cQOwkXuP+MzvFPExzNgQ=;
 b=JyDXLjH+bUGISEdBGEB1Lwf0/CYVENmHgAYrgBKCcTo8Yek9bib04lRE8oH1QSheS/
 7RbTqOGfdaRvZQXA9VxCNIUjm9K7crB8FNNPq8yKQjPGt5RlH52lzIJbd6f5sY/ZliPm
 DQYS4XzCni0rHeHTUF1swUTE0hyTHk+lbLkvOz6lQuHIQWufIpwHcWRhYwgJ71KQlrmD
 x7lsFjPrJAafWIFOjznPbc3o0RB21BmHyPqPC36Q3S8oRMTfh81QfAxAdJiuM2eA/6l/
 lrGmXhyjXh3L1I8DNl+BZy+JfO7EB+aXDKhVsUAVrEMpxPicFGKP8HO/ILvcvyrmwX+I
 qgzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777314449; x=1777919249;
 h=content-transfer-encoding:reply-to:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sV4/iVjPPR499XzkH2vzTp6cQOwkXuP+MzvFPExzNgQ=;
 b=Blq6ST1gQPF1227lC68YS1s/FQirqmsb2JUvMhvpCqFsuCwk5qkre7Z4KLBtLLWPay
 /hoNmF2aj4/DgWkAnNJx3Pn+v3RSgEKk+OAiI0ynWSaZuoHxaLwNsoNFtcHUBfYRuuSD
 jry9zq582Z6RYOrn8m9vT9gzqJ/DGm86YWwCsysWyZ/VJSUN0FuJSoO5Tz7bzfJaN/8n
 URBTSN0TNPuy3mHo7bdF9ejQyJ1sXSEJBUenfuMJacI9PjBiApjL4jmPPcbxLr6WuWSD
 7JzZx6F7VoSXjoO855hFKmWUzNEdmCu6KG4ivYGvTUwzmWiYJ6I9wVvz+wDgUpWDjDkX
 hDGA==
X-Gm-Message-State: AOJu0YwOKHlb9ie2VExaR96SJrj9jMyOawdjOonWXf4Zq+UAGbbRTd3B
 TUjEOPwQRZ1MkvbQIPcnOgdMTKN0umfqbfN5rDvjyBMjNKG2fdyjk8X1v1LYJduY
X-Gm-Gg: AeBDieugZ/pkd+VPmcOdEv5JD7WYD3Ocns+L9o+45NkhtmrsUxERLOg5jUiW/rnU+lh
 s2O3ajguy1dqGak1TfztKTOtMRnGNbgl4t+Le+SapGC0DT7DGErIXTJdKgP5cy7apV1cxckv11D
 BQHxljAQUYiJhz//J/0fi5BW4k2hAupXmwxLAnUaRVs7VDQ9ClQrmIErkYj5z1zIbBOhlC+yBFW
 vVkIhGFC3FZEQk/24MbaJ2T7lMdowC09VmUOQxZiSc2nIkelv/dS3a7ltlWOMvoN6yKwgQBs1IG
 k2lrW0Frg7SDDuy55DGlGnMt4uxuw0c3dyGVIDW3XI50964iHHZCCYCP83IIj6C8iLPC8yYzv6O
 GwEalCnWJL4N7F8f17m7x7gf0KOVweflVR5PD4T/vDRzgnJNNznd85EuHIAiUHSJS2kTHiZOm5t
 fa5A5EDZf7iRzJIHpBddYzqIAyGszT+wLFO4p+uPmaCI1+uQ==
X-Received: by 2002:a05:600c:5492:b0:485:46fd:7887 with SMTP id
 5b1f17b1804b1-48a76f59564mr7113765e9.13.1777314448533; 
 Mon, 27 Apr 2026 11:27:28 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:153b:d200:96aa:46be:4d7:72d2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a773af5c5sm6046165e9.5.2026.04.27.11.27.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 11:27:28 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: alexander.deucher@amd.com, Prike.Liang@amd.com, sukhatri@amd.com,
 jesse.zhang@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 6/8] drm/amdgpu: rework userq reset work handling
Date: Mon, 27 Apr 2026 20:27:21 +0200
Message-ID: <20260427182723.1715-6-christian.koenig@amd.com>
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
index 4bb8c34d2dd9..c400b4c5dda3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3790,7 +3790,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	}
 
 	INIT_WORK(&adev->xgmi_reset_work, amdgpu_device_xgmi_reset_func);
-	INIT_WORK(&adev->userq_reset_work, amdgpu_userq_reset_work);
 
 	amdgpu_coredump_init(adev);
 
@@ -5481,7 +5480,7 @@ static inline void amdgpu_device_stop_pending_resets(struct amdgpu_device *adev)
 	if (!amdgpu_sriov_vf(adev))
 		cancel_work(&adev->reset_work);
 #endif
-	cancel_work(&adev->userq_reset_work);
+	amdgpu_userq_mgr_cancel_reset_work(adev);
 
 	if (adev->kfd.dev)
 		cancel_work(&adev->kfd.reset_work);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index b2c64a05d03a..0374a70b631c 100644
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
@@ -1258,28 +1262,13 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
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
@@ -1313,9 +1302,24 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *f
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

