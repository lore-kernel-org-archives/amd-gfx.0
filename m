Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5D55C83F26
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Jul 2025 03:12:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C3D610E414;
	Fri, 25 Jul 2025 03:12:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mvx3EPzE";
	dkim-atps=neutral
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D673F10E412
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Jul 2025 03:12:32 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id B12FCA51D65;
 Fri, 25 Jul 2025 03:12:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED58EC4CEF5;
 Fri, 25 Jul 2025 03:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1753413151;
 bh=i34qQU1V1ZEVkBEpNeYp5m7/NLY0ExwpFcQoyd/QJUQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mvx3EPzEHRwD4hGBWStZPkHUWigPrfIrN45MnEBqhEWr9QmuloJkcVtw5uIal9XNT
 NHQOZcrWRYcLuuPSS98IaFL2+j9dcopb3kmgDTT864DnNZ0T24aCdXuVCwrT6vEelk
 ZuaHKqsbDwreH/TT+Wb2JB/FD3jtgU4D32wl5DGr5nLsdePTSP8gyDcjLrI9Xi0GnM
 RVZsVqq9MU0T8nha4mDdc1Kxi6BuanJ2jQ1QS6dIO+Q7+FzqsWLZAy2hZJIluEyuxs
 LFGLaoEqpRVD4Mnnsgx1mEv1MITrQ/33AZYraymv6XwWTb3kW9/uOzx2VGlYNpNIQd
 KVGZSCB1OkwmQ==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 2/2] drm/amd: Restore cached manual clock settings during
 resume
Date: Thu, 24 Jul 2025 22:12:22 -0500
Message-ID: <20250725031222.3015095-3-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250725031222.3015095-1-superm1@kernel.org>
References: <20250725031222.3015095-1-superm1@kernel.org>
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

If the SCLK limits have been set before S3 they will not
be restored. The limits are however cached in the driver and so
they can be restored by running a commit sequence during resume.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 7537964c3c998..26b8e232f8582 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -76,6 +76,9 @@ static void smu_power_profile_mode_get(struct smu_context *smu,
 				       enum PP_SMC_POWER_PROFILE profile_mode);
 static void smu_power_profile_mode_put(struct smu_context *smu,
 				       enum PP_SMC_POWER_PROFILE profile_mode);
+static int smu_od_edit_dpm_table(void *handle,
+				 enum PP_OD_DPM_TABLE_COMMAND type,
+				 long *input, uint32_t size);
 
 static int smu_sys_get_pp_feature_mask(void *handle,
 				       char *buf)
@@ -2144,6 +2147,7 @@ static int smu_resume(struct amdgpu_ip_block *ip_block)
 	int ret;
 	struct amdgpu_device *adev = ip_block->adev;
 	struct smu_context *smu = adev->powerplay.pp_handle;
+	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
 
 	if (amdgpu_sriov_multi_vf_mode(adev))
 		return 0;
@@ -2181,6 +2185,12 @@ static int smu_resume(struct amdgpu_ip_block *ip_block)
 			return ret;
 	}
 
+	if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
+		ret = smu_od_edit_dpm_table(smu, PP_OD_COMMIT_DPM_TABLE, NULL, 0);
+		if (ret)
+			return ret;
+	}
+
 	dev_info(adev->dev, "SMU is resumed successfully!\n");
 
 	return 0;
-- 
2.43.0

