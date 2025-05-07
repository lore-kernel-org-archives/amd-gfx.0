Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E01C9C3ABBE
	for <amd-gfx@archiver.kernel.org>; Wed,  7 May 2025 02:44:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AABB10E742;
	Wed,  7 May 2025 02:44:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ti320sOA";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EEFB10E73E
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 May 2025 02:44:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qMOKH3oyjXdUE3w+ZgXFK/TMrCJUgyskbefPu2pxsY3yY1lhDtl3RwINQ+vdulpmPaAgQ1xRwzIKx24a0Wn3jigwj1nJp72pn/YH2vf0THKj38ZRfrtVUEDMy1nmTbOmE2THBBBjaGZ9CLUQQLpu0wyyg+QnpsxJc5AeH6r5WjuJum33S+DxCx/Sz5bXE6m/aXCGV9K36VKniweECPL+sirm5EdhvupKo93EIE7b+g3iE+NLqWXDT6qux+wkk30dd3Oi/+I0gA4VSU/AJg6X7Rp2Efiqwo1p4kb0NBtjKF5icxiq/kPqD5TpLVw7CpCw67Ft/ZrqtkJkSh8S8bsLUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/rOeZlPxMIet5na7D0bgZ2wznbU22Q6EdcOnTWCucA=;
 b=q9vFjtMcDfC47/UZ3lfURDLm2y89e4W7rY6rV6Xk+xVoJu+oZtXHatsPG0kO6rkf2kLo5Vs3CtQVpd7H0hMm/t65LsMOFYMAf24eT/Y3Z6JWsvm1Bj5f2Vpq7pDP2tjSMa9mLr+1mnFOTr8NNz+B8x3OeMiVPRno/PD/uCviz+SqoqqXIBslKaniFxWq1Uw6+EeJ31QYWgV4dn9XANnIbwJNsRLZxAhYyhkqab19eBDbu8j9bV992p19ydHZbsaNkft7Bh04BdWdyw1lP0mkrwn1oqdEaezsyj8N1FJEvEUcnS3eO6sF2uW9n0EMoK87tz2Rl6zCsAPahXuOoNkqXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/rOeZlPxMIet5na7D0bgZ2wznbU22Q6EdcOnTWCucA=;
 b=ti320sOAX1tSajrVXMs2W4Ref+6KUZMQ1O8AWWf138SxybtDyNDuGJn1yQctrC016Er6xlPAT9pMbqo+SsaWDl/nq2iW+T7oYBw4lb77QocXW6RMTKxFYDWJuTrQCYVU3DCDO6b3zt5yt1KtDcAVUNFZ1BGiZkumACbnGs+nHHs=
Received: from MW4PR04CA0357.namprd04.prod.outlook.com (2603:10b6:303:8a::32)
 by DS7PR12MB6261.namprd12.prod.outlook.com (2603:10b6:8:97::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Wed, 7 May
 2025 02:44:06 +0000
Received: from SJ5PEPF000001EC.namprd05.prod.outlook.com
 (2603:10b6:303:8a:cafe::c9) by MW4PR04CA0357.outlook.office365.com
 (2603:10b6:303:8a::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Wed,
 7 May 2025 02:44:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001EC.mail.protection.outlook.com (10.167.242.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 7 May 2025 02:44:06 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 May
 2025 21:44:05 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 May
 2025 21:44:04 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 6 May 2025 21:44:01 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, "Michael
 Strauss" <michael.strauss@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, TungYu
 Lu <tungyu.lu@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 13/14] drm/amd/display: Add early 8b/10b channel equalization
 test pattern sequence
Date: Wed, 7 May 2025 10:34:57 +0800
Message-ID: <20250507024242.1928299-14-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250507024242.1928299-1-ray.wu@amd.com>
References: <20250507024242.1928299-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EC:EE_|DS7PR12MB6261:EE_
X-MS-Office365-Filtering-Correlation-Id: 9be7aaab-8d94-4167-64f5-08dd8d110905
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DidxBgkfnzQ8/riErrZ8uIOBmN5MLf0/AH7UHe4M/uatpmvT/UhzfjSwNvnp?=
 =?us-ascii?Q?FC+9jlFaSRb7wpmWyhU8F0GST/atZg5I7rUweZTujN9b2NqQlTQL5L6BdArv?=
 =?us-ascii?Q?oiXJ4bCTDpLS55ZyX7xSqKBA3E+N2vGjIRnaLgqmUBzGGxkT9xO5qyYmYVxU?=
 =?us-ascii?Q?SuzijoytZ/L14QieDEpzt1jPg2W4dwCBeKJyOQdxZrBq49r+M2v+lgrCzOHS?=
 =?us-ascii?Q?BQ6o/QXwN8d8NZe+gpxrhMo5RVSxGvjscNDuMwW/XU84Z+RQtniHcFOF0asb?=
 =?us-ascii?Q?eg6hdwdJp8suo8sfUjio+KQckk3tqR+lbhhoBLILXwhSF9vJIg5VAYeznD2z?=
 =?us-ascii?Q?mLD2vZWGm/EoVfM9I7tnVmxf14kSZ9/ma3j7xyGix5/cDU8zypc0SuLujT92?=
 =?us-ascii?Q?KoF/KVeTdwmwZIkZrQU1seFSyowXZR7q9fhoIGgxp5QXf4yd5XXmxcdt+Pkk?=
 =?us-ascii?Q?1biNqHt8Hv5kw5Sb4nNcw10+j6z0EZaq4XX+FummU/5obBC1MzovxCkuayJc?=
 =?us-ascii?Q?N+aL/v44Q021j2PzURr6UJDFmfVVV8+d+YHwXqAg/4XeU07n7v2lL78anVdr?=
 =?us-ascii?Q?xVch9jEwF6ZCPqgXs8lUAmhkLB3O5mM3MCalGbrbe6hkIrS9P1ZjCl7jL5Mb?=
 =?us-ascii?Q?TJwKv1ac2WSbAYp+lVK8sEFBGHyDnQNfoZyyHOpHTj0DUUx+4K1Dr+V5oqKn?=
 =?us-ascii?Q?6EyzeuS4+lpdqBwG1RlHX4hFWTJyQkmrcVGmmZanQuD2OWOfB+U/nwW7AD+9?=
 =?us-ascii?Q?sy87GVCWgWc9ETKmGzmj9P/WOXl3t9k3sZMdLGlqz5Jyo8ZrOplEMi7FlRyN?=
 =?us-ascii?Q?wy5rVzVzmwtBrKJzYN65H8vj+H3kOeZ2m1MDRaa8+CuCxEZXCEbQPUVC87Rw?=
 =?us-ascii?Q?3+64JGI86V9Ndb3554GUqYDX14dTR58YGJRP/0lmAhKM3B2X3N6SR/kHvhTd?=
 =?us-ascii?Q?HJYekRWSMQgoSNP/Y9Ynr3uGFIS5K1sc6i15kvKr74jUDXHfj1AgCg+1MkQW?=
 =?us-ascii?Q?TWGPxhtfLI3Py7YCthD+q+wUVIRPvn2CTol9FC6/wCwj6liIDtu7M6cYeAfK?=
 =?us-ascii?Q?feAKfq6Saq7uVbqlkzeLs/3h/tAESGErdulPbYC1XGO26qBz/qfXExK6Dfb/?=
 =?us-ascii?Q?hvh9Ibq8ixjBaf6JEsk+dSQJk7xL1kczQGwuQJwLYDuJsJS37EKEk11q82AD?=
 =?us-ascii?Q?CK1m4Uf4L+q5LKz48QDZSMqsyc7/id5EwxgNVFMEiTiUenp5RRHCgDvM+ilb?=
 =?us-ascii?Q?wA7Xcnq5Vwgj0TEJQ/++ZiKhrXIOQ+lC00/0LswG2W/NQahGTRyf1iDrdxlN?=
 =?us-ascii?Q?9/obu9t09iy7YlRdpDJ+aRQKhf81KBlMRk9dgAfw7kNoYIRmYnZX3YPJtjlE?=
 =?us-ascii?Q?6ZHOHZ7K7lgu+o/HYcNv2oEjxNi6izDwpkl4GyVEYcNvNbyV5JrD9TJllNf+?=
 =?us-ascii?Q?RXfhh1XIUlh/E2mgne3mUVBVBPYftbttuqi7AdiUkyfe1R4D80vZreRY9pAq?=
 =?us-ascii?Q?um7Q2ctVb/o9CgxHPmAkacDMHaapWFqfsStO?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 02:44:06.0387 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9be7aaab-8d94-4167-64f5-08dd8d110905
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6261
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

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
Early EQ pattern sequence is required for some LTTPR + old dongle
combinations.

[HOW]
If DP_EARLY_8B10B_TPS2 chip cap is set, this new sequence programs phy
to output TPS2 before initiating link training and writes TPS1 to
LTTPR training pattern register as instructed by vendor.

Add function to get embedded LTTPR target address offset.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
Signed-off-by: TungYu Lu <tungyu.lu@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../dc/link/protocols/link_dp_capability.c    |  8 +++
 .../dc/link/protocols/link_dp_capability.h    |  3 ++
 .../dc/link/protocols/link_dp_training.c      |  1 -
 .../link/protocols/link_dp_training_8b_10b.c  | 52 +++++++++++++++++--
 .../amd/display/include/link_service_types.h  |  2 +
 5 files changed, 62 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index 21ee0d96c9d4..9d49e77a24a1 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -158,6 +158,14 @@ uint8_t dp_parse_lttpr_repeater_count(uint8_t lttpr_repeater_count)
 	return 0; // invalid value
 }
 
+uint32_t dp_get_closest_lttpr_offset(uint8_t lttpr_count)
+{
+	/* Calculate offset for LTTPR closest to DPTX which is highest in the chain
+	 * Offset is 0 for single LTTPR cases as base LTTPR DPCD addresses target LTTPR 1
+	 */
+	return DP_REPEATER_CONFIGURATION_AND_STATUS_SIZE * (lttpr_count - 1);
+}
+
 uint32_t link_bw_kbps_from_raw_frl_link_rate_data(uint8_t bw)
 {
 	switch (bw) {
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.h
index 0ce0af3ddbeb..940b147cc5d4 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.h
@@ -48,6 +48,9 @@ enum dc_status dp_retrieve_lttpr_cap(struct dc_link *link);
 /* Convert PHY repeater count read from DPCD uint8_t. */
 uint8_t dp_parse_lttpr_repeater_count(uint8_t lttpr_repeater_count);
 
+/* Calculate embedded LTTPR address offset for vendor-specific behaviour */
+uint32_t dp_get_closest_lttpr_offset(uint8_t lttpr_count);
+
 bool dp_is_sink_present(struct dc_link *link);
 
 bool dp_is_lttpr_present(struct dc_link *link);
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
index ef358afdfb65..2dc1a660e504 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
@@ -785,7 +785,6 @@ void override_training_settings(
 		lt_settings->lttpr_mode = LTTPR_MODE_NON_LTTPR;
 
 	dp_get_lttpr_mode_override(link, &lt_settings->lttpr_mode);
-
 }
 
 enum dc_dp_training_pattern decide_cr_training_pattern(
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c
index 5a5d48fadbf2..66d0fb1b9b9d 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c
@@ -142,6 +142,14 @@ void decide_8b_10b_training_settings(
 	lt_settings->lttpr_mode = dp_decide_8b_10b_lttpr_mode(link);
 	lt_settings->cr_pattern_time = get_cr_training_aux_rd_interval(link, link_setting, lt_settings->lttpr_mode);
 	dp_hw_to_dpcd_lane_settings(lt_settings, lt_settings->hw_lane_settings, lt_settings->dpcd_lane_settings);
+
+	/* Some embedded LTTPRs rely on receiving TPS2 before LT to interop reliably with sensitive VGA dongles
+	 * This allows these LTTPRs to minimize freq/phase and skew variation during lock and deskew sequences
+	 */
+	if ((link->chip_caps & AMD_EXT_DISPLAY_PATH_CAPS__EXT_CHIP_MASK) ==
+			AMD_EXT_DISPLAY_PATH_CAPS__DP_EARLY_8B10B_TPS2) {
+		lt_settings->lttpr_early_tps2 = true;
+	}
 }
 
 enum lttpr_mode dp_decide_8b_10b_lttpr_mode(struct dc_link *link)
@@ -173,6 +181,42 @@ enum lttpr_mode dp_decide_8b_10b_lttpr_mode(struct dc_link *link)
 	return LTTPR_MODE_NON_LTTPR;
 }
 
+static void set_link_settings_and_perform_early_tps2_retimer_pre_lt_sequence(struct dc_link *link,
+	const struct link_resource *link_res,
+	struct link_training_settings *lt_settings,
+	uint32_t lttpr_count)
+{
+	/* Vendor-specific LTTPR early TPS2 sequence:
+	* 1. Output TPS2
+	* 2. Wait 400us
+	* 3. Set link settings as usual
+	* 4. Write TPS1 to DP_TRAINING_PATTERN_SET_PHY_REPEATERx targeting LTTPR closest to host
+	* 5. Wait 1ms
+	* 6. Begin link training as usual
+	* */
+
+	uint32_t closest_lttpr_address_offset = dp_get_closest_lttpr_offset(lttpr_count);
+
+	union dpcd_training_pattern dpcd_pattern = {0};
+
+	dpcd_pattern.v1_4.TRAINING_PATTERN_SET = 1;
+	dpcd_pattern.v1_4.SCRAMBLING_DISABLE = 1;
+
+	DC_LOG_HW_LINK_TRAINING("%s\n GPU sends TPS2. Wait 400us.\n", __func__);
+
+	dp_set_hw_training_pattern(link, link_res, DP_TRAINING_PATTERN_SEQUENCE_2, DPRX);
+
+	dp_set_hw_lane_settings(link, link_res, lt_settings, DPRX);
+
+	udelay(400);
+
+	dpcd_set_link_settings(link, lt_settings);
+
+	core_link_write_dpcd(link, DP_TRAINING_PATTERN_SET_PHY_REPEATER1 + closest_lttpr_address_offset, &dpcd_pattern.raw, 1);
+
+	udelay(1000);
+	}
+
 enum link_training_result perform_8b_10b_clock_recovery_sequence(
 	struct dc_link *link,
 	const struct link_resource *link_res,
@@ -383,7 +427,7 @@ enum link_training_result dp_perform_8b_10b_link_training(
 {
 	enum link_training_result status = LINK_TRAINING_SUCCESS;
 
-	uint8_t repeater_cnt;
+	uint8_t repeater_cnt = dp_parse_lttpr_repeater_count(link->dpcd_caps.lttpr_caps.phy_repeater_cnt);
 	uint8_t repeater_id;
 	uint8_t lane = 0;
 
@@ -391,14 +435,16 @@ enum link_training_result dp_perform_8b_10b_link_training(
 		start_clock_recovery_pattern_early(link, link_res, lt_settings, DPRX);
 
 	/* 1. set link rate, lane count and spread. */
-	dpcd_set_link_settings(link, lt_settings);
+	if (lt_settings->lttpr_early_tps2)
+		set_link_settings_and_perform_early_tps2_retimer_pre_lt_sequence(link, link_res, lt_settings, repeater_cnt);
+	else
+		dpcd_set_link_settings(link, lt_settings);
 
 	if (lt_settings->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT) {
 
 		/* 2. perform link training (set link training done
 		 *  to false is done as well)
 		 */
-		repeater_cnt = dp_parse_lttpr_repeater_count(link->dpcd_caps.lttpr_caps.phy_repeater_cnt);
 
 		for (repeater_id = repeater_cnt; (repeater_id > 0 && status == LINK_TRAINING_SUCCESS);
 				repeater_id--) {
diff --git a/drivers/gpu/drm/amd/display/include/link_service_types.h b/drivers/gpu/drm/amd/display/include/link_service_types.h
index 1867aac57cf2..da74ed66c8f9 100644
--- a/drivers/gpu/drm/amd/display/include/link_service_types.h
+++ b/drivers/gpu/drm/amd/display/include/link_service_types.h
@@ -89,6 +89,8 @@ struct link_training_settings {
 	bool enhanced_framing;
 	enum lttpr_mode lttpr_mode;
 
+	bool lttpr_early_tps2;
+
 	/* disallow different lanes to have different lane settings */
 	bool disallow_per_lane_settings;
 	/* dpcd lane settings will always use the same hw lane settings
-- 
2.43.0

