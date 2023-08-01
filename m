Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7639DC04FE0
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Aug 2023 08:28:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E26FE10E350;
	Tue,  1 Aug 2023 08:28:02 +0000 (UTC)
Received: from out28-145.mail.aliyun.com (out28-145.mail.aliyun.com
 [115.124.28.145])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5D3810E0A5;
 Tue,  1 Aug 2023 01:43:30 +0000 (UTC)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.0994977|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.0138158-0.000495978-0.985688;
 FP=0|0|0|0|0|-1|-1|-1; HT=ay29a033018047201; MF=sunran001@208suo.com; NM=1;
 PH=DS; RN=7; RT=7; SR=0; TI=SMTPD_---.U5Ch.34_1690854200; 
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com
 fp:SMTPD_---.U5Ch.34_1690854200) by smtp.aliyun-inc.com;
 Tue, 01 Aug 2023 09:43:22 +0800
From: Ran Sun <sunran001@208suo.com>
To: alexander.deucher@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch
Subject: [PATCH] drm/amd/pm: Clean up errors in smu_v13_0.c
Date: Tue,  1 Aug 2023 01:43:18 +0000
Message-Id: <20230801014318.4097-1-sunran001@208suo.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Approved-At: Tue, 01 Aug 2023 08:27:46 +0000
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
Cc: Ran Sun <sunran001@208suo.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the following errors reported by checkpatch:

ERROR: space required before the open parenthesis '('
ERROR: that open brace { should be on the previous line

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 9b62b45ebb7f..895cda8e6934 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -1121,7 +1121,7 @@ smu_v13_0_display_clock_voltage_request(struct smu_context *smu,
 
 		ret = smu_v13_0_set_hard_freq_limited_range(smu, clk_select, clk_freq, 0);
 
-		if(clk_select == SMU_UCLK)
+		if (clk_select == SMU_UCLK)
 			smu->hard_min_uclk_req_from_dal = clk_freq;
 	}
 
@@ -1437,8 +1437,7 @@ static int smu_v13_0_irq_process(struct amdgpu_device *adev,
 	return 0;
 }
 
-static const struct amdgpu_irq_src_funcs smu_v13_0_irq_funcs =
-{
+static const struct amdgpu_irq_src_funcs smu_v13_0_irq_funcs = {
 	.set = smu_v13_0_set_irq_state,
 	.process = smu_v13_0_irq_process,
 };
@@ -1933,7 +1932,7 @@ static int smu_v13_0_get_dpm_level_count(struct smu_context *smu,
 
 	ret = smu_v13_0_get_dpm_freq_by_index(smu, clk_type, 0xff, value);
 	/* SMU v13.0.2 FW returns 0 based max level, increment by one for it */
-	if((smu->adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 2)) && (!ret && value))
+	if ((smu->adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 2)) && (!ret && value))
 		++(*value);
 
 	return ret;
-- 
2.17.1

