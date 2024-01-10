Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C72EC47073
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jan 2024 21:56:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD80F10E682;
	Wed, 10 Jan 2024 21:56:43 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 657BA10E682
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jan 2024 21:56:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rxk3W4fqnODj8fNaFSjraStnBx+gJmDtX+pH1WsgomFlj0KQr6PycoQCPj+TrLRIz4W+tlKEmlgG+eA1QMxzZU9WQ0IlaE9KhyqqVolAKk64meWv/XB7NHO97FYosP/+g5rA6ToMS8+qdQmxz3EfhCrmxAd5SipT2lg9Ai6pSBM72bX9VumSDH0SHHh58HMDCqI2ByUwNHro7HI2ufzTv7Esh28dtLztekWNvsBs4Fzn6ZopGaU+bU6P1pR5VcrcpyiT3k5Yl3Oev/ZFdYajJOf92R4Ga1+qrn4JVD9NVgfIn6V5lhogVMGFEpj+ocrxsMkhM0WudArgblKkBNCA1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rU1Xxy/uvIst7RUmFCURqNg6322QLO6vvDFaE7xvHJw=;
 b=b9WNZmKXRc9GmC25zNTUMImaQPcVUxspkHIit3ia5ZY5DGekOOLSRBuwAlKogdIJXrSeQZ/Bnp4JeC4l16Md9pM3X+ddu0IyTc14khKyVJngjkIAGihYWeBfNgyYLupCzlddpNfXZQSbYuPaU4wuU4wOVhxSNyMFozvKtn9b7n3B2H3nyOlxDkD3AjDCURvXlN8+bKZ7o4B3gTdkWiaRxdPz3RK5x6jmocP/DVADd6/tbmO7foTRLQaRetXq8WzO2N16j913NN4NvmDriW03EXGhynszxTllAGM9H0ezKgTt9yxckV44HwqFp3iDqJoLnst9GAj5DrRovrGsYv/xYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rU1Xxy/uvIst7RUmFCURqNg6322QLO6vvDFaE7xvHJw=;
 b=W8ui14UIfu9+i9rwHG0MLOp5UL8R8OEL/UEsxXOtAJb+t/NUk0nTQst7hFNrmvmzA6C/YNYD5975dqPqkYmg1o1bGaQPp4H0M6IIiWt8Kga/Dl/XO3cjTcnFQTjZvQSx+tPy1KQTeXeo7d9f/D5JTNgVF3a7b3LG+8fyHpN7m6M=
Received: from BYAPR02CA0002.namprd02.prod.outlook.com (2603:10b6:a02:ee::15)
 by DS7PR12MB8229.namprd12.prod.outlook.com (2603:10b6:8:ea::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 21:56:40 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:a02:ee:cafe::62) by BYAPR02CA0002.outlook.office365.com
 (2603:10b6:a02:ee::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.27 via Frontend
 Transport; Wed, 10 Jan 2024 21:56:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Wed, 10 Jan 2024 21:56:40 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 10 Jan
 2024 15:56:37 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/19] drm/amd/display: Ensure populate uclk in bb construction
Date: Wed, 10 Jan 2024 14:52:54 -0700
Message-ID: <20240110215302.2116049-12-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110215302.2116049-1-alex.hung@amd.com>
References: <20240110215302.2116049-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|DS7PR12MB8229:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c7ab233-6f84-4a31-3133-08dc1227067b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LoeC14z/qxJYvSNX9oprt07gn+WR4xaS4NoNT5A1A4rI3VmQya1HwAlh/zzcerc4X7fCjQFLs0aN+0hVClQ2PTPTq/LY91tYcfOBThupPzLPyb+V0VzhAlUeSeu/LabyykduDpUImRcTjKHljCwqUScr1s3f1HfnqG8FTaj78yY/H2oLznHL/1cNQJzjkdeV7giXhvZVCAvzt1zhz9FoNbmNLeL6ltXUI+/sqq/BHtx/yVGoDBabYZwbgQUILW7BHHTMfD85Vk8qFGGmj4U2KyPakrxqTazf6+hPYogx8M0VgQXSO8P6bWOxSm67s34sZXJs4jzK7wRmXh3bmTgYlTQdbedkodYHSf3ZuS7x4GJjT4UD/UbnCxN8rzZcrUiT6gWgst049PR67QH5PMvfpIh0iAcMqmGEHMwQzCVDfDkpGyKuLBnUgp4qRJF/1eg2ozqppzyQsSkCzFPtqdnn88U+7uGdbWxhqWT+Q3GeykNNRWBylvSXZv/H9DyKea1jzvuT9nBagagWfaliYmtI2K+vW8xltdhLBo4GTaWjsHa5vPdVkE2tjpQ+glCWUykHhAh49sqq2QsgCBpgpQRvPH12CNqsLLcUg2vRNc2mlNmVs7UyisJ8g4+iiImY5ymX7ZBqmfI/O/ESS2Zrn7OsH248z6RvEjwzuyEojEP9xrSlhd19jv0FRTiN/VYsVzUMKEuidPxolzI1D16tUDYBMrVK4Hocy7udWEjI4xGboupPJZYyKcQiZfl4awOTHcdP0OwjaSJppIsCLrzq0EDaT87TmnmjVWFb4WB7mMyLx4I=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(39860400002)(136003)(376002)(230922051799003)(1800799012)(451199024)(186009)(82310400011)(64100799003)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(66899024)(83380400001)(81166007)(70586007)(41300700001)(70206006)(36756003)(86362001)(356005)(36860700001)(82740400003)(47076005)(426003)(16526019)(26005)(336012)(1076003)(2616005)(54906003)(2906002)(6916009)(478600001)(316002)(6666004)(7696005)(5660300002)(8936002)(4326008)(8676002)(44832011)(36900700001)(44824005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 21:56:40.0122 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c7ab233-6f84-4a31-3133-08dc1227067b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8229
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Samson Tam <samson.tam@amd.com>,
 Alex Hung <alex.hung@amd.com>, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com,
 Chaitanya Dhere <chaitanya.dhere@amd.com>, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Description]
- For some SKUs, the optimal DCFCLK for each UCLK is less than the
  smallest DCFCLK STA target due to low memory bandwidth. There is
  an assumption that the DCFCLK STA targets will always be less
  than one of the optimal DCFCLK values, but this is not true for
  SKUs that have low memory bandwidth. In this case we need to
  populate the optimal UCLK for each DCFCLK STA targets as the max
  UCLK freq.
- Also fix a bug in DML where start_state is not assigned and used
  correctly.

Reviewed-by: Samson Tam <samson.tam@amd.com>
Reviewed-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 .../display/dc/dml/dcn30/display_mode_vba_30.c   | 16 ++++++++--------
 .../drm/amd/display/dc/dml/dcn303/dcn303_fpu.c   | 11 +++++++++++
 .../display/dc/resource/dcn30/dcn30_resource.c   | 11 +++++++++++
 3 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
index 63c48c29ba49..e7f4a2d491cc 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
@@ -4273,7 +4273,7 @@ void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 
 	//Calculate Swath, DET Configuration, DCFCLKDeepSleep
 	//
-	for (i = 0; i < mode_lib->soc.num_states; ++i) {
+	for (i = start_state; i < mode_lib->soc.num_states; ++i) {
 		for (j = 0; j <= 1; ++j) {
 			for (k = 0; k < v->NumberOfActivePlanes; ++k) {
 				v->RequiredDPPCLKThisState[k] = v->RequiredDPPCLK[i][j][k];
@@ -4576,7 +4576,7 @@ void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 
 	//Calculate Return BW
 
-	for (i = 0; i < mode_lib->soc.num_states; ++i) {
+	for (i = start_state; i < mode_lib->soc.num_states; ++i) {
 		for (j = 0; j <= 1; ++j) {
 			for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
 				if (v->BlendingAndTiming[k] == k) {
@@ -4635,7 +4635,7 @@ void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 					v->UrgentOutOfOrderReturnPerChannelVMDataOnly);
 	v->FinalDRAMClockChangeLatency = (v->DRAMClockChangeLatencyOverride > 0 ? v->DRAMClockChangeLatencyOverride : v->DRAMClockChangeLatency);
 
-	for (i = 0; i < mode_lib->soc.num_states; ++i) {
+	for (i = start_state; i < mode_lib->soc.num_states; ++i) {
 		for (j = 0; j <= 1; ++j) {
 			v->DCFCLKState[i][j] = v->DCFCLKPerState[i];
 		}
@@ -4646,7 +4646,7 @@ void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 
 		if (v->ClampMinDCFCLK) {
 			/* Clamp calculated values to actual minimum */
-			for (i = 0; i < mode_lib->soc.num_states; ++i) {
+			for (i = start_state; i < mode_lib->soc.num_states; ++i) {
 				for (j = 0; j <= 1; ++j) {
 					if (v->DCFCLKState[i][j] < mode_lib->soc.min_dcfclk) {
 						v->DCFCLKState[i][j] = mode_lib->soc.min_dcfclk;
@@ -4656,7 +4656,7 @@ void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 		}
 	}
 
-	for (i = 0; i < mode_lib->soc.num_states; ++i) {
+	for (i = start_state; i < mode_lib->soc.num_states; ++i) {
 		for (j = 0; j <= 1; ++j) {
 			v->IdealSDPPortBandwidthPerState[i][j] = dml_min3(
 					v->ReturnBusWidth * v->DCFCLKState[i][j],
@@ -4674,7 +4674,7 @@ void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 
 	//Re-ordering Buffer Support Check
 
-	for (i = 0; i < mode_lib->soc.num_states; ++i) {
+	for (i = start_state; i < mode_lib->soc.num_states; ++i) {
 		for (j = 0; j <= 1; ++j) {
 			if ((v->ROBBufferSizeInKByte - v->PixelChunkSizeInKByte) * 1024 / v->ReturnBWPerState[i][j]
 					> (v->RoundTripPingLatencyCycles + 32) / v->DCFCLKState[i][j] + ReorderingBytes / v->ReturnBWPerState[i][j]) {
@@ -4692,7 +4692,7 @@ void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 		MaxTotalVActiveRDBandwidth = MaxTotalVActiveRDBandwidth + v->ReadBandwidthLuma[k] + v->ReadBandwidthChroma[k];
 	}
 
-	for (i = 0; i < mode_lib->soc.num_states; ++i) {
+	for (i = start_state; i < mode_lib->soc.num_states; ++i) {
 		for (j = 0; j <= 1; ++j) {
 			v->MaxTotalVerticalActiveAvailableBandwidth[i][j] = dml_min(
 					v->IdealSDPPortBandwidthPerState[i][j] * v->MaxAveragePercentOfIdealSDPPortBWDisplayCanUseInNormalSystemOperation / 100,
@@ -4708,7 +4708,7 @@ void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 
 	//Prefetch Check
 
-	for (i = 0; i < mode_lib->soc.num_states; ++i) {
+	for (i = start_state; i < mode_lib->soc.num_states; ++i) {
 		for (j = 0; j <= 1; ++j) {
 			int NextPrefetchModeState = MinPrefetchMode;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn303/dcn303_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn303/dcn303_fpu.c
index 3eb3a021ab7d..3f02bb806d42 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn303/dcn303_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn303/dcn303_fpu.c
@@ -266,6 +266,17 @@ void dcn303_fpu_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_p
 					optimal_uclk_for_dcfclk_sta_targets[i] =
 							bw_params->clk_table.entries[j].memclk_mhz * 16;
 					break;
+				} else {
+					/* condition where (dcfclk_sta_targets[i] >= optimal_dcfclk_for_uclk[j]):
+					 * This is required for dcn303 because it just so happens that the memory
+					 * bandwidth is low enough such that all the optimal DCFCLK for each UCLK
+					 * is lower than the smallest DCFCLK STA target. In this case we need to
+					 * populate the optimal UCLK for each DCFCLK STA target to be the max UCLK.
+					 */
+					if (j == num_uclk_states - 1) {
+						optimal_uclk_for_dcfclk_sta_targets[i] =
+								bw_params->clk_table.entries[j].memclk_mhz * 16;
+					}
 				}
 			}
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
index 37a64186f324..ecc477ef8e3b 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
@@ -2169,6 +2169,17 @@ void dcn30_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params
 					optimal_uclk_for_dcfclk_sta_targets[i] =
 							bw_params->clk_table.entries[j].memclk_mhz * 16;
 					break;
+				} else {
+					/* condition where (dcfclk_sta_targets[i] >= optimal_dcfclk_for_uclk[j]):
+					 * If it just so happens that the memory bandwidth is low enough such that
+					 * all the optimal DCFCLK for each UCLK is lower than the smallest DCFCLK STA
+					 * target, we need to populate the optimal UCLK for each DCFCLK STA target to
+					 * be the max UCLK.
+					 */
+					if (j == num_uclk_states - 1) {
+						optimal_uclk_for_dcfclk_sta_targets[i] =
+								bw_params->clk_table.entries[j].memclk_mhz * 16;
+					}
 				}
 			}
 		}
-- 
2.34.1

