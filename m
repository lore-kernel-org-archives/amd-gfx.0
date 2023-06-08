Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35C9FC7EE23
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jun 2023 10:27:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C62410E410;
	Thu,  8 Jun 2023 10:27:42 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D78710E410
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jun 2023 10:27:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LvPp9OSgdJ9Z4CUUW+hHJG7dSdM5rzmasL1XAQyz4e/UDUkYMIr1FE5ouqVeWZ3UPfC+drnaD8OA1r+/1PxeLLFvDu6s5PXPEegsOuo8CImiGjKDbwSe1semecYnkFM7nRZbhp2R4TLvn4vXlO2CasCzSHed3XVxHCrczavPuSmRhuzDzsz/T9NdcwDZBmpSqbuckYVTsgEszlO+U5ZzkPaDrVBNNFSUV/tbcQFazJtAcvZA8DQfAOknQMxBSKuQ1YT7SqGzKc72ovIYsOQw6juJqZPhZ6pnrIiw1te+9ngSPBr8O3fxRG+C0qR17Mwb30uCFGSqOuz5wdSZ6ftlGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2BZB6aNZVh+KFCFc/xnJ4uKVh1SIenSz3xnFegr2ipE=;
 b=mjVPdZ3g5NCWdKhEAHcneZ56yyXuYo/ugMbLMUVP9GlZx+TniCo5ukh5Bka6L3CFsgmQauvXiimfFUm6cbqlocG+ubY1/sHLU3TlPRqnhm7aJ8rersWtEmTy9hi5BKXRbWpxj9dCdOjTN+U6h9ThRFcYOd+QUhwt9G4rpA1d/hL84JatkBk73ozF4LUagHrHsWXY8OPoeHW+686mJiQwi47gQponVdm59KW2WDrp69AiZ7dGbltw1i1Qz5jztiv7kBJ78joY6NNBopWnen7/jbjfMzZqfEgJCtG8AswookB322KKTkibj/eB95TB/wMhQ737bDJSmh4BtZYvSXb1Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2BZB6aNZVh+KFCFc/xnJ4uKVh1SIenSz3xnFegr2ipE=;
 b=M20AfUBSlTDRKoAg0hVVgUq2WspSBWNxeQyAoNN37jvxzR3GyafAgzJgaR74a/g9f7nvtK8nQzCJmlaZVVf43ijYc1WOAgUIgbWk3LkX3vO6/bE8iLiymAzHRV0GV+yCbeIYw+XeGs1ZnY4BPsl0iEoDgTalhS0PgZsXBS+q3Wg=
Received: from DM6PR05CA0043.namprd05.prod.outlook.com (2603:10b6:5:335::12)
 by DS0PR12MB9037.namprd12.prod.outlook.com (2603:10b6:8:f1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 8 Jun
 2023 10:27:38 +0000
Received: from DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::b7) by DM6PR05CA0043.outlook.office365.com
 (2603:10b6:5:335::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Thu, 8 Jun 2023 10:27:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT064.mail.protection.outlook.com (10.13.172.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.24 via Frontend Transport; Thu, 8 Jun 2023 10:27:38 +0000
Received: from master-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 8 Jun
 2023 05:27:35 -0500
From: shikaguo <shikai.guo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3] drm/amd/pm: enable more Pstates profile levels for
 yellow_carp
Date: Thu, 8 Jun 2023 18:27:00 +0800
Message-ID: <20230608102700.1879369-1-shikai.guo@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT064:EE_|DS0PR12MB9037:EE_
X-MS-Office365-Filtering-Correlation-Id: f8b4cfdb-b2a0-420c-5526-08db680afba8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0sFglxfHtL5epkzyjBDAkAf4RQlN/4ethbiIvlgTzP8Y05jvow1e7l6M5R0ipeb4FHIihsKFduVnb4dtG03wmR9TY9rNxi805SmRmUcimDYzHTc8g4ytDj4IDIC5zcwmbzKWBM39SdrQfO/4SQamSYXK+U0zWr4AuhgcwohwSRo7fchSXc80o6j7gixvvZNypbcNT5sjkjX7VLXy3nU4AZ41VHOOW7xJzR8eJpCXmSZ/hS7m8IdFmxRRPHCLo39i5LR6/SmWWffA5fax++Pv8wifuu/1CPO/NpE1Jpd7SNL/DTNu2DMvApx5fd8abjazVj9PPKlxGkHccNtoACDPVVIbDBWaaCijJK5SOIAyYvUtI2k6edKP/ATeKAshdIV2rrxCofpG86skeX6SAYxGxLVj56CdaphvxA5sqS9rp20vJv8uaaThfcWPUVs3OCvvnbsggnSqgP1rkXa7bSFVWeca3fyO+AoUzkPpNE7C328AUxAej6J+/sbAiN1pQdxIXfxvhwzu7kf146k2FlnQ97EaLRj6htbvzkW87+71wbtC3XRi4sA2GJxiH0lPTjIUYyIb/qVyrGW0sQ4UMMuobKbuCw7xkyU/IBmx/QnJLEc2Lv8n6Xh8hSOngjTV2WkFD8toMLHiT2lpl+0fEHOnyeaCS0z+ZkGh2FIRTc2MUxD8UkUHnc4HngsOdsxtby39vxLPA1SUvzCHnkGoKFhmuRR/iNaQ1vCfqwmMozDQixWgwwmwz9gRg1PMbfgWtW89tMN/PTi6joiNtEaLC1dZZ1sA+75quQ3H28ehzUINzxVUmMqVXXN8EIzuqWsmigfNbmgn53G6Dv3y6Cx9NNyGGg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(2616005)(1076003)(41300700001)(336012)(7696005)(426003)(6666004)(36860700001)(47076005)(16526019)(26005)(186003)(83380400001)(40460700003)(40480700001)(478600001)(54906003)(81166007)(356005)(4326008)(82740400003)(316002)(82310400005)(70206006)(70586007)(8676002)(6916009)(8936002)(2906002)(5660300002)(86362001)(36756003)(43062005)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 10:27:38.3506 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8b4cfdb-b2a0-420c-5526-08db680afba8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9037
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
Cc: Alexander.Deucher@amd.com, tim.huang@amd.com, prike.liang@amd.com,
 aaron.liu@amd.com, shikaguo <shikai.guo@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch enables following UMD stable Pstates profile levels for power_dpm_force_performance_level interface.

- profile_peak
- profile_min_mclk
- profile_min_sclk
- profile_standard

Signed-off-by: shikaguo <shikai.guo@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  | 140 +++++++++++++++++-
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.h  |   1 -
 2 files changed, 136 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index a92da336ecec..71566c60372f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -47,6 +47,14 @@
 #define SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS_MASK		0x00000006L
 #define SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS__SHIFT          0x1L
 
+#define SMU_13_0_8_UMD_PSTATE_GFXCLK                   533
+#define SMU_13_0_8_UMD_PSTATE_SOCCLK                   533
+#define SMU_13_0_8_UMD_PSTATE_FCLK                     800
+
+#define SMU_13_0_1_UMD_PSTATE_GFXCLK       			  700
+#define SMU_13_0_1_UMD_PSTATE_SOCCLK		              678
+#define SMU_13_0_1_UMD_PSTATE_FCLK			          1800
+
 #define FEATURE_MASK(feature) (1ULL << feature)
 #define SMC_DPM_FEATURE ( \
 	FEATURE_MASK(FEATURE_CCLK_DPM_BIT) | \
@@ -957,6 +965,9 @@ static int yellow_carp_set_soft_freq_limited_range(struct smu_context *smu,
 							uint32_t max)
 {
 	enum smu_message_type msg_set_min, msg_set_max;
+	uint32_t min_clk = min;
+	uint32_t max_clk = max;
+
 	int ret = 0;
 
 	if (!yellow_carp_clk_dpm_is_enabled(smu, clk_type))
@@ -985,11 +996,17 @@ static int yellow_carp_set_soft_freq_limited_range(struct smu_context *smu,
 		return -EINVAL;
 	}
 
-	ret = smu_cmn_send_smc_msg_with_param(smu, msg_set_min, min, NULL);
+	if (clk_type == SMU_VCLK) {
+		min_clk = min << SMU_13_VCLK_SHIFT;
+		max_clk = max << SMU_13_VCLK_SHIFT;
+	}
+
+	ret = smu_cmn_send_smc_msg_with_param(smu, msg_set_min, min_clk, NULL);
+
 	if (ret)
 		goto out;
 
-	ret = smu_cmn_send_smc_msg_with_param(smu, msg_set_max, max, NULL);
+	ret = smu_cmn_send_smc_msg_with_param(smu, msg_set_max, max_clk, NULL);
 	if (ret)
 		goto out;
 
@@ -997,12 +1014,48 @@ static int yellow_carp_set_soft_freq_limited_range(struct smu_context *smu,
 	return ret;
 }
 
+static int yellow_carp_get_umd_pstate_clk_default(struct smu_context *smu,
+					enum smu_clk_type clk_type)
+{
+	uint32_t clk_limit = 0;
+	struct amdgpu_device *adev = smu->adev;
+	switch (clk_type) {
+	case SMU_GFXCLK:
+	case SMU_SCLK:
+		if ((adev->ip_versions[MP1_HWIP][0]) == IP_VERSION(13, 0, 8))
+			clk_limit = SMU_13_0_8_UMD_PSTATE_GFXCLK;
+		if ((adev->ip_versions[MP1_HWIP][0]) == IP_VERSION(13, 0, 1) ||
+			(adev->ip_versions[MP1_HWIP][0]) == IP_VERSION(13, 0, 3))
+			clk_limit = SMU_13_0_1_UMD_PSTATE_GFXCLK;
+		break;
+	case SMU_SOCCLK:
+		if ((adev->ip_versions[MP1_HWIP][0]) == IP_VERSION(13, 0, 8))
+			clk_limit = SMU_13_0_8_UMD_PSTATE_SOCCLK;
+		if ((adev->ip_versions[MP1_HWIP][0]) == IP_VERSION(13, 0, 1) ||
+			(adev->ip_versions[MP1_HWIP][0]) == IP_VERSION(13, 0, 3))
+			clk_limit = SMU_13_0_1_UMD_PSTATE_SOCCLK;
+		break;
+	case SMU_FCLK:
+		if ((adev->ip_versions[MP1_HWIP][0]) == IP_VERSION(13, 0, 8))
+			clk_limit = SMU_13_0_8_UMD_PSTATE_FCLK;
+		if ((adev->ip_versions[MP1_HWIP][0]) == IP_VERSION(13, 0, 1) ||
+			(adev->ip_versions[MP1_HWIP][0]) == IP_VERSION(13, 0, 3))
+			clk_limit = SMU_13_0_1_UMD_PSTATE_FCLK;
+		break;
+	default:
+		break;
+	}
+
+	return clk_limit;
+}
+
 static int yellow_carp_print_clk_levels(struct smu_context *smu,
 				enum smu_clk_type clk_type, char *buf)
 {
 	int i, idx, size = 0, ret = 0;
 	uint32_t cur_value = 0, value = 0, count = 0;
 	uint32_t min, max;
+	uint32_t clk_limit = 0;
 
 	smu_cmn_get_sysfs_buf(&buf, &size);
 
@@ -1044,6 +1097,7 @@ static int yellow_carp_print_clk_levels(struct smu_context *smu,
 		break;
 	case SMU_GFXCLK:
 	case SMU_SCLK:
+		clk_limit = yellow_carp_get_umd_pstate_clk_default(smu, clk_type);
 		ret = yellow_carp_get_current_clk_freq(smu, clk_type, &cur_value);
 		if (ret)
 			goto print_clk_out;
@@ -1058,7 +1112,7 @@ static int yellow_carp_print_clk_levels(struct smu_context *smu,
 		size += sysfs_emit_at(buf, size, "0: %uMhz %s\n", min,
 				i == 0 ? "*" : "");
 		size += sysfs_emit_at(buf, size, "1: %uMhz %s\n",
-				i == 1 ? cur_value : YELLOW_CARP_UMD_PSTATE_GFXCLK,
+				i == 1 ? cur_value : clk_limit,
 				i == 1 ? "*" : "");
 		size += sysfs_emit_at(buf, size, "2: %uMhz %s\n", max,
 				i == 2 ? "*" : "");
@@ -1107,6 +1161,49 @@ static int yellow_carp_force_clk_levels(struct smu_context *smu,
 	return ret;
 }
 
+static int yellow_carp_get_dpm_profile_freq(struct smu_context *smu,
+					enum amd_dpm_forced_level level,
+					enum smu_clk_type clk_type,
+					uint32_t *min_clk,
+					uint32_t *max_clk)
+{
+	int ret = 0;
+	uint32_t clk_limit = 0;
+
+	clk_limit = yellow_carp_get_umd_pstate_clk_default(smu, clk_type);
+
+	switch (clk_type) {
+	case SMU_GFXCLK:
+	case SMU_SCLK:
+		if (level == AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
+			yellow_carp_get_dpm_ultimate_freq(smu, SMU_SCLK, NULL, &clk_limit);
+		else if (level == AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK)
+			yellow_carp_get_dpm_ultimate_freq(smu, SMU_SCLK, &clk_limit, NULL);
+		break;
+	case SMU_SOCCLK:
+		if (level == AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
+			yellow_carp_get_dpm_ultimate_freq(smu, SMU_SOCCLK, NULL, &clk_limit);
+		break;
+	case SMU_FCLK:
+		if (level == AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
+			yellow_carp_get_dpm_ultimate_freq(smu, SMU_FCLK, NULL, &clk_limit);
+		else if (level == AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK)
+			yellow_carp_get_dpm_ultimate_freq(smu, SMU_FCLK, &clk_limit, NULL);
+		break;
+	case SMU_VCLK:
+		yellow_carp_get_dpm_ultimate_freq(smu, SMU_VCLK, NULL, &clk_limit);
+		break;
+	case SMU_DCLK:
+		yellow_carp_get_dpm_ultimate_freq(smu, SMU_DCLK, NULL, &clk_limit);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	*min_clk = *max_clk = clk_limit;
+	return ret;
+}
+
 static int yellow_carp_set_performance_level(struct smu_context *smu,
 						enum amd_dpm_forced_level level)
 {
@@ -1114,6 +1211,9 @@ static int yellow_carp_set_performance_level(struct smu_context *smu,
 	uint32_t sclk_min = 0, sclk_max = 0;
 	uint32_t fclk_min = 0, fclk_max = 0;
 	uint32_t socclk_min = 0, socclk_max = 0;
+	uint32_t vclk_min = 0, vclk_max = 0;
+	uint32_t dclk_min = 0, dclk_max = 0;
+
 	int ret = 0;
 
 	switch (level) {
@@ -1121,28 +1221,42 @@ static int yellow_carp_set_performance_level(struct smu_context *smu,
 		yellow_carp_get_dpm_ultimate_freq(smu, SMU_SCLK, NULL, &sclk_max);
 		yellow_carp_get_dpm_ultimate_freq(smu, SMU_FCLK, NULL, &fclk_max);
 		yellow_carp_get_dpm_ultimate_freq(smu, SMU_SOCCLK, NULL, &socclk_max);
+		yellow_carp_get_dpm_ultimate_freq(smu, SMU_VCLK, NULL, &vclk_max);
+		yellow_carp_get_dpm_ultimate_freq(smu, SMU_DCLK, NULL, &dclk_max);
 		sclk_min = sclk_max;
 		fclk_min = fclk_max;
 		socclk_min = socclk_max;
+		vclk_min = vclk_max;
+		dclk_min = dclk_max;
 		break;
 	case AMD_DPM_FORCED_LEVEL_LOW:
 		yellow_carp_get_dpm_ultimate_freq(smu, SMU_SCLK, &sclk_min, NULL);
 		yellow_carp_get_dpm_ultimate_freq(smu, SMU_FCLK, &fclk_min, NULL);
 		yellow_carp_get_dpm_ultimate_freq(smu, SMU_SOCCLK, &socclk_min, NULL);
+		yellow_carp_get_dpm_ultimate_freq(smu, SMU_VCLK, &vclk_min, NULL);
+		yellow_carp_get_dpm_ultimate_freq(smu, SMU_DCLK, &dclk_min, NULL);
 		sclk_max = sclk_min;
 		fclk_max = fclk_min;
 		socclk_max = socclk_min;
+		vclk_max = vclk_min;
+		dclk_max = dclk_min;
 		break;
 	case AMD_DPM_FORCED_LEVEL_AUTO:
 		yellow_carp_get_dpm_ultimate_freq(smu, SMU_SCLK, &sclk_min, &sclk_max);
 		yellow_carp_get_dpm_ultimate_freq(smu, SMU_FCLK, &fclk_min, &fclk_max);
 		yellow_carp_get_dpm_ultimate_freq(smu, SMU_SOCCLK, &socclk_min, &socclk_max);
+		yellow_carp_get_dpm_ultimate_freq(smu, SMU_VCLK, &vclk_min, &vclk_max);
+		yellow_carp_get_dpm_ultimate_freq(smu, SMU_DCLK, &dclk_min, &dclk_max);
 		break;
 	case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
 	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
 	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
 	case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
-		/* Temporarily do nothing since the optimal clocks haven't been provided yet */
+		yellow_carp_get_dpm_profile_freq(smu, level, SMU_SCLK, &sclk_min, &sclk_max);
+		yellow_carp_get_dpm_profile_freq(smu, level, SMU_FCLK, &fclk_min, &fclk_max);
+		yellow_carp_get_dpm_profile_freq(smu, level, SMU_SOCCLK, &socclk_min, &socclk_max);
+		yellow_carp_get_dpm_profile_freq(smu, level, SMU_VCLK, &vclk_min, &vclk_max);
+		yellow_carp_get_dpm_profile_freq(smu, level, SMU_DCLK, &dclk_min, &dclk_max);
 		break;
 	case AMD_DPM_FORCED_LEVEL_MANUAL:
 	case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
@@ -1182,6 +1296,24 @@ static int yellow_carp_set_performance_level(struct smu_context *smu,
 			return ret;
 	}
 
+	if (vclk_min && vclk_max) {
+		ret = yellow_carp_set_soft_freq_limited_range(smu,
+							      SMU_VCLK,
+							      vclk_min,
+							      vclk_max);
+		if (ret)
+			return ret;
+	}
+
+	if (dclk_min && dclk_max) {
+		ret = yellow_carp_set_soft_freq_limited_range(smu,
+							      SMU_DCLK,
+							      dclk_min,
+							      dclk_max);
+		if (ret)
+			return ret;
+	}
+
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.h
index a9205a8ea3ad..b3ad8352c68a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.h
@@ -24,6 +24,5 @@
 #define __YELLOW_CARP_PPT_H__
 
 extern void yellow_carp_set_ppt_funcs(struct smu_context *smu);
-#define YELLOW_CARP_UMD_PSTATE_GFXCLK       1100
 
 #endif
-- 
2.25.1

