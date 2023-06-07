Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3D46C77B7A
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 11:09:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8966310E0DB;
	Wed,  7 Jun 2023 11:09:04 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E579F10E010
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 11:09:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QcnLZ31P4bxwHVzLrHbv7IG6JxkT/HvPdRdl6DwvaeZiUXGi/4hDhbijMIXC4smtyRNNlqhq8H29anjfJKtlgkT6szr8dxpqGG8BdTWTORU6+YH2w8ZvX8JcurU9jR852Ec+M82e4vYSs/AmRHs5o/bEMEE6k8cq87HqUBaDqTMFDvd4EBXt11uaUvfLPCViGpHQvtjmMQNdekSK2QCaVGJlFUSZPm3ObRIb9JS4JxMpIuV8WBtuWrZBrscKq4t3Of4qRf0yX7pLu6pj8Vla8++z4ZMLZaE/9IDH6cHwCNZF2/FukUKT1WV72CyokXV9jTqKtWe8y5GgKRkraCNEAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yx2ymw1gN/rHECBHWOXnYWa9+zdiEWvulbBU0mMkdBw=;
 b=KodUlHG+trsgiLw9LiK7CebrvI9sF/Zx7OW4oUJhzVPGwX41YZlvvCTSV3rTVCXcNkJ6zVnNC6kWhfri6jJwe/az9ET5yIq3BI52CrE0s4ahelyQUHwQCAnfl4rswCDEoMybsVBr2TYQRWzLHJM4yOGx6/S1t4aKQz6dnH4fdd1III54WOhORTLKsySYh0NSjxB6x5JlxeQpY0gIvEYEKFEC7KG2DYXti1cHLUsNnubVKJ4atzexztWbIJTFfJZaSb3TVMpwBPcN8E6RgQnIN+7CF8uXdbiwa1c3FrmMlCyzlqlnkSjOHhkfyFgh5cuHpB+mmEiaomc/iYs7iZDW+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yx2ymw1gN/rHECBHWOXnYWa9+zdiEWvulbBU0mMkdBw=;
 b=2jK9GRKsDk7y9bskGbt4SVFj2Iehe/frigQ5h7YU2KYhewCoCal+RdAxbiGHG/Ft+jJyzL0Ucm8tWEah/zLJzugpNun/Xfu+f1GdzUsGtN+oCrxGXdBmmSQpJXwqU/PSVJg5AwbGBY3H50jjWBjbapeVbXzQK0bXTvurLvRQpTI=
Received: from MW4PR04CA0288.namprd04.prod.outlook.com (2603:10b6:303:89::23)
 by PH7PR12MB6860.namprd12.prod.outlook.com (2603:10b6:510:1b6::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.28; Wed, 7 Jun
 2023 11:08:58 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:303:89:cafe::ee) by MW4PR04CA0288.outlook.office365.com
 (2603:10b6:303:89::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Wed, 7 Jun 2023 11:08:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Wed, 7 Jun 2023 11:08:58 +0000
Received: from master-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 06:08:55 -0500
From: shikaguo <shikai.guo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: enable more Pstates profile levels for yellow_carp
Date: Wed, 7 Jun 2023 19:07:47 +0800
Message-ID: <20230607110747.1769721-1-shikai.guo@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|PH7PR12MB6860:EE_
X-MS-Office365-Filtering-Correlation-Id: 4058153b-1bd4-445f-b495-08db67479789
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hhGF0PlPibMGbZ3ioQrXMPq5S+erQCdCT98+UQ4lz3LcAgDiOKHbs9Hs9ty1FEJNXZt9p6KXucBiRwH4VfhXH6SBS7UINfcwBCSu3EIoMixEgtbnEpE3KpLFADwIDEwB0jwD63BiNrOsKg76LFlbaNyQ+uPZsJCsFP1juTQ2waOMVt5EIuhlv1irGLAAYjoYqjrujd1addAlmy/EhknMWQeUiUjNqjKXms3GBfuF1e76Frokv5YiM53ADSUHQ/lrbWPs2+sHNVL9WhkeRNTtkkMmAb8NwG8LN0ivQNH6Vz4NGwB9J5LDT/zmjxOV6zVrm3t9jsyJFkm+babLFvDnQNzuPU1QtBFBHHhKrTRkS+x7NCUIbaljPxuC1lGFUGEsfmAJYUUJvkba90N9FzTdo/KrpHwfSx6ypY5xd08ENl+zNnI5eqriyelrwVYAByCXUA8dgWy6JR5TaOhPMBo0NAIwi5u424oTIv0YnQ5OMBwsK+u5ErH9+hOqVdP44e2OMVK/h6vBgqrW+O77D5zKHY2ixSKPJCaykzG9u1I/q5or83DFBeZW4dJmD0qCFu8AJ9L1dWMHYnLD4pN43Nu+uwzv5nmV65SMuoYXwWJQQvlK5yflWbwvtUK5kUBWhWdecu5wCWA8jqBBP67Zwb5Zluj33ZelbMsM/BjuG0b7sPA9YB1rR3fJ7kbUEYcXSeRfDWz0GQkyHFgxa3jrl5q2+m0ptJ3RMnvfLRhN10a4SstfSsNILmhDW2mFxRkG/aLosBHEuCoI4LsxG/PBlNSgyn+uSOPJXBNuUE0g7bP7R+Dir0Kb9ZFV0Yw5u6FEI/QuQGZJFX0pKFITSyLulHqALg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(396003)(346002)(136003)(451199021)(36840700001)(40470700004)(46966006)(86362001)(336012)(47076005)(36756003)(41300700001)(356005)(82740400003)(83380400001)(36860700001)(426003)(81166007)(316002)(70586007)(186003)(26005)(1076003)(70206006)(16526019)(2616005)(4326008)(6916009)(82310400005)(478600001)(6666004)(54906003)(40460700003)(2906002)(7696005)(40480700001)(5660300002)(8676002)(8936002)(43062005)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 11:08:58.4374 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4058153b-1bd4-445f-b495-08db67479789
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6860
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
Cc: tim.huang@amd.com, prike.liang@amd.com, aaron.liu@amd.com,
 shikaguo <shikai.guo@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch enables following UMD stable Pstates profile levels for power_dpm_force_performance_level interface.

- profile_peak
- profile_min_mclk
- profile_min_sclk
- profile_standard

Signed-off-by: shikaguo <shikai.guo@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  | 94 ++++++++++++++++++-
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.h  |  8 +-
 2 files changed, 98 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index a92da336ecec..5c968ab2ea8d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -957,6 +957,9 @@ static int yellow_carp_set_soft_freq_limited_range(struct smu_context *smu,
 							uint32_t max)
 {
 	enum smu_message_type msg_set_min, msg_set_max;
+	uint32_t min_clk = min;
+	uint32_t max_clk = max;
+
 	int ret = 0;
 
 	if (!yellow_carp_clk_dpm_is_enabled(smu, clk_type))
@@ -985,11 +988,17 @@ static int yellow_carp_set_soft_freq_limited_range(struct smu_context *smu,
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
 
@@ -1107,6 +1116,50 @@ static int yellow_carp_force_clk_levels(struct smu_context *smu,
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
+	switch (clk_type) {
+	case SMU_GFXCLK:
+	case SMU_SCLK:
+		clk_limit = YELLOW_CARP_UMD_PSTATE_GFXCLK;
+		if (level == AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
+			yellow_carp_get_dpm_ultimate_freq(smu, SMU_SCLK, NULL, &clk_limit);
+		else if (level == AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK)
+			yellow_carp_get_dpm_ultimate_freq(smu, SMU_SCLK, &clk_limit, NULL);
+		break;
+	case SMU_SOCCLK:
+		clk_limit = YELLOW_CARP_UMD_PSTATE_SOCCLK;
+		if (level == AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
+			yellow_carp_get_dpm_ultimate_freq(smu, SMU_SOCCLK, NULL, &clk_limit);
+		break;
+	case SMU_FCLK:
+		clk_limit = YELLOW_CARP_UMD_PSTATE_FCLK;
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
@@ -1114,6 +1167,9 @@ static int yellow_carp_set_performance_level(struct smu_context *smu,
 	uint32_t sclk_min = 0, sclk_max = 0;
 	uint32_t fclk_min = 0, fclk_max = 0;
 	uint32_t socclk_min = 0, socclk_max = 0;
+	uint32_t vclk_min = 0, vclk_max = 0;
+	uint32_t dclk_min = 0, dclk_max = 0;
+
 	int ret = 0;
 
 	switch (level) {
@@ -1121,28 +1177,42 @@ static int yellow_carp_set_performance_level(struct smu_context *smu,
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
@@ -1182,6 +1252,24 @@ static int yellow_carp_set_performance_level(struct smu_context *smu,
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
index a9205a8ea3ad..59257bbd66e0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.h
@@ -24,6 +24,12 @@
 #define __YELLOW_CARP_PPT_H__
 
 extern void yellow_carp_set_ppt_funcs(struct smu_context *smu);
-#define YELLOW_CARP_UMD_PSTATE_GFXCLK       1100
+
+#define SMU_13_VCLK_SHIFT		16
+
+//UMD PState Rembrandt Msg Parameters in MHz
+#define YELLOW_CARP_UMD_PSTATE_GFXCLK       700
+#define YELLOW_CARP_UMD_PSTATE_SOCCLK		678
+#define YELLOW_CARP_UMD_PSTATE_FCLK			800
 
 #endif
-- 
2.25.1

