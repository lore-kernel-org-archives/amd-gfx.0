Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E13C28B30
	for <amd-gfx@archiver.kernel.org>; Sun, 23 Mar 2025 14:53:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D343C10E072;
	Sun, 23 Mar 2025 14:53:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="obHEwMIR";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47E7010E072
 for <amd-gfx@lists.freedesktop.org>; Sun, 23 Mar 2025 14:53:25 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 86E2743963;
 Sun, 23 Mar 2025 14:53:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 486D0C4CEE8;
 Sun, 23 Mar 2025 14:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1742741604;
 bh=u/iEhrKjjjv2CFpXcC1xr+Rb7WSS2GyMCtBpV0pS2is=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=obHEwMIRATJizbiOWxK4Y1u99wUJFZ4kpsNZwqQ0dO89A4EpxrZXyira2iQzpLch0
 Tu9Ky+OA2+XxT7V7uZ51/jfjJJmvlgNWz6ZZlwfmrsLd/lDHqw2VopwKJsP334/vna
 JZzVypsWTZ2TaW6hwyEWSgSJNjGaxXeEoM+JAbwuLMY41DR7qm3n5MzFV0JXHukd43
 0TSbWmefgYr7y5tTtADOflwWuZ97IZiR+RVC+qx37h9/5jnX7/7NdM2w1huaAIGaI3
 O2djXxHFU4uYwO3Cd0PYjFHuqa3DBZkCiDtBwqUx9cke6FLCi7+ridNj+aLOjLkZ3x
 IMmitiEj070yA==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>, Vicki Pfau <vi@endrift.com>
Subject: [PATCH 2/2] drm/amd: Allow printing Renoir OD SCLK levels without
 setting dpm to manual
Date: Sun, 23 Mar 2025 09:53:16 -0500
Message-ID: <20250323145316.859797-2-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250323145316.859797-1-superm1@kernel.org>
References: <20250323145316.859797-1-superm1@kernel.org>
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
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   | 36 +++++++++----------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index 37d82a71a2d7c..93275ff2ca692 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -510,28 +510,24 @@ static int renoir_print_clk_levels(struct smu_context *smu,
 
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

