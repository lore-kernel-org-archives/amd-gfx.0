Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD9DC61DD3
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2026 11:27:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4252C10E18A;
	Tue,  1 Sep 2026 11:27:32 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.217.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1863D10E18A
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2026 11:27:29 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 681BROgI1834879; Tue, 1 Sep 2026 16:57:24 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 681BROkG1834878;
 Tue, 1 Sep 2026 16:57:24 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH] drm/amdgpu/userq: dont overwrite the error of subsequent map
 call
Date: Tue,  1 Sep 2026 16:57:23 +0530
Message-Id: <20260901112723.1834853-1-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
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

If a queue fails to map that we need to return the error code back
to the caller and not overwrite with a success specifically.

Accumulate the failure and return that.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index f16af852725a..9dc937c22b05 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1562,7 +1562,7 @@ int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost)
 	struct amdgpu_usermode_queue *queue;
 	const struct amdgpu_userq_funcs *userq_funcs;
 	unsigned long queue_id;
-	int r = 0;
+	int ret = 0, r;
 
 	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
 		if (queue->state == AMDGPU_USERQ_STATE_HUNG && !vram_lost) {
@@ -1573,6 +1573,7 @@ int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost)
 			r = userq_funcs->map(queue);
 			if (r) {
 				dev_err(adev->dev, "Failed to remap queue %ld\n", queue_id);
+				ret = r;
 				continue;
 			}
 			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_MAPPED);
@@ -1580,5 +1581,5 @@ int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost)
 		}
 	}
 
-	return r;
+	return ret;
 }
-- 
2.34.1

