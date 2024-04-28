Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8927CC4345F
	for <amd-gfx@archiver.kernel.org>; Sun, 28 Apr 2024 08:45:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08F2510F9CE;
	Sun, 28 Apr 2024 08:45:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0v0Wte1n";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F35110F9CE
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Apr 2024 08:45:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ap9LkvUELpSQrXGqAW0Zoz/vCvoK8sXzgRymjHMz31K21L71sDV3be+FLlSNmpLeQ6PYgKiLiy10Bv5luFbJ094546qYeToP4x9HYkz5Qr5uleVUAnMw/mNsaG4i/ebvDe/kY1jIgr7e1y5IDXCo9u9KCZEQfSk1kIJUFbFv/f5Dldix9lXu4Nt1QxQnUragz0bLYCygSYGPpfZoG3drQ91HJo7M7ScVQM2wSDtT1mTCgXIlClCC7fNHMiWmSkUjjuXjj1lpJrbX4shgUB4uNUYTP9c4YnUyIyMnyWtQjJdURyCgPNv+I0GWyxmwLwZn+rO2/8lod5L4tCE/2A+FYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/j8WJMtHwu+t2xh48Jo80GVHD9Usb5MeHYLmpxAVICc=;
 b=JkJ0auiHeVmbIPBhIuStRZERsx9Pz6uW7TZKq0hq7kMltHUNGsRE8AHGW/frQSJzLVLV0ZmYz4u6oP98RW2kuIFqTxYXuad3eNobuVAAI1UmtM4PiLhKfPsFDSQ/SuADp67Fep2HPkEyff+uQ5howWul/YrIafcuaXvavJauV6NDNnH65xi64hJBUWAp8kbd4DY0wfZCcJgSM0ZE0HbiXwermTg7fsBalMU+EaDi4QnBNVBNbnF+mMslaTgr3zHBlA/ImNovsFvTsxN3i/yQQIWaU3HByHEc9CQy8YXhVqreriFE4uiFMYGnlFuP5tLXVuCuHCo+FGT7Q5twm5l7+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/j8WJMtHwu+t2xh48Jo80GVHD9Usb5MeHYLmpxAVICc=;
 b=0v0Wte1nsFDhvjnk98FJcQcd6NWPL5E9Tlau90W/VPviGybmSPF2AQw/6M2mK4sWszIrcEKXFd1XvccdAzI/zuUm4w5sYGy6V21JuK4LLYQMCfEajikB7VNYEmwNc6FjPYUcITEZwRx7qW29Y+4vxWvfYRHCAbfD96+hGVbY3c0=
Received: from SJ0PR03CA0181.namprd03.prod.outlook.com (2603:10b6:a03:2ef::6)
 by PH8PR12MB7206.namprd12.prod.outlook.com (2603:10b6:510:226::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Sun, 28 Apr
 2024 08:45:39 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::94) by SJ0PR03CA0181.outlook.office365.com
 (2603:10b6:a03:2ef::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.31 via Frontend
 Transport; Sun, 28 Apr 2024 08:45:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Sun, 28 Apr 2024 08:45:38 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 28 Apr
 2024 03:45:36 -0500
From: Tim Huang <Tim.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>, Tim Huang
 <Tim.Huang@amd.com>
Subject: [PATCH 1/2] drm/amd/pm: fix uninitialized variable warnings for
 vega10_hwmgr
Date: Sun, 28 Apr 2024 16:45:10 +0800
Message-ID: <20240428084511.1646356-1-Tim.Huang@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|PH8PR12MB7206:EE_
X-MS-Office365-Filtering-Correlation-Id: 3211e392-2530-4826-7491-08dc675f9451
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|1800799015|376005|82310400014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wcFcupyLuZq4626uLBdLF9FZqb1Z5n1/kACN0fpwydbjI5L+KKaGkSG+LVBx?=
 =?us-ascii?Q?UFo1hGT/QSNMN/jhbzq1wza1yzvcrNrFVetoi/c9abERyfWbKLNvsBuqVUFI?=
 =?us-ascii?Q?rekj1u9WjHWbmfTN56ic+N0BJSq7VVp4ryQk9wVapERPhFTbQ0ZyRXzeBzPH?=
 =?us-ascii?Q?jy41VRNF1xP9d/d7tu7/QAfeDfaNXIlBaS4ITzO7RyuNSCpXmXUfxVXmE+MY?=
 =?us-ascii?Q?M2y96VsQ+QwTVk/U6Yfrutl8cskuLJQI174UTaAi4iHZOUATCzY3O7z6tYZM?=
 =?us-ascii?Q?dNrUAKddMcwVSQ99qad0yTZhJOTrzJjDyJwPgHwZb+Sf6gHLNOY3WHM50I3T?=
 =?us-ascii?Q?r4aMCZGXYUYjfsTSamrvvKrOqE8hSraTfbYB9YQitxme3o+q0Z8OWsr3s4Bg?=
 =?us-ascii?Q?pHIpT8k6uiy7ywTtvWE1nnmWL/dEE0m4ggoX6Xky082fsc/TfVeadcirn/lp?=
 =?us-ascii?Q?rlMb30NhsfV5T/uYnw+9gaWIvKmv/cdbGr17wPDtgQxISiamXc+BTeDBlcbl?=
 =?us-ascii?Q?8dJtEgSz1vp/a8bmokw4+1OtD/Wm5sQcYxmyU/mgpThk6Opt0AmwWYq4mEh4?=
 =?us-ascii?Q?x15heIGaJXfLLTOxjOI5GIrJUt2w5icvzpQiPlCG+qlSYR0Q57jNXNmakUwi?=
 =?us-ascii?Q?Mvz5TcFVPyduFu6RvOKDNqM/k06YuBpej10CrBlfpmmBji6gS+gZyRwvoHTS?=
 =?us-ascii?Q?ZLmVsUt2xy+rZaRJJd+BFpaMpcP7Z5v5NlgEQeOMPuJTyd4j1ZnE3QyElLz6?=
 =?us-ascii?Q?5mT+DCLHe8KH+VFEeL4Yl9GCfED++gheB/5/CKEQXeUfjsZRVkEsoOOwbuIJ?=
 =?us-ascii?Q?2GfTRpY1+9KBK5RWdWNqzcnRNC19+/lrBwmS2ew0QO6b6xPDD55kmQKlJKiI?=
 =?us-ascii?Q?Y7W7hmRXbItYcfQAozt2p6tHnKirtaBtM7brIKU1VILO4Pehtj0usgOV8V3s?=
 =?us-ascii?Q?c6V+tu71GNBwwW3tM945CqDhifJogSlnvWQt3SPQapVPxME4x0Ge4hSIQC+R?=
 =?us-ascii?Q?QJ4AhdJpeegNz5o8eF+365Z13jJqCpZ/JEIxLyuxS/GfcezWrHhXScI+PJ4n?=
 =?us-ascii?Q?x6z0cnCNpmuhjc1+5xU9iarteENJGR1RQyOR70C98hvZrBe6D8R/6V5cu68K?=
 =?us-ascii?Q?oo2I/giEurWK2d8Rl2kYAO5T2JvV7wALhq0wA0loyx8ZAhGAJ0j6GVG7HKTo?=
 =?us-ascii?Q?sBZj9ByoAEJpQBi7L/qCei85KDgRsnZVlT2jlWhuz5w2gtEctGT5dJ1Uji4J?=
 =?us-ascii?Q?fcKOVoKfKUgxkPSf9XYAb2PxaSB3MEmLT56EORTDn9cCIeF8dSdRjek4FNnH?=
 =?us-ascii?Q?OYF6Ayc55WpqPk1wx9bwrYXSvEFHV2MdzGqVt7eMaeteKNQPw7mvyNnbS/zx?=
 =?us-ascii?Q?UAyskTdCrJr/KNhGsfH5WSrYrqSH?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2024 08:45:38.6438 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3211e392-2530-4826-7491-08dc675f9451
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7206
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

Clear warnings that using uninitialized variable when fails
to get the valid value from SMU.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
---
 .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 46 ++++++++++++++-----
 .../amd/pm/powerplay/smumgr/vega10_smumgr.c   |  6 ++-
 2 files changed, 39 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index 9f5bd998c6bf..488ad9de4694 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -354,13 +354,13 @@ static int vega10_odn_initial_default_setting(struct pp_hwmgr *hwmgr)
 	return 0;
 }
 
-static void vega10_init_dpm_defaults(struct pp_hwmgr *hwmgr)
+static int vega10_init_dpm_defaults(struct pp_hwmgr *hwmgr)
 {
 	struct vega10_hwmgr *data = hwmgr->backend;
-	int i;
 	uint32_t sub_vendor_id, hw_revision;
 	uint32_t top32, bottom32;
 	struct amdgpu_device *adev = hwmgr->adev;
+	int ret, i;
 
 	vega10_initialize_power_tune_defaults(hwmgr);
 
@@ -485,9 +485,12 @@ static void vega10_init_dpm_defaults(struct pp_hwmgr *hwmgr)
 	if (data->registry_data.vr0hot_enabled)
 		data->smu_features[GNLD_VR0HOT].supported = true;
 
-	smum_send_msg_to_smc(hwmgr,
+	ret = smum_send_msg_to_smc(hwmgr,
 			PPSMC_MSG_GetSmuVersion,
 			&hwmgr->smu_version);
+	if (ret)
+		return ret;
+
 		/* ACG firmware has major version 5 */
 	if ((hwmgr->smu_version & 0xff000000) == 0x5000000)
 		data->smu_features[GNLD_ACG].supported = true;
@@ -505,10 +508,16 @@ static void vega10_init_dpm_defaults(struct pp_hwmgr *hwmgr)
 		data->smu_features[GNLD_PCC_LIMIT].supported = true;
 
 	/* Get the SN to turn into a Unique ID */
-	smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumTop32, &top32);
-	smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumBottom32, &bottom32);
+	ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumTop32, &top32);
+	if (ret)
+		return ret;
+
+	ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumBottom32, &bottom32);
+	if (ret)
+		return ret;
 
 	adev->unique_id = ((uint64_t)bottom32 << 32) | top32;
+	return 0;
 }
 
 #ifdef PPLIB_VEGA10_EVV_SUPPORT
@@ -882,7 +891,9 @@ static int vega10_hwmgr_backend_init(struct pp_hwmgr *hwmgr)
 
 	vega10_set_features_platform_caps(hwmgr);
 
-	vega10_init_dpm_defaults(hwmgr);
+	result = vega10_init_dpm_defaults(hwmgr);
+	if (result)
+		return result;
 
 #ifdef PPLIB_VEGA10_EVV_SUPPORT
 	/* Get leakage voltage based on leakage ID. */
@@ -3900,11 +3911,14 @@ static int vega10_get_gpu_power(struct pp_hwmgr *hwmgr,
 		uint32_t *query)
 {
 	uint32_t value;
+	int ret;
 
 	if (!query)
 		return -EINVAL;
 
-	smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetCurrPkgPwr, &value);
+	ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetCurrPkgPwr, &value);
+	if (ret)
+		return ret;
 
 	/* SMC returning actual watts, keep consistent with legacy asics, low 8 bit as 8 fractional bits */
 	*query = value << 8;
@@ -4800,14 +4814,16 @@ static int vega10_print_clock_levels(struct pp_hwmgr *hwmgr,
 	uint32_t gen_speed, lane_width, current_gen_speed, current_lane_width;
 	PPTable_t *pptable = &(data->smc_state_table.pp_table);
 
-	int i, now, size = 0, count = 0;
+	int i, ret, now,  size = 0, count = 0;
 
 	switch (type) {
 	case PP_SCLK:
 		if (data->registry_data.sclk_dpm_key_disabled)
 			break;
 
-		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetCurrentGfxclkIndex, &now);
+		ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetCurrentGfxclkIndex, &now);
+		if (ret)
+			break;
 
 		if (hwmgr->pp_one_vf &&
 		    (hwmgr->dpm_level == AMD_DPM_FORCED_LEVEL_PROFILE_PEAK))
@@ -4823,7 +4839,9 @@ static int vega10_print_clock_levels(struct pp_hwmgr *hwmgr,
 		if (data->registry_data.mclk_dpm_key_disabled)
 			break;
 
-		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetCurrentUclkIndex, &now);
+		ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetCurrentUclkIndex, &now);
+		if (ret)
+			break;
 
 		for (i = 0; i < mclk_table->count; i++)
 			size += sprintf(buf + size, "%d: %uMhz %s\n",
@@ -4834,7 +4852,9 @@ static int vega10_print_clock_levels(struct pp_hwmgr *hwmgr,
 		if (data->registry_data.socclk_dpm_key_disabled)
 			break;
 
-		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetCurrentSocclkIndex, &now);
+		ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetCurrentSocclkIndex, &now);
+		if (ret)
+			break;
 
 		for (i = 0; i < soc_table->count; i++)
 			size += sprintf(buf + size, "%d: %uMhz %s\n",
@@ -4845,8 +4865,10 @@ static int vega10_print_clock_levels(struct pp_hwmgr *hwmgr,
 		if (data->registry_data.dcefclk_dpm_key_disabled)
 			break;
 
-		smum_send_msg_to_smc_with_parameter(hwmgr,
+		ret = smum_send_msg_to_smc_with_parameter(hwmgr,
 				PPSMC_MSG_GetClockFreqMHz, CLK_DCEFCLK, &now);
+		if (ret)
+			break;
 
 		for (i = 0; i < dcef_table->count; i++)
 			size += sprintf(buf + size, "%d: %uMhz %s\n",
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
index a70d73896649..f9c0f117725d 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
@@ -130,13 +130,17 @@ int vega10_get_enabled_smc_features(struct pp_hwmgr *hwmgr,
 			    uint64_t *features_enabled)
 {
 	uint32_t enabled_features;
+	int ret;
 
 	if (features_enabled == NULL)
 		return -EINVAL;
 
-	smum_send_msg_to_smc(hwmgr,
+	ret = smum_send_msg_to_smc(hwmgr,
 			PPSMC_MSG_GetEnabledSmuFeatures,
 			&enabled_features);
+	if (ret)
+		return ret;
+
 	*features_enabled = enabled_features;
 
 	return 0;
-- 
2.39.2

