Return-Path: <SRS0=7Jcp=MC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0975EC07E95
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Jul 2021 23:50:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5029613B6
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Jul 2021 23:50:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5029613B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB6206EB6C;
	Sat, 10 Jul 2021 23:50:02 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34ECD6EB68;
 Sat, 10 Jul 2021 23:50:01 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 36158610CA;
 Sat, 10 Jul 2021 23:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625961000;
 bh=rpDobu1G+F7akFTYlmVyFeM8NUSVwORrKbFMdXzVVOY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ICR/53P3Ai3103+NJ3xCRatwHYJQMLctxlsGxOxTAhsFuwUdeu0U8oLTJfGSli4gG
 XHFmjBhf1Qea/CAxjsuZ5sErb9V3/u8aHFBhFLm3KD0NGs9PGLu7ogMrbLv3o8e8Ct
 fpzOOwRr9u+UYKt5vHmFZkHKAnKblbUC7loWXM74phF5ggfL6g4Mt2yTzSKvpKw2Mp
 aA1wyGh/ZNggSQWl8ey9wsPWpgDSwtOMVT9OxljPwPVeEy3nApl0RgMKh/8bjx7Xxt
 8hUFKkYNdCCdad7213YjvswwUqCWXbDAKrnACzWkgM56A8DciA2jQZoTxEO2uPamU4
 py2PN+np7E6xQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.12 31/43] drm/amdgpu: fix Navi1x tcp power gating
 hang when issuing lightweight invalidaiton
Date: Sat, 10 Jul 2021 19:49:03 -0400
Message-Id: <20210710234915.3220342-31-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210710234915.3220342-1-sashal@kernel.org>
References: <20210710234915.3220342-1-sashal@kernel.org>
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
Cc: Sasha Levin <sashal@kernel.org>, Lijo Lazar <lijo.lazar@amd.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Evan Quan <evan.quan@amd.com>

[ Upstream commit 9c26ddb1c5b6e30c6bca48b8ad9205d96efe93d0 ]

Fix TCP hang when a lightweight invalidation happens on Navi1x.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 95 ++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 2342c5d216f9..5c40912b51d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7744,6 +7744,97 @@ static void gfx_v10_0_update_fine_grain_clock_gating(struct amdgpu_device *adev,
 	}
 }
 
+static void gfx_v10_0_apply_medium_grain_clock_gating_workaround(struct amdgpu_device *adev)
+{
+	uint32_t reg_data = 0;
+	uint32_t reg_idx = 0;
+	uint32_t i;
+
+	const uint32_t tcp_ctrl_regs[] = {
+		mmCGTS_SA0_WGP00_CU0_TCP_CTRL_REG,
+		mmCGTS_SA0_WGP00_CU1_TCP_CTRL_REG,
+		mmCGTS_SA0_WGP01_CU0_TCP_CTRL_REG,
+		mmCGTS_SA0_WGP01_CU1_TCP_CTRL_REG,
+		mmCGTS_SA0_WGP02_CU0_TCP_CTRL_REG,
+		mmCGTS_SA0_WGP02_CU1_TCP_CTRL_REG,
+		mmCGTS_SA0_WGP10_CU0_TCP_CTRL_REG,
+		mmCGTS_SA0_WGP10_CU1_TCP_CTRL_REG,
+		mmCGTS_SA0_WGP11_CU0_TCP_CTRL_REG,
+		mmCGTS_SA0_WGP11_CU1_TCP_CTRL_REG,
+		mmCGTS_SA0_WGP12_CU0_TCP_CTRL_REG,
+		mmCGTS_SA0_WGP12_CU1_TCP_CTRL_REG,
+		mmCGTS_SA1_WGP00_CU0_TCP_CTRL_REG,
+		mmCGTS_SA1_WGP00_CU1_TCP_CTRL_REG,
+		mmCGTS_SA1_WGP01_CU0_TCP_CTRL_REG,
+		mmCGTS_SA1_WGP01_CU1_TCP_CTRL_REG,
+		mmCGTS_SA1_WGP02_CU0_TCP_CTRL_REG,
+		mmCGTS_SA1_WGP02_CU1_TCP_CTRL_REG,
+		mmCGTS_SA1_WGP10_CU0_TCP_CTRL_REG,
+		mmCGTS_SA1_WGP10_CU1_TCP_CTRL_REG,
+		mmCGTS_SA1_WGP11_CU0_TCP_CTRL_REG,
+		mmCGTS_SA1_WGP11_CU1_TCP_CTRL_REG,
+		mmCGTS_SA1_WGP12_CU0_TCP_CTRL_REG,
+		mmCGTS_SA1_WGP12_CU1_TCP_CTRL_REG
+	};
+
+	const uint32_t tcp_ctrl_regs_nv12[] = {
+		mmCGTS_SA0_WGP00_CU0_TCP_CTRL_REG,
+		mmCGTS_SA0_WGP00_CU1_TCP_CTRL_REG,
+		mmCGTS_SA0_WGP01_CU0_TCP_CTRL_REG,
+		mmCGTS_SA0_WGP01_CU1_TCP_CTRL_REG,
+		mmCGTS_SA0_WGP02_CU0_TCP_CTRL_REG,
+		mmCGTS_SA0_WGP02_CU1_TCP_CTRL_REG,
+		mmCGTS_SA0_WGP10_CU0_TCP_CTRL_REG,
+		mmCGTS_SA0_WGP10_CU1_TCP_CTRL_REG,
+		mmCGTS_SA0_WGP11_CU0_TCP_CTRL_REG,
+		mmCGTS_SA0_WGP11_CU1_TCP_CTRL_REG,
+		mmCGTS_SA1_WGP00_CU0_TCP_CTRL_REG,
+		mmCGTS_SA1_WGP00_CU1_TCP_CTRL_REG,
+		mmCGTS_SA1_WGP01_CU0_TCP_CTRL_REG,
+		mmCGTS_SA1_WGP01_CU1_TCP_CTRL_REG,
+		mmCGTS_SA1_WGP02_CU0_TCP_CTRL_REG,
+		mmCGTS_SA1_WGP02_CU1_TCP_CTRL_REG,
+		mmCGTS_SA1_WGP10_CU0_TCP_CTRL_REG,
+		mmCGTS_SA1_WGP10_CU1_TCP_CTRL_REG,
+		mmCGTS_SA1_WGP11_CU0_TCP_CTRL_REG,
+		mmCGTS_SA1_WGP11_CU1_TCP_CTRL_REG,
+	};
+
+	const uint32_t sm_ctlr_regs[] = {
+		mmCGTS_SA0_QUAD0_SM_CTRL_REG,
+		mmCGTS_SA0_QUAD1_SM_CTRL_REG,
+		mmCGTS_SA1_QUAD0_SM_CTRL_REG,
+		mmCGTS_SA1_QUAD1_SM_CTRL_REG
+	};
+
+	if (adev->asic_type == CHIP_NAVI12) {
+		for (i = 0; i < ARRAY_SIZE(tcp_ctrl_regs_nv12); i++) {
+			reg_idx = adev->reg_offset[GC_HWIP][0][mmCGTS_SA0_WGP00_CU0_TCP_CTRL_REG_BASE_IDX] +
+				  tcp_ctrl_regs_nv12[i];
+			reg_data = RREG32(reg_idx);
+			reg_data |= CGTS_SA0_WGP00_CU0_TCP_CTRL_REG__TCPI_LS_OVERRIDE_MASK;
+			WREG32(reg_idx, reg_data);
+		}
+	} else {
+		for (i = 0; i < ARRAY_SIZE(tcp_ctrl_regs); i++) {
+			reg_idx = adev->reg_offset[GC_HWIP][0][mmCGTS_SA0_WGP00_CU0_TCP_CTRL_REG_BASE_IDX] +
+				  tcp_ctrl_regs[i];
+			reg_data = RREG32(reg_idx);
+			reg_data |= CGTS_SA0_WGP00_CU0_TCP_CTRL_REG__TCPI_LS_OVERRIDE_MASK;
+			WREG32(reg_idx, reg_data);
+		}
+	}
+
+	for (i = 0; i < ARRAY_SIZE(sm_ctlr_regs); i++) {
+		reg_idx = adev->reg_offset[GC_HWIP][0][mmCGTS_SA0_QUAD0_SM_CTRL_REG_BASE_IDX] +
+			  sm_ctlr_regs[i];
+		reg_data = RREG32(reg_idx);
+		reg_data &= ~CGTS_SA0_QUAD0_SM_CTRL_REG__SM_MODE_MASK;
+		reg_data |= 2 << CGTS_SA0_QUAD0_SM_CTRL_REG__SM_MODE__SHIFT;
+		WREG32(reg_idx, reg_data);
+	}
+}
+
 static int gfx_v10_0_update_gfx_clock_gating(struct amdgpu_device *adev,
 					    bool enable)
 {
@@ -7760,6 +7851,10 @@ static int gfx_v10_0_update_gfx_clock_gating(struct amdgpu_device *adev,
 		gfx_v10_0_update_3d_clock_gating(adev, enable);
 		/* ===  CGCG + CGLS === */
 		gfx_v10_0_update_coarse_grain_clock_gating(adev, enable);
+
+		if ((adev->asic_type >= CHIP_NAVI10) &&
+		     (adev->asic_type <= CHIP_NAVI12))
+			gfx_v10_0_apply_medium_grain_clock_gating_workaround(adev);
 	} else {
 		/* CGCG/CGLS should be disabled before MGCG/MGLS
 		 * ===  CGCG + CGLS ===
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
