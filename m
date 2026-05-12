Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B6BECD4F26
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2026 07:04:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABBCE10E987;
	Tue, 12 May 2026 07:04:53 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C65A610E987
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2026 07:04:51 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 64C74jUq405450; Tue, 12 May 2026 12:34:45 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 64C74jNq405443;
 Tue, 12 May 2026 12:34:45 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH] drm/amdgpu/userq: make sure only one reset work thread runs
 at a time
Date: Tue, 12 May 2026 12:34:44 +0530
Message-Id: <20260512070444.405424-1-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
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

CPU0:   hang_detect_work → directly calls reset_work()
CPU1:   evict_all → queues reset_work (via workqueue)

There is a possibility of two reset thread running at same time.
To avoid that we add a per queue manager flag to avoid duplication.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 16 ++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 0a1fc45f5b4e..1440f51b667f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -109,6 +109,19 @@ static void amdgpu_userq_mgr_reset_work(struct work_struct *work)
 	if (!amdgpu_gpu_recovery)
 		return;
 
+	/*
+	 * Prevent concurrent/duplicate reset executions. Both hang_detect_work
+	 * (direct call) and evict_all (via schedule+flush_work) can invoke this
+	 * function simultaneously. Use an atomic test-and-set so only the first
+	 * caller proceeds; the second exits early.
+	 *
+	 * Note: amdgpu_in_reset() cannot be used here because in_gpu_reset is
+	 * only set deep inside amdgpu_device_gpu_recover(), well after we've
+	 * already entered this function.
+	 */
+	if (atomic_cmpxchg(&uq_mgr->reset_in_progress, 0, 1) != 0)
+		return;
+
 	/*
 	 * Iterate through all queue types to detect and reset problematic queues
 	 * Process each queue type in the defined order
@@ -145,6 +158,8 @@ static void amdgpu_userq_mgr_reset_work(struct work_struct *work)
 
 		amdgpu_device_gpu_recover(adev, NULL, &reset_context);
 	}
+
+	atomic_set(&uq_mgr->reset_in_progress, 0);
 }
 
 static void amdgpu_userq_hang_detect_work(struct work_struct *work)
@@ -1304,6 +1319,7 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *f
 
 	INIT_DELAYED_WORK(&userq_mgr->resume_work, amdgpu_userq_restore_worker);
 	INIT_WORK(&userq_mgr->reset_work, amdgpu_userq_mgr_reset_work);
+	atomic_set(&userq_mgr->reset_in_progress, 0);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 49b33e2d6932..2748ecc0f6c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -129,6 +129,7 @@ struct amdgpu_userq_mgr {
 	 * Reset work which is used when eviction fails.
 	 */
 	struct work_struct		reset_work;
+	atomic_t			reset_in_progress;
 	atomic_t                        userq_count[AMDGPU_RING_TYPE_MAX];
 };
 
-- 
2.34.1

