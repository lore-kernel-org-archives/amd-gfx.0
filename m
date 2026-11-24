Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F2E606A323
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2026 15:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jgaS/xsT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF42510F74F;
	Tue, 24 Nov 2026 15:54:51 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADCE310F65A
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2026 14:14:55 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-492fcbfaa88so2960511f8f.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2026 06:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795529694; x=1796134494; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=M12X8tjuW0sKi49HLINmGzuFf6BtCLDiS8x3VkrOa38=;
 b=jgaS/xsTMkpQFvcReN7WYbAfeuhk/aJ1YGOCSVdzzDGDmQCESWeyxKaqRDJexYKK30
 s3badbkiVgCZ0CyVamEWBePe3SKc1X1NoWd2h8nbxv96BI8PMW8tqiAYkV02Tl7ZLVu1
 nnAMerp6MwYPvOoQkzdT1bSCCostJ/2Ce9LFpgoaTeS7NAecBu0AzYA6XH/JnuLX8TOl
 rApxZmePC4MQQ6TWORkb5Cgdf/346RlpOsB5qHr1ykcPyKMUSfmCywoCm8++keAWmVU4
 ExwThnAoTg6nOWPFsPpnyNtAfTaIuWMZTsjFAw58i3VIHir6cJhXL0m/9UODC4krCVmy
 btDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795529694; x=1796134494;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=M12X8tjuW0sKi49HLINmGzuFf6BtCLDiS8x3VkrOa38=;
 b=FCETIebjYZcLzNjMwSVBYFMUoN1Bk7o6Jv7R9f7ny+hYpB0PnKjChaE5mrBGFAZdm1
 lX3msju69VDQDfXbe60QPO5dJg4y2AdfsY0Ow6F78XxDNRqw5jWzEOS3QT0CoqONQuDa
 r7sNwxW+qt/k4OrNiK8H+m+lQrjb11Voz4wgU7MXc9lgpQv/xkySIh/EJQu0TYq/68u0
 DNQGZgMTcGvzgAKIX8NoMEjNW6DHnJflGEt0hJ5lTK9vx+hzZ3ByY/KqF56RZ4IZ4/TL
 eTDp9W3JdMwwXGRjacB/mzb1xqLIV/yjzzvdWaYhxmx6QvNVq5+v5KqYci0udOyYT4xh
 rRGw==
X-Gm-Message-State: APuU4Z8yB48KNTGp+o7EY1vugLFepCLkRDZ/BAkNHXBRrHyAl1R8Vf/2
 ZL6YruG/c9o2X3KNDQijYtmVjh3V3aGAW33BS9tRT3vNT5NL/miEFVgIcQG6Au88Jo8=
X-Gm-Gg: AZFdTZe3X/Pn5qX3NsS6OYfAO3m3brqd8IV6BCD124yFmYjTuvrmon+kb87vselo2ul
 fybhkRsXnbf/efJyJlh+UNatYqiTMBVTJKoDyTtfo3fNZo6ZpvnHipN7GPwu4NQ6WnSMxks/tMC
 DQGSqv6C2C+QOIZRp1m5rS+sVDp6jHbj6rAjQcCBBp3wYQeW8cL6RUA4SCLjgB4POkOGB2DX7tb
 IMQRZ6iXY2saYSWGtcmXHroG3O119AfhYm8dPymYgPHxOmSYnRp/LKOcoeZsOIKNvKYqdqYVb0s
 IRSF3i/b1l6by5b80oAj05yXf8uhgWnyFDarQ7fPOhVHU4LrlAlqpuQ33pvMikaMT26Kcr1X/ET
 vcCxZsm3/iNSofHVPnZjavQad3VaVlvzd9fU1ioIrCiEE2zHjwL2kj5gCljFD6AVIFu89RzKdAR
 4sNFd4ZeE4toHrndqiWrWQqPDpuSzVTgLXEYqXrMijmxR2E3kPdkUR/MgyMvz6HugTLMBrhfve5
 u7DPfrDj9dCJNdxXsu0SQ3lHlfULqxuH5ftbQrVQ5BkR1qSYMIRZV+VjIvKTFrMdNqZWKpPrSkf
 fpOTVevcjF4t5Cz7YegrW+DW7GdCNlIr/CNhIoIpRcYFE8zxmKfuesA137C1DseV8S9sdkyK+K6
 BbqI2XW3ol5L4niXXD4TnmGPm5EasoRiZbQtMXkqX2PhDXA==
X-Received: by 2002:a05:6000:3107:b0:4aa:1ae2:ff2a with SMTP id
 ffacd0b85a97d-4abaa977260mr35741366f8f.2.1795529693775; 
 Tue, 24 Nov 2026 06:14:53 -0800 (PST)
Received: from localhost (2001-1ae9-5b-ad10-2088-6b73-139a-ba27.ip6.tmcz.cz.
 [2001:1ae9:5b:ad10:2088:6b73:139a:ba27])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6bc8ce06sm27575587f8f.47.2026.11.24.06.14.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 06:14:53 -0800 (PST)
From: Arisa Snowbell <arisa.snowbell@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Vitaly Prosyak <Vitaly.Prosyak@amd.com>,
 Sunil Khatri <Sunil.Khatri@amd.com>,
 Arisa Snowbell <arisa.snowbell@gmail.com>
Subject: [PATCH v3] drm/amdgpu/userq: keep the restore worker out of system
 sleep
Date: Tue, 24 Nov 2026 15:14:16 +0100
Message-ID: <20261124141416.11034-1-arisa.snowbell@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124130258.1270242-1-arisa.snowbell@gmail.com>
References: <20261124130258.1270242-1-arisa.snowbell@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 24 Nov 2026 15:54:45 +0000
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
the restore worker on system_wq. That workqueue is not frozen, so the
restore worker runs while the eviction is still going on and moves the
BOs back into VRAM, waiting for the page table updates while it holds
their reservations.

On an RX 9070 XT (gfx12) this hung S3 suspend for good after a few hours
of uptime. A restore worker waited forever on a page table update fence
while holding the reservations, and systemd-sleep waited in
ttm_bo_evict_first() for one of them.

Queue the restore worker on system_freezable_wq, like the amdkfd restore
workers. Its work is frozen before dpm_prepare(), so a restore queued
during the eviction stays pending until amdgpu_userq_suspend() cancels
it.

The processes are then still evicted at resume, so amdgpu_userq_resume()
must not map their queues: their BOs are not validated and their page
tables are out of date. Mapping them made MES time out on ADD_QUEUE and
the resume fail with -110. Queue the restore worker for them instead,
which validates the BOs, rearms the eviction fence and maps the queues
once the system is thawed.

Fixes: 44cfdf368fb7 ("drm/amdgpu: resume gfx userqueues")
Signed-off-by: Arisa Snowbell <arisa.snowbell@gmail.com>
---
v3: bring back the resume change from v1: amdgpu_userq_resume() does not
    map the queues of processes whose BOs are evicted, and queues the
    restore worker for them instead. With v2 alone, resume mapped them
    with the BOs still evicted, MES timed out on ADD_QUEUE and the resume
    failed with -110.

v2: drop the restore block flag and the resume changes, only move the
    restore worker to system_freezable_wq (Christian). v1 claimed that
    for hibernation dpm_prepare() runs before freeze_kernel_threads(),
    which is wrong.

Tested with S3 on an RX 9070 XT, with the desktop (Hyprland) and a game
on user queues: suspend and resume complete and the queues keep running.
Rendering after resume is still corrupted (the game, and small artifacts
on the desktop), but that also happens with kernel queues; I'll report
it separately.

 .../drm/amd/amdgpu/amdgpu_eviction_fence.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 19 ++++++++++++++++++-
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
index f8652fd0525d..18b11d7f457e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -91,7 +91,7 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
 	dma_fence_put(ev_fence);
 
 	if (!evf_mgr->shutdown)
-		schedule_delayed_work(&uq_mgr->resume_work, 0);
+		queue_delayed_work(system_freezable_wq, &uq_mgr->resume_work, 0);
 
 	mutex_unlock(&uq_mgr->userq_mutex);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 9fc8e9e97595..4f41163a0a55 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -456,7 +456,7 @@ amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *uq_mgr,
 		 * Looks like there was no pending resume work,
 		 * add one now to create a valid eviction fence
 		 */
-		schedule_delayed_work(&uq_mgr->resume_work, 0);
+		queue_delayed_work(system_freezable_wq, &uq_mgr->resume_work, 0);
 		goto retry;
 	}
 	dma_fence_put(ev_fence);
@@ -1428,6 +1428,16 @@ int amdgpu_userq_suspend(struct amdgpu_device *adev)
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
 int amdgpu_userq_resume(struct amdgpu_device *adev)
 {
 	struct amdgpu_usermode_queue *queue;
@@ -1438,6 +1448,13 @@ int amdgpu_userq_resume(struct amdgpu_device *adev)
 	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
 		uqm = queue->userq_mgr;
 		guard(mutex)(&uqm->userq_mutex);
+
+		/* The BOs moved, let the restore worker validate them first */
+		if (amdgpu_userq_evicted(uqm)) {
+			queue_delayed_work(system_freezable_wq, &uqm->resume_work, 0);
+			continue;
+		}
+
 		if (adev->in_s0ix)
 			r = amdgpu_userq_restore_helper(queue);
 		else
-- 
2.56.1

