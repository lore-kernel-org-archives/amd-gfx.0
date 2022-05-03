Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9213C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:37:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDF5B10F45B;
	Tue,  3 May 2022 20:37:44 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 736F810F44C
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:37:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TOoe35rwm47TspIHBVv/O7U3Y71bFlzIeSHsQ6Qy3M3X59KVli9tsC+9i2H+AtccX6k6yB+4IXCfr4XTdxyR7WpTEKHnJcsjE3MKKwZ6aFv4xoxBDGS7qwcsY372BWqrsZpFviOJ7GjKihhNTvnPF1MOmVqX8l/WTbXu1z4K1JYgX22FbvvkdlohkW0YORYCl6QYlJ/+2fDAtUlUfy45xicwRr1Bzk9rNR+RV65OfOffvbTBH9ocxtynbY+YevxgSHxAAdxyA5AotgRazqpuVi592/bRf0QZJdSU7dlQ05leBX8joC241FD/4wzDvNPkk1VSN9IjiCvHrKSXsRrGsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RSSf+oYS+JsyTMPG4uij4ZCuISvhy3IGrOIM8/oSyGw=;
 b=RvPe8sZgsLZfvErHcfMwxNdccA45KCdJ4ueQkbQRTYCMI5KiX2pvMB4tN4fn8SQf6ibjHmlIqDDSJ7vzQ9k0ODrFjDr/g/DTk0YHLxnOuMqGRWLAgsdzVej1d9v1M2axAW2zX7DNA1vrrm+OhwZR9UnfAw2M623OXhBhUBjPHtl8u3kTLQRw/HjNpbsE5bquaZYL+8MJ1PxDfXsscyauzl07IG5vq/NqLMdfOXV/sGX8+8nO3RwcUsUs7Iwq+hE1FDjHG1QHsEt9yaPSlRRxCUqdp2X4dTjEWmVBbW/k0ffT3BO8ZtmurkkdYcerdI4IJ9YToZEZq8l08ZEIu8tsZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RSSf+oYS+JsyTMPG4uij4ZCuISvhy3IGrOIM8/oSyGw=;
 b=vY38Wp3mhdrsPEAoyu0Xfis6ILsgIG+fZYGpYMYCkuWgA202XvRwx0Np1uTOQO6dXvBsKVM9bg9lKVPFDMa8h+QBTKQMTDzxWuDS+erGHAJ63dnsbnNWyXZKTJXXTwdU31QxQydyeuLNa8STjrfOZI1Xoirnl2pQ+Yq53I4xxVQ=
Received: from MW4PR04CA0141.namprd04.prod.outlook.com (2603:10b6:303:84::26)
 by BL1PR12MB5378.namprd12.prod.outlook.com (2603:10b6:208:31d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12; Tue, 3 May
 2022 20:37:40 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::85) by MW4PR04CA0141.outlook.office365.com
 (2603:10b6:303:84::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Tue, 3 May 2022 20:37:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 3 May 2022 20:37:39 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:37:35 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/26] drm/amd/pm: pp_dpm_* interface for smu_v13_0_7
Date: Tue, 3 May 2022 16:37:04 -0400
Message-ID: <20220503203716.1230313-14-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 96e80d7a-f492-4881-f709-08da2d44c448
X-MS-TrafficTypeDiagnostic: BL1PR12MB5378:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5378016858D0A82C5D736B49F7C09@BL1PR12MB5378.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: htdJw59Z7NThELVwSjgLsx9d2Fdx8DZcQTGWg6hYQyimbNpQaR1isMu6He5pSdh2R89c0pE3ayX8sGWck69yhMR6i3CVP5V1SCLXX0drbi6zf/3Q5/Pk95AkeDgFpPv6LkOcpKpgECb+Jd5rWp5RykFleih7CPrDhMkVDz3nnd5z4OgkYMDaQLm+xXW6L/OQ2HyFrBpLtt9NqEdeEMOyJFxiV/o0eYPUqEEZKiCHT5+YdyTQE4Qa0bzOydaJdQccinQPwo0DqEwMk/CE60EYrX/v5p9t5JzIB6sJIwpXf03foDqlefyhv/i7t0CdKL7J43lCvtRCPrIia6JMQym0gViuNuMT3ctYvgEifsnTm94/IVTYk0gOw3f+glc6J746U1AQVb61/d/2uo/hGN+RVuktzYjZavYQskD+PPztyiFrzyYDm/LC11yK787Bvyl5/k9vrP83oYGPh5GLGvijzKgGvvymh3aHy6S/dUB7KTMpQXGuMH4LZ/HQB0zD8aNBq+H/P4HlUIQLOvsbWBzDTVzXq0qccakkSYf0ueV6MyF2tvyldH1LikWeyjKcuq4Div2PzRRxnz98hZ+4RtY+MyJhvxpsHUV3aeXGi7YeKJiOEVPM7f4i371bBPCt/LknkgiPALn5Wpn6dzZpKWIJ7WVpohUgUjno29h2xuB67HJhBrucFgZ+Q5vO/RZ15dQQiYq9N8Ey1qX5QHTu7QHnZA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(7696005)(336012)(426003)(30864003)(47076005)(26005)(6666004)(36860700001)(86362001)(2906002)(83380400001)(4326008)(8676002)(40460700003)(70206006)(70586007)(54906003)(6916009)(186003)(81166007)(16526019)(36756003)(1076003)(2616005)(508600001)(5660300002)(356005)(316002)(82310400005)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:37:39.8613 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96e80d7a-f492-4881-f709-08da2d44c448
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5378
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
Cc: Alex
 Deucher <alexander.deucher@amd.com>, Kenneth Feng <kenneth.feng@amd.com>,
 Jack Gui <Jack.Gui@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Kenneth Feng <kenneth.feng@amd.com>

add the sysfs pp_dpm_* interface for smu_v13_0_7

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Jack Gui <Jack.Gui@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 756 +++++++++++++++++-
 1 file changed, 743 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index ece0cb276aca..9e5ea20f2342 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -45,6 +45,7 @@
 
 #include "asic_reg/mp/mp_13_0_0_sh_mask.h"
 #include "smu_cmn.h"
+#include "amdgpu_ras.h"
 
 /*
  * DO NOT use these for err/warn/info/debug messages.
@@ -107,6 +108,11 @@ static struct cmn2asic_msg_mapping smu_v13_0_7_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(PowerDownVcn,			PPSMC_MSG_PowerDownVcn,                0),
 	MSG_MAP(PowerUpJpeg,			PPSMC_MSG_PowerUpJpeg,                 0),
 	MSG_MAP(PowerDownJpeg,			PPSMC_MSG_PowerDownJpeg,               0),
+	MSG_MAP(GetDcModeMaxDpmFreq,		PPSMC_MSG_GetDcModeMaxDpmFreq,         1),
+	MSG_MAP(OverridePcieParameters,		PPSMC_MSG_OverridePcieParameters,      0),
+	MSG_MAP(DramLogSetDramAddrHigh,		PPSMC_MSG_DramLogSetDramAddrHigh,      0),
+	MSG_MAP(DramLogSetDramAddrLow,		PPSMC_MSG_DramLogSetDramAddrLow,       0),
+	MSG_MAP(DramLogSetDramSize,		PPSMC_MSG_DramLogSetDramSize,          0),
 };
 
 static struct cmn2asic_mapping smu_v13_0_7_clk_map[SMU_CLK_COUNT] = {
@@ -116,10 +122,21 @@ static struct cmn2asic_mapping smu_v13_0_7_clk_map[SMU_CLK_COUNT] = {
 	CLK_MAP(FCLK,		PPCLK_FCLK),
 	CLK_MAP(UCLK,		PPCLK_UCLK),
 	CLK_MAP(MCLK,		PPCLK_UCLK),
+	CLK_MAP(VCLK,		PPCLK_VCLK_0),
+	CLK_MAP(VCLK1,		PPCLK_VCLK_1),
+	CLK_MAP(DCLK,		PPCLK_DCLK_0),
+	CLK_MAP(DCLK1,		PPCLK_DCLK_1),
 };
 
 static struct cmn2asic_mapping smu_v13_0_7_feature_mask_map[SMU_FEATURE_COUNT] = {
-	FEA_MAP(DPM_GFXCLK),
+	[SMU_FEATURE_DPM_GFXCLK_BIT] = {1, FEATURE_DPM_GFXCLK_BIT},
+	[SMU_FEATURE_DPM_UCLK_BIT] = {1, FEATURE_DPM_UCLK_BIT},
+	[SMU_FEATURE_DPM_FCLK_BIT] = {1, FEATURE_DPM_FCLK_BIT},
+	[SMU_FEATURE_DPM_SOCCLK_BIT] = {1, FEATURE_DPM_SOCCLK_BIT},
+	[SMU_FEATURE_DPM_LINK_BIT] = {1, FEATURE_DPM_LINK_BIT},
+	[SMU_FEATURE_DPM_VCLK_BIT] = {1, FEATURE_MM_DPM_BIT},
+	[SMU_FEATURE_DPM_DCLK_BIT] = {1, FEATURE_MM_DPM_BIT},
+	[SMU_FEATURE_FAN_CONTROL_BIT] = {1, FEATURE_FAN_CONTROL_BIT},
 };
 
 static struct cmn2asic_mapping smu_v13_0_7_table_map[SMU_TABLE_COUNT] = {
@@ -148,6 +165,26 @@ static struct cmn2asic_mapping smu_v13_0_7_workload_map[PP_SMC_POWER_PROFILE_COU
 	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_CUSTOM,		WORKLOAD_PPLIB_CUSTOM_BIT),
 };
 
+static const uint8_t smu_v13_0_7_throttler_map[] = {
+	[THROTTLER_PPT0_BIT]		= (SMU_THROTTLER_PPT0_BIT),
+	[THROTTLER_PPT1_BIT]		= (SMU_THROTTLER_PPT1_BIT),
+	[THROTTLER_PPT2_BIT]		= (SMU_THROTTLER_PPT2_BIT),
+	[THROTTLER_PPT3_BIT]		= (SMU_THROTTLER_PPT3_BIT),
+	[THROTTLER_TDC_GFX_BIT]		= (SMU_THROTTLER_TDC_GFX_BIT),
+	[THROTTLER_TDC_SOC_BIT]		= (SMU_THROTTLER_TDC_SOC_BIT),
+	[THROTTLER_TEMP_EDGE_BIT]	= (SMU_THROTTLER_TEMP_EDGE_BIT),
+	[THROTTLER_TEMP_HOTSPOT_BIT]	= (SMU_THROTTLER_TEMP_HOTSPOT_BIT),
+	[THROTTLER_TEMP_MEM_BIT]	= (SMU_THROTTLER_TEMP_MEM_BIT),
+	[THROTTLER_TEMP_VR_GFX_BIT]	= (SMU_THROTTLER_TEMP_VR_GFX_BIT),
+	[THROTTLER_TEMP_VR_SOC_BIT]	= (SMU_THROTTLER_TEMP_VR_SOC_BIT),
+	[THROTTLER_TEMP_VR_MEM0_BIT]	= (SMU_THROTTLER_TEMP_VR_MEM0_BIT),
+	[THROTTLER_TEMP_VR_MEM1_BIT]	= (SMU_THROTTLER_TEMP_VR_MEM1_BIT),
+	[THROTTLER_TEMP_LIQUID0_BIT]	= (SMU_THROTTLER_TEMP_LIQUID0_BIT),
+	[THROTTLER_TEMP_LIQUID1_BIT]	= (SMU_THROTTLER_TEMP_LIQUID1_BIT),
+	[THROTTLER_GFX_APCC_PLUS_BIT]	= (SMU_THROTTLER_APCC_BIT),
+	[THROTTLER_FIT_BIT]		= (SMU_THROTTLER_FIT_BIT),
+};
+
 static int
 smu_v13_0_7_get_allowed_feature_mask(struct smu_context *smu,
 				  uint32_t *feature_mask, uint32_t num)
@@ -344,7 +381,6 @@ static int smu_v13_0_7_tables_init(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct smu_table *tables = smu_table->tables;
-	struct amdgpu_device *adev = smu->adev;
 
 	SMU_TABLE_INIT(tables, SMU_TABLE_PPTABLE, sizeof(PPTable_t),
 		PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
@@ -370,7 +406,7 @@ static int smu_v13_0_7_tables_init(struct smu_context *smu)
 		goto err0_out;
 	smu_table->metrics_time = 0;
 
-	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_1);
+	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_3);
 	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
 	if (!smu_table->gpu_metrics_table)
 		goto err1_out;
@@ -422,9 +458,10 @@ static int smu_v13_0_7_set_default_dpm_table(struct smu_context *smu)
 {
 	struct smu_13_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
 	PPTable_t *driver_ppt = smu->smu_table.driver_pptable;
-	SkuTable_t *sku_ppt = &driver_ppt->SkuTable;
+	SkuTable_t *skutable = &driver_ppt->SkuTable;
 	struct smu_13_0_dpm_table *dpm_table;
-	struct amdgpu_device *adev = smu->adev;
+	struct smu_13_0_pcie_table *pcie_table;
+	uint32_t link_level;
 	int ret = 0;
 
 	/* socclk dpm table setup */
@@ -435,8 +472,6 @@ static int smu_v13_0_7_set_default_dpm_table(struct smu_context *smu)
 						     dpm_table);
 		if (ret)
 			return ret;
-		dpm_table->is_fine_grained =
-			!sku_ppt->DpmDescriptor[PPCLK_SOCCLK].SnapToDiscrete;
 	} else {
 		dpm_table->count = 1;
 		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.socclk / 100;
@@ -453,8 +488,6 @@ static int smu_v13_0_7_set_default_dpm_table(struct smu_context *smu)
 						     dpm_table);
 		if (ret)
 			return ret;
-		dpm_table->is_fine_grained =
-			!sku_ppt->DpmDescriptor[PPCLK_GFXCLK].SnapToDiscrete;
 	} else {
 		dpm_table->count = 1;
 		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.gfxclk / 100;
@@ -471,8 +504,6 @@ static int smu_v13_0_7_set_default_dpm_table(struct smu_context *smu)
 						     dpm_table);
 		if (ret)
 			return ret;
-		dpm_table->is_fine_grained =
-			!sku_ppt->DpmDescriptor[PPCLK_UCLK].SnapToDiscrete;
 	} else {
 		dpm_table->count = 1;
 		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.uclk / 100;
@@ -481,6 +512,72 @@ static int smu_v13_0_7_set_default_dpm_table(struct smu_context *smu)
 		dpm_table->max = dpm_table->dpm_levels[0].value;
 	}
 
+	/* fclk dpm table setup */
+	dpm_table = &dpm_context->dpm_tables.fclk_table;
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_FCLK_BIT)) {
+		ret = smu_v13_0_set_single_dpm_table(smu,
+						     SMU_FCLK,
+						     dpm_table);
+		if (ret)
+			return ret;
+	} else {
+		dpm_table->count = 1;
+		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.fclk / 100;
+		dpm_table->dpm_levels[0].enabled = true;
+		dpm_table->min = dpm_table->dpm_levels[0].value;
+		dpm_table->max = dpm_table->dpm_levels[0].value;
+	}
+
+	/* vclk dpm table setup */
+	dpm_table = &dpm_context->dpm_tables.vclk_table;
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_VCLK_BIT)) {
+		ret = smu_v13_0_set_single_dpm_table(smu,
+						     SMU_VCLK,
+						     dpm_table);
+		if (ret)
+			return ret;
+	} else {
+		dpm_table->count = 1;
+		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.vclk / 100;
+		dpm_table->dpm_levels[0].enabled = true;
+		dpm_table->min = dpm_table->dpm_levels[0].value;
+		dpm_table->max = dpm_table->dpm_levels[0].value;
+	}
+
+	/* dclk dpm table setup */
+	dpm_table = &dpm_context->dpm_tables.dclk_table;
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_DCLK_BIT)) {
+		ret = smu_v13_0_set_single_dpm_table(smu,
+						     SMU_DCLK,
+						     dpm_table);
+		if (ret)
+			return ret;
+	} else {
+		dpm_table->count = 1;
+		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.dclk / 100;
+		dpm_table->dpm_levels[0].enabled = true;
+		dpm_table->min = dpm_table->dpm_levels[0].value;
+		dpm_table->max = dpm_table->dpm_levels[0].value;
+	}
+
+	/* lclk dpm table setup */
+	pcie_table = &dpm_context->dpm_tables.pcie_table;
+	pcie_table->num_of_link_levels = 0;
+	for (link_level = 0; link_level < NUM_LINK_LEVELS; link_level++) {
+		if (!skutable->PcieGenSpeed[link_level] &&
+		    !skutable->PcieLaneCount[link_level] &&
+		    !skutable->LclkFreq[link_level])
+			continue;
+
+		pcie_table->pcie_gen[pcie_table->num_of_link_levels] =
+					skutable->PcieGenSpeed[link_level];
+		pcie_table->pcie_lane[pcie_table->num_of_link_levels] =
+					skutable->PcieLaneCount[link_level];
+		pcie_table->clk_freq[pcie_table->num_of_link_levels] =
+					skutable->LclkFreq[link_level];
+		pcie_table->num_of_link_levels++;
+	}
+
 	return 0;
 }
 
@@ -509,6 +606,626 @@ static void smu_v13_0_7_dump_pptable(struct smu_context *smu)
        dev_info(smu->adev->dev, "FeaturesToRun[1] = 0x%08x\n", skutable->FeaturesToRun[1]);
 }
 
+static uint32_t smu_v13_0_7_get_throttler_status(SmuMetrics_t *metrics)
+{
+	uint32_t throttler_status = 0;
+	int i;
+
+	for (i = 0; i < THROTTLER_COUNT; i++)
+		throttler_status |=
+			(metrics->ThrottlingPercentage[i] ? 1U << i : 0);
+
+	return throttler_status;
+}
+
+#define SMU_13_0_7_BUSY_THRESHOLD	15
+static int smu_v13_0_7_get_smu_metrics_data(struct smu_context *smu,
+					    MetricsMember_t member,
+					    uint32_t *value)
+{
+	struct smu_table_context *smu_table= &smu->smu_table;
+	SmuMetrics_t *metrics =
+		&(((SmuMetricsExternal_t *)(smu_table->metrics_table))->SmuMetrics);
+	int ret = 0;
+
+	ret = smu_cmn_get_metrics_table(smu,
+					NULL,
+					false);
+	if (ret)
+		return ret;
+
+	switch (member) {
+	case METRICS_CURR_GFXCLK:
+		*value = metrics->CurrClock[PPCLK_GFXCLK];
+		break;
+	case METRICS_CURR_SOCCLK:
+		*value = metrics->CurrClock[PPCLK_SOCCLK];
+		break;
+	case METRICS_CURR_UCLK:
+		*value = metrics->CurrClock[PPCLK_UCLK];
+		break;
+	case METRICS_CURR_VCLK:
+		*value = metrics->CurrClock[PPCLK_VCLK_0];
+		break;
+	case METRICS_CURR_VCLK1:
+		*value = metrics->CurrClock[PPCLK_VCLK_1];
+		break;
+	case METRICS_CURR_DCLK:
+		*value = metrics->CurrClock[PPCLK_DCLK_0];
+		break;
+	case METRICS_CURR_DCLK1:
+		*value = metrics->CurrClock[PPCLK_DCLK_1];
+		break;
+	case METRICS_CURR_FCLK:
+		*value = metrics->CurrClock[PPCLK_FCLK];
+		break;
+	case METRICS_AVERAGE_GFXCLK:
+		if (metrics->AverageGfxActivity <= SMU_13_0_7_BUSY_THRESHOLD)
+			*value = metrics->AverageGfxclkFrequencyPostDs;
+		else
+			*value = metrics->AverageGfxclkFrequencyPreDs;
+		break;
+	case METRICS_AVERAGE_FCLK:
+		if (metrics->AverageUclkActivity <= SMU_13_0_7_BUSY_THRESHOLD)
+			*value = metrics->AverageFclkFrequencyPostDs;
+		else
+			*value = metrics->AverageFclkFrequencyPreDs;
+		break;
+	case METRICS_AVERAGE_UCLK:
+		if (metrics->AverageUclkActivity <= SMU_13_0_7_BUSY_THRESHOLD)
+			*value = metrics->AverageMemclkFrequencyPostDs;
+		else
+			*value = metrics->AverageMemclkFrequencyPreDs;
+		break;
+	case METRICS_AVERAGE_VCLK:
+		*value = metrics->AverageVclk0Frequency;
+		break;
+	case METRICS_AVERAGE_DCLK:
+		*value = metrics->AverageDclk0Frequency;
+		break;
+	case METRICS_AVERAGE_VCLK1:
+		*value = metrics->AverageVclk1Frequency;
+		break;
+	case METRICS_AVERAGE_DCLK1:
+		*value = metrics->AverageDclk1Frequency;
+		break;
+	case METRICS_AVERAGE_GFXACTIVITY:
+		*value = metrics->AverageGfxActivity;
+		break;
+	case METRICS_AVERAGE_MEMACTIVITY:
+		*value = metrics->AverageUclkActivity;
+		break;
+	case METRICS_AVERAGE_SOCKETPOWER:
+		*value = metrics->AverageSocketPower << 8;
+		break;
+	case METRICS_TEMPERATURE_EDGE:
+		*value = metrics->AvgTemperature[TEMP_EDGE] *
+			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		break;
+	case METRICS_TEMPERATURE_HOTSPOT:
+		*value = metrics->AvgTemperature[TEMP_HOTSPOT] *
+			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		break;
+	case METRICS_TEMPERATURE_MEM:
+		*value = metrics->AvgTemperature[TEMP_MEM] *
+			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		break;
+	case METRICS_TEMPERATURE_VRGFX:
+		*value = metrics->AvgTemperature[TEMP_VR_GFX] *
+			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		break;
+	case METRICS_TEMPERATURE_VRSOC:
+		*value = metrics->AvgTemperature[TEMP_VR_SOC] *
+			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		break;
+	case METRICS_THROTTLER_STATUS:
+		*value = smu_v13_0_7_get_throttler_status(metrics);
+		break;
+	case METRICS_CURR_FANSPEED:
+		*value = metrics->AvgFanRpm;
+		break;
+	case METRICS_CURR_FANPWM:
+		*value = metrics->AvgFanPwm;
+		break;
+	case METRICS_VOLTAGE_VDDGFX:
+		*value = metrics->AvgVoltage[SVI_PLANE_GFX];
+		break;
+	case METRICS_PCIE_RATE:
+		*value = metrics->PcieRate;
+		break;
+	case METRICS_PCIE_WIDTH:
+		*value = metrics->PcieWidth;
+		break;
+	default:
+		*value = UINT_MAX;
+		break;
+	}
+
+	return ret;
+}
+
+static int smu_v13_0_7_read_sensor(struct smu_context *smu,
+				   enum amd_pp_sensors sensor,
+				   void *data,
+				   uint32_t *size)
+{
+	struct smu_table_context *table_context = &smu->smu_table;
+	PPTable_t *smc_pptable = table_context->driver_pptable;
+	int ret = 0;
+
+	switch (sensor) {
+	case AMDGPU_PP_SENSOR_MAX_FAN_RPM:
+		*(uint16_t *)data = smc_pptable->SkuTable.FanMaximumRpm;
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_MEM_LOAD:
+		ret = smu_v13_0_7_get_smu_metrics_data(smu,
+						       METRICS_AVERAGE_MEMACTIVITY,
+						       (uint32_t *)data);
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_GPU_LOAD:
+		ret = smu_v13_0_7_get_smu_metrics_data(smu,
+						       METRICS_AVERAGE_GFXACTIVITY,
+						       (uint32_t *)data);
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_GPU_POWER:
+		ret = smu_v13_0_7_get_smu_metrics_data(smu,
+						       METRICS_AVERAGE_SOCKETPOWER,
+						       (uint32_t *)data);
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_HOTSPOT_TEMP:
+		ret = smu_v13_0_7_get_smu_metrics_data(smu,
+						       METRICS_TEMPERATURE_HOTSPOT,
+						       (uint32_t *)data);
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_EDGE_TEMP:
+		ret = smu_v13_0_7_get_smu_metrics_data(smu,
+						       METRICS_TEMPERATURE_EDGE,
+						       (uint32_t *)data);
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_MEM_TEMP:
+		ret = smu_v13_0_7_get_smu_metrics_data(smu,
+						       METRICS_TEMPERATURE_MEM,
+						       (uint32_t *)data);
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_GFX_MCLK:
+		ret = smu_v13_0_7_get_smu_metrics_data(smu,
+						       METRICS_AVERAGE_UCLK,
+						       (uint32_t *)data);
+		*(uint32_t *)data *= 100;
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_GFX_SCLK:
+		ret = smu_v13_0_7_get_smu_metrics_data(smu,
+						       METRICS_AVERAGE_GFXCLK,
+						       (uint32_t *)data);
+		*(uint32_t *)data *= 100;
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_VDDGFX:
+		ret = smu_v13_0_7_get_smu_metrics_data(smu,
+						       METRICS_VOLTAGE_VDDGFX,
+						       (uint32_t *)data);
+		*size = 4;
+		break;
+	default:
+		ret = -EOPNOTSUPP;
+		break;
+	}
+
+	return ret;
+}
+
+static int smu_v13_0_7_get_current_clk_freq_by_table(struct smu_context *smu,
+						     enum smu_clk_type clk_type,
+						     uint32_t *value)
+{
+	MetricsMember_t member_type;
+	int clk_id = 0;
+
+	clk_id = smu_cmn_to_asic_specific_index(smu,
+						CMN2ASIC_MAPPING_CLK,
+						clk_type);
+	if (clk_id < 0)
+		return -EINVAL;
+
+	switch (clk_id) {
+	case PPCLK_GFXCLK:
+		member_type = METRICS_CURR_GFXCLK;
+		break;
+	case PPCLK_UCLK:
+		member_type = METRICS_CURR_UCLK;
+		break;
+	case PPCLK_FCLK:
+		member_type = METRICS_CURR_FCLK;
+		break;
+	case PPCLK_SOCCLK:
+		member_type = METRICS_CURR_SOCCLK;
+		break;
+	case PPCLK_VCLK_0:
+		member_type = METRICS_CURR_VCLK;
+		break;
+	case PPCLK_DCLK_0:
+		member_type = METRICS_CURR_DCLK;
+		break;
+	case PPCLK_VCLK_1:
+		member_type = METRICS_CURR_VCLK1;
+		break;
+	case PPCLK_DCLK_1:
+		member_type = METRICS_CURR_DCLK1;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return smu_v13_0_7_get_smu_metrics_data(smu,
+						member_type,
+						value);
+}
+
+static int smu_v13_0_7_print_clk_levels(struct smu_context *smu,
+					enum smu_clk_type clk_type,
+					char *buf)
+{
+	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
+	struct smu_13_0_dpm_context *dpm_context = smu_dpm->dpm_context;
+	struct smu_13_0_dpm_table *single_dpm_table;
+	struct smu_13_0_pcie_table *pcie_table;
+	uint32_t gen_speed, lane_width;
+	int i, curr_freq, size = 0;
+	int ret = 0;
+
+	smu_cmn_get_sysfs_buf(&buf, &size);
+
+	if (amdgpu_ras_intr_triggered()) {
+		size += sysfs_emit_at(buf, size, "unavailable\n");
+		return size;
+	}
+
+	switch (clk_type) {
+	case SMU_SCLK:
+		single_dpm_table = &(dpm_context->dpm_tables.gfx_table);
+		break;
+	case SMU_MCLK:
+		single_dpm_table = &(dpm_context->dpm_tables.uclk_table);
+		break;
+	case SMU_SOCCLK:
+		single_dpm_table = &(dpm_context->dpm_tables.soc_table);
+		break;
+	case SMU_FCLK:
+		single_dpm_table = &(dpm_context->dpm_tables.fclk_table);
+		break;
+	case SMU_VCLK:
+	case SMU_VCLK1:
+		single_dpm_table = &(dpm_context->dpm_tables.vclk_table);
+		break;
+	case SMU_DCLK:
+	case SMU_DCLK1:
+		single_dpm_table = &(dpm_context->dpm_tables.dclk_table);
+		break;
+	default:
+		break;
+	}
+
+	switch (clk_type) {
+	case SMU_SCLK:
+	case SMU_MCLK:
+	case SMU_SOCCLK:
+	case SMU_FCLK:
+	case SMU_VCLK:
+	case SMU_VCLK1:
+	case SMU_DCLK:
+	case SMU_DCLK1:
+		ret = smu_v13_0_7_get_current_clk_freq_by_table(smu, clk_type, &curr_freq);
+		if (ret) {
+			dev_err(smu->adev->dev, "Failed to get current clock freq!");
+			return ret;
+		}
+
+		if (single_dpm_table->is_fine_grained) {
+			/*
+			 * For fine grained dpms, there are only two dpm levels:
+			 *   - level 0 -> min clock freq
+			 *   - level 1 -> max clock freq
+			 * And the current clock frequency can be any value between them.
+			 * So, if the current clock frequency is not at level 0 or level 1,
+			 * we will fake it as three dpm levels:
+			 *   - level 0 -> min clock freq
+			 *   - level 1 -> current actual clock freq
+			 *   - level 2 -> max clock freq
+			 */
+			if ((single_dpm_table->dpm_levels[0].value != curr_freq) &&
+			     (single_dpm_table->dpm_levels[1].value != curr_freq)) {
+				size += sysfs_emit_at(buf, size, "0: %uMhz\n",
+						single_dpm_table->dpm_levels[0].value);
+				size += sysfs_emit_at(buf, size, "1: %uMhz *\n",
+						curr_freq);
+				size += sysfs_emit_at(buf, size, "2: %uMhz\n",
+						single_dpm_table->dpm_levels[1].value);
+			} else {
+				size += sysfs_emit_at(buf, size, "0: %uMhz %s\n",
+						single_dpm_table->dpm_levels[0].value,
+						single_dpm_table->dpm_levels[0].value == curr_freq ? "*" : "");
+				size += sysfs_emit_at(buf, size, "1: %uMhz %s\n",
+						single_dpm_table->dpm_levels[1].value,
+						single_dpm_table->dpm_levels[1].value == curr_freq ? "*" : "");
+			}
+		} else {
+			for (i = 0; i < single_dpm_table->count; i++)
+				size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
+						i, single_dpm_table->dpm_levels[i].value,
+						single_dpm_table->dpm_levels[i].value == curr_freq ? "*" : "");
+		}
+		break;
+	case SMU_PCIE:
+		ret = smu_v13_0_7_get_smu_metrics_data(smu,
+						       METRICS_PCIE_RATE,
+						       &gen_speed);
+		if (ret)
+			return ret;
+
+		ret = smu_v13_0_7_get_smu_metrics_data(smu,
+						       METRICS_PCIE_WIDTH,
+						       &lane_width);
+		if (ret)
+			return ret;
+
+		pcie_table = &(dpm_context->dpm_tables.pcie_table);
+		for (i = 0; i < pcie_table->num_of_link_levels; i++)
+			size += sysfs_emit_at(buf, size, "%d: %s %s %dMhz %s\n", i,
+					(pcie_table->pcie_gen[i] == 0) ? "2.5GT/s," :
+					(pcie_table->pcie_gen[i] == 1) ? "5.0GT/s," :
+					(pcie_table->pcie_gen[i] == 2) ? "8.0GT/s," :
+					(pcie_table->pcie_gen[i] == 3) ? "16.0GT/s," : "",
+					(pcie_table->pcie_lane[i] == 1) ? "x1" :
+					(pcie_table->pcie_lane[i] == 2) ? "x2" :
+					(pcie_table->pcie_lane[i] == 3) ? "x4" :
+					(pcie_table->pcie_lane[i] == 4) ? "x8" :
+					(pcie_table->pcie_lane[i] == 5) ? "x12" :
+					(pcie_table->pcie_lane[i] == 6) ? "x16" : "",
+					pcie_table->clk_freq[i],
+					(gen_speed == pcie_table->pcie_gen[i]) &&
+					(lane_width == pcie_table->pcie_lane[i]) ?
+					"*" : "");
+		break;
+
+	default:
+		break;
+	}
+
+	return size;
+}
+
+static int smu_v13_0_7_force_clk_levels(struct smu_context *smu,
+					enum smu_clk_type clk_type,
+					uint32_t mask)
+{
+	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
+	struct smu_13_0_dpm_context *dpm_context = smu_dpm->dpm_context;
+	struct smu_13_0_dpm_table *single_dpm_table;
+	uint32_t soft_min_level, soft_max_level;
+	uint32_t min_freq, max_freq;
+	int ret = 0;
+
+	soft_min_level = mask ? (ffs(mask) - 1) : 0;
+	soft_max_level = mask ? (fls(mask) - 1) : 0;
+
+	switch (clk_type) {
+	case SMU_GFXCLK:
+	case SMU_SCLK:
+		single_dpm_table = &(dpm_context->dpm_tables.gfx_table);
+		break;
+	case SMU_MCLK:
+	case SMU_UCLK:
+		single_dpm_table = &(dpm_context->dpm_tables.uclk_table);
+		break;
+	case SMU_SOCCLK:
+		single_dpm_table = &(dpm_context->dpm_tables.soc_table);
+		break;
+	case SMU_FCLK:
+		single_dpm_table = &(dpm_context->dpm_tables.fclk_table);
+		break;
+	case SMU_VCLK:
+	case SMU_VCLK1:
+		single_dpm_table = &(dpm_context->dpm_tables.vclk_table);
+		break;
+	case SMU_DCLK:
+	case SMU_DCLK1:
+		single_dpm_table = &(dpm_context->dpm_tables.dclk_table);
+		break;
+	default:
+		break;
+	}
+
+	switch (clk_type) {
+	case SMU_GFXCLK:
+	case SMU_SCLK:
+	case SMU_MCLK:
+	case SMU_UCLK:
+	case SMU_SOCCLK:
+	case SMU_FCLK:
+	case SMU_VCLK:
+	case SMU_VCLK1:
+	case SMU_DCLK:
+	case SMU_DCLK1:
+		if (single_dpm_table->is_fine_grained) {
+			/* There is only 2 levels for fine grained DPM */
+			soft_max_level = (soft_max_level >= 1 ? 1 : 0);
+			soft_min_level = (soft_min_level >= 1 ? 1 : 0);
+		} else {
+			if ((soft_max_level >= single_dpm_table->count) ||
+			    (soft_min_level >= single_dpm_table->count))
+				return -EINVAL;
+		}
+
+		min_freq = single_dpm_table->dpm_levels[soft_min_level].value;
+		max_freq = single_dpm_table->dpm_levels[soft_max_level].value;
+
+		ret = smu_v13_0_set_soft_freq_limited_range(smu,
+							    clk_type,
+							    min_freq,
+							    max_freq);
+		break;
+	case SMU_DCEFCLK:
+	case SMU_PCIE:
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+static int smu_v13_0_7_update_pcie_parameters(struct smu_context *smu,
+					      uint32_t pcie_gen_cap,
+					      uint32_t pcie_width_cap)
+{
+	struct smu_13_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
+	struct smu_13_0_pcie_table *pcie_table =
+				&dpm_context->dpm_tables.pcie_table;
+	uint32_t smu_pcie_arg;
+	int ret, i;
+
+	for (i = 0; i < pcie_table->num_of_link_levels; i++) {
+		if (pcie_table->pcie_gen[i] > pcie_gen_cap)
+			pcie_table->pcie_gen[i] = pcie_gen_cap;
+		if (pcie_table->pcie_lane[i] > pcie_width_cap)
+			pcie_table->pcie_lane[i] = pcie_width_cap;
+
+		smu_pcie_arg = i << 16;
+		smu_pcie_arg |= pcie_table->pcie_gen[i] << 8;
+		smu_pcie_arg |= pcie_table->pcie_lane[i];
+
+		ret = smu_cmn_send_smc_msg_with_param(smu,
+						      SMU_MSG_OverridePcieParameters,
+						      smu_pcie_arg,
+						      NULL);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static const struct smu_temperature_range smu13_thermal_policy[] =
+{
+	{-273150,  99000, 99000, -273150, 99000, 99000, -273150, 99000, 99000},
+	{ 120000, 120000, 120000, 120000, 120000, 120000, 120000, 120000, 120000},
+};
+
+static int smu_v13_0_7_get_thermal_temperature_range(struct smu_context *smu,
+						     struct smu_temperature_range *range)
+{
+	struct smu_table_context *table_context = &smu->smu_table;
+	struct smu_13_0_7_powerplay_table *powerplay_table =
+		table_context->power_play_table;
+	PPTable_t *pptable = smu->smu_table.driver_pptable;
+
+	if (!range)
+		return -EINVAL;
+
+	memcpy(range, &smu13_thermal_policy[0], sizeof(struct smu_temperature_range));
+
+	range->max = pptable->SkuTable.TemperatureLimit[TEMP_EDGE] *
+		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+	range->edge_emergency_max = (pptable->SkuTable.TemperatureLimit[TEMP_EDGE] + CTF_OFFSET_EDGE) *
+		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+	range->hotspot_crit_max = pptable->SkuTable.TemperatureLimit[TEMP_HOTSPOT] *
+		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+	range->hotspot_emergency_max = (pptable->SkuTable.TemperatureLimit[TEMP_HOTSPOT] + CTF_OFFSET_HOTSPOT) *
+		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+	range->mem_crit_max = pptable->SkuTable.TemperatureLimit[TEMP_MEM] *
+		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+	range->mem_emergency_max = (pptable->SkuTable.TemperatureLimit[TEMP_MEM] + CTF_OFFSET_MEM)*
+		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+	range->software_shutdown_temp = powerplay_table->software_shutdown_temp;
+
+	return 0;
+}
+
+#define MAX(a, b)	((a) > (b) ? (a) : (b))
+static ssize_t smu_v13_0_7_get_gpu_metrics(struct smu_context *smu,
+					   void **table)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	struct gpu_metrics_v1_3 *gpu_metrics =
+		(struct gpu_metrics_v1_3 *)smu_table->gpu_metrics_table;
+	SmuMetricsExternal_t metrics_ext;
+	SmuMetrics_t *metrics = &metrics_ext.SmuMetrics;
+	int ret = 0;
+
+	ret = smu_cmn_get_metrics_table(smu,
+					&metrics_ext,
+					true);
+	if (ret)
+		return ret;
+
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
+
+	gpu_metrics->temperature_edge = metrics->AvgTemperature[TEMP_EDGE];
+	gpu_metrics->temperature_hotspot = metrics->AvgTemperature[TEMP_HOTSPOT];
+	gpu_metrics->temperature_mem = metrics->AvgTemperature[TEMP_MEM];
+	gpu_metrics->temperature_vrgfx = metrics->AvgTemperature[TEMP_VR_GFX];
+	gpu_metrics->temperature_vrsoc = metrics->AvgTemperature[TEMP_VR_SOC];
+	gpu_metrics->temperature_vrmem = MAX(metrics->AvgTemperature[TEMP_VR_MEM0],
+					     metrics->AvgTemperature[TEMP_VR_MEM1]);
+
+	gpu_metrics->average_gfx_activity = metrics->AverageGfxActivity;
+	gpu_metrics->average_umc_activity = metrics->AverageUclkActivity;
+	gpu_metrics->average_mm_activity = MAX(metrics->Vcn0ActivityPercentage,
+					       metrics->Vcn1ActivityPercentage);
+
+	gpu_metrics->average_socket_power = metrics->AverageSocketPower;
+	gpu_metrics->energy_accumulator = metrics->EnergyAccumulator;
+
+	if (metrics->AverageGfxActivity <= SMU_13_0_7_BUSY_THRESHOLD)
+		gpu_metrics->average_gfxclk_frequency = metrics->AverageGfxclkFrequencyPostDs;
+	else
+		gpu_metrics->average_gfxclk_frequency = metrics->AverageGfxclkFrequencyPreDs;
+
+	if (metrics->AverageUclkActivity <= SMU_13_0_7_BUSY_THRESHOLD)
+		gpu_metrics->average_uclk_frequency = metrics->AverageMemclkFrequencyPostDs;
+	else
+		gpu_metrics->average_uclk_frequency = metrics->AverageMemclkFrequencyPreDs;
+
+	gpu_metrics->average_vclk0_frequency = metrics->AverageVclk0Frequency;
+	gpu_metrics->average_dclk0_frequency = metrics->AverageDclk0Frequency;
+	gpu_metrics->average_vclk1_frequency = metrics->AverageVclk1Frequency;
+	gpu_metrics->average_dclk1_frequency = metrics->AverageDclk1Frequency;
+
+	gpu_metrics->current_gfxclk = metrics->CurrClock[PPCLK_GFXCLK];
+	gpu_metrics->current_vclk0 = metrics->CurrClock[PPCLK_VCLK_0];
+	gpu_metrics->current_dclk0 = metrics->CurrClock[PPCLK_DCLK_0];
+	gpu_metrics->current_vclk1 = metrics->CurrClock[PPCLK_VCLK_1];
+	gpu_metrics->current_dclk1 = metrics->CurrClock[PPCLK_DCLK_1];
+
+	gpu_metrics->throttle_status =
+			smu_v13_0_7_get_throttler_status(metrics);
+	gpu_metrics->indep_throttle_status =
+			smu_cmn_get_indep_throttler_status(gpu_metrics->throttle_status,
+							   smu_v13_0_7_throttler_map);
+
+	gpu_metrics->current_fan_speed = metrics->AvgFanRpm;
+
+	gpu_metrics->pcie_link_width = metrics->PcieWidth;
+	gpu_metrics->pcie_link_speed = metrics->PcieRate;
+
+	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
+
+	gpu_metrics->voltage_gfx = metrics->AvgVoltage[SVI_PLANE_GFX];
+	gpu_metrics->voltage_soc = metrics->AvgVoltage[SVI_PLANE_SOC];
+	gpu_metrics->voltage_mem = metrics->AvgVoltage[SVI_PLANE_VMEMP];
+
+	*table = (void *)gpu_metrics;
+
+	return sizeof(struct gpu_metrics_v1_3);
+}
+
 static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.get_allowed_feature_mask = smu_v13_0_7_get_allowed_feature_mask,
 	.set_default_dpm_table = smu_v13_0_7_set_default_dpm_table,
@@ -529,12 +1246,25 @@ static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.dpm_set_vcn_enable = smu_v13_0_set_vcn_enable,
 	.dpm_set_jpeg_enable = smu_v13_0_set_jpeg_enable,
 	.init_pptable_microcode = smu_v13_0_init_pptable_microcode,
+	.get_dpm_ultimate_freq = smu_v13_0_get_dpm_ultimate_freq,
+	.get_vbios_bootup_values = smu_v13_0_get_vbios_bootup_values,
+	.read_sensor = smu_v13_0_7_read_sensor,
+	.feature_is_enabled = smu_cmn_feature_is_enabled,
+	.print_clk_levels = smu_v13_0_7_print_clk_levels,
+	.force_clk_levels = smu_v13_0_7_force_clk_levels,
+	.update_pcie_parameters = smu_v13_0_7_update_pcie_parameters,
+	.get_thermal_temperature_range = smu_v13_0_7_get_thermal_temperature_range,
+	.register_irq_handler = smu_v13_0_register_irq_handler,
+	.enable_thermal_alert = smu_v13_0_enable_thermal_alert,
+	.disable_thermal_alert = smu_v13_0_disable_thermal_alert,
+	.notify_memory_pool_location = smu_v13_0_notify_memory_pool_location,
+	.get_gpu_metrics = smu_v13_0_7_get_gpu_metrics,
+	.set_soft_freq_limited_range = smu_v13_0_set_soft_freq_limited_range,
+	.set_performance_level = smu_v13_0_set_performance_level,
 };
 
 void smu_v13_0_7_set_ppt_funcs(struct smu_context *smu)
 {
-	struct amdgpu_device *adev = smu->adev;
-
 	smu->ppt_funcs = &smu_v13_0_7_ppt_funcs;
 	smu->message_map = smu_v13_0_7_message_map;
 	smu->clock_map = smu_v13_0_7_clk_map;
-- 
2.35.1

