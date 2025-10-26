Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 669B2CCD193
	for <amd-gfx@archiver.kernel.org>; Sun, 26 Oct 2025 04:30:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3A4210E27F;
	Sun, 26 Oct 2025 04:30:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="idGXWDGq";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 949A110E049
 for <amd-gfx@lists.freedesktop.org>; Sun, 26 Oct 2025 04:30:01 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 5A11C43344;
 Sun, 26 Oct 2025 04:30:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFBE1C4CEF7;
 Sun, 26 Oct 2025 04:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1761453001;
 bh=sE2l5IJ2U14MFh/TQuB6IRZ4KW5SxAHQAG/NTdqe3cI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=idGXWDGqpt4Ll/nYfljHBFe4SPKFCoXoGevTrT4bOSKy9ijEHbkuP79jqoxcOWbGO
 LJVj2OILrcwFfu/7hpNkaULe8QhIR2MYJcu4s4m/zLr3uU02ZYeg9eMvV3BItHfTUZ
 AEk4hzUfWSNIAfUTQpdTCuvAMIoxxdYe8H2QEo0ZTJyDiFZfWTOlqfOzRiLZB1ist6
 M6yrSGx6dxKI+yIXkLn1L5xe4WQ7bAVc2ntTuVrGpuYU1UeuyF2Gsn9RqcHZ43koRS
 9bS9s/BOnzUuh8nYjsZuox6Ai1vfjhIThAyoc2cb6Vyi0qympHR0fknkSLzthejZ09
 Ybe5Rvd7NHanQ==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Mario Limonciello <superm1@kernel.org>, lkml@antheas.dev
Subject: [PATCH v5 1/5] drm/amdgpu: Drop PMFW RLC notifier from
 amdgpu_device_suspend()
Date: Sat, 25 Oct 2025 23:29:36 -0500
Message-ID: <20251026042942.549389-2-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251026042942.549389-1-superm1@kernel.org>
References: <20251026042942.549389-1-superm1@kernel.org>
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

From: Alex Deucher <alexander.deucher@amd.com>

For S3 on vangogh, PMFW needs to be notified before the
driver powers down RLC.  This already happens in smu_disable_dpms()
so drop the superfluous call in amdgpu_device_suspend().

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Co-developed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
Cc: lkml@antheas.dev
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 ----
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c        | 18 ------------------
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h    |  2 --
 3 files changed, 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b8d91247f51a..f6850b86e96f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5280,10 +5280,6 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 	if (amdgpu_sriov_vf(adev))
 		amdgpu_virt_release_full_gpu(adev, false);
 
-	r = amdgpu_dpm_notify_rlc_state(adev, false);
-	if (r)
-		return r;
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 5d08dc3b7110..5c4d0eb198c4 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -195,24 +195,6 @@ int amdgpu_dpm_set_mp1_state(struct amdgpu_device *adev,
 	return ret;
 }
 
-int amdgpu_dpm_notify_rlc_state(struct amdgpu_device *adev, bool en)
-{
-	int ret = 0;
-	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-
-	if (pp_funcs && pp_funcs->notify_rlc_state) {
-		mutex_lock(&adev->pm.mutex);
-
-		ret = pp_funcs->notify_rlc_state(
-				adev->powerplay.pp_handle,
-				en);
-
-		mutex_unlock(&adev->pm.mutex);
-	}
-
-	return ret;
-}
-
 int amdgpu_dpm_is_baco_supported(struct amdgpu_device *adev)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 3bce74f8bb0a..c7ea29385682 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -424,8 +424,6 @@ int amdgpu_dpm_mode1_reset(struct amdgpu_device *adev);
 int amdgpu_dpm_set_mp1_state(struct amdgpu_device *adev,
 			     enum pp_mp1_state mp1_state);
 
-int amdgpu_dpm_notify_rlc_state(struct amdgpu_device *adev, bool en);
-
 int amdgpu_dpm_set_gfx_power_up_by_imu(struct amdgpu_device *adev);
 
 int amdgpu_dpm_baco_exit(struct amdgpu_device *adev);
-- 
2.51.1

