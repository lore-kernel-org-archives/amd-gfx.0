Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E419DC4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:37:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76EBA10F4D6;
	Tue,  3 May 2022 20:37:52 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DAF610F4BF
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:37:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RwVHmDyTK/OQjo9NvaRE7xUGZnenAgErGDdVBoD61vpnSyZkQEUA7s4/tzCEjsj2obItfnOuSlCbO/uoNDnp5fLU6nf2WtLdFwlDbq2eSXceFvbiZ7VO/61uybFi9GiuBn9wNxNMvXnEM7BB2kLLmKU9plu/JGbzbq72ggJc2FDi2Szio5otN0SEFOteEi56CfcNpoQ7Yft8YQsiNS0/RHWoyPOKIHEhfrirckVH6/vfCWMDuS5tKeC4y1EwCNOX1EaLhOF4UzMIDsHXzjwXp631QotBMmoNBV4wq+qGOseMxZSw4tVj4aHYksMrAjB9+2KZD9fpfZfXo9nkt10TAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M+DYBtdrKNNDw3t7fTOc9wuwrRm78d78ioy968q8TmI=;
 b=eBkTIXAHcvD1nY7ZCS3tYYQ9gld+HjpsdfFD3PRMcoLHaYq71hwkbuBCxgmepaJap3D8wdtBMVKGGfS3ylq1cyHlCbmNUMKFv/QwzzjY6o8MTq7W4sMNKb3FiSTahuYrhI9bkOzoW3j8VokeysVFGL+owiXF7mSE8IJ4dbQ4D1AcM2WG0h7gkUZomrrsW7nK221tLVV69y5z/k7hSaBDLs3ky0nPv0cs3XGvfVwvi5MwqZACBqCk1sb7u9GpX5KpMdj0GHjo01rPQ6mTGbbHosdxAYfTXPgpRABXPHIkbfpijJ9ljlKiplj2a3To60bhrUJeMU1T1eH9WJth8WLHoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+DYBtdrKNNDw3t7fTOc9wuwrRm78d78ioy968q8TmI=;
 b=4bZFSHFq16zWoDAPKicFecbIr8/70nOD7jlmAdPRPvKNgLv1EswATiW0SwMr2IRVuizH/IB1L7xgnQ/15pTEsmURWlbfZkUM+N5tcC7yeVb21BVoqGzI2P5B++OrooDdHU6tZzDg6icrXTuIY0/phlCmziSq3xwkUMISsQZgUAI=
Received: from MW4PR04CA0139.namprd04.prod.outlook.com (2603:10b6:303:84::24)
 by BYAPR12MB2854.namprd12.prod.outlook.com (2603:10b6:a03:135::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Tue, 3 May
 2022 20:37:43 +0000
Received: from CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::de) by MW4PR04CA0139.outlook.office365.com
 (2603:10b6:303:84::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Tue, 3 May 2022 20:37:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT067.mail.protection.outlook.com (10.13.174.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Tue, 3 May 2022 20:37:43 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:37:40 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 23/26] drm/amd/pm: enable workload type change on smu_v13_0_7
Date: Tue, 3 May 2022 16:37:13 -0400
Message-ID: <20220503203716.1230313-23-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503203716.1230313-1-alexander.deucher@amd.com>
References: <20220503203716.1230313-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ebc9d018-622a-4d49-667f-08da2d44c683
X-MS-TrafficTypeDiagnostic: BYAPR12MB2854:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB28543B981B72C37C1789D861F7C09@BYAPR12MB2854.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q5+3KJsoPpWXeMbBNKYiqcGwlAewq6DSbhOJlq5tkdQcgHQRPGIIwvIHhzelVkHbvngojo+N5aNHeEJQ7LoJy8kC7mnEbgQYNxzxn1HTG6UKG/3yGccBvaipLir5WWFkR8Z1wqLFPGdlc3Uz4ohD01wj6GDnpaJKhZSHznwaThKkaaYasz7HXlu6wBhYxA16uKykrm4zLlE2ofJJYIDNflt22dks1IDp7Ipm8aw0QzJ9yroB/pT7224H21Szsk6jrQdKzYDC6XMxgrPwVO7Demn4TRSFEr/phyHwJq4g+OPZZwgKyJQZFYiCWL2CaUzAYwMp7aGELPpFWd62re4GmiYYHv3HdZnlsoeC+2Hi6dNC2UwRBRVRDmtd4377WpO2cDCmOEQxOzitNZalR49sndp1ezloExAob6/gKW8FNu7FeqFqXuKeKpVto48bgFw3MPdqHlxt6UZbnBNNMiKPHfvsJoMAv/dTRIpMYvFWlxPBH35lV2gCt98oyJwSdbPP6zBQ14Xq9YOMnZCanDCjpL8pSJQ8+/gEIwpHDc8UQVk25MKIiBmMrMWOo4IjVv2K/MQ5jVJOUAa7e98tNQrCKSrYYY7ZAEaHjSrdgd9ET2Df/7LL4x2gkuROBtNAdU0eoYDUPEuSoR71nYz12CsErG1E9gamlEUZ5VczYJYyxxIStZLMexzAtaKgqFcpha6qAEGiJulemq6FJ2o6h+OPFw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(36756003)(2616005)(16526019)(1076003)(40460700003)(186003)(426003)(47076005)(2906002)(83380400001)(336012)(26005)(8936002)(5660300002)(7696005)(81166007)(356005)(6666004)(70206006)(36860700001)(508600001)(4326008)(70586007)(86362001)(8676002)(316002)(54906003)(6916009)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:37:43.5997 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebc9d018-622a-4d49-667f-08da2d44c683
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2854
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Kenneth Feng <kenneth.feng@amd.com>, Yang Wang <kevinyang.wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Kenneth Feng <kenneth.feng@amd.com>

enable workload type change on smu_v13_0_7

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    |   1 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |   3 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 133 +++++++++++++++++-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |   2 +-
 4 files changed, 136 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index a4c267f15959..7e3231c2191c 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -157,6 +157,7 @@ enum PP_SMC_POWER_PROFILE {
 	PP_SMC_POWER_PROFILE_VR           = 0x4,
 	PP_SMC_POWER_PROFILE_COMPUTE      = 0x5,
 	PP_SMC_POWER_PROFILE_CUSTOM       = 0x6,
+	PP_SMC_POWER_PROFILE_WINDOW3D     = 0x7,
 	PP_SMC_POWER_PROFILE_COUNT,
 };
 
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index d2978396d6b7..70a0aad05426 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -89,7 +89,8 @@ const char * const amdgpu_pp_profile_name[] = {
 	"VIDEO",
 	"VR",
 	"COMPUTE",
-	"CUSTOM"
+	"CUSTOM",
+	"WINDOW_3D",
 };
 
 /**
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index d7e42cbe9fb7..4ed5b557ecc9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -161,8 +161,9 @@ static struct cmn2asic_mapping smu_v13_0_7_workload_map[PP_SMC_POWER_PROFILE_COU
 	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_POWERSAVING,		WORKLOAD_PPLIB_POWER_SAVING_BIT),
 	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VIDEO,		WORKLOAD_PPLIB_VIDEO_BIT),
 	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VR,			WORKLOAD_PPLIB_VR_BIT),
-	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_COMPUTE,		WORKLOAD_PPLIB_CUSTOM_BIT),
+	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_COMPUTE,		WORKLOAD_PPLIB_COMPUTE_BIT),
 	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_CUSTOM,		WORKLOAD_PPLIB_CUSTOM_BIT),
+	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_WINDOW3D,		WORKLOAD_PPLIB_WINDOW_3D_BIT),
 };
 
 static const uint8_t smu_v13_0_7_throttler_map[] = {
@@ -1322,6 +1323,134 @@ static int smu_v13_0_7_enable_mgpu_fan_boost(struct smu_context *smu)
 					       NULL);
 }
 
+static int smu_v13_0_7_get_power_profile_mode(struct smu_context *smu, char *buf)
+{
+	DpmActivityMonitorCoeffIntExternal_t activity_monitor_external[PP_SMC_POWER_PROFILE_COUNT];
+	uint32_t i, j, size = 0;
+	int16_t workload_type = 0;
+	int result = 0;
+
+	if (!buf)
+		return -EINVAL;
+
+	size += sysfs_emit_at(buf, size, "                              ");
+	for (i = 0; i <= PP_SMC_POWER_PROFILE_WINDOW3D; i++)
+		size += sysfs_emit_at(buf, size, "%-14s%s", amdgpu_pp_profile_name[i],
+			(i == smu->power_profile_mode) ? "* " : "  ");
+
+	size += sysfs_emit_at(buf, size, "\n");
+
+	for (i = 0; i <= PP_SMC_POWER_PROFILE_WINDOW3D; i++) {
+		/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
+		workload_type = smu_cmn_to_asic_specific_index(smu,
+							       CMN2ASIC_MAPPING_WORKLOAD,
+							       i);
+		if (workload_type < 0)
+			return -EINVAL;
+
+		result = smu_cmn_update_table(smu,
+					  SMU_TABLE_ACTIVITY_MONITOR_COEFF, workload_type,
+					  (void *)(&activity_monitor_external[i]), false);
+		if (result) {
+			dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
+			return result;
+		}
+	}
+
+#define PRINT_DPM_MONITOR(field)									\
+do {													\
+	size += sysfs_emit_at(buf, size, "%-30s", #field);						\
+	for (j = 0; j <= PP_SMC_POWER_PROFILE_WINDOW3D; j++)						\
+		size += sysfs_emit_at(buf, size, "%-16d", activity_monitor_external[i].DpmActivityMonitorCoeffInt.field);		\
+	size += sysfs_emit_at(buf, size, "\n");								\
+} while (0)
+
+	PRINT_DPM_MONITOR(Gfx_ActiveHystLimit);
+	PRINT_DPM_MONITOR(Gfx_IdleHystLimit);
+	PRINT_DPM_MONITOR(Gfx_FPS);
+	PRINT_DPM_MONITOR(Gfx_MinActiveFreqType);
+	PRINT_DPM_MONITOR(Gfx_BoosterFreqType);
+	PRINT_DPM_MONITOR(Gfx_MinActiveFreq);
+	PRINT_DPM_MONITOR(Gfx_BoosterFreq);
+	PRINT_DPM_MONITOR(Fclk_ActiveHystLimit);
+	PRINT_DPM_MONITOR(Fclk_IdleHystLimit);
+	PRINT_DPM_MONITOR(Fclk_FPS);
+	PRINT_DPM_MONITOR(Fclk_MinActiveFreqType);
+	PRINT_DPM_MONITOR(Fclk_BoosterFreqType);
+	PRINT_DPM_MONITOR(Fclk_MinActiveFreq);
+	PRINT_DPM_MONITOR(Fclk_BoosterFreq);
+#undef PRINT_DPM_MONITOR
+
+	return size;
+}
+
+static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu, long *input, uint32_t size)
+{
+
+	DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
+	DpmActivityMonitorCoeffInt_t *activity_monitor =
+		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
+	int workload_type, ret = 0;
+
+	smu->power_profile_mode = input[size];
+
+	if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_WINDOW3D) {
+		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
+		return -EINVAL;
+	}
+
+	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
+
+		ret = smu_cmn_update_table(smu,
+				       SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
+				       (void *)(&activity_monitor_external), false);
+		if (ret) {
+			dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
+			return ret;
+		}
+
+		switch (input[0]) {
+		case 0: /* Gfxclk */
+			activity_monitor->Gfx_ActiveHystLimit = input[1];
+			activity_monitor->Gfx_IdleHystLimit = input[2];
+			activity_monitor->Gfx_FPS = input[3];
+			activity_monitor->Gfx_MinActiveFreqType = input[4];
+			activity_monitor->Gfx_BoosterFreqType = input[5];
+			activity_monitor->Gfx_MinActiveFreq = input[6];
+			activity_monitor->Gfx_BoosterFreq = input[7];
+			break;
+		case 1: /* Fclk */
+			activity_monitor->Fclk_ActiveHystLimit = input[1];
+			activity_monitor->Fclk_IdleHystLimit = input[2];
+			activity_monitor->Fclk_FPS = input[3];
+			activity_monitor->Fclk_MinActiveFreqType = input[4];
+			activity_monitor->Fclk_BoosterFreqType = input[5];
+			activity_monitor->Fclk_MinActiveFreq = input[6];
+			activity_monitor->Fclk_BoosterFreq = input[7];
+			break;
+		}
+
+		ret = smu_cmn_update_table(smu,
+				       SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
+				       (void *)(&activity_monitor_external), true);
+		if (ret) {
+			dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
+			return ret;
+		}
+	}
+
+	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
+	workload_type = smu_cmn_to_asic_specific_index(smu,
+						       CMN2ASIC_MAPPING_WORKLOAD,
+						       smu->power_profile_mode);
+	if (workload_type < 0)
+		return -EINVAL;
+	smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
+				    1 << workload_type, NULL);
+
+	return ret;
+}
+
 static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.get_allowed_feature_mask = smu_v13_0_7_get_allowed_feature_mask,
 	.set_default_dpm_table = smu_v13_0_7_set_default_dpm_table,
@@ -1365,6 +1494,8 @@ static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.get_fan_control_mode = smu_v13_0_get_fan_control_mode,
 	.set_fan_control_mode = smu_v13_0_set_fan_control_mode,
 	.enable_mgpu_fan_boost = smu_v13_0_7_enable_mgpu_fan_boost,
+	.get_power_profile_mode = smu_v13_0_7_get_power_profile_mode,
+	.set_power_profile_mode = smu_v13_0_7_set_power_profile_mode,
 };
 
 void smu_v13_0_7_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 1274c794a776..5de7da75d14a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -497,7 +497,7 @@ int smu_cmn_to_asic_specific_index(struct smu_context *smu,
 		return mapping.map_to;
 
 	case CMN2ASIC_MAPPING_WORKLOAD:
-		if (index > PP_SMC_POWER_PROFILE_CUSTOM ||
+		if (index > PP_SMC_POWER_PROFILE_WINDOW3D ||
 		    !smu->workload_map)
 			return -EINVAL;
 
-- 
2.35.1

