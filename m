Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F36CCC54E41
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Mar 2024 11:59:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A26A810E160;
	Tue,  5 Mar 2024 11:59:03 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4481310E160
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Mar 2024 11:59:01 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 425Bwua43119821; Tue, 5 Mar 2024 17:28:56 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 425BwugX3119820;
 Tue, 5 Mar 2024 17:28:56 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Pan@rtg-sunil-navi33.amd.com,
 Xinhui <Xinhui.Pan@amd.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v2] drm/amdgpu: add ring timeout information in devcoredump
Date: Tue,  5 Mar 2024 17:28:43 +0530
Message-Id: <20240305115843.3119708-1-sunil.khatri@amd.com>
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

Add ring timeout related information in the amdgpu
devcoredump file for debugging purposes.

During the gpu recovery process the registered call
is triggered and add the debug information in data
file created by devcoredump framework under the
directory /sys/class/devcoredump/devcdx/

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c | 15 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index a59364e9b6ed..aa7fed59a0d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -196,6 +196,13 @@ amdgpu_devcoredump_read(char *buffer, loff_t offset, size_t count,
 			   coredump->reset_task_info.process_name,
 			   coredump->reset_task_info.pid);
 
+	if (coredump->ring_timeout) {
+		drm_printf(&p, "\nRing timed out details\n");
+		drm_printf(&p, "IP Type: %d Ring Name: %s \n",
+				coredump->ring->funcs->type,
+				coredump->ring->name);
+	}
+
 	if (coredump->reset_vram_lost)
 		drm_printf(&p, "VRAM is lost due to GPU reset!\n");
 	if (coredump->adev->reset_info.num_regs) {
@@ -220,6 +227,8 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool vram_lost,
 {
 	struct amdgpu_coredump_info *coredump;
 	struct drm_device *dev = adev_to_drm(adev);
+	struct amdgpu_job *job = reset_context->job;
+	struct drm_sched_job *s_job;
 
 	coredump = kzalloc(sizeof(*coredump), GFP_NOWAIT);
 
@@ -228,6 +237,12 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool vram_lost,
 		return;
 	}
 
+	if (job) {
+		s_job = &job->base;
+		coredump->ring = to_amdgpu_ring(s_job->sched);
+		coredump->ring_timeout = TRUE;
+	}
+
 	coredump->reset_vram_lost = vram_lost;
 
 	if (reset_context->job && reset_context->job->vm) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
index 19899f6b9b2b..6d67001a1057 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -97,6 +97,8 @@ struct amdgpu_coredump_info {
 	struct amdgpu_task_info         reset_task_info;
 	struct timespec64               reset_time;
 	bool                            reset_vram_lost;
+	struct amdgpu_ring          *ring;
+	bool                            ring_timeout;
 };
 #endif
 
-- 
2.34.1

