Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE056C04E69
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Aug 2023 08:27:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA0E410E32B;
	Tue,  1 Aug 2023 08:27:47 +0000 (UTC)
Received: from out28-3.mail.aliyun.com (out28-3.mail.aliyun.com [115.124.28.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7042D10E06B;
 Tue,  1 Aug 2023 02:01:03 +0000 (UTC)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.08409528|-1; CH=green;
 DM=|CONTINUE|false|; DS=CONTINUE|ham_alarm|0.00368847-0.000301355-0.99601;
 FP=0|0|0|0|0|-1|-1|-1; HT=ay29a033018047192; MF=sunran001@208suo.com; NM=1;
 PH=DS; RN=7; RT=7; SR=0; TI=SMTPD_---.U5DeSmo_1690855254; 
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com
 fp:SMTPD_---.U5DeSmo_1690855254) by smtp.aliyun-inc.com;
 Tue, 01 Aug 2023 10:00:56 +0800
From: Ran Sun <sunran001@208suo.com>
To: alexander.deucher@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch
Subject: [PATCH] drm/amd/pm: Clean up errors in aldebaran_ppt.c
Date: Tue,  1 Aug 2023 02:00:52 +0000
Message-Id: <20230801020052.4192-1-sunran001@208suo.com>
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

ERROR: that open brace { should be on the previous line
ERROR: space required after that ',' (ctx:VxV)
ERROR: spaces required around that '=' (ctx:VxW)
ERROR: else should follow close brace '}'

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index ce50ef46e73f..8f26123ac703 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -94,8 +94,7 @@
  */
 #define SUPPORT_BAD_CHANNEL_INFO_MSG_VERSION 0x00443300
 
-static const struct smu_temperature_range smu13_thermal_policy[] =
-{
+static const struct smu_temperature_range smu13_thermal_policy[] = {
 	{-273150,  99000, 99000, -273150, 99000, 99000, -273150, 99000, 99000},
 	{ 120000, 120000, 120000, 120000, 120000, 120000, 120000, 120000, 120000},
 };
@@ -196,7 +195,7 @@ static const struct cmn2asic_mapping aldebaran_feature_mask_map[SMU_FEATURE_COUN
 	ALDEBARAN_FEA_MAP(SMU_FEATURE_FW_CTF_BIT, 				FEATURE_FW_CTF_BIT),
 	ALDEBARAN_FEA_MAP(SMU_FEATURE_THERMAL_BIT, 				FEATURE_THERMAL_BIT),
 	ALDEBARAN_FEA_MAP(SMU_FEATURE_OUT_OF_BAND_MONITOR_BIT, 	FEATURE_OUT_OF_BAND_MONITOR_BIT),
-	ALDEBARAN_FEA_MAP(SMU_FEATURE_XGMI_PER_LINK_PWR_DWN_BIT,FEATURE_XGMI_PER_LINK_PWR_DWN),
+	ALDEBARAN_FEA_MAP(SMU_FEATURE_XGMI_PER_LINK_PWR_DWN_BIT, FEATURE_XGMI_PER_LINK_PWR_DWN),
 	ALDEBARAN_FEA_MAP(SMU_FEATURE_DF_CSTATE_BIT, 			FEATURE_DF_CSTATE),
 };
 
@@ -580,7 +579,7 @@ static int aldebaran_get_smu_metrics_data(struct smu_context *smu,
 					  MetricsMember_t member,
 					  uint32_t *value)
 {
-	struct smu_table_context *smu_table= &smu->smu_table;
+	struct smu_table_context *smu_table = &smu->smu_table;
 	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table->metrics_table;
 	int ret = 0;
 
@@ -1906,8 +1905,7 @@ static int aldebaran_mode1_reset(struct smu_context *smu)
 	smu_cmn_get_smc_version(smu, NULL, &smu_version);
 	if (smu_version < 0x00440700) {
 		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_Mode1Reset, NULL);
-	}
-	else {
+	} else {
 		/* fatal error triggered by ras, PMFW supports the flag
 		   from 68.44.0 */
 		if ((smu_version >= 0x00442c00) && ras &&
@@ -2116,7 +2114,7 @@ static const struct pptable_funcs aldebaran_ppt_funcs = {
 	.register_irq_handler = smu_v13_0_register_irq_handler,
 	.set_azalia_d3_pme = smu_v13_0_set_azalia_d3_pme,
 	.get_max_sustainable_clocks_by_dc = smu_v13_0_get_max_sustainable_clocks_by_dc,
-	.baco_is_support= aldebaran_is_baco_supported,
+	.baco_is_support = aldebaran_is_baco_supported,
 	.get_dpm_ultimate_freq = smu_v13_0_get_dpm_ultimate_freq,
 	.set_soft_freq_limited_range = aldebaran_set_soft_freq_limited_range,
 	.od_edit_dpm_table = aldebaran_usr_edit_dpm_table,
-- 
2.17.1

