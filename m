Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C439D1CDC6
	for <amd-gfx@archiver.kernel.org>; Sun,  7 Dec 2025 19:49:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67D9510E2EE;
	Sun,  7 Dec 2025 19:49:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="okTI5DYV";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B655310E2EE
 for <amd-gfx@lists.freedesktop.org>; Sun,  7 Dec 2025 19:49:18 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 17F6A42B83;
 Sun,  7 Dec 2025 19:49:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B9B3C19422;
 Sun,  7 Dec 2025 19:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1765136957;
 bh=BHsa2wMik8HY+KnrXw+AYjiHIGwPVJkxNqOfUDXY/Jw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=okTI5DYVGC0avApUn2Jx8Q+RJQujyGOPwlKHuxal32MneV5wvAI4ZMCwdWibBi8pn
 0pv9cgml9segp6bCXTlvu8/DY8U5XD7q75xXMXrvjA8dmvBzY56p36Q9KTEb7VjQ8n
 ton+gckdLWT0WK68qDcjgetuykLLflGF3jKLLDfeIFNiZAUs1djYFqFxTNk8u24Hka
 McYEKbgWPQCnds1EkmhPpMcikg+A7DVO9WbhjbdBxffWz17IJfiyxlDmQyO50MiTU/
 l5/NL00O4aXEZu04ortJDi5lr2SKnq3w+IRYyEwufy5ppghg3XpWDfLXSAON8Pe79K
 e/IITHmlcCmaw==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Antheas Kapenekakis <lkml@antheas.dev>
Subject: [RFC PATCH 1/1] drm/amd: Expand runtime suspend to APUs
Date: Sun,  7 Dec 2025 13:49:10 -0600
Message-ID: <20251207194910.122711-2-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251207194910.122711-1-superm1@kernel.org>
References: <20251207194910.122711-1-superm1@kernel.org>
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

Set up APUs to follow similar policies as dGPUs in that they can
potentially runtime suspend.  If an APU is runtime suspended then
prepare it for the matching system state (s0ix or s3) so that steps
can be skipped when runtime suspended.

It's important to note that default runtime PM policy will prevent
entering runtime PM when displays are connected. This can be changed
by setting amdgpu.runpm=-2.

Cc: Antheas Kapenekakis <lkml@antheas.dev>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 17 +++++++++++++++--
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h    |  1 +
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 6fffb47cb9b42..749fb29026ef5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -497,6 +497,12 @@ void amdgpu_device_detect_runtime_pm_mode(struct amdgpu_device *adev)
 			adev->pm.rpm_mode = AMDGPU_RUNPM_BOCO;
 			dev_info(adev->dev, "Using BOCO for runtime pm\n");
 		} else {
+			/* APU runtime pm */
+			if (adev->flags & AMD_IS_APU) {
+				adev->pm.rpm_mode = AMDGPU_RUNPM_APU;
+				dev_info(adev->dev, "Using APU runtime pm\n");
+				break;
+			}
 			if (!bamaco_support)
 				goto no_runtime_pm;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 25b725bd38201..ebe544c544c10 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2471,7 +2471,7 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 		if (amdgpu_device_supports_px(adev))
 			dev_pm_set_driver_flags(ddev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
 		/* we want direct complete for BOCO */
-		if (amdgpu_device_supports_boco(adev))
+		if (amdgpu_device_supports_boco(adev) || adev->flags & AMD_IS_APU)
 			dev_pm_set_driver_flags(ddev->dev, DPM_FLAG_SMART_PREPARE |
 						DPM_FLAG_SMART_SUSPEND |
 						DPM_FLAG_MAY_SKIP_RESUME);
@@ -2581,7 +2581,7 @@ static int amdgpu_pmops_prepare(struct device *dev)
 	/* Return a positive number here so
 	 * DPM_FLAG_SMART_SUSPEND works properly
 	 */
-	if (amdgpu_device_supports_boco(adev) && pm_runtime_suspended(dev))
+	if (pm_runtime_suspended(dev))
 		return 1;
 
 	/* if we will not support s3 or s2i for the device
@@ -2848,6 +2848,15 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 	ret = amdgpu_device_prepare(drm_dev);
 	if (ret)
 		return ret;
+
+	/* for APUs - match the sleep state of the system */
+	if (adev->pm.rpm_mode == AMDGPU_RUNPM_APU) {
+		if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)
+			adev->in_s0ix = true;
+		else
+			adev->in_s3 = true;
+	}
+
 	ret = amdgpu_device_suspend(drm_dev, false);
 	if (ret) {
 		adev->in_runpm = false;
@@ -2925,6 +2934,10 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
 	if (adev->pm.rpm_mode == AMDGPU_RUNPM_PX)
 		drm_dev->switch_power_state = DRM_SWITCH_POWER_ON;
 	adev->in_runpm = false;
+	if (adev->pm.rpm_mode == AMDGPU_RUNPM_APU) {
+		adev->in_s0ix = false;
+		adev->in_s3 = false;
+	}
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index c7ea293856827..2972c874b5e6d 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -51,6 +51,7 @@ enum amdgpu_runpm_mode {
 	AMDGPU_RUNPM_BOCO,
 	AMDGPU_RUNPM_BACO,
 	AMDGPU_RUNPM_BAMACO,
+	AMDGPU_RUNPM_APU,
 };
 
 #define BACO_SUPPORT (1<<0)
-- 
2.43.0

