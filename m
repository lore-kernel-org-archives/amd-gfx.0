Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61847606A33D
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2026 08:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tgwpKl/w
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 724BE10F36F;
	Tue, 24 Nov 2026 08:40:27 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE3E510E04F
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2026 02:33:27 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4bb68c197c7so50228235e9.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2026 18:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795487606; x=1796092406; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j9mwc6rMpp4Ga5sYTN+M+X+R5MsOKpnzk7Ke7RTLN+o=;
 b=tgwpKl/wKsgvX4CBR5tIEdrt27d8yBENHLH9B3P9FCeN50IZ4rC+Xc4PjJySAfbmS9
 oH/dMD8oVivoVK+sZILtl9X9f59syKgOvKOBRJvq01hluezUfOXAiNKoQv9wIkK7weFH
 sMFykwdGwZX0cvAzlJgPksAcHk+YdkXf7juhvaBlTGVmQCuDbUgqWas4++v4CD4xVKCe
 uLG1ItQyoB4//fD6ldg+awE4YiDvYlfYEecBy049qYKBCAXKfnZqAI51xJQb0MhbQtCE
 meOXbIDRwDRvNerW1Xaf/9+ccNhXXI5XLIbFc8wDYf8OrMKN14Z0dZbkyMgIyPmcKRJw
 qwhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795487606; x=1796092406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=j9mwc6rMpp4Ga5sYTN+M+X+R5MsOKpnzk7Ke7RTLN+o=;
 b=w+I170KmHADPrf8XgijDqFayYFMe18sGV+wcut++LoG57dVb16USXWF0Efl1JBuDPe
 1Ox+qrnG7eC3J24pnexFKsDNpXp1zrmSPcOBY+89Jau/m2WF4bbEjtbGESkvWQ7h90G3
 E42eW4LxiwXvjA9oywt5o831e1l9wpi/Gr92ywRdX9Dc+bLmsI5bC+z2mOJkHJ4tQs4x
 BAQYvb0EglZxbXNDeKsg99tVrfwwRiaKHmMHbto6gV0SfGNkCrWHKH2KysEHyTiMk6U2
 +l58TC34QGH6LWntx+a31Q0n/2UCTfNbnbbYwifMhe8Rb5sBNF1x7kaXUk1yz3K6pAL5
 6PVQ==
X-Gm-Message-State: APuU4Z+BI7MHL6WpgIetgPdeKDLVsW4gEXUa4UsSEojk8tkGgy9e/hjF
 Trvrudz0eJuYk03EY9nxHto2rwsF6JNDhqC8lY0ED3suJv2Tft45vWM9qXEjIoko
X-Gm-Gg: AZFdTZf5MLqgA7PwR9bedd+Eo1qLcLiDfBM9peHMQa/2AImT/F7d6rA99NLo4g5yR43
 mWsVyKVhZU9GZKnDIKetshUzSmYK0+Ip5x3qMd+2kHmvBPllQyW8/WISbO0glHk9yEpEIQmy2/3
 21BFhSNmbZaD1SszrciYyDqoOweQNxuhJ5BbyddLOIIGyezeIPaS96libRUBlGiJx87e13UN5dd
 NxQ7sRTqAmm7lF5uJdUwhr4qCadb0ASzJ/zER3TO+WMtZrIklIbtqRKmAn8zf+bzLMoAUXo9esy
 rdneOObZm6lMU+ftLkemv5il6pPAWmEBsvtIFgHX4du0CjmoXuyhJDI/AIhTZ1ULloUKo58HMF6
 qikvJPwhpc9Tjo86zlX42YhoMmgTDL9YtzY8Mx8bIYbY0YQAdBZUTMyzt4EyPhU2QLJm1fb4/LG
 0YiYmif4DaDSuvHU4Ewx5huf4FMJPAh8GFWqJ0h4EsVYH4BuhzFUdlm+2LGVgPYt9G46q/pAZ9S
 oxdntetQx/PRt37YFDhfjvd/jfdL8qLp1uBgkzCCjVGHIaZIW+s7rndd329dzRNYjzHiuOl+ocQ
 hj+fzgtUDEECGYAVnff6bgfP2zejTFiUiBdyDFRsQAcUR6XKch/QXj+pzBVAyyrk1oOhY70ou3+
 KGRM2UH7A6cORpPEnv7EVaxKoAjkfZhbSffAhLlJACF1y3Q==
X-Received: by 2002:a05:600c:3547:b0:4a3:5991:718 with SMTP id
 5b1f17b1804b1-4bb88809795mr274116815e9.16.1795487606193; 
 Mon, 23 Nov 2026 18:33:26 -0800 (PST)
Received: from localhost (2001-1ae9-5b-ad10-b3af-f37f-773f-f37e.ip6.tmcz.cz.
 [2001:1ae9:5b:ad10:b3af:f37f:773f:f37e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb906635c7sm215637135e9.2.2026.11.23.18.33.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 18:33:25 -0800 (PST)
From: Arisa Snowbell <arisa.snowbell@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Arisa Snowbell <arisa.snowbell@gmail.com>
Subject: [PATCH 1/1] drm/amdgpu/userq: don't restore user queues during system
 sleep
Date: Tue, 24 Nov 2026 03:32:50 +0100
Message-ID: <2ba4e27796fb1777481bd91d8467439a85542a42.1795482456.git.arisa.snowbell@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <cover.1795482456.git.arisa.snowbell@gmail.com>
References: <cover.1795482456.git.arisa.snowbell@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 24 Nov 2026 08:40:19 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Before system sleep, amdgpu_device_prepare() moves all BOs out of VRAM.
When it evicts a BO of a process with user queues, the eviction fence of
that process signals, and amdgpu_eviction_fence_suspend_worker() queues
the restore worker right away. So the restore worker runs while the
eviction is still going on and does the opposite: it locks the VM and
its BOs, moves them back into VRAM and waits for the page table updates
while still holding the locks. amdgpu_userq_suspend() cancels the
restore worker, but only later, in amdgpu_device_suspend().

On an RX 9070 XT (gfx12) this hung S3 suspend for good after a few hours
of uptime. A restore worker waited forever on a page table update fence
while holding the reservations, and systemd-sleep waited in
ttm_bo_evict_first() for one of them. Why the fence never signaled is
not known, but the eviction should not depend on the restore at all.

Keep the restore out of system sleep:

- Prepare sets a flag that stops the eviction worker from queuing the
  restore, then cancels any restore already queued. The worker checks
  the flag under the userq_mutex, so prepare also takes and releases
  each userq_mutex to wait for a worker that checked it just before.

- amdgpu_userq_resume() does not map the queues of a process whose BOs
  were evicted, as its page tables are out of date. It queues the
  restore worker instead, which validates the BOs, rearms the eviction
  fence and maps the queues. It decides this under the userq_mutex,
  which the eviction worker holds while it signals.

- Complete clears the flag and queues the restore for evicted processes,
  unless the device is still suspended, as it is after the hibernation
  snapshot. A failed prepare does the same.

- The restore worker runs on system_freezable_wq, like the amdkfd
  restore workers, so a restore queued during resume waits until the
  system is thawed.

The flag is needed besides the freezable workqueue because for
hibernation dpm_prepare() runs before freeze_kernel_threads().
amdgpu_userq_ensure_ev_fence() still queues the restore directly, since
only ioctls reach it and user space is frozen by then.

A restore worker that was already stuck before suspend started still
blocks it: hibernation waits for it in amdgpu_userq_block_restore(),
and for S3 and s2idle the freezer gives up after 20 seconds and aborts
the suspend instead of hanging.

Fixes: 44cfdf368fb7 ("drm/amdgpu: resume gfx userqueues")
Signed-off-by: Arisa Snowbell <arisa.snowbell@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 13 +++-
 .../drm/amd/amdgpu/amdgpu_eviction_fence.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 64 ++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |  3 +
 5 files changed, 79 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index c7577b608f3e..db1800421e37 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -975,6 +975,7 @@ struct amdgpu_device {
 	bool                            apu_prefer_gtt;
 
 	bool                            userq_halt_for_enforce_isolation;
+	bool                            userq_restore_blocked;
 	struct amdgpu_uid *uid_info;
 
 	struct amdgpu_uma_carveout_info uma_info;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index e3b3a2eebd95..01458a613e21 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2647,6 +2647,7 @@ static int amdgpu_pmops_prepare(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(drm_dev);
+	int r;
 
 	/* device maybe not resumed here, return immediately in this case */
 	if (adev->in_s4 && adev->in_suspend)
@@ -2665,12 +2666,20 @@ static int amdgpu_pmops_prepare(struct device *dev)
 	    !amdgpu_acpi_is_s3_active(adev))
 		return 1;
 
-	return amdgpu_device_prepare(drm_dev);
+	amdgpu_userq_block_restore(adev);
+	r = amdgpu_device_prepare(drm_dev);
+	if (r)
+		amdgpu_userq_unblock_restore(adev);
+
+	return r;
 }
 
 static void amdgpu_pmops_complete(struct device *dev)
 {
-	amdgpu_device_complete(dev_get_drvdata(dev));
+	struct drm_device *drm_dev = dev_get_drvdata(dev);
+
+	amdgpu_device_complete(drm_dev);
+	amdgpu_userq_unblock_restore(drm_to_adev(drm_dev));
 }
 
 static int amdgpu_pmops_suspend(struct device *dev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
index f8652fd0525d..6c06c93d7f7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -91,7 +91,7 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
 	dma_fence_put(ev_fence);
 
 	if (!evf_mgr->shutdown)
-		schedule_delayed_work(&uq_mgr->resume_work, 0);
+		amdgpu_userq_schedule_resume(uq_mgr);
 
 	mutex_unlock(&uq_mgr->userq_mutex);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 9fc8e9e97595..4dfe2d1e1b5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -428,6 +428,17 @@ static void amdgpu_userq_detach_doorbell(struct amdgpu_usermode_queue *queue)
 	up_read(&adev->reset_domain->sem);
 }
 
+static void amdgpu_userq_queue_restore(struct amdgpu_userq_mgr *uq_mgr)
+{
+	queue_delayed_work(system_freezable_wq, &uq_mgr->resume_work, 0);
+}
+
+void amdgpu_userq_schedule_resume(struct amdgpu_userq_mgr *uq_mgr)
+{
+	if (!READ_ONCE(uq_mgr->adev->userq_restore_blocked))
+		amdgpu_userq_queue_restore(uq_mgr);
+}
+
 /**
  * amdgpu_userq_ensure_ev_fence - ensure a valid, unsignaled eviction fence exists
  * @uq_mgr: the usermode queue manager for this process
@@ -456,7 +467,7 @@ amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *uq_mgr,
 		 * Looks like there was no pending resume work,
 		 * add one now to create a valid eviction fence
 		 */
-		schedule_delayed_work(&uq_mgr->resume_work, 0);
+		amdgpu_userq_queue_restore(uq_mgr);
 		goto retry;
 	}
 	dma_fence_put(ev_fence);
@@ -1428,6 +1439,51 @@ int amdgpu_userq_suspend(struct amdgpu_device *adev)
 	return 0;
 }
 
+static bool amdgpu_userq_evicted(struct amdgpu_userq_mgr *uq_mgr)
+{
+	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
+	struct dma_fence *ev_fence = amdgpu_evf_mgr_get_fence(&fpriv->evf_mgr);
+	bool evicted = dma_fence_is_signaled(ev_fence);
+
+	dma_fence_put(ev_fence);
+	return evicted;
+}
+
+void amdgpu_userq_block_restore(struct amdgpu_device *adev)
+{
+	struct amdgpu_usermode_queue *queue;
+	struct amdgpu_userq_mgr *uqm;
+	unsigned long queue_id;
+
+	WRITE_ONCE(adev->userq_restore_blocked, true);
+
+	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
+		uqm = queue->userq_mgr;
+		/* Wait out an eviction worker that missed the flag */
+		mutex_lock(&uqm->userq_mutex);
+		mutex_unlock(&uqm->userq_mutex);
+		cancel_delayed_work_sync(&uqm->resume_work);
+	}
+}
+
+void amdgpu_userq_unblock_restore(struct amdgpu_device *adev)
+{
+	struct amdgpu_usermode_queue *queue;
+	struct amdgpu_userq_mgr *uqm;
+	unsigned long queue_id;
+
+	WRITE_ONCE(adev->userq_restore_blocked, false);
+	if (adev->in_suspend)
+		return;
+
+	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
+		uqm = queue->userq_mgr;
+		guard(mutex)(&uqm->userq_mutex);
+		if (amdgpu_userq_evicted(uqm))
+			amdgpu_userq_queue_restore(uqm);
+	}
+}
+
 int amdgpu_userq_resume(struct amdgpu_device *adev)
 {
 	struct amdgpu_usermode_queue *queue;
@@ -1438,6 +1494,12 @@ int amdgpu_userq_resume(struct amdgpu_device *adev)
 	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
 		uqm = queue->userq_mgr;
 		guard(mutex)(&uqm->userq_mutex);
+
+		if (amdgpu_userq_evicted(uqm)) {
+			amdgpu_userq_queue_restore(uqm);
+			continue;
+		}
+
 		if (adev->in_s0ix)
 			r = amdgpu_userq_restore_helper(queue);
 		else
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 488dc21d7c81..41d26f95a306 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -160,6 +160,7 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *f
 
 void amdgpu_userq_mgr_cancel_reset_work(struct amdgpu_device *adev);
 void amdgpu_userq_mgr_cancel_resume(struct amdgpu_userq_mgr *userq_mgr);
+void amdgpu_userq_schedule_resume(struct amdgpu_userq_mgr *uq_mgr);
 void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);
 
 void amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr);
@@ -173,6 +174,8 @@ bool amdgpu_userq_enabled(struct drm_device *dev);
 
 int amdgpu_userq_suspend(struct amdgpu_device *adev);
 int amdgpu_userq_resume(struct amdgpu_device *adev);
+void amdgpu_userq_block_restore(struct amdgpu_device *adev);
+void amdgpu_userq_unblock_restore(struct amdgpu_device *adev);
 
 int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
 						  u32 idx);
-- 
2.56.1

