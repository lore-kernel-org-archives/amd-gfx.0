Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD53C3DA41
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 19:37:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D93F10E8A5;
	Wed, 10 Jul 2024 19:37:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QgMPPBOG";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FE6010E8A3
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 19:37:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LhJWPRCb3AVTjCdFNHytqFuEpbsCxNvuI0JGftocNoH1+/Wgl0kIlzpMZjijH0lf8thu3mwsS/C6RdY4ZqZN+NgAgg6QiN6F5BkhUoGNkaOzc1riCfWv5hPMmOAFlpTSeoZFO+B6uUc3VetFi5Y7QAZMvRheaQzO4y6pEivtzXnfjuTizJ+UOGvATYWvJ2+cxMmD/rn5YwrhPq/5scktIMe+I53oD7MygeIPq2m/WYrhHrLpJpZxgKx2Jnns6DKk7krRq3sg9vS5E+NPPua9/zei74Q69mdnvqspzKnxHolgtkuSZ4iG4TW/cWYJ8Fioh1JsaUPvAYwyGW7ziVVavw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aWTieWKsAP2YPCpXeTsb64+AA9gV+ZhPGs05b+UL24Q=;
 b=QnvP9Qz9OQB16/48Ayvp2F75lw1GO2IuC6fdDk6gM1uqDaAjpJZutpuJNC9RVzddUnBrbypsM1ee08KDD1mQMQ9H2FHNm18ucrrIbmKl6f67l1OZ2TGYHQL3qSRrmznzA4xRGEqe2HK+VEgco74Zuuyxc+QSqoc88U6WMG3VcqlD1JcNKHkAoD/1BZNcqxMBri3eGpeWmYdcHZs/S/JoMyZSnJ4ASEi9A8QRSfKnKpEPHwgiyjX9i/8Wr7CAshH8ARO6stxJ5fo5VkmL3YTttoH7+OwLqZB5Vk0rshTJUQ7CrOM35f4ROmXSHDZoxgroVSb94XfWFVbCISa+/0LuAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWTieWKsAP2YPCpXeTsb64+AA9gV+ZhPGs05b+UL24Q=;
 b=QgMPPBOGAOFHZZZ+wiSJVxR2RXuNwtnyzH2Q6nNRzfAGYm603AgfvsvWqEkvO86jiQA7AgdiqEPNaMCga+xoYmzPkD8Ko6B74KSk9VOOv3z6N3/b8IN1Z4GbcRsd1mu8ENshXrGZ4isCpPubNKP6HEzFZpnDT0g/kOD6a2HlJ+4=
Received: from MN2PR06CA0017.namprd06.prod.outlook.com (2603:10b6:208:23d::22)
 by PH8PR12MB7110.namprd12.prod.outlook.com (2603:10b6:510:22e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 10 Jul
 2024 19:37:48 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:23d:cafe::68) by MN2PR06CA0017.outlook.office365.com
 (2603:10b6:208:23d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Wed, 10 Jul 2024 19:37:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 19:37:47 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:37:46 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:37:46 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 10 Jul 2024 14:37:45 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Jun Lei
 <jun.lei@amd.com>
Subject: [PATCH 09/50] drm/amd/display: apply vmin optimization even if it
 doesn't reach vmin level
Date: Wed, 10 Jul 2024 15:36:26 -0400
Message-ID: <20240710193707.43754-10-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710193707.43754-1-Jerry.Zuo@amd.com>
References: <20240710193707.43754-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|PH8PR12MB7110:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fb94952-fcc1-4207-c887-08dca117c73b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OPCPzwtaWkdKI+dQxJIa2yeX9FghFEs5dY/Duo5vZQIt9v1MPdk0JLOzrBpW?=
 =?us-ascii?Q?BXcFgxcEBgJdvKKPzWoEb7DDgQa+KpGCqTXiK8V+fltYLSgEnTTUDsJRcRy7?=
 =?us-ascii?Q?tlyys6nzUJGK4gtMuhIgGNONUj5ShpaVQdWRmIMycLSocWmL7yItoZ1KdXjJ?=
 =?us-ascii?Q?0Ldk5LxJ1vU/rr9rEXuasXOmhcMeoCNb6AitQyEVcgmBp3LrixOMU/hRfdol?=
 =?us-ascii?Q?ccvGK7oBD3hQEyK7IEC5yydXnb2HmMt6yYE7GanO0tmG/P65QouhV6RiwMzr?=
 =?us-ascii?Q?3uhOxZkaZ92ec2QM4t5onNuVKeQ/EE1uy632Uxmn0iTuVpsoc9WJ1MqL00oG?=
 =?us-ascii?Q?F8eoISS45XO5eTuY2KLSoFugYLxEabTNernUmwYCbgplbD5hh2AohhfGOmil?=
 =?us-ascii?Q?m1mjbpN1THpl8f/tK5MFXRMZPHzFG8YRPX0y3Z7KScXcGMfpJ+waOS4nvfIF?=
 =?us-ascii?Q?X811DWyblzLSf6dIuJmpeBh7zeybRzAoRT9LzoH70x+FGnF0zayzjCohTg1R?=
 =?us-ascii?Q?71Brxr2y9iuxaRC6eI+lR09OoYsJKVk0m4x5GDw06nZiRAcqDp3BYrUYo1v9?=
 =?us-ascii?Q?VZwm0cf/qUmBgiO2fBuCwamKh6k6t6SJqqzqFNmlzJQ+7G5fIdgJ2JhAAw7O?=
 =?us-ascii?Q?hnDpEt0QdKh9AbHWqFGoMuuJustdh+f04APS48Au4SOTb0B/d644PFLq93ad?=
 =?us-ascii?Q?7GHwUK5xuE216tr21V1ZhP8gC7Iqkpmbt8+AMjTesBBXiMWwHy6cVJELbhCU?=
 =?us-ascii?Q?LbrEateWwsOsESL2Z1DhIK+OXnxTX/Q/kjUvHNJT3sDA08l4sZLVf8JQ78sv?=
 =?us-ascii?Q?fjLWmlK+WVU6jgqJnCLOrJOO6ogqImBcpBzuIB5WcQ8gs+bjL3WJVwH06i8I?=
 =?us-ascii?Q?8XCKNF7sQz2r11VnIxby2dfxZgIK+qSU+KvY5k/3nC8SXEhjsLgFbh2pH82y?=
 =?us-ascii?Q?amoSSQFIAbM800A1zdVa5oU3OJPu9r7aGL2z8Z8MfV9ERJhYgjxoYsZuuKvJ?=
 =?us-ascii?Q?jYC/vUPFy8tOLRZclY+wzFlbfsjLnJck3lIgcxD5TVOmbQwZnxJsJCXIfZdU?=
 =?us-ascii?Q?1B2GIjHPhIfHsM371IE4FDf5YpRZohHI1O+Mm+SOJyjrH9R5vZI93GmPLrRN?=
 =?us-ascii?Q?KZ0fbkIuG3xq7Awn5zt+o9yMEVWeuBNYmTJEhzIit27o3akMJEjoaWr8gGVm?=
 =?us-ascii?Q?TOnByHKf9fFcf5IyjSIRbOVAb9Rc4c3Als8jgEYqyKWSKodPHv3TUDjI+DZB?=
 =?us-ascii?Q?H/F8g8R+ZwylOtC0bhqta6EQQimKyYyhepSmXosStHPUUSJ6EYcrVRtaD/Nh?=
 =?us-ascii?Q?sTtk5eaT72tT8rwr/X6vZTq+ykW+0Cs0Sk+N1GgHA5gKjU51b1FmvWZTMpWd?=
 =?us-ascii?Q?uCV17LZXvRZWgMVtQZ2eZjvgFqHS0rCIqdhW1aZkLay3EcMboVq9ZeKFg5Hw?=
 =?us-ascii?Q?sbcAY+7nyQ2J7EmpadtnSgAPhaNdSggl?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:37:47.5858 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fb94952-fcc1-4207-c887-08dca117c73b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7110
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

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
Based on power measurement result, in most cases when display clock is higher
than Vmin display clock, lowering display clock using dynamic ODM will improve
overall power consumption by 0 to 4 watts even if we can't reach Vmin.

[how]
Allow vmin optimization applied even if dispclk can't reach Vmin.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  | 14 +++++++++-----
 .../display/dc/dml2/dml21/src/dml2_top/dml_top.c   | 13 +++++++++++--
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
index 603036df68ba..60a9faf81d3d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
@@ -591,6 +591,8 @@ bool pmo_dcn4_fams2_init_for_vmin(struct dml2_pmo_init_for_vmin_in_out *in_out)
 			&in_out->base_display_config->display_config;
 	const struct dml2_core_mode_support_result *mode_support_result =
 			&in_out->base_display_config->mode_support_result;
+	struct dml2_optimization_stage4_state *state =
+			&in_out->base_display_config->stage4;
 
 	if (in_out->instance->options->disable_dyn_odm ||
 			(in_out->instance->options->disable_dyn_odm_for_multi_stream && display_config->num_streams > 1))
@@ -611,28 +613,30 @@ bool pmo_dcn4_fams2_init_for_vmin(struct dml2_pmo_init_for_vmin_in_out *in_out)
 		 */
 		if (mode_support_result->cfg_support_info.plane_support_info[i].dpps_used > 1 &&
 				mode_support_result->cfg_support_info.stream_support_info[display_config->plane_descriptors[i].stream_index].odms_used == 1)
-			in_out->base_display_config->stage4.unoptimizable_streams[display_config->plane_descriptors[i].stream_index] = true;
+			state->unoptimizable_streams[display_config->plane_descriptors[i].stream_index] = true;
 
 	for (i = 0; i < display_config->num_streams; i++) {
 		if (display_config->stream_descriptors[i].overrides.disable_dynamic_odm)
-			in_out->base_display_config->stage4.unoptimizable_streams[i] = true;
+			state->unoptimizable_streams[i] = true;
 		else if (in_out->base_display_config->stage3.stream_svp_meta[i].valid &&
 				in_out->instance->options->disable_dyn_odm_for_stream_with_svp)
-			in_out->base_display_config->stage4.unoptimizable_streams[i] = true;
+			state->unoptimizable_streams[i] = true;
 		/*
 		 * ODM Combine requires horizontal timing divisible by 2 so each
 		 * ODM segment has the same size.
 		 */
 		else if (!is_h_timing_divisible_by(&display_config->stream_descriptors[i].timing, 2))
-			in_out->base_display_config->stage4.unoptimizable_streams[i] = true;
+			state->unoptimizable_streams[i] = true;
 		/*
 		 * Our hardware support seamless ODM transitions for DP encoders
 		 * only.
 		 */
 		else if (!is_dp_encoder(display_config->stream_descriptors[i].output.output_encoder))
-			in_out->base_display_config->stage4.unoptimizable_streams[i] = true;
+			state->unoptimizable_streams[i] = true;
 	}
 
+	state->performed = true;
+
 	return true;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/dml_top.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/dml_top.c
index 2fb3e2f45e07..b25e9230adea 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/dml_top.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/dml_top.c
@@ -268,9 +268,18 @@ bool dml2_build_mode_programming(struct dml2_build_mode_programming_in_out *in_o
 
 	vmin_success = dml2_top_optimization_perform_optimization_phase(&l->optimization_phase_locals, &l->vmin_phase);
 
-	if (vmin_success) {
+	if (l->optimized_display_config_with_meta.stage4.performed) {
+		/*
+		 * when performed is true, optimization has applied to
+		 * optimized_display_config_with_meta and it has passed mode
+		 * support. However it may or may not pass the test function to
+		 * reach actual Vmin. As long as voltage is optimized even if it
+		 * doesn't reach Vmin level, there is still power benefit so in
+		 * this case we will still copy this optimization into base
+		 * display config.
+		 */
 		memcpy(&l->base_display_config_with_meta, &l->optimized_display_config_with_meta, sizeof(struct display_configuation_with_meta));
-		l->base_display_config_with_meta.stage4.success = true;
+		l->base_display_config_with_meta.stage4.success = vmin_success;
 	}
 
 	/*
-- 
2.34.1

