Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21CFBC021A9
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2025 04:52:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4F1E10E2C6;
	Tue, 18 Feb 2025 04:52:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LOkIjecr";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19E8710E605
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2025 04:52:57 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id F2BA25C55C0;
 Tue, 18 Feb 2025 04:52:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931CDC4CEE6;
 Tue, 18 Feb 2025 04:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1739854375;
 bh=CGq1m5+ia0syy2YjVEoTOkb2iFoSAd5DTKt5xBSRyYc=;
 h=From:To:Cc:Subject:Date:From;
 b=LOkIjecr0XwoEszSUD7SRCIElIGnKZZm1Mm3tDVHGJliwctkKmhEHQ4hKCKUn1YOg
 5XcoxpdrRqjAQSr6X/jK0MImkWUTKmp47Oyo3NNYv2S5UyeQMqlXYp6ABv4IhBq+Wm
 QooD+6oOhDZzaU9T+q1fl1omEFegD0whRcI448A6oFW7E2TW7fEAT+adcLrjAzHtN/
 Z3WSGqU7ph0acCTOwx2y3nPyXEA6TS2rB5phQEBJEZFDpX8Z3TS0WBL14StirSvkRV
 qMo6ktVMM1KTfH3nn6LWaqBiZ1JHAjvwm+Hrq5dh95qYu32NguHmTzRKC+2YY/BVx+
 IbTCzO9wi2Ezw==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [RFC] drm/amd/display: Add and use new dm_prepare_suspend() callback
Date: Mon, 17 Feb 2025 22:52:43 -0600
Message-ID: <20250218045244.2455390-1-superm1@kernel.org>
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

The displays currently don't get turned off until after other IP blocks
have been suspended.  However turning off the displays first gives a
visible response that the system is on it's way down.

Turn off displays in a prepare_suspend() callback instead.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 21 ++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 70594e9179e8c..320b3ba74baea 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3037,6 +3037,21 @@ static void hpd_rx_irq_work_suspend(struct amdgpu_display_manager *dm)
 	}
 }
 
+static int dm_prepare_suspend(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+
+	if (amdgpu_in_reset(adev))
+		return 0;
+
+	WARN_ON(adev->dm.cached_state);
+	adev->dm.cached_state = drm_atomic_helper_suspend(adev_to_drm(adev));
+	if (IS_ERR(adev->dm.cached_state))
+		return PTR_ERR(adev->dm.cached_state);
+
+	return 0;
+}
+
 static int dm_suspend(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -3067,11 +3082,6 @@ static int dm_suspend(struct amdgpu_ip_block *ip_block)
 		return 0;
 	}
 
-	WARN_ON(adev->dm.cached_state);
-	adev->dm.cached_state = drm_atomic_helper_suspend(adev_to_drm(adev));
-	if (IS_ERR(adev->dm.cached_state))
-		return PTR_ERR(adev->dm.cached_state);
-
 	s3_handle_hdmi_cec(adev_to_drm(adev), true);
 
 	s3_handle_mst(adev_to_drm(adev), true);
@@ -3468,6 +3478,7 @@ static const struct amd_ip_funcs amdgpu_dm_funcs = {
 	.early_fini = amdgpu_dm_early_fini,
 	.hw_init = dm_hw_init,
 	.hw_fini = dm_hw_fini,
+	.prepare_suspend = dm_prepare_suspend,
 	.suspend = dm_suspend,
 	.resume = dm_resume,
 	.is_idle = dm_is_idle,
-- 
2.43.0

