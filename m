Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9947C369AB
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Apr 2025 21:07:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9944210E06D;
	Mon, 21 Apr 2025 21:07:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gibr1pnF";
	dkim-atps=neutral
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6EBF10E06D
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Apr 2025 21:06:55 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id EB67EA4BE75;
 Mon, 21 Apr 2025 21:01:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58DE4C4CEE4;
 Mon, 21 Apr 2025 21:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1745269609;
 bh=Ag49L9QhG6fGGMiLFns4JlsIQ+i3Z23OViVSlWYIgBc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gibr1pnFHKPR/PU+FIZv1wd36pmPMUI9ccJMlvsWz4hT3BK/Tm5Y7XY8b77+8i/X4
 +aymznhUhQnKpXZjQgSm+yw1g7/njnu2tWF3DWH9RSeARjwwfw9lCHSdxDW7hofEUo
 0ov1+xRTLeVGEmzSDR4oU+diWbb/XZa9X1yAI3y7bb39b9uZ6Q7bYN3lJhTRUxf7Bz
 0W0twS7CLMtNCcErpCKN/rNABMgOC6yi1JCx1ZjQH1G4Wm6QcTDPJzlWhlIBODtJeD
 Q7RUNmbBPUYSafqT+O6TEz1rHbihjRLUzZ6fR6DLY1ww2quuXOIn5s0c8hPvNLDkk0
 u7TF3xNtTft/Q==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>, Vicki Pfau <vi@endrift.com>
Subject: [PATCH RESEND 2/2] drm/amd: Allow printing Renoir OD SCLK levels
 without setting dpm to manual
Date: Mon, 21 Apr 2025 16:06:39 -0500
Message-ID: <20250421210639.1138228-2-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250421210639.1138228-1-superm1@kernel.org>
References: <20250421210639.1138228-1-superm1@kernel.org>
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

Several other ASICs allow printing OD SCLK levels without setting DPM
control to manual.  When OD is disabled it will show the range the
hardware supports. When OD is enabled it will show what values have been
programmed. Adjust Renoir to work the same.

Reported-by: Vicki Pfau <vi@endrift.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2:
 * Drop extra variable
---
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   | 37 ++++++++-----------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index 9481f897432d7..e97b0cf19197e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -497,7 +497,6 @@ static int renoir_print_clk_levels(struct smu_context *smu,
 	int i, idx, size = 0, ret = 0;
 	uint32_t cur_value = 0, value = 0, count = 0, min = 0, max = 0;
 	SmuMetrics_t metrics;
-	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
 	bool cur_value_match_level = false;
 
 	memset(&metrics, 0, sizeof(metrics));
@@ -510,28 +509,24 @@ static int renoir_print_clk_levels(struct smu_context *smu,
 
 	switch (clk_type) {
 	case SMU_OD_RANGE:
-		if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
-			ret = smu_cmn_send_smc_msg_with_param(smu,
-						SMU_MSG_GetMinGfxclkFrequency,
-						0, &min);
-			if (ret)
-				return ret;
-			ret = smu_cmn_send_smc_msg_with_param(smu,
-						SMU_MSG_GetMaxGfxclkFrequency,
-						0, &max);
-			if (ret)
-				return ret;
-			size += sysfs_emit_at(buf, size, "OD_RANGE\nSCLK: %10uMhz %10uMhz\n", min, max);
-		}
+		ret = smu_cmn_send_smc_msg_with_param(smu,
+					SMU_MSG_GetMinGfxclkFrequency,
+					0, &min);
+		if (ret)
+			return ret;
+		ret = smu_cmn_send_smc_msg_with_param(smu,
+					SMU_MSG_GetMaxGfxclkFrequency,
+					0, &max);
+		if (ret)
+			return ret;
+		size += sysfs_emit_at(buf, size, "OD_RANGE\nSCLK: %10uMhz %10uMhz\n", min, max);
 		break;
 	case SMU_OD_SCLK:
-		if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
-			min = (smu->gfx_actual_hard_min_freq > 0) ? smu->gfx_actual_hard_min_freq : smu->gfx_default_hard_min_freq;
-			max = (smu->gfx_actual_soft_max_freq > 0) ? smu->gfx_actual_soft_max_freq : smu->gfx_default_soft_max_freq;
-			size += sysfs_emit_at(buf, size, "OD_SCLK\n");
-			size += sysfs_emit_at(buf, size, "0:%10uMhz\n", min);
-			size += sysfs_emit_at(buf, size, "1:%10uMhz\n", max);
-		}
+		min = (smu->gfx_actual_hard_min_freq > 0) ? smu->gfx_actual_hard_min_freq : smu->gfx_default_hard_min_freq;
+		max = (smu->gfx_actual_soft_max_freq > 0) ? smu->gfx_actual_soft_max_freq : smu->gfx_default_soft_max_freq;
+		size += sysfs_emit_at(buf, size, "OD_SCLK\n");
+		size += sysfs_emit_at(buf, size, "0:%10uMhz\n", min);
+		size += sysfs_emit_at(buf, size, "1:%10uMhz\n", max);
 		break;
 	case SMU_GFXCLK:
 	case SMU_SCLK:
-- 
2.43.0

