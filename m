Return-Path: <SRS0=BZXp=2K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D18DC43603
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2019 14:30:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63A6D21D7E
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2019 14:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OyeQAaiG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63A6D21D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98BBD89951;
	Fri, 20 Dec 2019 14:30:02 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0986A897F3;
 Fri, 20 Dec 2019 14:30:01 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1023B222C2;
 Fri, 20 Dec 2019 14:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1576852200;
 bh=3CFxgb1XYfVRl4xlSUpQXa/2v8fVOtiV7dJcNuwG3bE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=OyeQAaiGbJnTIpqiC3/FDOIUZX5W5bar7SIHnHB8M5CPeRqS0muMwfu0otystF90G
 L2f+RpOfkCXMORDbRhX6Q4IDuP2cXjIgQHhkeUSBmH7oSYVnvCw9yk4Ohcc1LNq5ht
 vQP7S0o8SLBTmCf7woNMTDZI71BKhT/1RpJt7Pmo=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 04/52] drm/amdgpu: add check before
 enabling/disabling broadcast mode
Date: Fri, 20 Dec 2019 09:29:06 -0500
Message-Id: <20191220142954.9500-4-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191220142954.9500-1-sashal@kernel.org>
References: <20191220142954.9500-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
Cc: Sasha Levin <sashal@kernel.org>, Guchun Chen <guchun.chen@amd.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Guchun Chen <guchun.chen@amd.com>

[ Upstream commit 6e807535dae5dbbd53bcc5e81047a20bf5eb08ea ]

When security violation from new vbios happens, data fabric is
risky to stop working. So prevent the direct access to DF
mmFabricConfigAccessControl from the new vbios and onwards.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/df_v3_6.c | 38 ++++++++++++++++------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
index 5850c8e34caac..97d11d7923514 100644
--- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
+++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
@@ -261,23 +261,29 @@ static void df_v3_6_update_medium_grain_clock_gating(struct amdgpu_device *adev,
 {
 	u32 tmp;
 
-	/* Put DF on broadcast mode */
-	adev->df_funcs->enable_broadcast_mode(adev, true);
-
-	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_DF_MGCG)) {
-		tmp = RREG32_SOC15(DF, 0, mmDF_PIE_AON0_DfGlobalClkGater);
-		tmp &= ~DF_PIE_AON0_DfGlobalClkGater__MGCGMode_MASK;
-		tmp |= DF_V3_6_MGCG_ENABLE_15_CYCLE_DELAY;
-		WREG32_SOC15(DF, 0, mmDF_PIE_AON0_DfGlobalClkGater, tmp);
-	} else {
-		tmp = RREG32_SOC15(DF, 0, mmDF_PIE_AON0_DfGlobalClkGater);
-		tmp &= ~DF_PIE_AON0_DfGlobalClkGater__MGCGMode_MASK;
-		tmp |= DF_V3_6_MGCG_DISABLE;
-		WREG32_SOC15(DF, 0, mmDF_PIE_AON0_DfGlobalClkGater, tmp);
-	}
+	if (adev->cg_flags & AMD_CG_SUPPORT_DF_MGCG) {
+		/* Put DF on broadcast mode */
+		adev->df_funcs->enable_broadcast_mode(adev, true);
+
+		if (enable) {
+			tmp = RREG32_SOC15(DF, 0,
+					mmDF_PIE_AON0_DfGlobalClkGater);
+			tmp &= ~DF_PIE_AON0_DfGlobalClkGater__MGCGMode_MASK;
+			tmp |= DF_V3_6_MGCG_ENABLE_15_CYCLE_DELAY;
+			WREG32_SOC15(DF, 0,
+					mmDF_PIE_AON0_DfGlobalClkGater, tmp);
+		} else {
+			tmp = RREG32_SOC15(DF, 0,
+					mmDF_PIE_AON0_DfGlobalClkGater);
+			tmp &= ~DF_PIE_AON0_DfGlobalClkGater__MGCGMode_MASK;
+			tmp |= DF_V3_6_MGCG_DISABLE;
+			WREG32_SOC15(DF, 0,
+					mmDF_PIE_AON0_DfGlobalClkGater, tmp);
+		}
 
-	/* Exit broadcast mode */
-	adev->df_funcs->enable_broadcast_mode(adev, false);
+		/* Exit broadcast mode */
+		adev->df_funcs->enable_broadcast_mode(adev, false);
+	}
 }
 
 static void df_v3_6_get_clockgating_state(struct amdgpu_device *adev,
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
