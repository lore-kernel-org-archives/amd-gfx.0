Return-Path: <SRS0=vl2N=PR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F841C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 15:34:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24EE461166
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 15:34:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 24EE461166
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB7886E169;
	Fri, 29 Oct 2021 15:34:12 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86A456E169
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Oct 2021 15:34:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H3354lBJtZxgPVQe+sV2fo68wfLqa18O+pKQOLuF3LCzG5e2wVbuAUyLPIUNBiIyeO6BbOVBVCQ5dg+MMfIYKuFC+UnunrolY0iUuk/GvawdrEl3AXULl1azdZMFO7uS6Hx+BUX45irskCt4Q7rY2IuOttKwV+4RFb2BM0lcH7cR/RvGRlCaLGkUU9+eUvHltJD2AO8dKqONrsUz2wJxg/i7m+JfL24OzmmYmY+/4rwK/Cu7Zkb72SGUFFI8nLqyXiqPMj1TC2Z4s4EXfolX8i28bI+AyP7ra2EsU4awSdK0cMi/+MBOeJhxUGKVq4f+RLSDZ/Z8dzE4VUbJH7255g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/oaOgcyRZc8tcECIkB5SzXxmcm+umTlPJTH+3fpWimk=;
 b=Jx3XzT2k5VxWJKWBxabFzY/95uyEYzTj5ulCZLeqfolzDamue71e8l6iUPixFtmUdozVwJIMjWgAJepUavwid6Hg+Gpw2+Vq7A5z1rV1vfdgCwOPSaVbgmezRE8LY87qdKDR3xq8+MGwMPOr08nWUZUuMU3GSEBt7fG5SmNaZGnn+fFyo9PjpppCIRM9ppohak9wldrbbOr+TPbE+BPmBCtb22GXw+E25BEqCkjDBvYkRtHlF6j10QxqgNdouoHPO+oIfyjwO1guRhmf7ebveGvY3kzs/uPb5+X5EZzdIktap4jAWi7IQV9Uys6yCvGdfsPmjMpd0eG4PwZKtzHNrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/oaOgcyRZc8tcECIkB5SzXxmcm+umTlPJTH+3fpWimk=;
 b=us8SlUg/FCezsowa3OtpYIbqLgpSoU2SVcFplgnbIdGWAYQMA5sXKuJcOco5jJ0cmkwJA6drDp4vDM4PZ6oGBXJDJtJN0q2Mc/96fKoOg9Ce69QfZK25Tv7LkqTABR2H//dCU3OyTJVNQHDcn9PGoUipRRq7cT5B4NHdNIUfn2U=
Received: from MW4PR04CA0217.namprd04.prod.outlook.com (2603:10b6:303:87::12)
 by CY4PR1201MB0037.namprd12.prod.outlook.com (2603:10b6:910:1c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Fri, 29 Oct
 2021 15:34:08 +0000
Received: from CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::6c) by MW4PR04CA0217.outlook.office365.com
 (2603:10b6:303:87::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Fri, 29 Oct 2021 15:34:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT049.mail.protection.outlook.com (10.13.175.50) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Fri, 29 Oct 2021 15:34:05 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 29 Oct
 2021 10:34:04 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2] drm/amdgpu/pm: drop pp_power_profile_mode support for
 yellow carp
Date: Fri, 29 Oct 2021 10:33:43 -0500
Message-ID: <20211029153343.17437-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7c24e91-f8b4-4445-3c0f-08d99af18b09
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0037:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB003759A0F007B00B8AAEDB9FE2879@CY4PR1201MB0037.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:22;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5SScTlQRxEC60Mm1uw1s08W1b8EilayqiNSQzrcKBfkNtwU+DwZCsqBdisBFfLCEYnPD9yWBXSzCFVag9RT7UWR4NCDioScicG0YRsbNP2lrCnds9BgTsVXU8RlwEPEwsDMfdzea5ytI2qom2LzIKLWi83tnwAslcdCteomy8v6wWP2AkyUKob1i34bbEFtDhrGJ0nSOjh1WNT90EW20ufjA/b/PKEy8ofBVjiWja0xx8K4Niryqr7A7ATMtKuDFybtvp5ie3ctXnDf8eLG8HYpnMW0bL++K4Nz8oKLltvk7DbmCjWRPc0KeioLUjg5vVTeMR3YpFrlOYYrtW/FJiTmPddOyMuY+iTMbPZs1YHut/a0/mMzBJjZHnScX9vM3Is7KMnGOOivPjhggr/5+zRaQB7PxiLN3pnRrvY/k9qSYh0LxrmAPQ1C1Vx1UJrsVZ5J4W2I5yMYWXn7SMTzSPhRb6lLnow1sI0rwO9OD9/b9gsSLiZgTSAO2FCAvt/ZI167VGFx8e7xpvJj1jB0bZAqqwzqbA7Z7ZujOLbudsEvff9S0zkJ2Sj5egyZjxnGmeCCKUJFOs/X3mOMMdYcy1x/mKFdLNG3kbsxqPciNVeUlYtRHKh75VWz7qwGHvT9Ut7s2S/W+X+U0SuhdHvdidmpq5CGy1mhGCLoWA+KQffuoNqqEazFuiEKijzjAsiyZ106ccQujOBFKq1WyXWxp/34nz83AUT3bgmP3x9eMwJM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(186003)(2616005)(8676002)(426003)(44832011)(336012)(36756003)(26005)(316002)(83380400001)(86362001)(6666004)(1076003)(16526019)(7696005)(70586007)(70206006)(356005)(5660300002)(8936002)(508600001)(2906002)(81166007)(36860700001)(82310400003)(4326008)(6916009)(47076005)(19627235002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 15:34:05.8490 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7c24e91-f8b4-4445-3c0f-08d99af18b09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0037
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

This was added by commit bd8dcea93a7d ("drm/amd/pm: add callbacks to
read/write sysfs file pp_power_profile_mode") but the feature was
deprecated from PMFW.  Remove it from the driver.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Changes from v1->v2:
 * Drop changes to RN and VGH as the deprecation is only in YC.
 * Leave PPSMC_MSG_ActiveProcessNotify message but mark deprecated
 * Rename PPSMC_MSG_SPARE0 to align to the name used by PMFW (PPSMC_MSG_SPARE)

 .../gpu/drm/amd/pm/inc/smu_v13_0_1_ppsmc.h    |  4 +-
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  | 87 -------------------
 2 files changed, 2 insertions(+), 89 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_ppsmc.h b/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_ppsmc.h
index 1d3447991d0c..fc9198846e70 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_ppsmc.h
@@ -51,7 +51,7 @@
 #define PPSMC_MSG_PowerUpVcn                    0x07 ///< Power up VCN; VCN is power gated by default
 #define PPSMC_MSG_SetHardMinVcn                 0x08 ///< For wireless display
 #define PPSMC_MSG_SetSoftMinGfxclk              0x09 ///< Set SoftMin for GFXCLK, argument is frequency in MHz
-#define PPSMC_MSG_ActiveProcessNotify           0x0A ///< Set active work load type
+#define PPSMC_MSG_ActiveProcessNotify           0x0A ///< Deprecated (Not to be used)
 #define PPSMC_MSG_ForcePowerDownGfx             0x0B ///< Force power down GFX, i.e. enter GFXOFF
 #define PPSMC_MSG_PrepareMp1ForUnload           0x0C ///< Prepare PMFW for GFX driver unload
 #define PPSMC_MSG_SetDriverDramAddrHigh         0x0D ///< Set high 32 bits of DRAM address for Driver table transfer
@@ -63,7 +63,7 @@
 #define PPSMC_MSG_SetHardMinSocclkByFreq        0x13 ///< Set hard min for SOC CLK
 #define PPSMC_MSG_SetSoftMinFclk                0x14 ///< Set hard min for FCLK
 #define PPSMC_MSG_SetSoftMinVcn                 0x15 ///< Set soft min for VCN clocks (VCLK and DCLK)
-#define PPSMC_MSG_SPARE0                        0x16 ///< Spared
+#define PPSMC_MSG_SPARE                         0x16 ///< Spare
 #define PPSMC_MSG_GetGfxclkFrequency            0x17 ///< Get GFX clock frequency
 #define PPSMC_MSG_GetFclkFrequency              0x18 ///< Get FCLK frequency
 #define PPSMC_MSG_AllowGfxOff                   0x19 ///< Inform PMFW of allowing GFXOFF entry
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index a403657151ba..8215bbf5ed7c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -64,7 +64,6 @@ static struct cmn2asic_msg_mapping yellow_carp_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(PowerDownVcn,                   PPSMC_MSG_PowerDownVcn,			1),
 	MSG_MAP(PowerUpVcn,                     PPSMC_MSG_PowerUpVcn,			1),
 	MSG_MAP(SetHardMinVcn,                  PPSMC_MSG_SetHardMinVcn,		1),
-	MSG_MAP(ActiveProcessNotify,            PPSMC_MSG_ActiveProcessNotify,		1),
 	MSG_MAP(PrepareMp1ForUnload,            PPSMC_MSG_PrepareMp1ForUnload,      1),
 	MSG_MAP(SetDriverDramAddrHigh,          PPSMC_MSG_SetDriverDramAddrHigh,	1),
 	MSG_MAP(SetDriverDramAddrLow,           PPSMC_MSG_SetDriverDramAddrLow,		1),
@@ -135,14 +134,6 @@ static struct cmn2asic_mapping yellow_carp_table_map[SMU_TABLE_COUNT] = {
 	TAB_MAP_VALID(CUSTOM_DPM),
 	TAB_MAP_VALID(DPMCLOCKS),
 };
-
-static struct cmn2asic_mapping yellow_carp_workload_map[PP_SMC_POWER_PROFILE_COUNT] = {
-	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_FULLSCREEN3D,		WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT),
-	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VIDEO,		WORKLOAD_PPLIB_VIDEO_BIT),
-	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VR,			WORKLOAD_PPLIB_VR_BIT),
-	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_COMPUTE,		WORKLOAD_PPLIB_COMPUTE_BIT),
-	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_CUSTOM,		WORKLOAD_PPLIB_CUSTOM_BIT),
-};
 	
 static int yellow_carp_init_smc_tables(struct smu_context *smu)
 {
@@ -543,81 +534,6 @@ static int yellow_carp_set_watermarks_table(struct smu_context *smu,
 	return 0;
 }
 
-static int yellow_carp_get_power_profile_mode(struct smu_context *smu,
-						char *buf)
-{
-	static const char *profile_name[] = {
-					"BOOTUP_DEFAULT",
-					"3D_FULL_SCREEN",
-					"POWER_SAVING",
-					"VIDEO",
-					"VR",
-					"COMPUTE",
-					"CUSTOM"};
-	uint32_t i, size = 0;
-	int16_t workload_type = 0;
-
-	if (!buf)
-		return -EINVAL;
-
-	for (i = 0; i <= PP_SMC_POWER_PROFILE_CUSTOM; i++) {
-		/*
-		 * Conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT.
-		 * Not all profile modes are supported on yellow carp.
-		 */
-		workload_type = smu_cmn_to_asic_specific_index(smu,
-							       CMN2ASIC_MAPPING_WORKLOAD,
-							       i);
-
-		if (workload_type < 0)
-			continue;
-
-		size += sysfs_emit_at(buf, size, "%2d %14s%s\n",
-			i, profile_name[i], (i == smu->power_profile_mode) ? "*" : " ");
-	}
-
-	return size;
-}
-
-static int yellow_carp_set_power_profile_mode(struct smu_context *smu,
-						long *input, uint32_t size)
-{
-	int workload_type, ret;
-	uint32_t profile_mode = input[size];
-
-	if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
-		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
-		return -EINVAL;
-	}
-
-	if (profile_mode == PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT ||
-			profile_mode == PP_SMC_POWER_PROFILE_POWERSAVING)
-		return 0;
-
-	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
-	workload_type = smu_cmn_to_asic_specific_index(smu,
-						       CMN2ASIC_MAPPING_WORKLOAD,
-						       profile_mode);
-	if (workload_type < 0) {
-		dev_dbg(smu->adev->dev, "Unsupported power profile mode %d on YELLOWCARP\n",
-					profile_mode);
-		return -EINVAL;
-	}
-
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ActiveProcessNotify,
-				    1 << workload_type,
-				    NULL);
-	if (ret) {
-		dev_err_once(smu->adev->dev, "Fail to set workload type %d\n",
-					workload_type);
-		return ret;
-	}
-
-	smu->power_profile_mode = profile_mode;
-
-	return 0;
-}
-
 static ssize_t yellow_carp_get_gpu_metrics(struct smu_context *smu,
 						void **table)
 {
@@ -1238,8 +1154,6 @@ static const struct pptable_funcs yellow_carp_ppt_funcs = {
 	.read_sensor = yellow_carp_read_sensor,
 	.is_dpm_running = yellow_carp_is_dpm_running,
 	.set_watermarks_table = yellow_carp_set_watermarks_table,
-	.get_power_profile_mode = yellow_carp_get_power_profile_mode,
-	.set_power_profile_mode = yellow_carp_set_power_profile_mode,
 	.get_gpu_metrics = yellow_carp_get_gpu_metrics,
 	.get_enabled_mask = smu_cmn_get_enabled_32_bits_mask,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
@@ -1261,6 +1175,5 @@ void yellow_carp_set_ppt_funcs(struct smu_context *smu)
 	smu->message_map = yellow_carp_message_map;
 	smu->feature_map = yellow_carp_feature_mask_map;
 	smu->table_map = yellow_carp_table_map;
-	smu->workload_map = yellow_carp_workload_map;
 	smu->is_apu = true;
 }

base-commit: b785098f70a5ed2488becbdd5921054053034439
-- 
2.25.1

