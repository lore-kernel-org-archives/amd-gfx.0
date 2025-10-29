Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FAC3CCF9EA
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 03:11:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01D3310E6E7;
	Wed, 29 Oct 2025 03:11:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i3OF1CyG";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010000.outbound.protection.outlook.com [52.101.56.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92C0510E6E7
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 03:11:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dSamUNK3J0r2TsNzrG7rDxpOiqyxR3VyWBjvH2fNTgpIrzaBfDLQ4GlRQ+ElehzAbRhD3T2vUdThgdYiMYspz/sv1lINm6E8Mpz/3Q83Yizy3JHkoieiIIAUVcJomdR3iRE3jxzEhpAxxmuMZFtMc7/QDO9ha2g8x9v3ovTqdfjLaPa8G9OZtyoQEaXYlHLhxuGW/qHtn8Xpgku8nVrOZFv63xp77klNe9oo7sozIa2/6AKkuRgeelIiLT6n7fK1A1jeqYixiYbI+J+KrePvekspB2KqrrsnhhWe+muRFZz3zoYRzzRxI4DE+LBimjqaJOJ8d9WE8UIUy1qIiEPRkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1l5euuwCiu5IPtZIMUBrbool6aS9w67db6UDw5F7WNg=;
 b=AwNlm6x5rsJIftVBiqYqT5rC/86smDmYU/Fu+phLRo4AkuNA9Pgd3CTpicPrtZs/ulBJFPZ3QWX8NCDsAdq5V3eAY711sOhQoNqaG54dD5RwjODt5McKi8pMc4dyS8HQ9Lx2vKBgMVNkheV3hXrCpZ3T/M9KgvuMZFTRPpXbX4gIn5IqLmkPFbCO+CZTXT6HO0xlfLvaJbFZz9RJGII/cygeUbEhcrO/dbO3c1WcghQ1NVUNog5PRWGu8d7khiC1fiksyNcCUER7THemUAb2LRDmM5Ft6552ce58RaIJpY8Cy+cgHaByzxgk0bF156qfAU8muy2DS09ylZ+MCjA6Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1l5euuwCiu5IPtZIMUBrbool6aS9w67db6UDw5F7WNg=;
 b=i3OF1CyGHfimLbgH+o9iKPrO/XonkQcAw2ZqjiofZ2EgbF+FxKMHCVN9hINW5XBeP8z1Zi0Pqtk2Xm9SHdvClaVKkHdZv451zIZ9Fz9aTtcZwgmTeHmJlr+6WjJTPJ9P4IuvdVddnA7+8fGdzF6pHxzQg4o5jCuQ6+kJR4O2dfo=
Received: from DM6PR02CA0144.namprd02.prod.outlook.com (2603:10b6:5:332::11)
 by MW6PR12MB9000.namprd12.prod.outlook.com (2603:10b6:303:24b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 03:11:31 +0000
Received: from DS3PEPF000099D4.namprd04.prod.outlook.com
 (2603:10b6:5:332:cafe::b) by DM6PR02CA0144.outlook.office365.com
 (2603:10b6:5:332::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Wed,
 29 Oct 2025 03:11:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF000099D4.mail.protection.outlook.com (10.167.17.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 03:11:30 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 28 Oct
 2025 20:11:04 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 28 Oct
 2025 22:11:04 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 28 Oct 2025 20:10:56 -0700
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Austin Zheng <Austin.Zheng@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 06/13] drm/amd/display: Refactor VActive implementation
Date: Wed, 29 Oct 2025 11:02:54 +0800
Message-ID: <20251029030935.2785560-7-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251029030935.2785560-1-ray.wu@amd.com>
References: <20251029030935.2785560-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D4:EE_|MW6PR12MB9000:EE_
X-MS-Office365-Filtering-Correlation-Id: 12cc52da-7538-46dd-61ea-08de1698db6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TuvVRWMGyHxtFGdt0/HOOBUiQWwuqULsGjnTkjWwYeBCGy7KrUapZUeGhwqj?=
 =?us-ascii?Q?GaLjfotV/xgAJQVFZIVqRndql4gFtV2jjHerAYNU51n41a9p90eYmLexngIf?=
 =?us-ascii?Q?PH2KJHlaFTpPemcTXgm41SCKDGptHM8ihIakMnn73/mTjRT3uxtbuzQCUVqv?=
 =?us-ascii?Q?Zgx7Ocsv4Lls4wFdY7e+P9ILbH4aUAjLhux9VU/XllUFrxticaxrb4eJO7hD?=
 =?us-ascii?Q?hpv8RXL9nYupbPmEz0entgx9qbXaMylPSiAN7r+7b/Khpbh8sOPKtzW2od34?=
 =?us-ascii?Q?RtDVMcJ9h1UOz8ieqUNZQPf0PskoZRPXoRS7mCPEOlOuJJokRsnBrUR9GiVw?=
 =?us-ascii?Q?shzgmkVjDNGnxA2adTP2BXJvgjWK3sYZXKn1cKW+FnEQUccF4SWYlYoIevQu?=
 =?us-ascii?Q?Y1iEVQ9V2zgKJtf4Om4VzUIdKsTWS6NX1G1gpZ6S1LLoDKR8CjyGYzsAvc8u?=
 =?us-ascii?Q?iHzgrRCHWepQZdUW+Zoax19uYALCqr/BipYUgNS3b9NTHwHQbe3wlSWcu8MQ?=
 =?us-ascii?Q?HEiZYufKYPr86m+AASiL34hxM4hoOcSm0wWXrnCmQvEqCzVy1g10vOJtvdF9?=
 =?us-ascii?Q?jLkmouSvbu68ylk7Xyi341UNXi55LAJGvERxwKQlTHkSlRo9OO8V1HlB9LE4?=
 =?us-ascii?Q?52yO0qMQ9vvMGoBEDNTq3qQ1zzRTaPA87sxcGkVKB1oo2dhbqDbVKGEVIccB?=
 =?us-ascii?Q?dklvJwOVKduYQqrxdOeV06TquGko4SBCmeEuVrywNiW5fwz2xxIKTQJeyeeJ?=
 =?us-ascii?Q?hrbTAVDULo9m3D5wFhdVrCncbkEGmK/APWEvt8Ag8adQITdim9eiu3yfOyVv?=
 =?us-ascii?Q?NFJcMPUTaX6tnyNH5DG6FQ9hHf6yW2Gm5b/+mwgnuw0jIv241NWq6zAzPcaX?=
 =?us-ascii?Q?Rut4e9LcHgOl7OBZedOq4uN66XpM5pTa7m8FoIiHLDSCN+VIo2nFhvpwRryW?=
 =?us-ascii?Q?VcRoyTWJtoDyn050FeBcGVl9GZ0R7i1bJfMp6RetgF9a8Rvq0pIKgAghEkv8?=
 =?us-ascii?Q?ms1InZ3OW7miiFWqy632pfcKqNM28b7yVB9zgLYQjFgnHQohUow291c/WNOj?=
 =?us-ascii?Q?htVFJcyVlE1JLjGYOGu0xq8VFQbxgqzPDj5Cdkh+79dIyWUPtLdTy73lF1Cw?=
 =?us-ascii?Q?CukOMuMwJnCkY01jdLxKw/9LbeaMocR2QS/fXwVy3C8pIsPAZwy51avwjwm8?=
 =?us-ascii?Q?a2MzxD3k+r+tzSi7Yo4JF8VvW98eXe1H1Nk5Bd8KxyeVZOHr+DLtNc/wu5jK?=
 =?us-ascii?Q?SpMHOUTEdOgUcGJwM9Tz38uFwf0mqpk0kwamBsNC0lQDS+5SU17nEYvDvuJ/?=
 =?us-ascii?Q?erfyMfMHaxukrsn3UfaQciJe45H9FlasOXQjhfDyrvIQvEVZK0mKSMMA1/iv?=
 =?us-ascii?Q?iKZ8n/RPC/CDzXLxqMUj/SWKvWkJBEW+KMo/TKuWghJ159WG7gtUOZXJbIdP?=
 =?us-ascii?Q?8eyPcL2hgqui/ztW1H72Hz/ngbmlyYxWv/nUkXiaZNRmYj69DEF90c/bdHET?=
 =?us-ascii?Q?ztaGmt7r35aKNM+diVs3+DelSzF6uc/9F8pfOteMIsBHmepTp38CgFGmCqJR?=
 =?us-ascii?Q?ggD52XYeFFDydvph+Xg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 03:11:30.4418 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12cc52da-7538-46dd-61ea-08de1698db6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9000
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

[Why & How]
Refactors VActive accounting in PMO, and breaks down fill time
requirement by P-State type as it can result in drasitcally different
bandwidth requirements depending on the blackout length.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../dml21/inc/dml_top_display_cfg_types.h     | 12 +++++-
 .../dml21/inc/dml_top_soc_parameter_types.h   |  2 +-
 .../dc/dml2_0/dml21/inc/dml_top_types.h       |  8 ----
 .../src/dml2_core/dml2_core_dcn4_calcs.c      | 37 ++++++++--------
 .../src/dml2_core/dml2_core_shared_types.h    | 16 +++----
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  | 14 +++----
 .../src/inc/dml2_internal_shared_types.h      | 42 +++++++++++--------
 7 files changed, 69 insertions(+), 62 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_display_cfg_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_display_cfg_types.h
index da8e5c8b2244..35aa954248cd 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_display_cfg_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_display_cfg_types.h
@@ -87,6 +87,15 @@ enum dml2_output_link_dp_rate {
 	dml2_dp_rate_uhbr20 = 6
 };
 
+enum dml2_pstate_type {
+	dml2_pstate_type_uclk = 0,
+	dml2_pstate_type_fclk = 1,
+	dml2_pstate_type_ppt = 2,
+	dml2_pstate_type_temp_read = 3,
+	dml2_pstate_type_dummy_pstate = 4,
+	dml2_pstate_type_count = 5
+};
+
 enum dml2_uclk_pstate_change_strategy {
 	dml2_uclk_pstate_change_strategy_auto = 0,
 	dml2_uclk_pstate_change_strategy_force_vactive = 1,
@@ -393,8 +402,7 @@ struct dml2_plane_parameters {
 		// reserved_vblank_time_ns is the minimum time to reserve in vblank for Twait
 		// The actual reserved vblank time used for the corresponding stream in mode_programming would be at least as much as this per-plane override.
 		long reserved_vblank_time_ns;
-		unsigned int max_vactive_det_fill_delay_us; // 0 = no reserved time, +ve = explicit max delay
-		unsigned int vactive_latency_to_hide_for_pstate_admissibility_us;
+		unsigned int max_vactive_det_fill_delay_us[dml2_pstate_type_count]; // 0 = no reserved time, +ve = explicit max delay
 		unsigned int gpuvm_min_page_size_kbytes;
 		unsigned int hostvm_min_page_size_kbytes;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_soc_parameter_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_soc_parameter_types.h
index e87d04a734b5..1fbc520c2540 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_soc_parameter_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_soc_parameter_types.h
@@ -191,7 +191,7 @@ struct dml2_ip_capabilities {
 	unsigned int subvp_prefetch_end_to_mall_start_us;
 	unsigned int subvp_fw_processing_delay;
 	unsigned int max_vactive_det_fill_delay_us;
-	unsigned int ppt_max_allow_delay_ns;
+	unsigned int ppt_max_allow_delay_us;
 	unsigned int temp_read_max_allow_delay_us;
 	unsigned int dummy_pstate_max_allow_delay_us;
 	/* FAMS2 delays */
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h
index 8646ce5f1c01..d2584b00a19c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h
@@ -195,14 +195,6 @@ struct dml2_mcache_surface_allocation {
 	} informative;
 };
 
-enum dml2_pstate_type {
-	dml2_pstate_type_uclk,
-	dml2_pstate_type_ppt,
-	dml2_pstate_type_temp_read,
-	dml2_pstate_type_dummy_pstate,
-	dml2_pstate_type_count
-};
-
 enum dml2_pstate_method {
 	dml2_pstate_method_na = 0,
 	/* hw exclusive modes */
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index e7a0f46e1289..df81bd963bb8 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -6972,7 +6972,7 @@ static void calculate_bytes_to_fetch_required_to_hide_latency(
 
 		stream_index = p->display_cfg->plane_descriptors[plane_index].stream_index;
 
-		dst_lines_to_hide = (unsigned int)math_ceil(p->latency_to_hide_us /
+		dst_lines_to_hide = (unsigned int)math_ceil(p->latency_to_hide_us[0] /
 			((double)p->display_cfg->stream_descriptors[stream_index].timing.h_total /
 				(double)p->display_cfg->stream_descriptors[stream_index].timing.pixel_clock_khz * 1000.0));
 
@@ -7069,9 +7069,9 @@ static void calculate_excess_vactive_bandwidth_required(
 		excess_vactive_fill_bw_l[plane_index] = 0.0;
 		excess_vactive_fill_bw_c[plane_index] = 0.0;
 
-		if (display_cfg->plane_descriptors[plane_index].overrides.max_vactive_det_fill_delay_us > 0) {
-			excess_vactive_fill_bw_l[plane_index] = (double)bytes_required_l[plane_index] / (double)display_cfg->plane_descriptors[plane_index].overrides.max_vactive_det_fill_delay_us;
-			excess_vactive_fill_bw_c[plane_index] = (double)bytes_required_c[plane_index] / (double)display_cfg->plane_descriptors[plane_index].overrides.max_vactive_det_fill_delay_us;
+		if (display_cfg->plane_descriptors[plane_index].overrides.max_vactive_det_fill_delay_us[dml2_pstate_type_uclk] > 0) {
+			excess_vactive_fill_bw_l[plane_index] = (double)bytes_required_l[plane_index] / (double)display_cfg->plane_descriptors[plane_index].overrides.max_vactive_det_fill_delay_us[dml2_pstate_type_uclk];
+			excess_vactive_fill_bw_c[plane_index] = (double)bytes_required_c[plane_index] / (double)display_cfg->plane_descriptors[plane_index].overrides.max_vactive_det_fill_delay_us[dml2_pstate_type_uclk];
 		}
 	}
 }
@@ -9051,11 +9051,11 @@ static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out
 	calculate_bytes_to_fetch_required_to_hide_latency_params->swath_width_c = mode_lib->ms.SwathWidthC;
 	calculate_bytes_to_fetch_required_to_hide_latency_params->swath_height_l = mode_lib->ms.SwathHeightY;
 	calculate_bytes_to_fetch_required_to_hide_latency_params->swath_height_c = mode_lib->ms.SwathHeightC;
-	calculate_bytes_to_fetch_required_to_hide_latency_params->latency_to_hide_us = mode_lib->soc.power_management_parameters.dram_clk_change_blackout_us;
+	calculate_bytes_to_fetch_required_to_hide_latency_params->latency_to_hide_us[0] = mode_lib->soc.power_management_parameters.dram_clk_change_blackout_us;
 
 	/* outputs */
-	calculate_bytes_to_fetch_required_to_hide_latency_params->bytes_required_l = s->pstate_bytes_required_l;
-	calculate_bytes_to_fetch_required_to_hide_latency_params->bytes_required_c = s->pstate_bytes_required_c;
+	calculate_bytes_to_fetch_required_to_hide_latency_params->bytes_required_l = s->pstate_bytes_required_l[dml2_pstate_type_uclk];
+	calculate_bytes_to_fetch_required_to_hide_latency_params->bytes_required_c = s->pstate_bytes_required_c[dml2_pstate_type_uclk];
 
 	calculate_bytes_to_fetch_required_to_hide_latency(calculate_bytes_to_fetch_required_to_hide_latency_params);
 
@@ -9063,8 +9063,8 @@ static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out
 	calculate_excess_vactive_bandwidth_required(
 			display_cfg,
 			mode_lib->ms.num_active_planes,
-			s->pstate_bytes_required_l,
-			s->pstate_bytes_required_c,
+			s->pstate_bytes_required_l[dml2_pstate_type_uclk],
+			s->pstate_bytes_required_c[dml2_pstate_type_uclk],
 			/* outputs */
 			mode_lib->ms.excess_vactive_fill_bw_l,
 			mode_lib->ms.excess_vactive_fill_bw_c);
@@ -9506,8 +9506,8 @@ static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out
 	calculate_vactive_det_fill_latency(
 			display_cfg,
 			mode_lib->ms.num_active_planes,
-			s->pstate_bytes_required_l,
-			s->pstate_bytes_required_c,
+			s->pstate_bytes_required_l[dml2_pstate_type_uclk],
+			s->pstate_bytes_required_c[dml2_pstate_type_uclk],
 			mode_lib->ms.dcc_dram_bw_nom_overhead_factor_p0,
 			mode_lib->ms.dcc_dram_bw_nom_overhead_factor_p1,
 			mode_lib->ms.vactive_sw_bw_l,
@@ -9515,7 +9515,7 @@ static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out
 			mode_lib->ms.surface_avg_vactive_required_bw,
 			mode_lib->ms.surface_peak_required_bw,
 			/* outputs */
-			mode_lib->ms.dram_change_vactive_det_fill_delay_us);
+			mode_lib->ms.pstate_vactive_det_fill_delay_us[dml2_pstate_type_uclk]);
 
 #ifdef __DML_VBA_DEBUG__
 	DML_LOG_VERBOSE("DML::%s: max_urgent_latency_us = %f\n", __func__, s->mSOCParameters.max_urgent_latency_us);
@@ -11009,11 +11009,11 @@ static bool dml_core_mode_programming(struct dml2_core_calcs_mode_programming_ex
 	calculate_bytes_to_fetch_required_to_hide_latency_params->swath_width_c = mode_lib->mp.SwathWidthC;
 	calculate_bytes_to_fetch_required_to_hide_latency_params->swath_height_l = mode_lib->mp.SwathHeightY;
 	calculate_bytes_to_fetch_required_to_hide_latency_params->swath_height_c = mode_lib->mp.SwathHeightC;
-	calculate_bytes_to_fetch_required_to_hide_latency_params->latency_to_hide_us = mode_lib->soc.power_management_parameters.dram_clk_change_blackout_us;
+	calculate_bytes_to_fetch_required_to_hide_latency_params->latency_to_hide_us[0] = mode_lib->soc.power_management_parameters.dram_clk_change_blackout_us;
 
 	/* outputs */
-	calculate_bytes_to_fetch_required_to_hide_latency_params->bytes_required_l = s->pstate_bytes_required_l;
-	calculate_bytes_to_fetch_required_to_hide_latency_params->bytes_required_c = s->pstate_bytes_required_c;
+	calculate_bytes_to_fetch_required_to_hide_latency_params->bytes_required_l = s->pstate_bytes_required_l[dml2_pstate_type_uclk];
+	calculate_bytes_to_fetch_required_to_hide_latency_params->bytes_required_c = s->pstate_bytes_required_c[dml2_pstate_type_uclk];
 
 	calculate_bytes_to_fetch_required_to_hide_latency(calculate_bytes_to_fetch_required_to_hide_latency_params);
 
@@ -11021,8 +11021,8 @@ static bool dml_core_mode_programming(struct dml2_core_calcs_mode_programming_ex
 	calculate_excess_vactive_bandwidth_required(
 			display_cfg,
 			s->num_active_planes,
-			s->pstate_bytes_required_l,
-			s->pstate_bytes_required_c,
+			s->pstate_bytes_required_l[dml2_pstate_type_uclk],
+			s->pstate_bytes_required_c[dml2_pstate_type_uclk],
 			/* outputs */
 			mode_lib->mp.excess_vactive_fill_bw_l,
 			mode_lib->mp.excess_vactive_fill_bw_c);
@@ -12943,7 +12943,8 @@ void dml2_core_calcs_get_plane_support_info(const struct dml2_display_cfg *displ
 
 	out->active_latency_hiding_us = (int)mode_lib->ms.VActiveLatencyHidingUs[plane_idx];
 
-	out->dram_change_vactive_det_fill_delay_us = (unsigned int)math_ceil(mode_lib->ms.dram_change_vactive_det_fill_delay_us[plane_idx]);
+	out->vactive_det_fill_delay_us[dml2_pstate_type_uclk] =
+			(unsigned int)math_ceil(mode_lib->ms.pstate_vactive_det_fill_delay_us[plane_idx][dml2_pstate_type_uclk]);
 }
 
 void dml2_core_calcs_get_stream_support_info(const struct dml2_display_cfg *display_cfg, const struct dml2_core_internal_display_mode_lib *mode_lib, struct core_stream_support_info *out, int plane_index)
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h
index 6d13d4c9b69a..1087a8c926ff 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h
@@ -593,7 +593,7 @@ struct dml2_core_internal_mode_support {
 	double VActiveLatencyHidingMargin[DML2_MAX_PLANES];
 	double VActiveLatencyHidingUs[DML2_MAX_PLANES];
 	unsigned int MaxVStartupLines[DML2_MAX_PLANES];
-	double dram_change_vactive_det_fill_delay_us[DML2_MAX_PLANES];
+	double pstate_vactive_det_fill_delay_us[dml2_pstate_type_count][DML2_MAX_PLANES];
 
 	unsigned int num_mcaches_l[DML2_MAX_PLANES];
 	unsigned int mcache_row_bytes_l[DML2_MAX_PLANES];
@@ -623,8 +623,8 @@ struct dml2_core_internal_mode_support {
 	unsigned int dpte_row_bytes_per_row_l[DML2_MAX_PLANES];
 	unsigned int dpte_row_bytes_per_row_c[DML2_MAX_PLANES];
 
-	unsigned int pstate_bytes_required_l[DML2_MAX_PLANES];
-	unsigned int pstate_bytes_required_c[DML2_MAX_PLANES];
+	unsigned int pstate_bytes_required_l[dml2_pstate_type_count][DML2_MAX_PLANES];
+	unsigned int pstate_bytes_required_c[dml2_pstate_type_count][DML2_MAX_PLANES];
 	unsigned int cursor_bytes_per_chunk[DML2_MAX_PLANES];
 	unsigned int cursor_bytes_per_line[DML2_MAX_PLANES];
 
@@ -1138,8 +1138,8 @@ struct dml2_core_calcs_mode_support_locals {
 	unsigned int cursor_bytes[DML2_MAX_PLANES];
 	bool stream_visited[DML2_MAX_PLANES];
 
-	unsigned int pstate_bytes_required_l[DML2_MAX_PLANES];
-	unsigned int pstate_bytes_required_c[DML2_MAX_PLANES];
+	unsigned int pstate_bytes_required_l[dml2_pstate_type_count][DML2_MAX_PLANES];
+	unsigned int pstate_bytes_required_c[dml2_pstate_type_count][DML2_MAX_PLANES];
 
 	double prefetch_sw_bytes[DML2_MAX_PLANES];
 	double Tpre_rounded[DML2_MAX_PLANES];
@@ -1230,8 +1230,8 @@ struct dml2_core_calcs_mode_programming_locals {
 	double Tr0_trips_flip_rounded[DML2_MAX_PLANES];
 	unsigned int per_pipe_flip_bytes[DML2_MAX_PLANES];
 
-	unsigned int pstate_bytes_required_l[DML2_MAX_PLANES];
-	unsigned int pstate_bytes_required_c[DML2_MAX_PLANES];
+	unsigned int pstate_bytes_required_l[dml2_pstate_type_count][DML2_MAX_PLANES];
+	unsigned int pstate_bytes_required_c[dml2_pstate_type_count][DML2_MAX_PLANES];
 
 	double prefetch_sw_bytes[DML2_MAX_PLANES];
 	double Tpre_rounded[DML2_MAX_PLANES];
@@ -2253,7 +2253,7 @@ struct dml2_core_calcs_calculate_bytes_to_fetch_required_to_hide_latency_params
 	unsigned int *swath_width_c;
 	unsigned int *swath_height_l;
 	unsigned int *swath_height_c;
-	double latency_to_hide_us;
+	double latency_to_hide_us[DML2_MAX_PLANES];
 
 	/* outputs */
 	unsigned int *bytes_required_l;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
index abd210401fe2..c26e100fcaf2 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
@@ -1087,7 +1087,7 @@ static bool all_timings_support_drr(const struct dml2_pmo_instance *pmo,
 
 			/* check required stretch is allowed */
 			if (stream_descriptor->timing.drr_config.max_instant_vtotal_delta > 0 &&
-					stream_pstate_meta->method_drr.stretched_vtotal - stream_pstate_meta->nom_vtotal > stream_descriptor->timing.drr_config.max_instant_vtotal_delta) {
+					stream_pstate_meta->method_drr.stretched_vtotal - stream_pstate_meta->nom_vtotal > (int)stream_descriptor->timing.drr_config.max_instant_vtotal_delta) {
 				return false;
 			}
 		}
@@ -1669,15 +1669,15 @@ static int get_vactive_pstate_margin(const struct display_configuation_with_meta
 	return min_vactive_margin_us;
 }
 
-static unsigned int get_vactive_det_fill_latency_delay_us(const struct display_configuation_with_meta *display_cfg, int plane_mask)
+static int get_vactive_det_fill_latency_delay_us(const struct display_configuation_with_meta *display_cfg, int plane_mask)
 {
 	unsigned char i;
-	unsigned int max_vactive_fill_us = 0;
+	int max_vactive_fill_us = 0;
 
 	for (i = 0; i < DML2_MAX_PLANES; i++) {
 		if (is_bit_set_in_bitfield(plane_mask, i)) {
-			if (display_cfg->mode_support_result.cfg_support_info.plane_support_info[i].dram_change_vactive_det_fill_delay_us > max_vactive_fill_us)
-				max_vactive_fill_us = display_cfg->mode_support_result.cfg_support_info.plane_support_info[i].dram_change_vactive_det_fill_delay_us;
+			if (display_cfg->mode_support_result.cfg_support_info.plane_support_info[i].vactive_det_fill_delay_us[dml2_pstate_type_uclk] > max_vactive_fill_us)
+				max_vactive_fill_us = display_cfg->mode_support_result.cfg_support_info.plane_support_info[i].vactive_det_fill_delay_us[dml2_pstate_type_uclk];
 		}
 	}
 
@@ -2095,7 +2095,7 @@ static void setup_planes_for_vactive_by_mask(struct display_configuation_with_me
 			display_config->stage3.pstate_switch_modes[plane_index] = dml2_pstate_method_vactive;
 
 			if (!pmo->options->disable_vactive_det_fill_bw_pad) {
-				display_config->display_config.plane_descriptors[plane_index].overrides.max_vactive_det_fill_delay_us =
+				display_config->display_config.plane_descriptors[plane_index].overrides.max_vactive_det_fill_delay_us[dml2_pstate_type_uclk] =
 					(unsigned int)math_floor(pmo->scratch.pmo_dcn4.stream_pstate_meta[stream_index].method_vactive.max_vactive_det_fill_delay_us);
 			}
 		}
@@ -2116,7 +2116,7 @@ static void setup_planes_for_vactive_drr_by_mask(struct display_configuation_wit
 			display_config->stage3.pstate_switch_modes[plane_index] = dml2_pstate_method_fw_vactive_drr;
 
 			if (!pmo->options->disable_vactive_det_fill_bw_pad) {
-				display_config->display_config.plane_descriptors[plane_index].overrides.max_vactive_det_fill_delay_us =
+				display_config->display_config.plane_descriptors[plane_index].overrides.max_vactive_det_fill_delay_us[dml2_pstate_type_uclk] =
 					(unsigned int)math_floor(pmo->scratch.pmo_dcn4.stream_pstate_meta[stream_index].method_vactive.max_vactive_det_fill_delay_us);
 			}
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/inc/dml2_internal_shared_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/inc/dml2_internal_shared_types.h
index 9f562f0c4797..1a6c0727cd2a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/inc/dml2_internal_shared_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/inc/dml2_internal_shared_types.h
@@ -152,7 +152,7 @@ struct core_plane_support_info {
 	int active_latency_hiding_us;
 	int mall_svp_size_requirement_ways;
 	int nominal_vblank_pstate_latency_hiding_us;
-	unsigned int dram_change_vactive_det_fill_delay_us;
+	int vactive_det_fill_delay_us[dml2_pstate_type_count];
 };
 
 struct core_stream_support_info {
@@ -209,6 +209,7 @@ struct dml2_core_mode_support_result {
 
 		unsigned int uclk_pstate_supported;
 		unsigned int fclk_pstate_supported;
+		struct dml2_core_internal_watermarks watermarks;
 	} global;
 
 	struct {
@@ -257,8 +258,8 @@ struct dml2_implicit_svp_meta {
 
 struct dml2_pstate_per_method_common_meta {
 	/* generic params */
-	unsigned int allow_start_otg_vline;
-	unsigned int allow_end_otg_vline;
+	int allow_start_otg_vline;
+	int allow_end_otg_vline;
 	/* scheduling params */
 	double allow_time_us;
 	double disallow_time_us;
@@ -268,39 +269,44 @@ struct dml2_pstate_per_method_common_meta {
 struct dml2_pstate_meta {
 	bool valid;
 	double otg_vline_time_us;
-	unsigned int scheduling_delay_otg_vlines;
-	unsigned int vertical_interrupt_ack_delay_otg_vlines;
-	unsigned int allow_to_target_delay_otg_vlines;
-	unsigned int contention_delay_otg_vlines;
-	unsigned int min_allow_width_otg_vlines;
-	unsigned int nom_vtotal;
-	unsigned int vblank_start;
+	int scheduling_delay_otg_vlines;
+	int vertical_interrupt_ack_delay_otg_vlines;
+	int allow_to_target_delay_otg_vlines;
+	int contention_delay_otg_vlines;
+	int min_allow_width_otg_vlines;
+	int nom_vtotal;
+	int vblank_start;
 	double nom_refresh_rate_hz;
 	double nom_frame_time_us;
-	unsigned int max_vtotal;
+	int max_vtotal;
 	double min_refresh_rate_hz;
 	double max_frame_time_us;
-	unsigned int blackout_otg_vlines;
+	int blackout_otg_vlines;
+	int max_allow_delay_otg_vlines;
+	double nom_vblank_time_us;
 	struct {
 		double max_vactive_det_fill_delay_us;
-		unsigned int max_vactive_det_fill_delay_otg_vlines;
+		double vactive_latency_hiding_us;
+		double reserved_vblank_required_us;
+		int max_vactive_det_fill_delay_otg_vlines;
+		int reserved_blank_required_vlines;
 		struct dml2_pstate_per_method_common_meta common;
 	} method_vactive;
 	struct {
 		struct dml2_pstate_per_method_common_meta common;
 	} method_vblank;
 	struct {
-		unsigned int programming_delay_otg_vlines;
-		unsigned int df_throttle_delay_otg_vlines;
-		unsigned int prefetch_to_mall_delay_otg_vlines;
+		int programming_delay_otg_vlines;
+		int df_throttle_delay_otg_vlines;
+		int prefetch_to_mall_delay_otg_vlines;
 		unsigned long phantom_vactive;
 		unsigned long phantom_vfp;
 		unsigned long phantom_vtotal;
 		struct dml2_pstate_per_method_common_meta common;
 	} method_subvp;
 	struct {
-		unsigned int programming_delay_otg_vlines;
-		unsigned int stretched_vtotal;
+		int programming_delay_otg_vlines;
+		int stretched_vtotal;
 		struct dml2_pstate_per_method_common_meta common;
 	} method_drr;
 };
-- 
2.43.0

