Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43950C02184
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2025 09:55:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8FF610E030;
	Tue, 14 Jan 2025 09:55:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SEnZ2NeR";
	dkim-atps=neutral
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1B4810E00A
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2025 09:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1736848507; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=VI7llR3vBqZ9jpEftgcg4rERqPvNU1vPN7NwgxxrFP0=;
 b=SEnZ2NeRNhktqXND52PhStojbKOKkAPocYIZSApwnVWfbtlGk0lb1KyHzKt5jO5kQ7wp7rIYhYDphCAm9VrjwlMZ0LsiCQALxlwqWl42ErZQlIqQsgt8k2IKhULtPxAxMAhjYVPZZT6pHImAUw2JuJU+hd03npWnpt/LijTTZ8M=
Received: from i32d02263.sqa.eu95.tbsite.net(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WNerZyu_1736848505 cluster:ay36) by smtp.aliyun-inc.com;
 Tue, 14 Jan 2025 17:55:06 +0800
From: Jiang Liu <gerry@linux.alibaba.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, simona@ffwll.ch, sunil.khatri@amd.com,
 lijo.lazar@amd.com, Hawking.Zhang@amd.com, mario.limonciello@amd.com,
 xiaogang.chen@amd.com, Kent.Russell@amd.com, shuox.liu@linux.alibaba.com,
 amd-gfx@lists.freedesktop.org
Cc: Jiang Liu <gerry@linux.alibaba.com>
Subject: [RFC v1 1/2] drm/amdgpu: update cached vram base addresses on resume
Date: Tue, 14 Jan 2025 17:54:57 +0800
Message-ID: <ccc964858fd99facb8984e035d611c3a9c591bdc.1736847835.git.gerry@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1736847835.git.gerry@linux.alibaba.com>
References: <cover.1736847835.git.gerry@linux.alibaba.com>
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

When resume on a different SR-IOV vGPU device, the VRAM base addresses
may have changed. So we need to update those cached addresses.

Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 15 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h    |  6 ++++--
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c     |  7 +++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      |  6 ++++++
 4 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 36053b3d48b3..c9df54127417 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4970,6 +4970,21 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
 	if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
 		return 0;
 
+	/* Get xgmi info again for sriov to detect device changes */
+	if (amdgpu_sriov_vf(adev) &&
+	    !(adev->flags & AMD_IS_APU) &&
+	    adev->gmc.xgmi.supported &&
+	    !adev->gmc.xgmi.connected_to_cpu) {
+		adev->gmc.xgmi.prev_physical_node_id = adev->gmc.xgmi.physical_node_id;
+		r = adev->gfxhub.funcs->get_xgmi_info(adev);
+		if (r)
+			return r;
+		if (adev->gmc.xgmi.physical_node_id != adev->gmc.xgmi.prev_physical_node_id)
+			adev->gmc.xgmi.physical_node_id_changed = true;
+		else
+			adev->gmc.xgmi.physical_node_id_changed = false;
+	}
+
 	if (adev->in_s0ix)
 		amdgpu_dpm_gfx_state_change(adev, sGpuChangeState_D0Entry);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 459a30fe239f..a32ab7b61cfd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -184,10 +184,12 @@ struct amdgpu_xgmi {
 	u64 hive_id;
 	/* fixed per family */
 	u64 node_segment_size;
-	/* physical node (0-3) */
-	unsigned physical_node_id;
 	/* number of nodes (0-4) */
 	unsigned num_physical_nodes;
+	/* physical node (0-3) */
+	unsigned physical_node_id;
+	unsigned prev_physical_node_id;
+	bool physical_node_id_changed;
 	/* gpu list in the same hive */
 	struct list_head head;
 	bool supported;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 9bedca9a79c6..94d86e9a08e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -1065,8 +1065,15 @@ static int gmc_v10_0_suspend(struct amdgpu_ip_block *ip_block)
 
 static int gmc_v10_0_resume(struct amdgpu_ip_block *ip_block)
 {
+	struct amdgpu_device *adev = ip_block->adev;
 	int r;
 
+	if (adev->gmc.xgmi.physical_node_id_changed) {
+		r = gmc_v10_0_mc_init(adev);
+		if (r)
+			return r;
+	}
+
 	r = gmc_v10_0_hw_init(ip_block);
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 291549765c38..db118e07efde 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -2532,6 +2532,12 @@ static int gmc_v9_0_resume(struct amdgpu_ip_block *ip_block)
 		adev->gmc.reset_flags &= ~AMDGPU_GMC_INIT_RESET_NPS;
 	}
 
+	if (adev->gmc.xgmi.physical_node_id_changed) {
+		r = gmc_v9_0_mc_init(adev);
+		if (r)
+			return r;
+	}
+
 	r = gmc_v9_0_hw_init(ip_block);
 	if (r)
 		return r;
-- 
2.43.5

