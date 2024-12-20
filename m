Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29F72E7718C
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2024 21:51:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0EFB10F07A;
	Fri, 20 Dec 2024 21:51:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sbJJgeJM";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6784710F077
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2024 21:51:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=thYgvf1V2hDg9hE7VJc3yaPl4pG3HoeVbN78J0D15VVeuSWY5xicsRnXmt46Qi4DoXJ0Bz3AZBrgqmTpV8IXVLiTDbxlvvicI13D9FQGeDdEUIjag9fLSHugS+yDW9rjj2cBuvkaRzG6GPY1kHujlsYtREKd07zMKUga0c7LRg7wnRGPmhqsEFtEFRk6fHphwhxF5MdUOLZoL5GqYFndWEGu1cQpyeU2bN0let8b3AbxeSB5m0WScxfbIXJ2opjX/HN5BAoL+wQe4djR71dWEIL18cQdbj+Gv3NBvFRWwJVemg3h9vwp8G2of01adYFlYfP8BLCnHX9ytpTd27ZzcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b5YPCIKM3uWI6n88Ryf9jppEc7hiea9SCxxgrsd03zA=;
 b=YZZon/SXXh+694hGbj3BlPrs7gEfkZ52v0aig5yHqZwPClC4QsVMbnzybJ9DZF3ij2HIONLMjVCdd0XfmdutroYgqokSORbhMN9LY/oTq5w6hi6U+dOpQnYr6fBeyHlWAblA/V5oAzlw875sVKr2RUtHkfWMgFNoCjwY/1KXtr5NRkHyb1ZCFUyQGzAdjq+X+TBg680wJWNxo5hhOk8ssl9BBJYIvf477+kn4hJGK526k4voln9Icdj9pXe34XGw51w3S5NObbA7XAGuulqjQK5woUPcL4CfxkgkrQ3gH+JzS7EXbCdycdp5bjg1v2x328pk7sQQqRuLyk706wtlGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b5YPCIKM3uWI6n88Ryf9jppEc7hiea9SCxxgrsd03zA=;
 b=sbJJgeJMFTQJZF06NZt+jVms2gA0Wgh0jTeI9EbddPhmMvKpE8C5LFMlmia5FPm6t3ScZ1IJaec7duqJ6IqFYpPZFPTuyKkc/Fokr3l9YOuZJbpIAE+R+EKjZkXfzLlaA3ynC5nwUDuoosO6HgGk4OklCtF0kQFCjSS0ax+AWoU=
Received: from MW2PR16CA0058.namprd16.prod.outlook.com (2603:10b6:907:1::35)
 by BY5PR12MB4292.namprd12.prod.outlook.com (2603:10b6:a03:212::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Fri, 20 Dec
 2024 21:51:10 +0000
Received: from CO1PEPF000075F1.namprd03.prod.outlook.com
 (2603:10b6:907:1:cafe::d9) by MW2PR16CA0058.outlook.office365.com
 (2603:10b6:907:1::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8137.28 via Frontend Transport; Fri,
 20 Dec 2024 21:51:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000075F1.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 20 Dec 2024 21:51:09 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Dec
 2024 15:51:08 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 20 Dec 2024 15:51:07 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, "Natanel
 Roizenman" <Natanel.Roizenman@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>
Subject: [PATCH 10/28] drm/amd/display: correct type mismatches in comparisons
 in DML2
Date: Fri, 20 Dec 2024 16:48:37 -0500
Message-ID: <20241220214855.2608618-11-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241220214855.2608618-1-Roman.Li@amd.com>
References: <20241220214855.2608618-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F1:EE_|BY5PR12MB4292:EE_
X-MS-Office365-Filtering-Correlation-Id: a4d331d2-8e4b-4349-54ad-08dd21406a46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GMytPorjZ19HOTEun4F7LvnA1bocbB5TAWVDE3zzxRNLClH9SjpBpDsK3Ewt?=
 =?us-ascii?Q?30dMzQz93cXzyzNcV5gxnC6zMb1/Mq3OFQlzxNy+pHW6Z1gvoUZGo6tR0VTk?=
 =?us-ascii?Q?t0Orvf9DHnxRRKoYq0UHesXG97/ciJY2JLaCdYULQBMcu8ev4Ef4OwPpyWzX?=
 =?us-ascii?Q?qi3JH36kk0GUIB4CT28lbynpfi3VZ8E8pqTA7LQ/8uaxosDuwncGnek1lWU5?=
 =?us-ascii?Q?LjYkIgeBE8YeOfxbSxNUR2YDy0NLU+fDCXczb+BwxejVb1EKN6M9akrGas95?=
 =?us-ascii?Q?AB7XRFduYWbrI89Td5qTeqHFQK9EwoA6iDcm8oIepcpSq3XCHNvVHJgSLRTC?=
 =?us-ascii?Q?CqiKToa+rWOvP9VVTitdimf0YiwMP8QiS6ApFl1tb+Yn07cE1niKgqpbAXhN?=
 =?us-ascii?Q?l4JJ41VlfaEoIlbWS8BwBISkr4vtVO2yU41T7S31oEBFBletQZXhDrJMaaFX?=
 =?us-ascii?Q?e0R1snJSHaCMx0eyN6zXC+oDbnc7tSLPhtxr76N5FZq02tbzxTGdsFkqJ19S?=
 =?us-ascii?Q?fQUu1vL2/BtwBZzHGFd0X2I/+RpUfWcsh1Xx/F1GmG7NmAwxXPIESVi9MyYg?=
 =?us-ascii?Q?l4OPXCqUfpUEApuFmUWhpJsfm2MF8vrxJcutka5OhZ6qgq1g2F3PvVbycevt?=
 =?us-ascii?Q?FvRsgwrLGMm4DU3Y2u+fOJpgFSCB3LYm3dw7VYIuILkz1FXVZTrK6y7NgYVe?=
 =?us-ascii?Q?h1qgCeVnWa5aBQBNeYoqsrPTfp27KONbnwFtGiCu9DT5I4lIFkiih+HlOz6E?=
 =?us-ascii?Q?DDmPkaVvtQ0XI7FwMY3H9WqFPzm4nE1Z2Gcy1AYFYHIEuknx7jxfJE2Vb8ox?=
 =?us-ascii?Q?kYfFyhoHarbkBKd2O9DCxWABwEpCgH01tKCuk3jbUA9XVXeDX1Dp5ylmrIj4?=
 =?us-ascii?Q?9uy3I33ONmmyASgJAaRFZzFuiPO8JbQFZEQKE9kLLnXiXCksEceEEfEfbaYo?=
 =?us-ascii?Q?ss+5YVfIHxSo8LaDr0ZsWsS/wIXbQSttmdHSdqTJjEOH62I9t3VDmd3Wjjv6?=
 =?us-ascii?Q?jgUZ3r6bf3mvFiRl0fXIVVCVwxn7inP+bxQxw1CEF3vz8VnIl0mtqEnPjXwW?=
 =?us-ascii?Q?/8O+E9eDu6dIPE4KpDZG2Kiayz+E1vMu7erUC9enERF2GkBn8BgrQf/0ouqz?=
 =?us-ascii?Q?ciRzIOWnd9CFEn4hDoWisUfCGHwaHCYGCHOt/bO94OeKiXPZCakj0tIHyvr3?=
 =?us-ascii?Q?Vu6hVLHJODYJn/wHp32KYb7Cg3R0FtEOPtiziKCzlOoqk/jFtnE6OSouWf0Z?=
 =?us-ascii?Q?C41/W9NnyLIYOUJvv2W2R0vWZH9/2aczebGW1qH5Lfsl0v97sidqtNOhGxgy?=
 =?us-ascii?Q?DNoNTVvrkQ1YcJpq4MeZCG9whwdt6XtwN/01OfK6dcoptHyOwoWIqHD3ACQi?=
 =?us-ascii?Q?4PqN+JXbDoJre69mmaVyMLfuFw7TsFs+gT6dwdzXELiWocSxalktoiuIvOLw?=
 =?us-ascii?Q?5DseX2SP+fpIACJwQzbTD3FymSBRbaqqzIvP9cE1iegEEJzfNHfrviXo/aY7?=
 =?us-ascii?Q?G3X2loX1SrAUHbw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 21:51:09.9377 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4d331d2-8e4b-4349-54ad-08dd21406a46
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4292
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

From: Natanel Roizenman <Natanel.Roizenman@amd.com>

[Why]
Comparisons were made between unsigned char and unsigned int.

[How]
Corrected by changing variable types.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Natanel Roizenman <Natanel.Roizenman@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 .../dml2/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c | 12 ++++----
 .../dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c   |  6 ++--
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  | 30 +++++++++----------
 3 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c
index 8a78b9adfc62..0c5ddb322e40 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c
@@ -417,11 +417,11 @@ static bool map_min_clocks_to_dpm(const struct dml2_core_mode_support_result *mo
 
 static bool are_timings_trivially_synchronizable(struct dml2_display_cfg *display_config, int mask)
 {
-	unsigned char i;
+	unsigned int i;
 	bool identical = true;
 	bool contains_drr = false;
-	unsigned char remap_array[DML2_MAX_PLANES];
-	unsigned char remap_array_size = 0;
+	unsigned int remap_array[DML2_MAX_PLANES];
+	unsigned int remap_array_size = 0;
 
 	// Create a remap array to enable simple iteration through only masked stream indicies
 	for (i = 0; i < display_config->num_streams; i++) {
@@ -456,10 +456,10 @@ static bool are_timings_trivially_synchronizable(struct dml2_display_cfg *displa
 
 static int find_smallest_idle_time_in_vblank_us(struct dml2_dpmm_map_mode_to_soc_dpm_params_in_out *in_out, int mask)
 {
-	unsigned char i;
+	unsigned int i;
 	int min_idle_us = 0;
-	unsigned char remap_array[DML2_MAX_PLANES];
-	unsigned char remap_array_size = 0;
+	unsigned int remap_array[DML2_MAX_PLANES];
+	unsigned int remap_array_size = 0;
 	const struct dml2_core_mode_support_result *mode_support_result = &in_out->display_cfg->mode_support_result;
 
 	// Create a remap array to enable simple iteration through only masked stream indicies
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c
index a31db5742675..655d1ef56814 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c
@@ -195,11 +195,11 @@ static int count_planes_with_stream_index(const struct dml2_display_cfg *display
 
 static bool are_timings_trivially_synchronizable(struct display_configuation_with_meta *display_config, int mask)
 {
-	unsigned char i;
+	unsigned int i;
 	bool identical = true;
 	bool contains_drr = false;
-	unsigned char remap_array[DML2_MAX_PLANES];
-	unsigned char remap_array_size = 0;
+	unsigned int remap_array[DML2_MAX_PLANES];
+	unsigned int remap_array_size = 0;
 
 	// Create a remap array to enable simple iteration through only masked stream indicies
 	for (i = 0; i < display_config->display_config.num_streams; i++) {
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
index 1efbc0329f85..94609f9c18eb 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
@@ -986,7 +986,7 @@ static bool all_timings_support_vactive(const struct dml2_pmo_instance *pmo,
 		const struct display_configuation_with_meta *display_config,
 		unsigned int mask)
 {
-	unsigned char i;
+	unsigned int i;
 	bool valid = true;
 
 	// Create a remap array to enable simple iteration through only masked stream indicies
@@ -1035,7 +1035,7 @@ static bool all_timings_support_drr(const struct dml2_pmo_instance *pmo,
 	const struct display_configuation_with_meta *display_config,
 	unsigned int mask)
 {
-	unsigned char i;
+	unsigned int i;
 	for (i = 0; i < DML2_MAX_PLANES; i++) {
 		const struct dml2_stream_parameters *stream_descriptor;
 		const struct dml2_fams2_meta *stream_fams2_meta;
@@ -1077,7 +1077,7 @@ static bool all_timings_support_svp(const struct dml2_pmo_instance *pmo,
 	const struct dml2_plane_parameters *plane_descriptor;
 	const struct dml2_fams2_meta *stream_fams2_meta;
 	unsigned int microschedule_vlines;
-	unsigned char i;
+	unsigned int i;
 
 	unsigned int num_planes_per_stream[DML2_MAX_PLANES] = { 0 };
 
@@ -1194,7 +1194,7 @@ static enum dml2_uclk_pstate_change_strategy pstate_method_to_uclk_pstate_strate
 
 static bool all_planes_match_method(const struct display_configuation_with_meta *display_cfg, int plane_mask, enum dml2_pstate_method method)
 {
-	unsigned char i;
+	unsigned int i;
 
 	for (i = 0; i < DML2_MAX_PLANES; i++) {
 		if (is_bit_set_in_bitfield(plane_mask, i)) {
@@ -1545,7 +1545,7 @@ static bool validate_pstate_support_strategy_cofunctionality(struct dml2_pmo_ins
 {
 	struct dml2_pmo_scratch *s = &pmo->scratch;
 
-	unsigned char stream_index = 0;
+	unsigned int stream_index = 0;
 
 	unsigned int svp_count = 0;
 	unsigned int svp_stream_mask = 0;
@@ -1609,7 +1609,7 @@ static bool validate_pstate_support_strategy_cofunctionality(struct dml2_pmo_ins
 
 static int get_vactive_pstate_margin(const struct display_configuation_with_meta *display_cfg, int plane_mask)
 {
-	unsigned char i;
+	unsigned int i;
 	int min_vactive_margin_us = 0xFFFFFFF;
 
 	for (i = 0; i < DML2_MAX_PLANES; i++) {
@@ -1817,7 +1817,7 @@ bool pmo_dcn4_fams2_init_for_pstate_support(struct dml2_pmo_init_for_pstate_supp
 	const struct dml2_pmo_pstate_strategy *strategy_list = NULL;
 	struct dml2_pmo_pstate_strategy override_base_strategy = { 0 };
 	unsigned int strategy_list_size = 0;
-	unsigned char plane_index, stream_index, i;
+	unsigned int plane_index, stream_index, i;
 	bool build_override_strategy = true;
 
 	state->performed = true;
@@ -1940,7 +1940,7 @@ static void setup_planes_for_drr_by_mask(struct display_configuation_with_meta *
 	struct dml2_pmo_instance *pmo,
 	int plane_mask)
 {
-	unsigned char plane_index;
+	unsigned int plane_index;
 	struct dml2_plane_parameters *plane;
 
 	for (plane_index = 0; plane_index < display_config->display_config.num_planes; plane_index++) {
@@ -1961,7 +1961,7 @@ static void setup_planes_for_svp_by_mask(struct display_configuation_with_meta *
 {
 	struct dml2_pmo_scratch *scratch = &pmo->scratch;
 
-	unsigned char plane_index;
+	unsigned int plane_index;
 	int stream_index = -1;
 
 	for (plane_index = 0; plane_index < display_config->display_config.num_planes; plane_index++) {
@@ -1984,7 +1984,7 @@ static void setup_planes_for_svp_drr_by_mask(struct display_configuation_with_me
 {
 	struct dml2_pmo_scratch *scratch = &pmo->scratch;
 
-	unsigned char plane_index;
+	unsigned int plane_index;
 	int stream_index = -1;
 
 	for (plane_index = 0; plane_index < display_config->display_config.num_planes; plane_index++) {
@@ -2005,7 +2005,7 @@ static void setup_planes_for_vblank_by_mask(struct display_configuation_with_met
 	struct dml2_pmo_instance *pmo,
 	int plane_mask)
 {
-	unsigned char plane_index;
+	unsigned int plane_index;
 	struct dml2_plane_parameters *plane;
 
 	for (plane_index = 0; plane_index < display_config->display_config.num_planes; plane_index++) {
@@ -2025,7 +2025,7 @@ static void setup_planes_for_vblank_drr_by_mask(struct display_configuation_with
 	struct dml2_pmo_instance *pmo,
 	int plane_mask)
 {
-	unsigned char plane_index;
+	unsigned int plane_index;
 	struct dml2_plane_parameters *plane;
 
 	for (plane_index = 0; plane_index < display_config->display_config.num_planes; plane_index++) {
@@ -2042,7 +2042,7 @@ static void setup_planes_for_vactive_by_mask(struct display_configuation_with_me
 	struct dml2_pmo_instance *pmo,
 	int plane_mask)
 {
-	unsigned char plane_index;
+	unsigned int plane_index;
 	unsigned int stream_index;
 
 	for (plane_index = 0; plane_index < display_config->display_config.num_planes; plane_index++) {
@@ -2063,7 +2063,7 @@ static void setup_planes_for_vactive_drr_by_mask(struct display_configuation_wit
 	struct dml2_pmo_instance *pmo,
 	int plane_mask)
 {
-	unsigned char plane_index;
+	unsigned int plane_index;
 	unsigned int stream_index;
 
 	for (plane_index = 0; plane_index < display_config->display_config.num_planes; plane_index++) {
@@ -2131,7 +2131,7 @@ static bool setup_display_config(struct display_configuation_with_meta *display_
 static int get_minimum_reserved_time_us_for_planes(struct display_configuation_with_meta *display_config, int plane_mask)
 {
 	int min_time_us = 0xFFFFFF;
-	unsigned char plane_index = 0;
+	unsigned int plane_index = 0;
 
 	for (plane_index = 0; plane_index < display_config->display_config.num_planes; plane_index++) {
 		if (is_bit_set_in_bitfield(plane_mask, plane_index)) {
-- 
2.34.1

