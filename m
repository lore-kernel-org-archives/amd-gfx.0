Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D6FD6AAF7
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Apr 2026 18:34:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CF7610F291;
	Thu,  2 Apr 2026 18:34:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cQQGuK52";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013052.outbound.protection.outlook.com
 [40.93.201.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76F4010F28C
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Apr 2026 18:34:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FLOAsyAPMXLxhq7d8E2lxSXRLNA5IUsBWPGUg35tjvZ6egWI2m6cCw1caa4nWKlNVM5QTNIJTXn+MWPW39cx8Uoj1dHFTHMWMx+dp90EdauoZ9DJCY4f2neMeNe8n+5ygqcYAonSZWuwOttdViwTou699E7IgHx5/4nrDS/XQUH8p9Bm8K/KHRNuHsPhRDuuRarNfG584vfbAnS16+3sk/dYQIiBVgCdVM5dSlw8kMW68NUsca5J/Zei6wrnw/Vwl+19h7C6e6pK98Sd1B3/gW36kaoHhtRmpQCUzARvX6XDdhsxRdYcB47kZ+8m4IRLYgtM93+EqGsA+wGrHogknw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXmhX0fX5P0ApWKDW3t//vY5SFw++gILmFiMAbYwxT8=;
 b=Je1V0QDEw6MBsCV6G5FgDQX7krFUwXwjhiLPfQstQuqEYU7yF/Dw3XMfkWu8NH3rK8btf8xr0RPBJFPxyLT26hQBWcRgTjThQd/w1vXR01jbCRTXB9sWPmBR79niTBXmnx0vTF6CStywd2tIvwDHMBdFU/luAhtu0aZBc2vKvPlFYsKPXbQc8gJLDF96tcQ6mdBnY/G2+l2rW3W9QB2SSDFXnM23hzN9KOwQMaOrHkHI3axQIvuLgA6izCZAackYDh00UX7mHqeCXStRZ366s0Q6YfgJXEW5Cd85K7ASGH+WqBxe4P2eWLZCAR5JgjqiL5icvMLoV1/8nlRBH5AIMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXmhX0fX5P0ApWKDW3t//vY5SFw++gILmFiMAbYwxT8=;
 b=cQQGuK52FXzbreT5OkIZ5yCuR/bJHcuE2oZHa9lr5nW7W8ZUUQtmb+d7soOByjuzv4ymXt8hj104r/y4VDIvLUXNmG4Sub0Cdb5bwuOiVMYS54sKIk4iKi1YJK1LGYPfaCAIB6roaD57NQVkYvFBODxYEbuess+lMtYdBG59j7c=
Received: from CH5P221CA0010.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::28)
 by LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 2 Apr
 2026 18:34:21 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:610:1f2:cafe::46) by CH5P221CA0010.outlook.office365.com
 (2603:10b6:610:1f2::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.20 via Frontend Transport; Thu,
 2 Apr 2026 18:34:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 18:34:20 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 2 Apr
 2026 13:34:13 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 2 Apr
 2026 13:34:12 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 2 Apr 2026 13:34:11 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Chuanyu Tseng <Chuanyu.Tseng@amd.com>, "Gaghik
 Khachatrian" <gaghik.khachatrian@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH 16/22] drm/amd/display: Fix implicit narrowing conversions in
 modules
Date: Thu, 2 Apr 2026 14:33:08 -0400
Message-ID: <20260402183314.1388755-17-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260402183314.1388755-1-Roman.Li@amd.com>
References: <20260402183314.1388755-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|LV3PR12MB9404:EE_
X-MS-Office365-Filtering-Correlation-Id: 52c07fb0-7b5b-462d-a8cb-08de90e674ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: mE6wO6KBfpG3f80sN2DoJiS10pBJCZk79LKS2+0Baz6pCEBZgQPEGIHfLRItPXf9jZHfutjIk7gYnrpBEfjLOylGssseXALFUFXso/w1MOvEueealAuA7Vrx5qpLDArmPkaVsyXOHn9dVXPmhA9HYJ/2f7fjA/4ctdzNOiCcvAvSlZ0o3Xo9sertAmZSPgB/RgxFGBnOCno6RG8/UoYdYhQArTOV1TvtRVL6ELxNnXTiojjoKCKbb/UUtIXlXuajlzNVRv24Z8ER31G/c+LkwrG5CW+y6oqIrVLJELUj1G8fs3dzAIiV4uZY1z5MHDBJFEs/7Ir/pKXKUFMiVH7HwqjR38OfcoFXxNZEQaV85hQxXl+WM0D0ZybohvV3beA6xhg2syORXgGh2WmPL8AAkAhbRgqiRYkR7Slm1GYRc50htET1mrpaJJLQI55oLLD13X4WowVSGN6sxQd+vPxAyl7TsANy9HH3rL9X1j9jkMnvu44Sp3OR3j0/u6LcuHX/touFpuI+02eX+36qEu2gd1NgpFBbblnKaoU5TeCt7apoe0DPSYNBcOeeFJZPjhoohjGhnh4jQacb8IP4YYPU6C2X/794PIvefNz5t2jU4Lg0HVYhydGhpBCagW6jbjrZsEgKqy+YIo292DWJfPheY4P3NnWJCBk+i4DQI5sIlwUwIrbqQa3q6774NbrJHEV/Eh8EE39kdeVaLmm4gKPkMYWNdi5QHLpVE7SUIphLB+nKVcPg0YM55E2vfeTw7QZmWLnxswFlbz8299Rh9c0kZg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aFmm+lJEPOETxPYi0LF6IawTPoCSDwA/PCrIehP8CgwX7aeXsrAQt0mr0so0g1VkMNSi2mGCaoCDuXJaHMZl0rWppGqs4faewDHhkGdydyQem5iY8wBzNTGGXAqN7qvEX8qC40Yxtz7XqM6+Kjp3lXHFneHMYiFTunb/UmAjlGKAZNXiUT1ZmPth+2WM8Q2QzI+RtS0f1n1bYpj/kZ5jpEA5UH757A6Gy0jR+U4xnP6hCS4EF34H2BPw2sHonRDmE2gc76jtmKUEcUQMJkcKfJpr28T2AClpL6qhoirX3ENcCUWjSyIaHfYQ2G7taDvpU0vW/j/AdDKFiC7iaTdDCN79GKchyvwmbUk2bZFGZ/aZjor6qVxRQwTnkPgSmwKp6JTZlsBY0NqmU8JOaAa2sydiZeYXh8O9IiDCuXtvyTuPHW7qRTGo2U8XextJJW3W
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 18:34:20.8704 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52c07fb0-7b5b-462d-a8cb-08de90e674ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9404
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

From: Gaghik Khachatrian <gaghik.khachatrian@amd.com>

[Why]: Implicit narrowing of wider integer types (unsigned int, uint64_t)
into narrower fields (uint8_t, uint16_t, unsigned short) has potential
truncation issues.

[How]: For each warning site, added ASSERT(<value> <= 0xFFFF/0xFF) for
debug-mode bounds verification followed by an explicit cast. Typed
intermediate variables introduced where needed for clarity.

No functional change intended.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Gaghik Khachatrian <gaghik.khachatrian@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../amd/display/modules/freesync/freesync.c   | 32 +++++++-----
 .../amd/display/modules/power/power_helpers.c | 49 +++++++++++++------
 .../gpu/drm/amd/display/modules/vmid/vmid.c   |  8 ++-
 3 files changed, 61 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index b7e03dda700c..c0b0e5edae24 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -153,7 +153,7 @@ unsigned int mod_freesync_calc_v_total_from_refresh(
 		 * round down the vtotal value to avoid stretching vblank over
 		 * panel's vtotal boundary.
 		 */
-		v_total = div64_u64(div64_u64(((unsigned long long)(
+		v_total = (unsigned int)div64_u64(div64_u64(((unsigned long long)(
 				frame_duration_in_ns) * (stream->timing.pix_clk_100hz / 10)),
 				stream->timing.h_total), 1000000);
 	} else if (refresh_in_uhz >= stream->timing.max_refresh_in_uhz) {
@@ -161,11 +161,11 @@ unsigned int mod_freesync_calc_v_total_from_refresh(
 		 * round up the vtotal value to prevent off-by-one error causing
 		 * v_total_min to be below the panel's lower bound
 		 */
-		v_total = div64_u64(div64_u64(((unsigned long long)(
+		v_total = (unsigned int)div64_u64(div64_u64(((unsigned long long)(
 				frame_duration_in_ns) * (stream->timing.pix_clk_100hz / 10)),
 				stream->timing.h_total) + (1000000 - 1), 1000000);
 	} else {
-		v_total = div64_u64(div64_u64(((unsigned long long)(
+		v_total = (unsigned int)div64_u64(div64_u64(((unsigned long long)(
 				frame_duration_in_ns) * (stream->timing.pix_clk_100hz / 10)),
 				stream->timing.h_total) + 500000, 1000000);
 	}
@@ -196,11 +196,11 @@ static unsigned int calc_v_total_from_duration(
 		uint32_t h_total_up_scaled;
 
 		h_total_up_scaled = stream->timing.h_total * 10000;
-		v_total = div_u64((unsigned long long)duration_in_us
+		v_total = (unsigned int)div_u64((unsigned long long)duration_in_us
 					* stream->timing.pix_clk_100hz + (h_total_up_scaled - 1),
 					h_total_up_scaled); //ceiling for MMax and MMin for MVRR
 	} else {
-		v_total = div64_u64(div64_u64(((unsigned long long)(
+		v_total = (unsigned int)div64_u64(div64_u64(((unsigned long long)(
 					duration_in_us) * (stream->timing.pix_clk_100hz / 10)),
 					stream->timing.h_total), 1000);
 	}
@@ -232,22 +232,28 @@ static void update_v_total_for_static_ramp(
 				target_duration_in_us;
 
 	/* Calculate ratio between new and current frame duration with 3 digit */
-	unsigned int frame_duration_ratio = div64_u64(1000000,
+	uint64_t frame_duration_ratio_u64 = div64_u64(1000000,
 		(1000 +  div64_u64(((unsigned long long)(
 		STATIC_SCREEN_RAMP_DELTA_REFRESH_RATE_PER_FRAME) *
 		current_duration_in_us),
 		1000000)));
+	ASSERT(frame_duration_ratio_u64 <= 0xFFFFFFFF);
+	unsigned int frame_duration_ratio = (unsigned int)frame_duration_ratio_u64;
 
 	/* Calculate delta between new and current frame duration in us */
-	unsigned int frame_duration_delta = div64_u64(((unsigned long long)(
+	uint64_t frame_duration_delta_u64 = div64_u64(((unsigned long long)(
 		current_duration_in_us) *
 		(1000 - frame_duration_ratio)), 1000);
+	ASSERT(frame_duration_delta_u64 <= 0xFFFFFFFF);
+	unsigned int frame_duration_delta = (unsigned int)frame_duration_delta_u64;
 
 	/* Adjust frame duration delta based on ratio between current and
 	 * standard frame duration (frame duration at 60 Hz refresh rate).
 	 */
-	unsigned int ramp_rate_interpolated = div64_u64(((unsigned long long)(
+	uint64_t ramp_rate_interpolated_u64 = div64_u64(((unsigned long long)(
 		frame_duration_delta) * current_duration_in_us), 16666);
+	ASSERT(ramp_rate_interpolated_u64 <= 0xFFFFFFFF);
+	unsigned int ramp_rate_interpolated = (unsigned int)ramp_rate_interpolated_u64;
 
 	/* Going to a higher refresh rate (lower frame duration) */
 	if (ramp_direction_is_up) {
@@ -277,7 +283,7 @@ static void update_v_total_for_static_ramp(
 		}
 	}
 
-	v_total = div64_u64(div64_u64(((unsigned long long)(
+	v_total = (unsigned int)div64_u64(div64_u64(((unsigned long long)(
 			current_duration_in_us) * (stream->timing.pix_clk_100hz / 10)),
 				stream->timing.h_total), 1000);
 
@@ -1058,8 +1064,12 @@ void mod_freesync_build_vrr_params(struct mod_freesync *mod_freesync,
 		else
 			in_out_vrr->fixed_refresh_in_uhz = 0;
 
-		refresh_range = div_u64(in_out_vrr->max_refresh_in_uhz + 500000, 1000000) -
-				div_u64(in_out_vrr->min_refresh_in_uhz + 500000, 1000000);
+		{
+			uint64_t rr_tmp = div_u64(in_out_vrr->max_refresh_in_uhz + 500000, 1000000) -
+					div_u64(in_out_vrr->min_refresh_in_uhz + 500000, 1000000);
+			ASSERT(rr_tmp <= 0xFFFFFFFF);
+			refresh_range = (unsigned int)rr_tmp;
+		}
 
 		in_out_vrr->supported = true;
 	}
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
index df3b8383b06d..5d444e9eb38f 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
@@ -250,10 +250,12 @@ static void fill_backlight_transform_table(struct dmcu_iram_parameters params,
 	unsigned int lut_index;
 
 	table->backlight_thresholds[0] = 0;
-	table->backlight_offsets[0] = params.backlight_lut_array[0];
+	ASSERT(params.backlight_lut_array[0] <= 0xFFFF);
+	table->backlight_offsets[0] = (uint16_t)params.backlight_lut_array[0];
 	table->backlight_thresholds[num_entries-1] = 0xFFFF;
+	ASSERT(params.backlight_lut_array[params.backlight_lut_array_size - 1] <= 0xFFFF);
 	table->backlight_offsets[num_entries-1] =
-		params.backlight_lut_array[params.backlight_lut_array_size - 1];
+		(uint16_t)params.backlight_lut_array[params.backlight_lut_array_size - 1];
 
 	/* Setup all brightness levels between 0% and 100% exclusive
 	 * Fills brightness-to-backlight transform table. Backlight custom curve
@@ -265,12 +267,17 @@ static void fill_backlight_transform_table(struct dmcu_iram_parameters params,
 	 */
 	for (i = 1; i+1 < num_entries; i++) {
 		lut_index = (params.backlight_lut_array_size - 1) * i / (num_entries - 1);
+
 		ASSERT(lut_index < params.backlight_lut_array_size);
 
-		table->backlight_thresholds[i] =
-			cpu_to_be16(DIV_ROUNDUP((i * 65536), num_entries));
-		table->backlight_offsets[i] =
-			cpu_to_be16(params.backlight_lut_array[lut_index]);
+		unsigned int threshold_val = DIV_ROUNDUP((i * 65536), num_entries);
+		unsigned int offset_val = params.backlight_lut_array[lut_index];
+
+		ASSERT(threshold_val <= 0xFFFF);
+		ASSERT(offset_val <= 0xFFFF);
+
+		table->backlight_thresholds[i] = cpu_to_be16((uint16_t)threshold_val);
+		table->backlight_offsets[i]    = cpu_to_be16((uint16_t)offset_val);
 	}
 }
 
@@ -282,10 +289,12 @@ static void fill_backlight_transform_table_v_2_2(struct dmcu_iram_parameters par
 	unsigned int lut_index;
 
 	table->backlight_thresholds[0] = 0;
-	table->backlight_offsets[0] = params.backlight_lut_array[0];
+	ASSERT(params.backlight_lut_array[0] <= 0xFFFF);
+	table->backlight_offsets[0] = (uint16_t)params.backlight_lut_array[0];
 	table->backlight_thresholds[num_entries-1] = 0xFFFF;
+	ASSERT(params.backlight_lut_array[params.backlight_lut_array_size - 1] <= 0xFFFF);
 	table->backlight_offsets[num_entries-1] =
-		params.backlight_lut_array[params.backlight_lut_array_size - 1];
+		(uint16_t)params.backlight_lut_array[params.backlight_lut_array_size - 1];
 
 	/* Setup all brightness levels between 0% and 100% exclusive
 	 * Fills brightness-to-backlight transform table. Backlight custom curve
@@ -299,12 +308,16 @@ static void fill_backlight_transform_table_v_2_2(struct dmcu_iram_parameters par
 		lut_index = DIV_ROUNDUP((i * params.backlight_lut_array_size), num_entries);
 		ASSERT(lut_index < params.backlight_lut_array_size);
 
+		unsigned int threshold_val = DIV_ROUNDUP((i * 65536), num_entries);
+		unsigned int offset_val = params.backlight_lut_array[lut_index];
+
+		ASSERT(threshold_val <= 0xFFFF);
+		ASSERT(offset_val <= 0xFFFF);
+
 		table->backlight_thresholds[i] = (big_endian) ?
-			cpu_to_be16(DIV_ROUNDUP((i * 65536), num_entries)) :
-			cpu_to_le16(DIV_ROUNDUP((i * 65536), num_entries));
+			cpu_to_be16((uint16_t)threshold_val) : cpu_to_le16((uint16_t)threshold_val);
 		table->backlight_offsets[i] = (big_endian) ?
-			cpu_to_be16(params.backlight_lut_array[lut_index]) :
-			cpu_to_le16(params.backlight_lut_array[lut_index]);
+			cpu_to_be16((uint16_t)offset_val) : cpu_to_le16((uint16_t)offset_val);
 	}
 }
 
@@ -740,9 +753,12 @@ bool dmub_init_abm_config(struct resource_pool *res_pool,
 	}
 
 	if (params.backlight_ramping_override) {
+
+		ASSERT(params.backlight_ramping_reduction <= 0xFFFF);
+		ASSERT(params.backlight_ramping_start <= 0xFFFF);
 		for (i = 0; i < NUM_AGGR_LEVEL; i++) {
-			config.blRampReduction[i] = params.backlight_ramping_reduction;
-			config.blRampStart[i] = params.backlight_ramping_start;
+			config.blRampReduction[i] = (uint16_t)params.backlight_ramping_reduction;
+			config.blRampStart[i]     = (uint16_t)params.backlight_ramping_start;
 		}
 	} else {
 		for (i = 0; i < NUM_AGGR_LEVEL; i++) {
@@ -1060,6 +1076,7 @@ void calculate_replay_link_off_frame_count(struct dc_link *link,
 bool fill_custom_backlight_caps(unsigned int config_no, struct dm_acpi_atif_backlight_caps *caps)
 {
 	unsigned int data_points_size;
+	uint64_t caps_size;
 
 	if (config_no >= ARRAY_SIZE(custom_backlight_profiles))
 		return false;
@@ -1067,7 +1084,9 @@ bool fill_custom_backlight_caps(unsigned int config_no, struct dm_acpi_atif_back
 	data_points_size = custom_backlight_profiles[config_no].num_data_points
 			* sizeof(custom_backlight_profiles[config_no].data_points[0]);
 
-	caps->size = sizeof(struct dm_acpi_atif_backlight_caps) - sizeof(caps->data_points) + data_points_size;
+	caps_size = sizeof(struct dm_acpi_atif_backlight_caps) - sizeof(caps->data_points) + data_points_size;
+	ASSERT(caps_size <= 0xFFFF);
+	caps->size = (uint16_t)caps_size;
 	caps->flags = 0;
 	caps->error_code = 0;
 	caps->ac_level_percentage = custom_backlight_profiles[config_no].ac_level_percentage;
diff --git a/drivers/gpu/drm/amd/display/modules/vmid/vmid.c b/drivers/gpu/drm/amd/display/modules/vmid/vmid.c
index 2c40212d86da..0f8fab5f5c6a 100644
--- a/drivers/gpu/drm/amd/display/modules/vmid/vmid.c
+++ b/drivers/gpu/drm/amd/display/modules/vmid/vmid.c
@@ -57,7 +57,10 @@ static void clear_entry_from_vmid_table(struct core_vmid *core_vmid, unsigned in
 static void evict_vmids(struct core_vmid *core_vmid)
 {
 	int i;
-	uint16_t ord = dc_get_vmid_use_vector(core_vmid->dc);
+	int ord_int = dc_get_vmid_use_vector(core_vmid->dc);
+
+	ASSERT(ord_int >= 0 && ord_int <= 0xFFFF);
+	uint16_t ord = (uint16_t)ord_int;
 
 	// At this point any positions with value 0 are unused vmids, evict them
 	for (i = 1; i < core_vmid->num_vmid; i++) {
@@ -120,7 +123,8 @@ uint8_t mod_vmid_get_for_ptb(struct mod_vmid *mod_vmid, uint64_t ptb)
 			ASSERT(0);
 	}
 
-	return vmid;
+	ASSERT(vmid >= 0 && vmid <= 0xFF);
+	return (uint8_t)vmid;
 }
 
 void mod_vmid_reset(struct mod_vmid *mod_vmid)
-- 
2.34.1

