Return-Path: <SRS0=khk6=AO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC80C433DF
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2020 08:55:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2E8E207DA
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2020 08:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="F0iBnf+7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2E8E207DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 874356E081;
	Fri,  3 Jul 2020 08:55:35 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCAD26E081
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jul 2020 08:55:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nUdDxgTzV6tLm4Re7XsLsQN0kklTtB6OkvSvfr+sDGD2ZvzCsS1qEkzPeGYd9zJwQEhSbaWiSmUmTtManju8unszAlcS8NWl/A9gSLiFSgEAoUr93Bw0O9FFJdlc+3dx6W96l1P5cv+P0BY0LEkCa67dR7ephnHy19vmPyAmvRwVvvXHtgoJifgImpNOB09k7+4p0iREcfAsr3esGtpOI2ia4/QpLsRgvLM8HLaTYY5oFLKD1qk4JSvYedU4nsPbBOsiRelPs1cD8oBAqjf28immpWcoBumwNEs/z0V+d8/8PV30c8IBNWMP3wGwiitwhrTFrzWn9y0uvG+S7pvQSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jP1s8FvH7scqUh2/VPmIGuJIGcppo0FEswAbKi2gXrw=;
 b=aNJVvm4br2fKU1sR5KA5dVHlK5F0XEC0oDVryRaIlQI3adV9rbx0Gb6GV6quaEh8Mi07YiGIIWagFUNV1qGLNNBcqGNhmrNvFXLT03Kee1902/YgvMsoWYh9dwSzWJu0GF8GMjGNA2Nl0XzbLQZEw+KmIF3IBarvtK3Cx9xNB1RAxVK6bs79lYgRDkLPjSs2iPEhtW/asyfypnIfDYPs+J3FVmr12NavU9pKX6Nc+41bxhz3AUSu2ZW5mMqjtkdkyk9Vwm3YHImo77YV9mJ/X2Cs7HCgm1/AwtmKlOWgXREHEi8WLMnjinC01yYXojb+sf1HsI+gd0WT7qPPqFHmcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jP1s8FvH7scqUh2/VPmIGuJIGcppo0FEswAbKi2gXrw=;
 b=F0iBnf+7in8rBPWlRP1AjHdzgVaP9Y4gRsdi+roW1+kFZ7D33cmOIdcHcqrturak+RVBEOMdSCRHa8EJj1o8vxAtdIpElg3vrt36ScSc5ECWME4fck9hhWdoQd+XLjuuwItqz3XJGjzVUKTPByr0oIadwuwP3JfOcyo0Qdp9q18=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4353.namprd12.prod.outlook.com (2603:10b6:5:2a6::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.20; Fri, 3 Jul 2020 08:55:32 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3153.023; Fri, 3 Jul 2020
 08:55:32 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amd/powerplay: drop unnecessary wrapper around pcie
 parameters setting
Date: Fri,  3 Jul 2020 16:55:14 +0800
Message-Id: <20200703085515.7552-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
X-ClientProxiedBy: HK2PR03CA0062.apcprd03.prod.outlook.com
 (2603:1096:202:17::32) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR03CA0062.apcprd03.prod.outlook.com (2603:1096:202:17::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.15 via Frontend Transport; Fri, 3 Jul 2020 08:55:31 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 248d571b-31cc-4d98-93e1-08d81f2ed7ec
X-MS-TrafficTypeDiagnostic: DM6PR12MB4353:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4353A648FD9F67112ECDCCF8E46A0@DM6PR12MB4353.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:261;
X-Forefront-PRVS: 045315E1EE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WXvVKGWhovCnFbB3eDH4b81hy3ZMg708JBLXpUISAhJYTb3TOBDJlKDsiua5Mn50ZOIBFwO8E1N9yuDdDkcxk/XxaMnfT37JT9BDuSdvSgbmwrw/n4DGzXlk/z9B9+4N4CGRRUDGu9pNtzVLMhZCrA0i1xmjDP2eVOqpy+ysZvJW9eYbQ+6ZF5apGi9lvZGFIbumQ/W+0alBdL4aOr4l3s+sTDwmewXXm+2OszzebRyHIRl6CptAvKHgcrcdxy1PSly+fk3LwrqLggi3xa5L5a/QW4sXHatosONGgwgbhEv0IBfqR1yDY1w1WAfSYTpjwxHsG4LvT+MAZXHYV8MXjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(39860400002)(346002)(136003)(366004)(956004)(478600001)(86362001)(4326008)(6486002)(8676002)(2906002)(8936002)(5660300002)(36756003)(83380400001)(6666004)(66574015)(2616005)(6916009)(186003)(316002)(44832011)(66476007)(52116002)(1076003)(26005)(66946007)(66556008)(16526019)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: KJd469UE4j5qs7cN++2hMmibST7/F9CKN+p6k64H2a8lzNMJT4S4PtXU5WkHhV2lK+3vuJu5Ysax64I2E2+ITJamEy3pM8eJn+jsBsNzcWfSyFLzHBpW5fjlyOR0pP1vm9891t38zqz+Rzx638vyCPfDpvq47hL0RrtuXJR5mLidPidpJ3isx2U0fHlKhULlFVIhe/RSMNz2NcbPPCe7E+FCUP0ZyLRYwwMNScfJBwsAF07rmS1u9JljZ4bL0nOI1+p1HKi9uj4Xv0+6qohjlX9DgbNBhHuWE+rqgKQptjRTrRwNHjZJPQb+SS9YU8u39qwHU/v1g1nKvPCLDB45xh2eSJVglB3ke9C39RyjjKN1FjFtv/rxLU89RM2IkknNi+4V4JBTsMtePCBnuyoKUaRXqZVK56KLkQB5a79/PvYU/vJ0/2XKr1sELAZ8KnLL6ROEBFT7CuAc2YNwAxH5gilbnEtniViGSl6Eo3N1XmuWNVtF0aJtc3iKJNw9R4o0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 248d571b-31cc-4d98-93e1-08d81f2ed7ec
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2020 08:55:32.6126 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y83A0rj+zHC2O3x+UeU08+YEa3+v0dfyFz8ehR2DSyPIWsXLAy43IIQNaOCZ5poB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4353
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This can also help to maintain clear code layer.

Change-Id: I9bf6a7bb93112ae40bd549ee4d7afb42a968aacf
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    | 33 ++++++++++++++-
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  |  1 -
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  1 -
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h |  2 -
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c    |  1 -
 .../drm/amd/powerplay/sienna_cichlid_ppt.c    |  1 -
 drivers/gpu/drm/amd/powerplay/smu_internal.h  |  1 -
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 42 -------------------
 8 files changed, 31 insertions(+), 51 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 38b3b47d12b7..3d62a99bad84 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -33,6 +33,7 @@
 #include "navi10_ppt.h"
 #include "sienna_cichlid_ppt.h"
 #include "renoir_ppt.h"
+#include "amd_pcie.h"
 
 /*
  * DO NOT use these for err/warn/info/debug messages.
@@ -993,6 +994,7 @@ static int smu_sw_fini(void *handle)
 static int smu_smc_hw_setup(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
+	uint32_t pcie_gen = 0, pcie_width = 0;
 	int ret;
 
 	if (smu_is_dpm_running(smu) && adev->in_suspend) {
@@ -1062,9 +1064,36 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 	if (!smu_is_dpm_running(smu))
 		dev_info(adev->dev, "dpm has been disabled\n");
 
-	ret = smu_override_pcie_parameters(smu);
-	if (ret)
+	if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN4)
+		pcie_gen = 3;
+	else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3)
+		pcie_gen = 2;
+	else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN2)
+		pcie_gen = 1;
+	else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN1)
+		pcie_gen = 0;
+
+	/* Bit 31:16: LCLK DPM level. 0 is DPM0, and 1 is DPM1
+	 * Bit 15:8:  PCIE GEN, 0 to 3 corresponds to GEN1 to GEN4
+	 * Bit 7:0:   PCIE lane width, 1 to 7 corresponds is x1 to x32
+	 */
+	if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X16)
+		pcie_width = 6;
+	else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X12)
+		pcie_width = 5;
+	else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X8)
+		pcie_width = 4;
+	else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X4)
+		pcie_width = 3;
+	else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X2)
+		pcie_width = 2;
+	else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X1)
+		pcie_width = 1;
+	ret = smu_update_pcie_parameters(smu, pcie_gen, pcie_width);
+	if (ret) {
+		dev_err(adev->dev, "Attempt to override pcie params failed!\n");
 		return ret;
+	}
 
 	ret = smu_enable_thermal_alert(smu);
 	if (ret) {
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index afd07c497205..3687e7620eb8 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -2422,7 +2422,6 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.baco_exit = smu_v11_0_baco_exit,
 	.get_dpm_ultimate_freq = smu_v11_0_get_dpm_ultimate_freq,
 	.set_soft_freq_limited_range = smu_v11_0_set_soft_freq_limited_range,
-	.override_pcie_parameters = NULL,
 	.set_df_cstate = arcturus_set_df_cstate,
 	.allow_xgmi_power_down = arcturus_allow_xgmi_power_down,
 	.log_thermal_throttling_event = arcturus_log_thermal_throttling_event,
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 470b0377a860..ba8e162f44ab 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -566,7 +566,6 @@ struct pptable_funcs {
 	int (*mode2_reset)(struct smu_context *smu);
 	int (*get_dpm_ultimate_freq)(struct smu_context *smu, enum smu_clk_type clk_type, uint32_t *min, uint32_t *max);
 	int (*set_soft_freq_limited_range)(struct smu_context *smu, enum smu_clk_type clk_type, uint32_t min, uint32_t max);
-	int (*override_pcie_parameters)(struct smu_context *smu);
 	int (*disable_umc_cdr_12gbps_workaround)(struct smu_context *smu);
 	int (*set_power_source)(struct smu_context *smu, enum smu_power_src_type power_src);
 	void (*log_thermal_throttling_event)(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
index 14d6eef8cf17..311166f1975c 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -268,8 +268,6 @@ int smu_v11_0_set_hard_freq_limited_range(struct smu_context *smu,
 					  uint32_t min,
 					  uint32_t max);
 
-int smu_v11_0_override_pcie_parameters(struct smu_context *smu);
-
 int smu_v11_0_set_performance_level(struct smu_context *smu,
 				    enum amd_dpm_forced_level level);
 
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 6d638a67bc4d..3db5e663aa6f 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -2435,7 +2435,6 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.baco_exit = smu_v11_0_baco_exit,
 	.get_dpm_ultimate_freq = smu_v11_0_get_dpm_ultimate_freq,
 	.set_soft_freq_limited_range = smu_v11_0_set_soft_freq_limited_range,
-	.override_pcie_parameters = smu_v11_0_override_pcie_parameters,
 	.set_default_od_settings = navi10_set_default_od_settings,
 	.od_edit_dpm_table = navi10_od_edit_dpm_table,
 	.run_btc = navi10_run_btc,
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index 141944df97b0..7a108676f90a 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -2551,7 +2551,6 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.baco_exit = smu_v11_0_baco_exit,
 	.get_dpm_ultimate_freq = sienna_cichlid_get_dpm_ultimate_freq,
 	.set_soft_freq_limited_range = smu_v11_0_set_soft_freq_limited_range,
-	.override_pcie_parameters = smu_v11_0_override_pcie_parameters,
 	.set_thermal_range = sienna_cichlid_set_thermal_range,
 };
 
diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
index 6eb375af543d..5deb30452ff8 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
@@ -90,7 +90,6 @@
 #define smu_get_dpm_ultimate_freq(smu, param, min, max)			smu_ppt_funcs(get_dpm_ultimate_freq, 0, smu, param, min, max)
 #define smu_asic_set_performance_level(smu, level)			smu_ppt_funcs(set_performance_level, -EINVAL, smu, level)
 #define smu_dump_pptable(smu)						smu_ppt_funcs(dump_pptable, 0, smu)
-#define smu_override_pcie_parameters(smu)				smu_ppt_funcs(override_pcie_parameters, 0, smu)
 #define smu_update_pcie_parameters(smu, pcie_gen_cap, pcie_width_cap)	smu_ppt_funcs(update_pcie_parameters, 0, smu, pcie_gen_cap, pcie_width_cap)
 #define smu_set_thermal_range(smu, range)				smu_ppt_funcs(set_thermal_range, 0, smu, range)
 #define smu_disable_umc_cdr_12gbps_workaround(smu)			smu_ppt_funcs(disable_umc_cdr_12gbps_workaround, 0, smu)
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 1ed5ac946c05..34bb0f0320f6 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -35,7 +35,6 @@
 #include "smu_v11_0.h"
 #include "soc15_common.h"
 #include "atom.h"
-#include "amd_pcie.h"
 #include "amdgpu_ras.h"
 
 #include "asic_reg/thm/thm_11_0_2_offset.h"
@@ -1823,47 +1822,6 @@ int smu_v11_0_set_hard_freq_limited_range(struct smu_context *smu,
 	return ret;
 }
 
-int smu_v11_0_override_pcie_parameters(struct smu_context *smu)
-{
-	struct amdgpu_device *adev = smu->adev;
-	uint32_t pcie_gen = 0, pcie_width = 0;
-	int ret;
-
-	if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN4)
-		pcie_gen = 3;
-	else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3)
-		pcie_gen = 2;
-	else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN2)
-		pcie_gen = 1;
-	else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN1)
-		pcie_gen = 0;
-
-	/* Bit 31:16: LCLK DPM level. 0 is DPM0, and 1 is DPM1
-	 * Bit 15:8:  PCIE GEN, 0 to 3 corresponds to GEN1 to GEN4
-	 * Bit 7:0:   PCIE lane width, 1 to 7 corresponds is x1 to x32
-	 */
-	if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X16)
-		pcie_width = 6;
-	else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X12)
-		pcie_width = 5;
-	else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X8)
-		pcie_width = 4;
-	else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X4)
-		pcie_width = 3;
-	else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X2)
-		pcie_width = 2;
-	else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X1)
-		pcie_width = 1;
-
-	ret = smu_update_pcie_parameters(smu, pcie_gen, pcie_width);
-
-	if (ret)
-		dev_err(adev->dev, "[%s] Attempt to override pcie params failed!\n", __func__);
-
-	return ret;
-
-}
-
 int smu_v11_0_set_performance_level(struct smu_context *smu,
 				    enum amd_dpm_forced_level level)
 {
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
