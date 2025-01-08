Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1CE0E7719E
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2025 14:00:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE9DB10E8B8;
	Wed,  8 Jan 2025 14:00:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="czYa+by0";
	dkim-atps=neutral
Received: from out30-101.freemail.mail.aliyun.com
 (out30-101.freemail.mail.aliyun.com [115.124.30.101])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 589A810E2A3
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2025 14:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1736344816; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=Vv5XwvrGOIsAF+hM/78p++8hqwEmRjyK1I5lFwFLf5U=;
 b=czYa+by0s4nRMmULJZzkGYphbqojsiAI61lxlYpHjYfA+i58ClEqJcRWLx/Hw1hnuQdo0KAVyMQCWCrv/gPgaZCwEGEEEB0+2wTXym4Xc3fZU5dHPpfDXIMM7G/7VFg3qmpR0lWlp+yn39DqMgLeWp2uUCSNMlcKInesb6iC4YQ=
Received: from i32d02263.sqa.eu95.tbsite.net(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WNEHXF9_1736344814 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 08 Jan 2025 22:00:14 +0800
From: Jiang Liu <gerry@linux.alibaba.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, simona@ffwll.ch, sunil.khatri@amd.com,
 lijo.lazar@amd.com, Hawking.Zhang@amd.com, mario.limonciello@amd.com,
 Jun.Ma2@amd.com, xiaogang.chen@amd.com, Kent.Russell@amd.com,
 shuox.liu@linux.alibaba.com, amd-gfx@lists.freedesktop.org
Cc: Jiang Liu <gerry@linux.alibaba.com>
Subject: [RFC PATCH 10/13] drm/admgpu: make device state machine work in stack
 like way
Date: Wed,  8 Jan 2025 22:00:02 +0800
Message-ID: <3d3920095879123b7261c7529ad4a61ee5e56259.1736344725.git.gerry@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1736344725.git.gerry@linux.alibaba.com>
References: <cover.1736344725.git.gerry@linux.alibaba.com>
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

Make the device state machine work in stack like way to better support
suspend/resume by following changes:

1. amdgpu_driver_load_kms()
	amdgpu_device_init()
		amdgpu_device_ip_early_init()
			ip_blocks[i].early_init()
			ip_blocks[i].status.valid = true
		amdgpu_device_ip_init()
			amdgpu_ras_init()
			ip_blocks[i].sw_init()
			ip_blocks[i].status.sw = true
			ip_blocks[i].hw_init()
			ip_blocks[i].status.hw = true
		amdgpu_device_ip_late_init()
			ip_blocks[i].late_init()
			ip_blocks[i].status.late_initialized = true
			amdgpu_ras_late_init()
				ras_blocks[i].ras_late_init()
					amdgpu_ras_feature_enable_on_boot()

2. amdgpu_pmops_suspend()/amdgpu_pmops_freeze()/amdgpu_pmops_poweroff()
	amdgpu_device_suspend()
		amdgpu_ras_early_fini()
			ras_blocks[i].ras_early_fini()
				amdgpu_ras_feature_disable()
		amdgpu_ras_suspend()
			amdgpu_ras_disable_all_features()
+++		ip_blocks[i].early_fini()
+++		ip_blocks[i].status.late_initialized = false
		ip_blocks[i].suspend()

3. amdgpu_pmops_resume()/amdgpu_pmops_thaw()/amdgpu_pmops_restore()
	amdgpu_device_resume()
		amdgpu_device_ip_resume()
			ip_blocks[i].resume()
		amdgpu_device_ip_late_init()
			ip_blocks[i].late_init()
			ip_blocks[i].status.late_initialized = true
			amdgpu_ras_late_init()
				ras_blocks[i].ras_late_init()
					amdgpu_ras_feature_enable_on_boot()
		amdgpu_ras_resume()
			amdgpu_ras_enable_all_features()

4. amdgpu_driver_unload_kms()
	amdgpu_device_fini_hw()
		amdgpu_ras_early_fini()
			ras_blocks[i].ras_early_fini()
+++		ip_blocks[i].early_fini()
+++		ip_blocks[i].status.late_initialized = false
		ip_blocks[i].hw_fini()
		ip_blocks[i].status.hw = false

5. amdgpu_driver_release_kms()
	amdgpu_device_fini_sw()
		amdgpu_device_ip_fini()
			ip_blocks[i].sw_fini()
			ip_blocks[i].status.sw = false
---			ip_blocks[i].status.valid = false
+++			amdgpu_ras_fini()
			ip_blocks[i].late_fini()
+++			ip_blocks[i].status.valid = false
---			ip_blocks[i].status.late_initialized = false
---			amdgpu_ras_fini()

The main changes include:
1) invoke ip_blocks[i].early_fini in amdgpu_pmops_suspend().
   Currently there's only one ip block which provides `early_fini`
   callback. We have add a check of `in_s3` to keep current behavior in
   function amdgpu_dm_early_fini(). So there should be no functional
   changes.
2) set ip_blocks[i].status.late_initialized to false after calling
   callback `early_fini`. We have auditted all usages of the
   late_initialized flag and no functional changes found.
3) only set ip_blocks[i].status.valid = false after calling the
   `late_fini` callback.
4) call amdgpu_ras_fini() before invoking ip_blocks[i].late_fini.

There's one more task left to analyze GPU reset related state machine
transitions.

Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 22 +++++++++++++++++--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  3 +++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 36a33a391411..5c6b39e5cdaa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3411,6 +3411,8 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
 		adev->ip_blocks[i].status.sw = false;
 	}
 
+	amdgpu_ras_fini(adev);
+
 	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
 		if (!adev->ip_blocks[i].status.valid)
 			continue;
@@ -3419,8 +3421,6 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
 		adev->ip_blocks[i].status.valid = false;
 	}
 
-	amdgpu_ras_fini(adev);
-
 	return 0;
 }
 
@@ -3478,6 +3478,24 @@ static int amdgpu_device_ip_suspend_phase1(struct amdgpu_device *adev)
 	if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_DISALLOW))
 		dev_warn(adev->dev, "Failed to disallow df cstate");
 
+	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
+		if (!adev->ip_blocks[i].status.valid)
+			continue;
+		if (!adev->ip_blocks[i].status.late_initialized)
+			continue;
+
+		if (adev->ip_blocks[i].version->funcs->early_fini) {
+			r = adev->ip_blocks[i].version->funcs->early_fini(&adev->ip_blocks[i]);
+			if (r) {
+				DRM_ERROR(" of IP block <%s> failed %d\n",
+					  adev->ip_blocks[i].version->funcs->name, r);
+				return r;
+			}
+		}
+
+		adev->ip_blocks[i].status.late_initialized = false;
+	}
+
 	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
 		if (!adev->ip_blocks[i].status.valid)
 			continue;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index f622eb1551df..33a1a795c761 100755
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2175,6 +2175,9 @@ static int amdgpu_dm_early_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
+	if (adev->in_s0ix || adev->in_s3 || adev->in_s4 || adev->in_suspend)
+		return 0;
+
 	amdgpu_dm_audio_fini(adev);
 
 	return 0;
-- 
2.43.5

