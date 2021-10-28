Return-Path: <SRS0=JMr/=PQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751EBC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Oct 2021 15:54:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30E9260FC1
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Oct 2021 15:54:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 30E9260FC1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEDA86E037;
	Thu, 28 Oct 2021 15:54:06 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E31876E037
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Oct 2021 15:54:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ApDROeLFlOrX90VASPgELkpnpZedvy6f/0IJeWqosiDo/wn1cXSN6oyJUX0Fug6KgAcNllHo/4jAc22F3cUFgvLJjf1lKHy7iRDiQxhAxTjeU/I4knCP8PJa5aGyAfE0rX/H5/dvw2UtHV0QM/6uvCGm38pyzaK2kMO0P3nWiYXNF2iegaVYDeYoY5omxs3Ihvjk5q+oPHilrQKqNoxMkPZUobosKLIHkzcljxooeMXUv6N7FslkdI+dIsiCj9hpB4Dg7ukSLVBPVKU1x5Af+VJqT1BNOKEh/JB5CzxETGrhCE07nx3EEnDhHACJSTVLzb4Cy6DFCVvRYHyjHtp6uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHNQi0FtXEGYgX+1BkMSRfMqC3eNB9DatiwhofYtviY=;
 b=nrsWDu8cfs0NUpiRZap53yh3HvYqN8ckZl27je1Pt28iuJFXLQQZIoW+JQ6uQ0QoGkf63MhaFRhKC7xXvLVf6akV+HVWDpfCST2YY0XhPq3yr7DbsBTgGpa8KChJyGKnp82/K/LG6uVAD0H3nE9Xm3rBgrFkWP5uaYzNa+VJ5RrdpebOdty80LHGTi0x/W7BLsVwZBWmqJmRQcxc+4PRnhMmThJctRbu0K0FDfxcq8cWwtzwbHVkWT+eigWLTGJGESUin1hRV3S1hj+ltUj1++ZKbR5lLJNQBD4w+wUOBP+/JbmqnK9NiJ5Qx2qZzSiyAa8GdYRVS3F0DknG7o5wtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHNQi0FtXEGYgX+1BkMSRfMqC3eNB9DatiwhofYtviY=;
 b=HirLteTTZuSW7MTfGkXHFLZMIK3EKyK74CmLw9T2IvpQbx50Lnhoav+TfkRh+InJm107Oll5YsrFNVpwxZmcIPIrV86UQjOwDVSAB1rgDdhp9Kp/WAdKg6AaMwJzUao6dCW+/S85er1WC1BZg/qFJKrFu/XAsMOyLnIOlgrohj0=
Received: from BN0PR10CA0019.namprd10.prod.outlook.com (2603:10b6:408:143::8)
 by CY4PR12MB1254.namprd12.prod.outlook.com (2603:10b6:903:41::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.20; Thu, 28 Oct
 2021 15:54:00 +0000
Received: from BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:143:cafe::6e) by BN0PR10CA0019.outlook.office365.com
 (2603:10b6:408:143::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Thu, 28 Oct 2021 15:54:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT008.mail.protection.outlook.com (10.13.177.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Thu, 28 Oct 2021 15:53:57 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 28 Oct
 2021 10:53:56 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] drm/amdgpu/pm: drop pp_power_profile_mode support for APUs
Date: Thu, 28 Oct 2021 10:53:36 -0500
Message-ID: <20211028155336.2990-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b4a521b-f647-4a85-006d-08d99a2b26f4
X-MS-TrafficTypeDiagnostic: CY4PR12MB1254:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1254F5A0620B64238BD91F74E2869@CY4PR12MB1254.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:16;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cntlm+rAuHBn//2zlKXrkwNx3TO9QJXY7qK421FP6CkXYrUFDYrWbBorX6rlszCzYor8NS5YpH6h9g2Nw5431sgVqUFkto5UZf1Ml4paEmb569zu/heQoDu5H4FnIST97cuSsb9OHGQ+kWLrWcVpNDzpwf4HvG4G4eOODDz/4+wsGFLx7BN2ISHH8xKXeg34ljMIuFIXzCr92cwHykJ1COQJPHrdz8wGUA9UBrsNt/xa42pfX4RCL7cOrERKoZBgbocCl9kFFfZ+DSiScMS5AFz9SlYETpjhv+UGD8iuDdwqusRknCYFNcyRwLYPYOWe2/tqWY+A5Tphk7wS1Z2rAjt3RZbbkeW4WrFYvqOR3e1sYtUZMsISebOAi0tZjqU5quabeQQgB4EBfBKM8i8ersSyImHryWB6moLdiv3z6EKPVlhSb19XQvfbf4VnC3t+J5RfCTMijkvgMCiZJfs2We+W1+4jOdQzwGhnNt1/ArQ4qQcKFac4ko9noJJzGfQ4i18F4RRnFYLLQHJoGzRgMFmLslt1qkmeYMg9e/uQtWmAwVXZ0m6Jr4+n+9wEfXybGyy99SMEAU2SkWsJSBqGQvo4tV5gDXdlFk8GJ5R4rG8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(86362001)(36860700001)(8676002)(7696005)(44832011)(81166007)(19627235002)(82310400003)(426003)(16526019)(186003)(8936002)(2616005)(26005)(336012)(6666004)(316002)(70586007)(47076005)(6916009)(4326008)(2906002)(36756003)(356005)(508600001)(70206006)(83380400001)(1076003)(30864003)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 15:53:57.7012 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b4a521b-f647-4a85-006d-08d99a2b26f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1254
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

Although this has been plumbed for Renoir, Green Sardine, Van Gogh,
and Yellow Carp the functionality in the SMU doesn't do anything for
these APUs.  Drop the associated code with them.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../gpu/drm/amd/pm/inc/smu_v13_0_1_ppsmc.h    |  4 +-
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 86 ------------------
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   | 87 -------------------
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  | 87 -------------------
 4 files changed, 2 insertions(+), 262 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_ppsmc.h b/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_ppsmc.h
index 1d3447991d0c..23d24173bc5d 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_ppsmc.h
@@ -51,7 +51,7 @@
 #define PPSMC_MSG_PowerUpVcn                    0x07 ///< Power up VCN; VCN is power gated by default
 #define PPSMC_MSG_SetHardMinVcn                 0x08 ///< For wireless display
 #define PPSMC_MSG_SetSoftMinGfxclk              0x09 ///< Set SoftMin for GFXCLK, argument is frequency in MHz
-#define PPSMC_MSG_ActiveProcessNotify           0x0A ///< Set active work load type
+#define PPSMC_MSG_SPARE0                        0x0A ///< Spare
 #define PPSMC_MSG_ForcePowerDownGfx             0x0B ///< Force power down GFX, i.e. enter GFXOFF
 #define PPSMC_MSG_PrepareMp1ForUnload           0x0C ///< Prepare PMFW for GFX driver unload
 #define PPSMC_MSG_SetDriverDramAddrHigh         0x0D ///< Set high 32 bits of DRAM address for Driver table transfer
@@ -63,7 +63,7 @@
 #define PPSMC_MSG_SetHardMinSocclkByFreq        0x13 ///< Set hard min for SOC CLK
 #define PPSMC_MSG_SetSoftMinFclk                0x14 ///< Set hard min for FCLK
 #define PPSMC_MSG_SetSoftMinVcn                 0x15 ///< Set soft min for VCN clocks (VCLK and DCLK)
-#define PPSMC_MSG_SPARE0                        0x16 ///< Spared
+#define PPSMC_MSG_SPARE1                        0x16 ///< Spare
 #define PPSMC_MSG_GetGfxclkFrequency            0x17 ///< Get GFX clock frequency
 #define PPSMC_MSG_GetFclkFrequency              0x18 ///< Get FCLK frequency
 #define PPSMC_MSG_AllowGfxOff                   0x19 ///< Inform PMFW of allowing GFXOFF entry
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 421f38e8dada..2451d990d577 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -72,7 +72,6 @@ static struct cmn2asic_msg_mapping vangogh_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(RlcPowerNotify,                 PPSMC_MSG_RlcPowerNotify,		0),
 	MSG_MAP(SetHardMinVcn,                  PPSMC_MSG_SetHardMinVcn,		0),
 	MSG_MAP(SetSoftMinGfxclk,               PPSMC_MSG_SetSoftMinGfxclk,		0),
-	MSG_MAP(ActiveProcessNotify,            PPSMC_MSG_ActiveProcessNotify,		0),
 	MSG_MAP(SetHardMinIspiclkByFreq,        PPSMC_MSG_SetHardMinIspiclkByFreq,	0),
 	MSG_MAP(SetHardMinIspxclkByFreq,        PPSMC_MSG_SetHardMinIspxclkByFreq,	0),
 	MSG_MAP(SetDriverDramAddrHigh,          PPSMC_MSG_SetDriverDramAddrHigh,	0),
@@ -182,14 +181,6 @@ static struct cmn2asic_mapping vangogh_table_map[SMU_TABLE_COUNT] = {
 	TAB_MAP_VALID(DPMCLOCKS),
 };
 
-static struct cmn2asic_mapping vangogh_workload_map[PP_SMC_POWER_PROFILE_COUNT] = {
-	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_FULLSCREEN3D,		WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT),
-	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VIDEO,		WORKLOAD_PPLIB_VIDEO_BIT),
-	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VR,			WORKLOAD_PPLIB_VR_BIT),
-	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_COMPUTE,		WORKLOAD_PPLIB_COMPUTE_BIT),
-	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_CUSTOM,		WORKLOAD_PPLIB_CUSTOM_BIT),
-};
-
 static const uint8_t vangogh_throttler_map[] = {
 	[THROTTLER_STATUS_BIT_SPL]	= (SMU_THROTTLER_SPL_BIT),
 	[THROTTLER_STATUS_BIT_FPPT]	= (SMU_THROTTLER_FPPT_BIT),
@@ -1010,80 +1001,6 @@ static int vangogh_get_dpm_ultimate_freq(struct smu_context *smu,
 	return ret;
 }
 
-static int vangogh_get_power_profile_mode(struct smu_context *smu,
-					   char *buf)
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
-		 * Conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT
-		 * Not all profile modes are supported on vangogh.
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
-static int vangogh_set_power_profile_mode(struct smu_context *smu, long *input, uint32_t size)
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
-		dev_dbg(smu->adev->dev, "Unsupported power profile mode %d on VANGOGH\n",
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
 static int vangogh_set_soft_freq_limited_range(struct smu_context *smu,
 					  enum smu_clk_type clk_type,
 					  uint32_t min,
@@ -2190,8 +2107,6 @@ static const struct pptable_funcs vangogh_ppt_funcs = {
 	.set_fine_grain_gfx_freq_parameters = vangogh_set_fine_grain_gfx_freq_parameters,
 	.system_features_control = vangogh_system_features_control,
 	.feature_is_enabled = smu_cmn_feature_is_enabled,
-	.set_power_profile_mode = vangogh_set_power_profile_mode,
-	.get_power_profile_mode = vangogh_get_power_profile_mode,
 	.get_dpm_clock_table = vangogh_get_dpm_clock_table,
 	.force_clk_levels = vangogh_force_clk_levels,
 	.set_performance_level = vangogh_set_performance_level,
@@ -2210,6 +2125,5 @@ void vangogh_set_ppt_funcs(struct smu_context *smu)
 	smu->message_map = vangogh_message_map;
 	smu->feature_map = vangogh_feature_mask_map;
 	smu->table_map = vangogh_table_map;
-	smu->workload_map = vangogh_workload_map;
 	smu->is_apu = true;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index 145f13b8c977..21da7989f1ba 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -58,7 +58,6 @@ static struct cmn2asic_msg_mapping renoir_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(SetHardMinVcn,                  PPSMC_MSG_SetHardMinVcn,                1),
 	MSG_MAP(SetAllowFclkSwitch,             PPSMC_MSG_SetAllowFclkSwitch,           1),
 	MSG_MAP(SetMinVideoGfxclkFreq,          PPSMC_MSG_SetMinVideoGfxclkFreq,        1),
-	MSG_MAP(ActiveProcessNotify,            PPSMC_MSG_ActiveProcessNotify,          1),
 	MSG_MAP(SetCustomPolicy,                PPSMC_MSG_SetCustomPolicy,              1),
 	MSG_MAP(SetVideoFps,                    PPSMC_MSG_SetVideoFps,                  1),
 	MSG_MAP(NumOfDisplays,                  PPSMC_MSG_SetDisplayCount,              1),
@@ -120,14 +119,6 @@ static struct cmn2asic_mapping renoir_table_map[SMU_TABLE_COUNT] = {
 	TAB_MAP_VALID(SMU_METRICS),
 };
 
-static struct cmn2asic_mapping renoir_workload_map[PP_SMC_POWER_PROFILE_COUNT] = {
-	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_FULLSCREEN3D,		WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT),
-	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VIDEO,		WORKLOAD_PPLIB_VIDEO_BIT),
-	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VR,			WORKLOAD_PPLIB_VR_BIT),
-	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_COMPUTE,		WORKLOAD_PPLIB_COMPUTE_BIT),
-	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_CUSTOM,		WORKLOAD_PPLIB_CUSTOM_BIT),
-};
-
 static const uint8_t renoir_throttler_map[] = {
 	[THROTTLER_STATUS_BIT_SPL]		= (SMU_THROTTLER_SPL_BIT),
 	[THROTTLER_STATUS_BIT_FPPT]		= (SMU_THROTTLER_FPPT_BIT),
@@ -854,46 +845,6 @@ static int renoir_force_clk_levels(struct smu_context *smu,
 	return ret;
 }
 
-static int renoir_set_power_profile_mode(struct smu_context *smu, long *input, uint32_t size)
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
-		/*
-		 * TODO: If some case need switch to powersave/default power mode
-		 * then can consider enter WORKLOAD_COMPUTE/WORKLOAD_CUSTOM for power saving.
-		 */
-		dev_dbg(smu->adev->dev, "Unsupported power profile mode %d on RENOIR\n", profile_mode);
-		return -EINVAL;
-	}
-
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ActiveProcessNotify,
-				    1 << workload_type,
-				    NULL);
-	if (ret) {
-		dev_err_once(smu->adev->dev, "Fail to set workload type %d\n", workload_type);
-		return ret;
-	}
-
-	smu->power_profile_mode = profile_mode;
-
-	return 0;
-}
-
 static int renoir_set_peak_clock_by_device(struct smu_context *smu)
 {
 	int ret = 0;
@@ -1092,41 +1043,6 @@ static int renoir_set_watermarks_table(
 	return 0;
 }
 
-static int renoir_get_power_profile_mode(struct smu_context *smu,
-					   char *buf)
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
-		 * Conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT
-		 * Not all profile modes are supported on arcturus.
-		 */
-		workload_type = smu_cmn_to_asic_specific_index(smu,
-							       CMN2ASIC_MAPPING_WORKLOAD,
-							       i);
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
 static int renoir_get_smu_metrics_data(struct smu_context *smu,
 				       MetricsMember_t member,
 				       uint32_t *value)
@@ -1389,11 +1305,9 @@ static const struct pptable_funcs renoir_ppt_funcs = {
 	.dpm_set_vcn_enable = renoir_dpm_set_vcn_enable,
 	.dpm_set_jpeg_enable = renoir_dpm_set_jpeg_enable,
 	.force_clk_levels = renoir_force_clk_levels,
-	.set_power_profile_mode = renoir_set_power_profile_mode,
 	.set_performance_level = renoir_set_performance_level,
 	.get_dpm_clock_table = renoir_get_dpm_clock_table,
 	.set_watermarks_table = renoir_set_watermarks_table,
-	.get_power_profile_mode = renoir_get_power_profile_mode,
 	.read_sensor = renoir_read_sensor,
 	.check_fw_status = smu_v12_0_check_fw_status,
 	.check_fw_version = smu_v12_0_check_fw_version,
@@ -1429,7 +1343,6 @@ void renoir_set_ppt_funcs(struct smu_context *smu)
 	smu->message_map = renoir_message_map;
 	smu->clock_map = renoir_clk_map;
 	smu->table_map = renoir_table_map;
-	smu->workload_map = renoir_workload_map;
 	smu->smc_driver_if_version = SMU12_DRIVER_IF_VERSION;
 	smu->is_apu = true;
 }
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
-- 
2.25.1

