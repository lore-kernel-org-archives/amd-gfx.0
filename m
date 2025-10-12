Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C91ECCD187
	for <amd-gfx@archiver.kernel.org>; Sun, 12 Oct 2025 19:18:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E693C10E0CB;
	Sun, 12 Oct 2025 19:18:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BvknNAl7";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE58010E0CB
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Oct 2025 19:18:32 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 7ED3240BAB;
 Sun, 12 Oct 2025 19:18:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1568C4CEE7;
 Sun, 12 Oct 2025 19:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1760296712;
 bh=QI2cnY77wrJPk6d70Qj5fG4Qx/CZSsNyFDsgeiQgbXQ=;
 h=From:To:Cc:Subject:Date:From;
 b=BvknNAl7V9GfQksBcp3grQ92YuvaDClyLpN1iW25g9XasJa9+bT0orkllU5LzpGx8
 ukyQv7tBodrOs+xYvuIIx/9fy6nIAOHwXoMP9P9Sd2Le7jmHKjM0IcN5y0w21D58nb
 qpiXJqC0rjaa3QQBUs1EV2drk2xvUfnbdy3bfei2HqoBJXfKuaoRzxhve162/Bq/uH
 jeoMQKjf+kJhbAs3Kd+/PWODzRxrbSi0xHIRpE87BGkw2xyeBy2HIoIFtWK1/g9qTk
 dlQlj/0UiWAGujLPmR1brl0n7PdEU6rKYFK6cd/jgD10cAP7+Aw9jHGlMoZm3zbtYq
 19RCs/sIz47Fw==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>, Peyton.Lee@amd.com,
 Sultan Alsawaf <sultan@kerneltoast.com>
Subject: [PATCH v3] drm/amd: Check that VPE has reached DPM0 in idle handler
Date: Sun, 12 Oct 2025 14:18:23 -0500
Message-ID: <20251012191823.856295-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
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

From: Mario Limonciello <mario.limonciello@amd.com>

[Why]
Newer VPE microcode has functionality that will decrease DPM level
only when a workload has run for 2 or more seconds.  If VPE is turned
off before this DPM decrease, the SOC can get stuck with a higher
DPM level.

This can happen from amdgpu's ring buffer test because it's a short
quick workload for VPE and VPE is turned off after 1s.

[How]
In idle handler besides checking fences are drained check that VPE DPM
level is really is at DPM0. If not, schedule delayed work again until
it is.

Cc: Peyton.Lee@amd.com
Reported-by: Sultan Alsawaf <sultan@kerneltoast.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4615
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v3:
 * Use label to avoid a register read if fences active
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index 474bfe36c0c2f..e8e512de5992a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -326,14 +326,23 @@ static void vpe_idle_work_handler(struct work_struct *work)
 {
 	struct amdgpu_device *adev =
 		container_of(work, struct amdgpu_device, vpe.idle_work.work);
+	struct amdgpu_vpe *vpe = &adev->vpe;
 	unsigned int fences = 0;
+	uint32_t dpm_level;
 
 	fences += amdgpu_fence_count_emitted(&adev->vpe.ring);
+	if (fences)
+		goto reschedule;
 
-	if (fences == 0)
+	dpm_level = adev->pm.dpm_enabled ?
+		    RREG32(vpe_get_reg_offset(vpe, 0, vpe->regs.dpm_request_lv)) : 0;
+	if (!dpm_level) {
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VPE, AMD_PG_STATE_GATE);
-	else
-		schedule_delayed_work(&adev->vpe.idle_work, VPE_IDLE_TIMEOUT);
+		return;
+	}
+
+reschedule:
+	schedule_delayed_work(&adev->vpe.idle_work, VPE_IDLE_TIMEOUT);
 }
 
 static int vpe_common_init(struct amdgpu_vpe *vpe)
-- 
2.43.0

