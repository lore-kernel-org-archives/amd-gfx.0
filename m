Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE8C3C71157
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Jun 2025 15:55:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F02F10E8C6;
	Wed, 18 Jun 2025 15:55:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QE4sqL/a";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E2E210E8C8
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jun 2025 15:55:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uo0e7AvG2ODpSfjBCOViKULN9PQz9FpGMcWIoHAsyJRHUKXA+anoKDw3fKs/GR1p92oz3kw5GzLc09pUvVWAIXa9ZXA05jbEZw0Y95eALBkrMRwDuEJqG4kG1Y+/3awjiVFRNjAc32Mo4EM0VvMCiE8kzsd46n316UDehIrq2KbmUknnVblJVYV98awOilET0/U/H7h0t3ic2KG+2DJuD4iqzxL7GNJxCbE+gKvqeymxjiQxwItPJ0Mp5I0xvZfFfOjretBjgQv4A2NBvWxtgOw43RLea2J44FBp+bEtTCCQa5Ppjo2UeD3yIUJ48pR0/QZBQJi98zAU+JNO3vHoog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MlLh4v+9oSlY90uiyOpWyDvccV7KNoGreEWmFN/YW6c=;
 b=f7GoUp5k2JnmGMj8aavqiPxXf8Nx3XHoyDqzrCUURJozHQz3H39W4NqZv0cbIbHBBwNj6JJ91cBZcf7DMHWMC/dk8Z+9OSHsjGPurnbtEz91ZTQIRvvSzzkMG7AZOYUMtT/7/J+ySGImlUxqm2p/P6QXv4PkgWfNescgVrd4VGfY8ASmZKqbQ4ssAeOYlY4RI8m8bfYF4ju09nRn6RTLIdyNV7oh5lQToE1QfKvL5BIVWaC1cpnJJWYEH+sZ+gidDEuct/Q3pI8CcSMSVP3gVc/fepNldgTxFmW9aOrRNxqQW8Z4/cvN4obBX6tOmOXdSgV5m7wCRXBuZHMcmz5wTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MlLh4v+9oSlY90uiyOpWyDvccV7KNoGreEWmFN/YW6c=;
 b=QE4sqL/ardsq+5OSGFFHnxgfjCql3GKpzbLygk4UPV6cfFof78LBMgf6ce/ySNGgp1+qIJSptPi08Z5RRhJJLwf4mybLA8xa+ZVvYZL+HmUKZL1pjw7TzmZVUxJGfF/xzgFiTxl5JDv+UbKIEsHvOBLgDcb9CCxlpN70J0rogfA=
Received: from BN0PR07CA0003.namprd07.prod.outlook.com (2603:10b6:408:141::15)
 by MN2PR12MB4128.namprd12.prod.outlook.com (2603:10b6:208:1dd::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Wed, 18 Jun
 2025 15:55:10 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:408:141:cafe::96) by BN0PR07CA0003.outlook.office365.com
 (2603:10b6:408:141::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.19 via Frontend Transport; Wed,
 18 Jun 2025 15:55:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8857.21 via Frontend Transport; Wed, 18 Jun 2025 15:55:10 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Jun
 2025 10:54:59 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Jun
 2025 10:54:59 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 18 Jun 2025 10:54:59 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Austin Zheng
 <Austin.Zheng@amd.com>, Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 09/13] drm/amd/display: DML21 Reintegration
Date: Wed, 18 Jun 2025 11:33:57 -0400
Message-ID: <20250618153936.6472-10-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250618153936.6472-1-Jerry.Zuo@amd.com>
References: <20250618153936.6472-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|MN2PR12MB4128:EE_
X-MS-Office365-Filtering-Correlation-Id: 061283aa-b880-43e9-da59-08ddae808155
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5iTQIHihAq93jk9KRiwMwhF2/iAAjir0OcDgC3tatuU3BmkT+pwOsnbSU+s2?=
 =?us-ascii?Q?6sv/Dwtb9FJLJHFpPM++uc3O4cAVBWh2XQQwMwFKpatwZJGVJsXYAcXltPCN?=
 =?us-ascii?Q?eRufmeSmjbXEXJk6vFLPlChZTTCGzwnC89zZTlhtn6b7eFGICpoS4g5bGfYc?=
 =?us-ascii?Q?XnlNXDBOVH4m8xjblNN7Z5aLaM5rOptdfECexK1a8gc7ON8T2RhSj5w9DmEX?=
 =?us-ascii?Q?+iyqhZpta+weckiPoiFLiMIdtRBRFlxP0s3bknVcH0f2xiEBCghX4cHam9fH?=
 =?us-ascii?Q?pybDmLR0Q1dBSTnDSCDZ3V9MP6g8iniGG0/Vd2JziLeO6K/jrpHGURu0aFFz?=
 =?us-ascii?Q?9fZTRiORKpHAu0AAX7h6dTG2HG06m/5eCnykQ8+LqxR/UZyUrKx/N9ISyVU/?=
 =?us-ascii?Q?Hc+MDahNgtpPOyxBO8J0BAGzcujaAAn9yKC7NpG7XO7M2wbPzzLrXY67ShTL?=
 =?us-ascii?Q?xJUuL04BltKyyw1D2tpqA1B3D7Vv6Py2v+jd2P6ojo5BQ9LG8Ky0fImKvk4K?=
 =?us-ascii?Q?RqbiUleBL+IXjDssoOfT8JlWsoZjsNq9RWvpeF459CsiaxX8ikqEGsA/8peQ?=
 =?us-ascii?Q?KOc7sGK5o7K0dxE3oZf6QH//qJ+e4bCvfxFeQQklBOjUY9s1CvN5tjXoeAW3?=
 =?us-ascii?Q?tMplvzKFp3leR3DRx/rWAeTBwBgPFfnOYtpNYlzYE4oX/o/9y/MV194vZQRe?=
 =?us-ascii?Q?6Rd1kx2by0RkqnsjBjDUUcv1oRyTUaUe/MZ2Pcuj8U3fY5u9DziTk8ZQ+3q/?=
 =?us-ascii?Q?9nX5ZrWl7ZIHdGLcka9E94ro6ho9ZtsPoOYP0iC6DEyx6fy6gNnv706GvK2D?=
 =?us-ascii?Q?C4UatwkI1RVCh0uUIgbkFt5na6HBY22fIT6sCm2kOxip6Uj5NVK2EGMXALFS?=
 =?us-ascii?Q?Ywxv3YjKmOZ6XG4vfzp9H6/sKnRk6EK/k+itcFCpkZUeBIgEIOyXaL7Ac5o3?=
 =?us-ascii?Q?IguYRBzvhTcLvTFsyhv9/UrVs5m65qhNYV4HZf9aETNQS3J1OCUDzujLyFFB?=
 =?us-ascii?Q?Db+vYIY3i7RXRw4S9VAyM49F7CGOoHIoJK6H0u8/YLswN+/v+6wdqhEEZbnM?=
 =?us-ascii?Q?8L8hnme7zPefZrg1zXbKBHxoDqIMibrzEhZ7nVKKuKrROIyDjPvx9DqT6qQR?=
 =?us-ascii?Q?/l9EwaR6Q1Sl2maCOXaiRgUvu0XlMoPbXe2izg+Y8mcZo19/n1DPvsKyYX8j?=
 =?us-ascii?Q?M/csR/lcQ5eEJyg3+NF5K0nD5E93LvoKpvDCUX4MMbtY1lDS31AoHVxOxkNk?=
 =?us-ascii?Q?adOVsE+Ul7djox19IPYfiygx3AwWe+aWIg3ydYhKO0szB7LmrW2grKqxzAJK?=
 =?us-ascii?Q?DI1KgDnFZPtsN0BpIOh+XqH6lGkXB1c1yXbCraMqYzwXVF4vLVT+NnU9jN6B?=
 =?us-ascii?Q?4XJF3aGOzxtSLxlH4galmJzNOZE5X/NG6Knhc/4bYlQchtvPxhtVGFYwlmH0?=
 =?us-ascii?Q?1+rD9rWOwnxCFurmm4GtS1Zaw+jQexwAaokI4b5zpmwjXSWXCWXY76uFyrrY?=
 =?us-ascii?Q?WQk/khbmJVBfFpCDJKms4cdAwlmqX6QYSzAX?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 15:55:10.5064 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 061283aa-b880-43e9-da59-08ddae808155
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4128
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

From: Austin Zheng <Austin.Zheng@amd.com>

Update logging macros for detailed debugging
Update structs to contain more detailed information
Add HDMI 16 and 20 Gbps rates

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 .../dml2/dml21/inc/dml_top_dchub_registers.h  |   1 +
 .../dml21/inc/dml_top_display_cfg_types.h     |   2 +
 .../dml21/inc/dml_top_soc_parameter_types.h   |   1 +
 .../display/dc/dml2/dml21/inc/dml_top_types.h |   4 +-
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |   4 +
 .../src/dml2_core/dml2_core_shared_types.h    |  83 +++++++++-
 .../dc/dml2/dml21/src/inc/dml2_debug.h        | 149 ++++++++++++++++--
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  28 +++-
 8 files changed, 248 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_dchub_registers.h b/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_dchub_registers.h
index 84c90050668c..b05030926ce8 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_dchub_registers.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_dchub_registers.h
@@ -46,6 +46,7 @@ struct dml2_display_dlg_regs {
 	uint32_t dst_y_delta_drq_limit;
 	uint32_t refcyc_per_vm_dmdata;
 	uint32_t dmdata_dl_delta;
+	uint32_t dst_y_svp_drq_limit;
 
 	// MRQ
 	uint32_t refcyc_per_meta_chunk_vblank_l;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_display_cfg_types.h b/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_display_cfg_types.h
index 255f05de362c..e8dc6471c0be 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_display_cfg_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_display_cfg_types.h
@@ -222,6 +222,7 @@ struct dml2_composition_cfg {
 
 	struct {
 		bool enabled;
+		bool upsp_enabled;
 		struct {
 			double h_ratio;
 			double v_ratio;
@@ -426,6 +427,7 @@ struct dml2_stream_parameters {
 
 struct dml2_display_cfg {
 	bool gpuvm_enable;
+	bool ffbm_enable;
 	bool hostvm_enable;
 
 	// Allocate DET proportionally between streams based on pixel rate
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_soc_parameter_types.h b/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_soc_parameter_types.h
index 1f5eaf79a8d1..8c9f414aa6bf 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_soc_parameter_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_soc_parameter_types.h
@@ -93,6 +93,7 @@ struct dml2_soc_power_management_parameters {
 	double dram_clk_change_write_only_us;
 	double fclk_change_blackout_us;
 	double g7_ppt_blackout_us;
+	double g7_temperature_read_blackout_us;
 	double stutter_enter_plus_exit_latency_us;
 	double stutter_exit_latency_us;
 	double z8_stutter_enter_plus_exit_latency_us;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_types.h b/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_types.h
index bcb99a155011..98c0234e2f47 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_types.h
@@ -53,7 +53,9 @@ enum dml2_output_type_and_rate__rate {
 	dml2_output_rate_hdmi_rate_6x4 = 9,
 	dml2_output_rate_hdmi_rate_8x4 = 10,
 	dml2_output_rate_hdmi_rate_10x4 = 11,
-	dml2_output_rate_hdmi_rate_12x4 = 12
+	dml2_output_rate_hdmi_rate_12x4 = 12,
+	dml2_output_rate_hdmi_rate_16x4 = 13,
+	dml2_output_rate_hdmi_rate_20x4 = 14
 };
 
 struct dml2_pmo_options {
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index 8d4e5a91af06..b9cff2198511 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -13069,6 +13069,10 @@ void dml2_core_calcs_get_informative(const struct dml2_core_internal_display_mod
 			out->informative.mode_support_info.OutputRate[k] = dml2_output_rate_hdmi_rate_10x4;
 		else if (mode_lib->ms.support.OutputRate[k] == dml2_core_internal_output_rate_hdmi_rate_12x4)
 			out->informative.mode_support_info.OutputRate[k] = dml2_output_rate_hdmi_rate_12x4;
+		else if (mode_lib->ms.support.OutputRate[k] == dml2_core_internal_output_rate_hdmi_rate_16x4)
+			out->informative.mode_support_info.OutputRate[k] = dml2_output_rate_hdmi_rate_16x4;
+		else if (mode_lib->ms.support.OutputRate[k] == dml2_core_internal_output_rate_hdmi_rate_20x4)
+			out->informative.mode_support_info.OutputRate[k] = dml2_output_rate_hdmi_rate_20x4;
 
 		out->informative.mode_support_info.AlignedYPitch[k] = mode_lib->ms.support.AlignedYPitch[k];
 		out->informative.mode_support_info.AlignedCPitch[k] = mode_lib->ms.support.AlignedCPitch[k];
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared_types.h b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared_types.h
index fb57fe459227..28687565ac22 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared_types.h
@@ -102,6 +102,7 @@ struct dml2_core_internal_DmlPipe {
 	double DCFClkDeepSleep;
 	unsigned int DPPPerSurface;
 	bool ScalerEnabled;
+	bool UPSPEnabled;
 	enum dml2_rotation_angle RotationAngle;
 	bool mirrored;
 	unsigned int ViewportHeight;
@@ -186,7 +187,9 @@ enum dml2_core_internal_output_type_rate {
 	dml2_core_internal_output_rate_hdmi_rate_6x4 = 9,
 	dml2_core_internal_output_rate_hdmi_rate_8x4 = 10,
 	dml2_core_internal_output_rate_hdmi_rate_10x4 = 11,
-	dml2_core_internal_output_rate_hdmi_rate_12x4 = 12
+	dml2_core_internal_output_rate_hdmi_rate_12x4 = 12,
+	dml2_core_internal_output_rate_hdmi_rate_16x4 = 13,
+	dml2_core_internal_output_rate_hdmi_rate_20x4 = 14
 };
 
 struct dml2_core_internal_watermarks {
@@ -260,12 +263,14 @@ struct dml2_core_internal_mode_support_info {
 	bool AvgBandwidthSupport;
 	bool UrgVactiveBandwidthSupport;
 	bool EnoughUrgentLatencyHidingSupport;
+	bool PrefetchScheduleSupported;
 	bool PrefetchSupported;
 	bool PrefetchBandwidthSupported;
 	bool DynamicMetadataSupported;
 	bool VRatioInPrefetchSupported;
 	bool DISPCLK_DPPCLK_Support;
 	bool TotalAvailablePipesSupport;
+	bool ODMSupport;
 	bool ModeSupport;
 	bool ViewportSizeSupport;
 
@@ -314,9 +319,7 @@ struct dml2_core_internal_mode_support_info {
 
 	double non_urg_bandwidth_required[dml2_core_internal_soc_state_max][dml2_core_internal_bw_max]; // same as urg_bandwidth, except not scaled by urg burst factor
 	double non_urg_bandwidth_required_flip[dml2_core_internal_soc_state_max][dml2_core_internal_bw_max];
-
 	bool avg_bandwidth_support_ok[dml2_core_internal_soc_state_max][dml2_core_internal_bw_max];
-
 	double max_urgent_latency_us;
 	double max_non_urgent_latency_us;
 	double avg_non_urgent_latency_us;
@@ -330,6 +333,7 @@ struct dml2_core_internal_mode_support_info {
 
 	struct dml2_core_internal_watermarks watermarks;
 	bool dcfclk_support;
+	bool qos_bandwidth_support;
 };
 
 struct dml2_core_internal_mode_support {
@@ -397,9 +401,13 @@ struct dml2_core_internal_mode_support {
 	double TWait[DML2_MAX_PLANES];
 
 	bool UnboundedRequestEnabled;
+	unsigned int compbuf_reserved_space_64b;
+	bool hw_debug5;
 	unsigned int CompressedBufferSizeInkByte;
 	double VRatioPreY[DML2_MAX_PLANES];
 	double VRatioPreC[DML2_MAX_PLANES];
+	unsigned int req_per_swath_ub_l[DML2_MAX_PLANES];
+	unsigned int req_per_swath_ub_c[DML2_MAX_PLANES];
 	unsigned int swath_width_luma_ub[DML2_MAX_PLANES];
 	unsigned int swath_width_chroma_ub[DML2_MAX_PLANES];
 	unsigned int RequiredSlots[DML2_MAX_PLANES];
@@ -420,8 +428,8 @@ struct dml2_core_internal_mode_support {
 	double dst_y_prefetch[DML2_MAX_PLANES];
 	double LinesForVM[DML2_MAX_PLANES];
 	double LinesForDPTERow[DML2_MAX_PLANES];
-	double SwathWidthYSingleDPP[DML2_MAX_PLANES];
-	double SwathWidthCSingleDPP[DML2_MAX_PLANES];
+	unsigned int SwathWidthYSingleDPP[DML2_MAX_PLANES];
+	unsigned int SwathWidthCSingleDPP[DML2_MAX_PLANES];
 	unsigned int BytePerPixelY[DML2_MAX_PLANES];
 	unsigned int BytePerPixelC[DML2_MAX_PLANES];
 	double BytePerPixelInDETY[DML2_MAX_PLANES];
@@ -472,6 +480,40 @@ struct dml2_core_internal_mode_support {
 	double mall_prefetch_sdp_overhead_factor[DML2_MAX_PLANES]; // overhead to the imall or phantom pipe
 	double mall_prefetch_dram_overhead_factor[DML2_MAX_PLANES];
 
+	bool is_using_mall_for_ss[DML2_MAX_PLANES];
+	unsigned int meta_row_width_chroma[DML2_MAX_PLANES];
+	unsigned int PixelPTEReqHeightC[DML2_MAX_PLANES];
+	bool PTE_BUFFER_MODE[DML2_MAX_PLANES];
+	unsigned int meta_req_height_chroma[DML2_MAX_PLANES];
+	unsigned int meta_pte_bytes_per_frame_ub_c[DML2_MAX_PLANES];
+	unsigned int dpde0_bytes_per_frame_ub_c[DML2_MAX_PLANES];
+	unsigned int dpte_row_width_luma_ub[DML2_MAX_PLANES];
+	unsigned int meta_req_width[DML2_MAX_PLANES];
+	unsigned int meta_row_width[DML2_MAX_PLANES];
+	unsigned int PixelPTEReqWidthY[DML2_MAX_PLANES];
+	unsigned int dpte_row_height_linear[DML2_MAX_PLANES];
+	unsigned int PTERequestSizeY[DML2_MAX_PLANES];
+	unsigned int dpte_row_width_chroma_ub[DML2_MAX_PLANES];
+	unsigned int PixelPTEReqWidthC[DML2_MAX_PLANES];
+	unsigned int meta_pte_bytes_per_frame_ub_l[DML2_MAX_PLANES];
+	unsigned int dpte_row_height_linear_chroma[DML2_MAX_PLANES];
+	unsigned int PTERequestSizeC[DML2_MAX_PLANES];
+	unsigned int meta_req_height[DML2_MAX_PLANES];
+	unsigned int dpde0_bytes_per_frame_ub_l[DML2_MAX_PLANES];
+	unsigned int meta_req_width_chroma[DML2_MAX_PLANES];
+	unsigned int PixelPTEReqHeightY[DML2_MAX_PLANES];
+	unsigned int BIGK_FRAGMENT_SIZE[DML2_MAX_PLANES];
+	unsigned int vm_group_bytes[DML2_MAX_PLANES];
+	unsigned int VReadyOffsetPix[DML2_MAX_PLANES];
+	unsigned int VUpdateOffsetPix[DML2_MAX_PLANES];
+	unsigned int VUpdateWidthPix[DML2_MAX_PLANES];
+	double TSetup[DML2_MAX_PLANES];
+	double Tdmdl_vm_raw[DML2_MAX_PLANES];
+	double Tdmdl_raw[DML2_MAX_PLANES];
+	unsigned int VStartupMin[DML2_MAX_PLANES]; /// <brief Minimum vstartup to meet the prefetch schedule (i.e. the prefetch solution can be found at this vstartup time); not the actual global sync vstartup pos.
+	double MaxActiveDRAMClockChangeLatencySupported[DML2_MAX_PLANES];
+	double MaxActiveFCLKChangeLatencySupported;
+
 	// Backend
 	bool RequiresDSC[DML2_MAX_PLANES];
 	bool RequiresFEC[DML2_MAX_PLANES];
@@ -489,6 +531,7 @@ struct dml2_core_internal_mode_support {
 	enum dml2_odm_mode ODMModeDSC;
 	double RequiredDISPCLKPerSurfaceNoDSC;
 	double RequiredDISPCLKPerSurfaceDSC;
+	unsigned int EstimatedNumberOfDSCSlices[DML2_MAX_PLANES];
 
 	// Bandwidth Related Info
 	double BandwidthAvailableForImmediateFlip;
@@ -581,6 +624,7 @@ struct dml2_core_internal_mode_support {
 
 	unsigned int tdlut_pte_bytes_per_frame[DML2_MAX_PLANES];
 	unsigned int tdlut_bytes_per_frame[DML2_MAX_PLANES];
+	unsigned int tdlut_groups_per_2row_ub[DML2_MAX_PLANES];
 	double tdlut_opt_time[DML2_MAX_PLANES];
 	double tdlut_drain_time[DML2_MAX_PLANES];
 	unsigned int tdlut_bytes_per_group[DML2_MAX_PLANES];
@@ -592,6 +636,8 @@ struct dml2_core_internal_mode_support {
 
 	unsigned int DSTYAfterScaler[DML2_MAX_PLANES];
 	unsigned int DSTXAfterScaler[DML2_MAX_PLANES];
+
+	enum dml2_pstate_method pstate_switch_modes[DML2_MAX_PLANES];
 };
 
 /// @brief A mega structure that houses various info for model programming step.
@@ -653,6 +699,8 @@ struct dml2_core_internal_mode_program {
 	unsigned int MacroTileHeightC[DML2_MAX_PLANES];
 	unsigned int MacroTileWidthY[DML2_MAX_PLANES];
 	unsigned int MacroTileWidthC[DML2_MAX_PLANES];
+	double MaximumSwathWidthLuma[DML2_MAX_PLANES];
+	double MaximumSwathWidthChroma[DML2_MAX_PLANES];
 
 	bool surf_linear128_l[DML2_MAX_PLANES];
 	bool surf_linear128_c[DML2_MAX_PLANES];
@@ -685,6 +733,14 @@ struct dml2_core_internal_mode_program {
 	double UrgentBurstFactorChroma[DML2_MAX_PLANES];
 	double UrgentBurstFactorChromaPre[DML2_MAX_PLANES];
 
+	double MaximumSwathWidthInLineBufferLuma;
+	double MaximumSwathWidthInLineBufferChroma;
+
+	unsigned int vmpg_width_y[DML2_MAX_PLANES];
+	unsigned int vmpg_height_y[DML2_MAX_PLANES];
+	unsigned int vmpg_width_c[DML2_MAX_PLANES];
+	unsigned int vmpg_height_c[DML2_MAX_PLANES];
+
 	double meta_row_bw[DML2_MAX_PLANES];
 	unsigned int meta_row_bytes[DML2_MAX_PLANES];
 	unsigned int meta_req_width[DML2_MAX_PLANES];
@@ -706,7 +762,9 @@ struct dml2_core_internal_mode_program {
 	unsigned int PTERequestSizeC[DML2_MAX_PLANES];
 
 	double TWait[DML2_MAX_PLANES];
+	double Tdmdl_vm_raw[DML2_MAX_PLANES];
 	double Tdmdl_vm[DML2_MAX_PLANES];
+	double Tdmdl_raw[DML2_MAX_PLANES];
 	double Tdmdl[DML2_MAX_PLANES];
 	double TSetup[DML2_MAX_PLANES];
 	unsigned int dpde0_bytes_per_frame_ub_l[DML2_MAX_PLANES];
@@ -780,6 +838,8 @@ struct dml2_core_internal_mode_program {
 
 	// Support
 	bool UrgVactiveBandwidthSupport;
+	bool PrefetchScheduleSupported;
+	bool UrgentBandwidthSupport;
 	bool PrefetchModeSupported; // <brief Is the prefetch mode (bandwidth and latency) supported
 	bool ImmediateFlipSupported;
 	bool ImmediateFlipSupportedForPipe[DML2_MAX_PLANES];
@@ -875,7 +935,7 @@ struct dml2_core_internal_mode_program {
 	// RQ registers
 	bool PTE_BUFFER_MODE[DML2_MAX_PLANES];
 	unsigned int BIGK_FRAGMENT_SIZE[DML2_MAX_PLANES];
-
+	double VActiveLatencyHidingUs[DML2_MAX_PLANES];
 	unsigned int SubViewportLinesNeededInMALL[DML2_MAX_PLANES];
 	bool is_using_mall_for_ss[DML2_MAX_PLANES];
 
@@ -1088,10 +1148,10 @@ struct dml2_core_calcs_mode_programming_locals {
 	double dummy_bw[dml2_core_internal_soc_state_max][dml2_core_internal_bw_max];
 	double surface_dummy_bw[dml2_core_internal_soc_state_max][dml2_core_internal_bw_max][DML2_MAX_PLANES];
 	double surface_dummy_bw0[dml2_core_internal_soc_state_max][dml2_core_internal_bw_max][DML2_MAX_PLANES];
-	unsigned int dummy_integer_array[2][DML2_MAX_PLANES];
+	unsigned int dummy_integer_array[4][DML2_MAX_PLANES];
 	enum dml2_output_encoder_class dummy_output_encoder_array[DML2_MAX_PLANES];
 	double dummy_single_array[2][DML2_MAX_PLANES];
-	unsigned int dummy_long_array[4][DML2_MAX_PLANES];
+	unsigned int dummy_long_array[8][DML2_MAX_PLANES];
 	bool dummy_boolean_array[2][DML2_MAX_PLANES];
 	bool dummy_boolean[2];
 	double dummy_single[2];
@@ -1239,6 +1299,7 @@ struct dml2_core_calcs_CalculateVMRowAndSwath_params {
 	unsigned int HostVMMinPageSize;
 	unsigned int DCCMetaBufferSizeBytes;
 	bool mrq_present;
+	enum dml2_pstate_method pstate_switch_modes[DML2_MAX_PLANES];
 
 	// Output
 	bool *PTEBufferSizeNotExceeded;
@@ -1504,6 +1565,7 @@ struct dml2_core_shared_CalculateFlipSchedule_locals {
 
 struct dml2_core_shared_rq_dlg_get_dlg_reg_locals {
 	unsigned int plane_idx;
+	unsigned int stream_idx;
 	enum dml2_source_format_class source_format;
 	const struct dml2_timing_cfg *timing;
 	bool dual_plane;
@@ -1711,6 +1773,9 @@ struct dml2_core_calcs_CalculateSwathAndDETConfiguration_params {
 	double *BytePerPixDETC;
 	unsigned int *DPPPerSurface;
 	bool mrq_present;
+	unsigned int dummy[2][DML2_MAX_PLANES];
+	unsigned int swath_width_luma_ub_single_dpp[DML2_MAX_PLANES];
+	unsigned int swath_width_chroma_ub_single_dpp[DML2_MAX_PLANES];
 
 	// output
 	unsigned int *req_per_swath_ub_l;
@@ -1728,6 +1793,8 @@ struct dml2_core_calcs_CalculateSwathAndDETConfiguration_params {
 	unsigned int *DETBufferSizeC;
 	unsigned int *full_swath_bytes_l;
 	unsigned int *full_swath_bytes_c;
+	unsigned int *full_swath_bytes_single_dpp_l;
+	unsigned int *full_swath_bytes_single_dpp_c;
 	bool *UnboundedRequestEnabled;
 	unsigned int *compbuf_reserved_space_64b;
 	unsigned int *CompressedBufferSizeInkByte;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/inc/dml2_debug.h b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/inc/dml2_debug.h
index b226225103c3..611c80f4f1bf 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/inc/dml2_debug.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/inc/dml2_debug.h
@@ -10,15 +10,74 @@
 #define DML_LOG_LEVEL_DEFAULT DML_LOG_LEVEL_WARN
 #define DML_LOG_INTERNAL(fmt, ...) dm_output_to_console(fmt, ## __VA_ARGS__)
 
-/* ASSERT with message output */
-#define DML_ASSERT_MSG(condition, fmt, ...)								\
-	do {												\
-		if (!(condition)) {									\
-			DML_LOG_ERROR("DML ASSERT hit in %s line %d\n", __func__, __LINE__);	\
-			DML_LOG_ERROR(fmt, ## __VA_ARGS__);						\
-			DML_ASSERT(condition);								\
-		}											\
-	} while (0)
+/* private helper macros */
+#define _BOOL_FORMAT(field) "%s", field ? "true" : "false"
+#define _UINT_FORMAT(field) "%u", field
+#define _INT_FORMAT(field) "%d", field
+#define _DOUBLE_FORMAT(field) "%lf", field
+#define _ELEMENT_FUNC "function"
+#define _ELEMENT_COMP_IF "component_interface"
+#define _ELEMENT_TOP_IF "top_interface"
+#define _LOG_ENTRY(element) do {		\
+	DML_LOG_INTERNAL("<"element" name=\"");	\
+	DML_LOG_INTERNAL(__func__);		\
+	DML_LOG_INTERNAL("\">\n");		\
+} while (0)
+#define _LOG_EXIT(element) DML_LOG_INTERNAL("</"element">\n")
+#define _LOG_SCALAR(field, format) do {						\
+	DML_LOG_INTERNAL(#field" = "format(field));				\
+	DML_LOG_INTERNAL("\n");							\
+} while (0)
+#define _LOG_ARRAY(field, size, format) do {					\
+	DML_LOG_INTERNAL(#field " = [");					\
+	for (int _i = 0; _i < (int) size; _i++) {				\
+		DML_LOG_INTERNAL(format(field[_i]));				\
+		if (_i + 1 == (int) size)					\
+			DML_LOG_INTERNAL("]\n");				\
+		else								\
+			DML_LOG_INTERNAL(", ");					\
+}} while (0)
+#define _LOG_2D_ARRAY(field, size0, size1, format) do {				\
+	DML_LOG_INTERNAL(#field" = [");						\
+	for (int _i = 0; _i < (int) size0; _i++) {				\
+		DML_LOG_INTERNAL("\n\t[");					\
+		for (int _j = 0; _j < (int) size1; _j++) {			\
+			DML_LOG_INTERNAL(format(field[_i][_j]));		\
+			if (_j + 1 == (int) size1)				\
+				DML_LOG_INTERNAL("]");				\
+			else							\
+				DML_LOG_INTERNAL(", ");				\
+		}								\
+		if (_i + 1 == (int) size0)					\
+			DML_LOG_INTERNAL("]\n");				\
+		else								\
+			DML_LOG_INTERNAL(", ");					\
+	}									\
+} while (0)
+#define _LOG_3D_ARRAY(field, size0, size1, size2, format) do {			\
+	DML_LOG_INTERNAL(#field" = [");						\
+	for (int _i = 0; _i < (int) size0; _i++) {				\
+		DML_LOG_INTERNAL("\n\t[");					\
+		for (int _j = 0; _j < (int) size1; _j++) {			\
+			DML_LOG_INTERNAL("[");					\
+			for (int _k = 0; _k < (int) size2; _k++) {		\
+				DML_LOG_INTERNAL(format(field[_i][_j][_k]));	\
+				if (_k + 1 == (int) size2)			\
+					DML_LOG_INTERNAL("]");			\
+				else						\
+					DML_LOG_INTERNAL(", ");			\
+			}							\
+			if (_j + 1 == (int) size1)				\
+				DML_LOG_INTERNAL("]");				\
+			else							\
+				DML_LOG_INTERNAL(", ");				\
+		}								\
+		if (_i + 1 == (int) size0)					\
+			DML_LOG_INTERNAL("]\n");				\
+		else								\
+			DML_LOG_INTERNAL(", ");					\
+	}									\
+} while (0)
 
 /* fatal errors for unrecoverable DML states until a full reset */
 #define DML_LOG_LEVEL_FATAL 0
@@ -28,7 +87,7 @@
 #define DML_LOG_LEVEL_WARN 2
 /* high level tracing of DML interfaces */
 #define DML_LOG_LEVEL_INFO 3
-/* detailed tracing of DML internal components */
+/* tracing of DML internal executions */
 #define DML_LOG_LEVEL_DEBUG 4
 /* detailed tracing of DML calculation procedure */
 #define DML_LOG_LEVEL_VERBOSE 5
@@ -37,30 +96,94 @@
 #define DML_LOG_LEVEL DML_LOG_LEVEL_DEFAULT
 #endif /* #ifndef DML_LOG_LEVEL */
 
+/* public macros for DML_LOG_LEVEL_FATAL and up */
 #define DML_LOG_FATAL(fmt, ...) DML_LOG_INTERNAL("[DML FATAL] " fmt, ## __VA_ARGS__)
+
+/* public macros for DML_LOG_LEVEL_ERROR and up */
 #if DML_LOG_LEVEL >= DML_LOG_LEVEL_ERROR
 #define DML_LOG_ERROR(fmt, ...) DML_LOG_INTERNAL("[DML ERROR] "fmt, ## __VA_ARGS__)
+#define DML_ASSERT_MSG(condition, fmt, ...)								\
+	do {												\
+		if (!(condition)) {									\
+			DML_LOG_ERROR("ASSERT hit in %s line %d\n", __func__, __LINE__);		\
+			DML_LOG_ERROR(fmt, ## __VA_ARGS__);						\
+			DML_ASSERT(condition);								\
+		}											\
+	} while (0)
 #else
 #define DML_LOG_ERROR(fmt, ...) ((void)0)
+#define DML_ASSERT_MSG(condition, fmt, ...) ((void)0)
 #endif
+
+/* public macros for DML_LOG_LEVEL_WARN and up */
 #if DML_LOG_LEVEL >= DML_LOG_LEVEL_WARN
 #define DML_LOG_WARN(fmt, ...) DML_LOG_INTERNAL("[DML WARN] "fmt, ## __VA_ARGS__)
 #else
 #define DML_LOG_WARN(fmt, ...) ((void)0)
 #endif
+
+/* public macros for DML_LOG_LEVEL_INFO and up */
 #if DML_LOG_LEVEL >= DML_LOG_LEVEL_INFO
 #define DML_LOG_INFO(fmt, ...) DML_LOG_INTERNAL("[DML INFO] "fmt, ## __VA_ARGS__)
+#define DML_LOG_TOP_IF_ENTER() _LOG_ENTRY(_ELEMENT_TOP_IF)
+#define DML_LOG_TOP_IF_EXIT() _LOG_EXIT(_ELEMENT_TOP_IF)
 #else
 #define DML_LOG_INFO(fmt, ...) ((void)0)
+#define DML_LOG_TOP_IF_ENTER() ((void)0)
+#define DML_LOG_TOP_IF_EXIT() ((void)0)
 #endif
+
+/* public macros for DML_LOG_LEVEL_DEBUG and up */
 #if DML_LOG_LEVEL >= DML_LOG_LEVEL_DEBUG
-#define DML_LOG_DEBUG(fmt, ...) DML_LOG_INTERNAL("[DML DEBUG] "fmt, ## __VA_ARGS__)
+#define DML_LOG_DEBUG(fmt, ...) DML_LOG_INTERNAL(fmt, ## __VA_ARGS__)
+#define DML_LOG_COMP_IF_ENTER() _LOG_ENTRY(_ELEMENT_COMP_IF)
+#define DML_LOG_COMP_IF_EXIT() _LOG_EXIT(_ELEMENT_COMP_IF)
+#define DML_LOG_FUNC_ENTER() _LOG_ENTRY(_ELEMENT_FUNC)
+#define DML_LOG_FUNC_EXIT() _LOG_EXIT(_ELEMENT_FUNC)
+#define DML_LOG_DEBUG_BOOL(field) _LOG_SCALAR(field, _BOOL_FORMAT)
+#define DML_LOG_DEBUG_UINT(field) _LOG_SCALAR(field, _UINT_FORMAT)
+#define DML_LOG_DEBUG_INT(field) _LOG_SCALAR(field, _INT_FORMAT)
+#define DML_LOG_DEBUG_DOUBLE(field) _LOG_SCALAR(field, _DOUBLE_FORMAT)
+#define DML_LOG_DEBUG_ARRAY_BOOL(field, size) _LOG_ARRAY(field, size, _BOOL_FORMAT)
+#define DML_LOG_DEBUG_ARRAY_UINT(field, size) _LOG_ARRAY(field, size, _UINT_FORMAT)
+#define DML_LOG_DEBUG_ARRAY_INT(field, size) _LOG_ARRAY(field, size, _INT_FORMAT)
+#define DML_LOG_DEBUG_ARRAY_DOUBLE(field, size) _LOG_ARRAY(field, size, _DOUBLE_FORMAT)
+#define DML_LOG_DEBUG_2D_ARRAY_BOOL(field, size0, size1) _LOG_2D_ARRAY(field, size0, size1, _BOOL_FORMAT)
+#define DML_LOG_DEBUG_2D_ARRAY_UINT(field, size0, size1) _LOG_2D_ARRAY(field, size0, size1, _UINT_FORMAT)
+#define DML_LOG_DEBUG_2D_ARRAY_INT(field, size0, size1) _LOG_2D_ARRAY(field, size0, size1, _INT_FORMAT)
+#define DML_LOG_DEBUG_2D_ARRAY_DOUBLE(field, size0, size1) _LOG_2D_ARRAY(field, size0, size1, _DOUBLE_FORMAT)
+#define DML_LOG_DEBUG_3D_ARRAY_BOOL(field, size0, size1, size2) _LOG_3D_ARRAY(field, size0, size1, size2, _BOOL_FORMAT)
+#define DML_LOG_DEBUG_3D_ARRAY_UINT(field, size0, size1, size2) _LOG_3D_ARRAY(field, size0, size1, size2, _UINT_FORMAT)
+#define DML_LOG_DEBUG_3D_ARRAY_INT(field, size0, size1, size2) _LOG_3D_ARRAY(field, size0, size1, size2, _INT_FORMAT)
+#define DML_LOG_DEBUG_3D_ARRAY_DOUBLE(field, size0, size1, size2) _LOG_3D_ARRAY(field, size0, size1, size2, _DOUBLE_FORMAT)
 #else
 #define DML_LOG_DEBUG(fmt, ...) ((void)0)
+#define DML_LOG_COMP_IF_ENTER() ((void)0)
+#define DML_LOG_COMP_IF_EXIT() ((void)0)
+#define DML_LOG_FUNC_ENTER() ((void)0)
+#define DML_LOG_FUNC_EXIT() ((void)0)
+#define DML_LOG_DEBUG_BOOL(field) ((void)0)
+#define DML_LOG_DEBUG_UINT(field) ((void)0)
+#define DML_LOG_DEBUG_INT(field) ((void)0)
+#define DML_LOG_DEBUG_DOUBLE(field) ((void)0)
+#define DML_LOG_DEBUG_ARRAY_BOOL(field, size) ((void)0)
+#define DML_LOG_DEBUG_ARRAY_UINT(field, size) ((void)0)
+#define DML_LOG_DEBUG_ARRAY_INT(field, size) ((void)0)
+#define DML_LOG_DEBUG_ARRAY_DOUBLE(field, size) ((void)0)
+#define DML_LOG_DEBUG_2D_ARRAY_BOOL(field, size0, size1) ((void)0)
+#define DML_LOG_DEBUG_2D_ARRAY_UINT(field, size0, size1) ((void)0)
+#define DML_LOG_DEBUG_2D_ARRAY_INT(field, size0, size1) ((void)0)
+#define DML_LOG_DEBUG_2D_ARRAY_DOUBLE(field, size0, size1) ((void)0)
+#define DML_LOG_DEBUG_3D_ARRAY_BOOL(field, size0, size1, size2) ((void)0)
+#define DML_LOG_DEBUG_3D_ARRAY_UINT(field, size0, size1, size2) ((void)0)
+#define DML_LOG_DEBUG_3D_ARRAY_INT(field, size0, size1, size2) ((void)0)
+#define DML_LOG_DEBUG_3D_ARRAY_DOUBLE(field, size0, size1, size2) ((void)0)
 #endif
+
+/* public macros for DML_LOG_LEVEL_VERBOSE */
 #if DML_LOG_LEVEL >= DML_LOG_LEVEL_VERBOSE
-#define DML_LOG_VERBOSE(fmt, ...) DML_LOG_INTERNAL("[DML VERBOSE] "fmt, ## __VA_ARGS__)
+#define DML_LOG_VERBOSE(fmt, ...) DML_LOG_INTERNAL(fmt, ## __VA_ARGS__)
 #else
 #define DML_LOG_VERBOSE(fmt, ...) ((void)0)
-#endif
+#endif /* #if DML_LOG_LEVEL >= DML_LOG_LEVEL_VERBOSE */
 #endif /* __DML2_DEBUG_H__ */
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 75e08efc582d..569644bea641 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -303,9 +303,11 @@ union dmub_addr {
 /* Flattened structure containing SOC BB parameters stored in the VBIOS
  * It is not practical to store the entire bounding box in VBIOS since the bounding box struct can gain new parameters.
  * This also prevents alighment issues when new parameters are added to the SoC BB.
+ * The following parameters should be added since these values can't be obtained elsewhere:
+ * -dml2_soc_power_management_parameters
+ * -dml2_soc_vmin_clock_limits
  */
 struct dmub_soc_bb_params {
-	/* dml2_soc_power_management_parameters */
 	uint32_t dram_clk_change_blackout_ns;
 	uint32_t dram_clk_change_read_only_ns;
 	uint32_t dram_clk_change_write_only_ns;
@@ -318,9 +320,9 @@ struct dmub_soc_bb_params {
 	uint32_t z8_min_idle_time_ns;
 	uint32_t type_b_dram_clk_change_blackout_ns;
 	uint32_t type_b_ppt_blackout_ns;
-	/* dml2_soc_vmin_clock_limits */
 	uint32_t vmin_limit_dispclk_khz;
 	uint32_t vmin_limit_dcfclk_khz;
+	uint32_t g7_temperature_read_blackout_ns;
 };
 #pragma pack(pop)
 
@@ -2100,6 +2102,28 @@ enum fams2_stream_type {
 	FAMS2_STREAM_TYPE_SUBVP = 4,
 };
 
+struct dmub_rect16 {
+	/**
+	 * Dirty rect x offset.
+	 */
+	uint16_t x;
+
+	/**
+	 * Dirty rect y offset.
+	 */
+	uint16_t y;
+
+	/**
+	 * Dirty rect width.
+	 */
+	uint16_t width;
+
+	/**
+	 * Dirty rect height.
+	 */
+	uint16_t height;
+};
+
 /* static stream state */
 struct dmub_fams2_legacy_stream_static_state {
 	uint8_t vactive_det_fill_delay_otg_vlines;
-- 
2.43.0

