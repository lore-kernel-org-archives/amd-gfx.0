Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14CDAFA0C43
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2026 07:44:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5A7410E69E;
	Wed, 15 Apr 2026 07:44:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jWt8n/03";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011043.outbound.protection.outlook.com [52.101.52.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7327010E6A1
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Apr 2026 07:44:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MLdW3YSmZK5P5Kl4crKy+pzOCrSv+eWcAX74vv8RHSFicWH4jOgQE2siuN1r+IXlgGt40yUjFodgL2BkCXKCa9E6RJ6nsZjg5fMi7XgrkHqvZUQK13le7srdKyeioAieU6XmqOCgh1cMDyNz0peKPNeh1wB25PFh/OAXhiBI06Da2nrwo1gyiqLgVhA3UW2jbQCKBP3kjQnrjjt4dABKHFsmfbGxwnMo06Yr5wQbYWh56PtqZO92jef1z3J0pNiyN9swd9gPNcTUWcHi+V/JDnQe8+kaDk7pz4aIjqPLGGoax1ZM6E+i6cG/tVTrs0aTTxxGa4GAQ+TYCXe7BjTB0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BGUdqR+bQTlhlusUZs8VYmWfx30HDpGmGio9xSD2Z5w=;
 b=XaUjrRBpF32QX1LcjsZaZ+0EWwY4BLzJHBcLhLByhggRCdMt558+a9o0AMX9GtbQ5pD6ylfZVYiisSCpaC6ji/nRWRISLL9cdlvfuV1+P0jf7OedKpDm2RtA1Qdqq499qwx3pdzHo+IwbesvHO64AzTFvat1pkSDmk6PKD4g8KlsUn10TAAn5l8HEELKhzm856QdmJ5YjgqNk1hHyHg3FOMNELZ+pxD0kebXT1Dl4guehIXMg+a+QUtmSunijAs1Khy/H2OA+FYCYm1XpE9Yeh6kzVDtKB6T0OQa204luk2N9txTWjvSf+ohgEQNmZyJ2rhj6NxsV5uQtzTfxzBgzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGUdqR+bQTlhlusUZs8VYmWfx30HDpGmGio9xSD2Z5w=;
 b=jWt8n/039JkQRAZAjwEzvI4jh2vAJ91ITMauuEfd2HVW5ZTTgwg21DpAXX6XWn6mv89Qfx49Yr9fvEcweGZ/qx0ZNvN4IDz2GChuxm0MF1nQ39jdtoiplbm3qd6ASn/CTh29YB+BxoacSxYZqml304PRbT/+7NCVl0++DMA9Gi8=
Received: from DM6PR11CA0004.namprd11.prod.outlook.com (2603:10b6:5:190::17)
 by SA1PR12MB6823.namprd12.prod.outlook.com (2603:10b6:806:25e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 15 Apr
 2026 07:44:14 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:5:190:cafe::b5) by DM6PR11CA0004.outlook.office365.com
 (2603:10b6:5:190::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Wed,
 15 Apr 2026 07:44:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 07:44:12 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 15 Apr
 2026 02:44:12 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 15 Apr 2026 02:44:09 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Chuanyu Tseng <Chuanyu.Tseng@amd.com>, "Gaghik
 Khachatrian" <gaghik.khachatrian@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 15/19] drm/amd/display: Fix dml2_0 narrowing boundaries
Date: Wed, 15 Apr 2026 15:39:54 +0800
Message-ID: <20260415074223.34848-16-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415074223.34848-1-chen-yu.chen@amd.com>
References: <20260415074223.34848-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|SA1PR12MB6823:EE_
X-MS-Office365-Filtering-Correlation-Id: 09dbd497-6338-4b9f-ac97-08de9ac2c98f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|56012099003|22082099003|18002099003|20052099010;
X-Microsoft-Antispam-Message-Info: WwxWB1f0deXjGsBztXADOaBVrNysmwJSgRmGPfJD8o7O94aBdyw0Iu6zCQxdP7AgI7kK+KupTCW6GJq2YUlJCu4hMRUlew+c4g2hTLKxNiIuTUr+Ao+oJRNDQ63VkX7xw3IwDHK71PLbY+AanBk/0fxKM0hXtJ1Z7d3Xnsa8vjMuW0rXPRVKYnaiUgoUs+OuQ8XR2YMUQm8xAYUAeJlDUgYX6nFMfMwm1D91D5qCrtkRgs+FcQ82D7mTWzSek3fhduHbTNNT0rDsXOe3anQpqiqWJUOc8m6tvJTGG3enuo/fuNXqHgGwgBjmKMj6YlXhrWsqGQovSmx1Bz/VaxL2oSbGV8aspz8jnHOHBbCLPz4/yrceQLQH1pkneDvsxbCEs0g6ZK4frVqbd0Mavx6rT23Wz9Aoc0AKQxv23Kng8/oFqa31ubqfr2bkoGBwvda0YxL8MBjCc2v9n8Hl1zaVrZDV4i+kSh7u12hjeQNzV40a2UOU6Nzp7E5URt5hY89dUy1HX4Ys4K1m8KgFCKR0c7X5L24w3KomxeowZ2suQG/V1bJetmTNriAJluRoiLnP4cz8QZklaX9JNAHENZbImDAo6h5E9MuRKkrqt11HE9E5v2BVCe+5byDO5yO1T8KEJiGzpO14y+RPMAMDECoVoIBwLOPqeKlLnsYBX48cANZgB9ZhCsZwucT0guesQtX5hbigKe1JbhxOsnt6nz8BdMm2HmjUF8UNeEfIRuVnVdxSa0BEArvWn7Gg5nvMWMbHr6oOyl/M+3VRX1CEMwHySg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(56012099003)(22082099003)(18002099003)(20052099010);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: o14ZC/iq9/6Cc8nab+I9hfY+LbRT38L95FL2SpAyHMiDY9pCtyhRN0dMEoVxaZBlSxnBBGbaRlXnr0Dsc1eMW4RHwhRK4BdZ/zeEe82NZhmIgj5RpC+MSwu7q1pTxw3U7zqO5POoX+46XA44I2q49QGv1GPWesKHWVZqV8PnbwnZ+eoZ2O/efeoCdcy3Y81JdopU7si8SyJ5BZfWrY3vpYi8GPoerYLUF4CwObbdGIhOZjKN7SDcrCAZ4iVyIQIOwO/ZKwB+Zim4UVpbpmwiCFuVIRL+f0cAaGjv4zGX2UdfB7Bsw6P1G7ToaZhAtH4VClntRiH7aaltXcojqrjjgC3O//Bw+KUyYgEPSt0RePIjBiqQSB+rEJKkUsp6M/ku6FNz/Ixjz/oXQUhftnWWd6og3UJtL8e85b1RBCWbr27/ze+gqdLJfIDg2ACE8vsn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 07:44:12.8664 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09dbd497-6338-4b9f-ac97-08de9ac2c98f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6823
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

[Why] drm/amd/display dml2_0 code had implicit narrowing conversions reported by
a warning in timing, watermark, and translation paths.

[How] Apply explicit boundary casts for intentional narrowing, preserve wider
intermediate math, and use wider timing intermediates where required for safe
range handling.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Gaghik Khachatrian <gaghik.khachatrian@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../amd/display/dc/dml2_0/display_mode_core.c |  14 +--
 .../amd/display/dc/dml2_0/display_mode_util.c |  20 ++--
 .../dml2_0/dml21/dml21_translation_helper.c   |   8 +-
 .../amd/display/dc/dml2_0/dml21/dml21_utils.c |   2 +-
 .../amd/display/dc/dml2_0/dml2_mall_phantom.c | 100 +++++++++---------
 .../drm/amd/display/dc/dml2_0/dml2_policy.c   |   6 +-
 .../dc/dml2_0/dml2_translation_helper.c       |   4 +-
 .../drm/amd/display/dc/dml2_0/dml2_utils.c    |  40 +++----
 8 files changed, 97 insertions(+), 97 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_core.c b/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_core.c
index 698d62fb9cf7..16514f1e4ed9 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_core.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_core.c
@@ -1119,10 +1119,10 @@ static dml_bool_t CalculatePrefetchSchedule(struct display_mode_lib_scratch_st *
 	if (p->myPipe->Dppclk == 0.0 || p->myPipe->Dispclk == 0.0)
 		return true;
 
-	*p->DSTXAfterScaler = (dml_uint_t) dml_round(s->DPPCycles * p->myPipe->PixelClock / p->myPipe->Dppclk + s->DISPCLKCycles * p->myPipe->PixelClock / p->myPipe->Dispclk + p->DSCDelay, 1.0);
+	*p->DSTXAfterScaler = (dml_uint_t) dml_round(s->DPPCycles * p->myPipe->PixelClock / p->myPipe->Dppclk + s->DISPCLKCycles * p->myPipe->PixelClock / p->myPipe->Dispclk + p->DSCDelay, true);
 	*p->DSTXAfterScaler = (dml_uint_t) dml_round(*p->DSTXAfterScaler + (p->myPipe->ODMMode != dml_odm_mode_bypass ? 18 : 0) + (p->myPipe->DPPPerSurface - 1) * p->DPP_RECOUT_WIDTH +
 						((p->myPipe->ODMMode == dml_odm_mode_split_1to2 || p->myPipe->ODMMode == dml_odm_mode_mso_1to2) ? (dml_float_t)p->myPipe->HActive / 2.0 : 0) +
-						((p->myPipe->ODMMode == dml_odm_mode_mso_1to4) ? (dml_float_t)p->myPipe->HActive * 3.0 / 4.0 : 0), 1.0);
+						((p->myPipe->ODMMode == dml_odm_mode_mso_1to4) ? (dml_float_t)p->myPipe->HActive * 3.0 / 4.0 : 0), true);
 
 #ifdef __DML_VBA_DEBUG__
 	dml_print("DML::%s: DPPCycles = %u\n", __func__, s->DPPCycles);
@@ -4301,7 +4301,7 @@ static void CalculateSwathAndDETConfiguration(struct display_mode_lib_scratch_st
 
 	*p->compbuf_reserved_space_64b = 2 * p->PixelChunkSizeInKByte * 1024 / 64;
 	if (*p->UnboundedRequestEnabled) {
-		*p->compbuf_reserved_space_64b = dml_max(*p->compbuf_reserved_space_64b,
+		*p->compbuf_reserved_space_64b = (dml_uint_t)dml_max(*p->compbuf_reserved_space_64b,
 				(dml_float_t)(p->ROBBufferSizeInKByte * 1024/64)
 				- (dml_float_t)(RoundedUpSwathSizeBytesY[SurfaceDoingUnboundedRequest] * TTUFIFODEPTH / MAXIMUMCOMPRESSION/64));
 	}
@@ -6178,9 +6178,9 @@ static void CalculateImmediateFlipBandwithSupport(
 
 static dml_uint_t MicroSecToVertLines(dml_uint_t num_us, dml_uint_t h_total, dml_float_t pixel_clock)
 {
-	dml_uint_t lines_time_in_ns = 1000.0 * (h_total * 1000.0) / (pixel_clock * 1000.0);
+	dml_uint_t lines_time_in_ns = (dml_uint_t)(1000.0 * (h_total * 1000.0) / (pixel_clock * 1000.0));
 
-	return dml_ceil(1000.0 * num_us / lines_time_in_ns, 1.0);
+	return (dml_uint_t)dml_ceil(1000.0 * num_us / lines_time_in_ns, 1.0);
 }
 
 /// @brief Calculate the maximum vstartup for mode support and mode programming consideration
@@ -6207,9 +6207,9 @@ static dml_uint_t CalculateMaxVStartup(
 	// + 2 is because
 	// 1 -> VStartup_start should be 1 line before VSync
 	// 1 -> always reserve 1 line between start of VBlank to VStartup signal
-	dml_uint_t vblank_nom_vsync_capped = dml_max(vblank_nom_input,
+	dml_uint_t vblank_nom_vsync_capped = (dml_uint_t)dml_max(vblank_nom_input,
 			timing->VTotal[plane_idx] - timing->VActive[plane_idx] - timing->VFrontPorch[plane_idx] + 2);
-	dml_uint_t vblank_nom_max_allowed_capped = dml_min(vblank_nom_vsync_capped, max_allowed_vblank_nom);
+	dml_uint_t vblank_nom_max_allowed_capped = (dml_uint_t)dml_min(vblank_nom_vsync_capped, max_allowed_vblank_nom);
 	dml_uint_t vblank_avail = (vblank_nom_max_allowed_capped == 0) ?
 			vblank_nom_default_in_line : vblank_nom_max_allowed_capped;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_util.c b/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_util.c
index b2fada6c44c3..3939a0d8b835 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_util.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_util.c
@@ -80,7 +80,7 @@ static inline float dcn_bw_pow(float a, float exp)
 	/*ASSERT(exp == (int)exp);*/
 	if ((int)exp == 0)
 		return 1;
-	temp = dcn_bw_pow(a, (int)(exp / 2));
+	temp = dcn_bw_pow(a, (float)(exp / 2));
 	if (((int)exp % 2) == 0) {
 		return temp * temp;
 	} else {
@@ -110,7 +110,7 @@ dml_float_t dml_ceil(dml_float_t x, dml_float_t granularity)
 	if (granularity == 0)
 		return 0;
 	//return (dml_float_t) (ceil(x / granularity) * granularity);
-	return (dml_float_t)dcn_bw_ceil2(x, granularity);
+	return (dml_float_t)dcn_bw_ceil2((float)x, (float)granularity);
 }
 
 dml_float_t dml_floor(dml_float_t x, dml_float_t granularity)
@@ -118,7 +118,7 @@ dml_float_t dml_floor(dml_float_t x, dml_float_t granularity)
 	if (granularity == 0)
 	return 0;
 	//return (dml_float_t) (floor(x / granularity) * granularity);
-	return (dml_float_t)dcn_bw_floor2(x, granularity);
+	return (dml_float_t)dcn_bw_floor2((float)x, (float)granularity);
 }
 
 dml_float_t dml_min(dml_float_t x, dml_float_t y)
@@ -168,12 +168,12 @@ dml_float_t dml_max5(dml_float_t a, dml_float_t b, dml_float_t c, dml_float_t d,
 }
 dml_float_t dml_log(dml_float_t x, dml_float_t base)
 {
-	return (dml_float_t) (_log(x) / _log(base));
+	return (dml_float_t) (_log((float)x) / _log((float)base));
 }
 
 dml_float_t dml_log2(dml_float_t x)
 {
-	return (dml_float_t) (_log(x) / _log(2));
+	return (dml_float_t) (_log((float)x) / _log(2.0f));
 }
 
 dml_float_t dml_round(dml_float_t val, dml_bool_t bankers_rounding)
@@ -184,19 +184,19 @@ dml_float_t dml_round(dml_float_t val, dml_bool_t bankers_rounding)
 //	else {
 //		return round(val);
 		double round_pt = 0.5;
-		double ceil = dml_ceil(val, 1);
-		double floor = dml_floor(val, 1);
+	double ceil = dml_ceil(val, 1.0);
+	double floor = dml_floor(val, 1.0);
 
 		if (val - floor >= round_pt)
-			return ceil;
+			return (dml_float_t)ceil;
 		else
-			return floor;
+			return (dml_float_t)floor;
 //	}
 }
 
 dml_float_t dml_pow(dml_float_t base, int exp)
 {
-	return (dml_float_t) dcn_bw_pow(base, exp);
+	return (dml_float_t) dcn_bw_pow((float)base, (float)exp);
 }
 
 dml_uint_t dml_round_to_multiple(dml_uint_t num, dml_uint_t multiple, dml_bool_t up)
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
index 9031fd582ec7..d89fd876975e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
@@ -851,10 +851,10 @@ void dml21_copy_clocks_to_dc_state(struct dml2_context *in_ctx, struct dc_state
 	context->bw_ctx.bw.dcn.clk.socclk_khz = in_ctx->v21.mode_programming.programming->min_clocks.dcn4x.socclk_khz;
 	context->bw_ctx.bw.dcn.clk.subvp_prefetch_dramclk_khz = in_ctx->v21.mode_programming.programming->min_clocks.dcn4x.svp_prefetch_no_throttle.uclk_khz;
 	context->bw_ctx.bw.dcn.clk.subvp_prefetch_fclk_khz = in_ctx->v21.mode_programming.programming->min_clocks.dcn4x.svp_prefetch_no_throttle.fclk_khz;
-	context->bw_ctx.bw.dcn.clk.stutter_efficiency.base_efficiency = in_ctx->v21.mode_programming.programming->stutter.base_percent_efficiency;
-	context->bw_ctx.bw.dcn.clk.stutter_efficiency.low_power_efficiency = in_ctx->v21.mode_programming.programming->stutter.low_power_percent_efficiency;
-	context->bw_ctx.bw.dcn.clk.stutter_efficiency.z8_stutter_efficiency = in_ctx->v21.mode_programming.programming->informative.power_management.z8.stutter_efficiency;
-	context->bw_ctx.bw.dcn.clk.stutter_efficiency.z8_stutter_period = in_ctx->v21.mode_programming.programming->informative.power_management.z8.stutter_period;
+	context->bw_ctx.bw.dcn.clk.stutter_efficiency.base_efficiency = (uint8_t)in_ctx->v21.mode_programming.programming->stutter.base_percent_efficiency;
+	context->bw_ctx.bw.dcn.clk.stutter_efficiency.low_power_efficiency = (uint8_t)in_ctx->v21.mode_programming.programming->stutter.low_power_percent_efficiency;
+	context->bw_ctx.bw.dcn.clk.stutter_efficiency.z8_stutter_efficiency = (uint8_t)in_ctx->v21.mode_programming.programming->informative.power_management.z8.stutter_efficiency;
+	context->bw_ctx.bw.dcn.clk.stutter_efficiency.z8_stutter_period = (int)in_ctx->v21.mode_programming.programming->informative.power_management.z8.stutter_period;
 	context->bw_ctx.bw.dcn.clk.zstate_support = in_ctx->v21.mode_programming.programming->z8_stutter.supported_in_blank; /*ignore meets_eco since it is not used*/
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.c
index 732de97335fa..835fece1d46a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.c
@@ -267,7 +267,7 @@ static struct dc_stream_state *dml21_add_phantom_stream(struct dml2_context *dml
 	phantom_stream->dst.height = stream_programming->phantom_stream.descriptor.timing.v_active;
 
 	phantom_stream->src.y = 0;
-	phantom_stream->src.height = (double)phantom_stream_descriptor->timing.v_active * (double)main_stream->src.height / (double)main_stream->dst.height;
+	phantom_stream->src.height = (int)((double)phantom_stream_descriptor->timing.v_active * (double)main_stream->src.height / (double)main_stream->dst.height);
 
 	phantom_stream->use_dynamic_meta = false;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_mall_phantom.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_mall_phantom.c
index 9bbe4e058be7..fe667aea6ec8 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_mall_phantom.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_mall_phantom.c
@@ -244,9 +244,9 @@ static bool assign_subvp_pipe(struct dml2_context *ctx, struct dc_state *context
 			continue;
 
 		// Round up
-		refresh_rate = (pipe->stream->timing.pix_clk_100hz * 100 +
+		refresh_rate = (unsigned int)((pipe->stream->timing.pix_clk_100hz * 100 +
 				pipe->stream->timing.v_total * pipe->stream->timing.h_total - 1)
-				/ (double)(pipe->stream->timing.v_total * pipe->stream->timing.h_total);
+				/ (double)(pipe->stream->timing.v_total * pipe->stream->timing.h_total));
 		/* SubVP pipe candidate requirements:
 		 * - Refresh rate < 120hz
 		 * - Not able to switch in vactive naturally (switching in active means the
@@ -264,8 +264,8 @@ static bool assign_subvp_pipe(struct dml2_context *ctx, struct dc_state *context
 			pipe = &context->res_ctx.pipe_ctx[i];
 			if (num_pipes <= free_pipes) {
 				struct dc_stream_state *stream = pipe->stream;
-				unsigned int frame_us = (stream->timing.v_total * stream->timing.h_total /
-						(double)(stream->timing.pix_clk_100hz * 100)) * 1000000;
+				unsigned int frame_us = (unsigned int)((stream->timing.v_total * stream->timing.h_total /
+						(double)(stream->timing.pix_clk_100hz * 100)) * 1000000);
 				if (frame_us > max_frame_time && !stream->ignore_msa_timing_param) {
 					*index = i;
 					max_frame_time = frame_us;
@@ -382,8 +382,8 @@ static bool subvp_subvp_schedulable(struct dml2_context *ctx, struct dc_state *c
 					phantom->timing.v_addressable;
 
 			// Round up when calculating microschedule time (+ 1 at the end)
-			time_us = (microschedule_lines * phantom->timing.h_total) /
-					(double)(phantom->timing.pix_clk_100hz * 100) * 1000000 +
+			time_us = (uint32_t)((microschedule_lines * phantom->timing.h_total) /
+					(double)(phantom->timing.pix_clk_100hz * 100) * 1000000) +
 					ctx->config.svp_pstate.subvp_prefetch_end_to_mall_start_us +
 					ctx->config.svp_pstate.subvp_fw_processing_delay_us + 1;
 			if (time_us > max_microschedule_us)
@@ -402,16 +402,16 @@ static bool subvp_subvp_schedulable(struct dml2_context *ctx, struct dc_state *c
 	if (index < 2 || !subvp_pipes[0] || !subvp_pipes[1])
 		return false;
 
-	vactive1_us = ((subvp_pipes[0]->stream->timing.v_addressable * subvp_pipes[0]->stream->timing.h_total) /
-			(double)(subvp_pipes[0]->stream->timing.pix_clk_100hz * 100)) * 1000000;
-	vactive2_us = ((subvp_pipes[1]->stream->timing.v_addressable * subvp_pipes[1]->stream->timing.h_total) /
-				(double)(subvp_pipes[1]->stream->timing.pix_clk_100hz * 100)) * 1000000;
-	vblank1_us = (((subvp_pipes[0]->stream->timing.v_total - subvp_pipes[0]->stream->timing.v_addressable) *
+	vactive1_us = (int32_t)(((subvp_pipes[0]->stream->timing.v_addressable * subvp_pipes[0]->stream->timing.h_total) /
+			(double)(subvp_pipes[0]->stream->timing.pix_clk_100hz * 100)) * 1000000);
+	vactive2_us = (int32_t)(((subvp_pipes[1]->stream->timing.v_addressable * subvp_pipes[1]->stream->timing.h_total) /
+				(double)(subvp_pipes[1]->stream->timing.pix_clk_100hz * 100)) * 1000000);
+	vblank1_us = (int32_t)(((subvp_pipes[0]->stream->timing.v_total - subvp_pipes[0]->stream->timing.v_addressable) *
 			subvp_pipes[0]->stream->timing.h_total) /
-			(double)(subvp_pipes[0]->stream->timing.pix_clk_100hz * 100)) * 1000000;
-	vblank2_us = (((subvp_pipes[1]->stream->timing.v_total - subvp_pipes[1]->stream->timing.v_addressable) *
+			(double)(subvp_pipes[0]->stream->timing.pix_clk_100hz * 100) * 1000000);
+	vblank2_us = (int32_t)(((subvp_pipes[1]->stream->timing.v_total - subvp_pipes[1]->stream->timing.v_addressable) *
 			subvp_pipes[1]->stream->timing.h_total) /
-			(double)(subvp_pipes[1]->stream->timing.pix_clk_100hz * 100)) * 1000000;
+			(double)(subvp_pipes[1]->stream->timing.pix_clk_100hz * 100) * 1000000);
 
 	if ((vactive1_us - vblank2_us) / 2 > max_microschedule_us &&
 	    (vactive2_us - vblank1_us) / 2 > max_microschedule_us)
@@ -445,13 +445,13 @@ bool dml2_svp_drr_schedulable(struct dml2_context *ctx, struct dc_state *context
 	struct dc_crtc_timing *main_timing = NULL;
 	struct dc_crtc_timing *phantom_timing = NULL;
 	struct dc_stream_state *phantom_stream;
-	int16_t prefetch_us = 0;
-	int16_t mall_region_us = 0;
-	int16_t drr_frame_us = 0;	// nominal frame time
-	int16_t subvp_active_us = 0;
-	int16_t stretched_drr_us = 0;
-	int16_t drr_stretched_vblank_us = 0;
-	int16_t max_vblank_mallregion = 0;
+	int32_t prefetch_us = 0;
+	int32_t mall_region_us = 0;
+	int32_t drr_frame_us = 0;	// nominal frame time
+	int32_t subvp_active_us = 0;
+	int32_t stretched_drr_us = 0;
+	int32_t drr_stretched_vblank_us = 0;
+	int32_t max_vblank_mallregion = 0;
 
 	// Find SubVP pipe
 	for (i = 0; i < ctx->config.dcn_pipe_count; i++) {
@@ -475,19 +475,19 @@ bool dml2_svp_drr_schedulable(struct dml2_context *ctx, struct dc_state *context
 	phantom_stream = ctx->config.svp_pstate.callbacks.get_paired_subvp_stream(context, pipe->stream);
 	main_timing = &pipe->stream->timing;
 	phantom_timing = &phantom_stream->timing;
-	prefetch_us = (phantom_timing->v_total - phantom_timing->v_front_porch) * phantom_timing->h_total /
+	prefetch_us = (int32_t)((phantom_timing->v_total - phantom_timing->v_front_porch) * phantom_timing->h_total /
 			(double)(phantom_timing->pix_clk_100hz * 100) * 1000000 +
-			ctx->config.svp_pstate.subvp_prefetch_end_to_mall_start_us;
-	subvp_active_us = main_timing->v_addressable * main_timing->h_total /
-			(double)(main_timing->pix_clk_100hz * 100) * 1000000;
-	drr_frame_us = drr_timing->v_total * drr_timing->h_total /
-			(double)(drr_timing->pix_clk_100hz * 100) * 1000000;
+			ctx->config.svp_pstate.subvp_prefetch_end_to_mall_start_us);
+	subvp_active_us = (int32_t)(main_timing->v_addressable * main_timing->h_total /
+			(double)(main_timing->pix_clk_100hz * 100) * 1000000);
+	drr_frame_us = (int32_t)(drr_timing->v_total * drr_timing->h_total /
+			(double)(drr_timing->pix_clk_100hz * 100) * 1000000);
 	// P-State allow width and FW delays already included phantom_timing->v_addressable
-	mall_region_us = phantom_timing->v_addressable * phantom_timing->h_total /
-			(double)(phantom_timing->pix_clk_100hz * 100) * 1000000;
+	mall_region_us = (int32_t)(phantom_timing->v_addressable * phantom_timing->h_total /
+			(double)(phantom_timing->pix_clk_100hz * 100) * 1000000);
 	stretched_drr_us = drr_frame_us + mall_region_us + SUBVP_DRR_MARGIN_US;
-	drr_stretched_vblank_us = (drr_timing->v_total - drr_timing->v_addressable) * drr_timing->h_total /
-			(double)(drr_timing->pix_clk_100hz * 100) * 1000000 + (stretched_drr_us - drr_frame_us);
+	drr_stretched_vblank_us = (int32_t)((drr_timing->v_total - drr_timing->v_addressable) * drr_timing->h_total /
+			(double)(drr_timing->pix_clk_100hz * 100) * 1000000 + (stretched_drr_us - drr_frame_us));
 	max_vblank_mallregion = drr_stretched_vblank_us > mall_region_us ? drr_stretched_vblank_us : mall_region_us;
 
 	/* We consider SubVP + DRR schedulable if the stretched frame duration of the DRR display (i.e. the
@@ -526,12 +526,12 @@ static bool subvp_vblank_schedulable(struct dml2_context *ctx, struct dc_state *
 	bool schedulable = false;
 	uint32_t i = 0;
 	uint8_t vblank_index = 0;
-	uint16_t prefetch_us = 0;
-	uint16_t mall_region_us = 0;
-	uint16_t vblank_frame_us = 0;
-	uint16_t subvp_active_us = 0;
-	uint16_t vblank_blank_us = 0;
-	uint16_t max_vblank_mallregion = 0;
+	uint32_t prefetch_us = 0;
+	uint32_t mall_region_us = 0;
+	uint32_t vblank_frame_us = 0;
+	uint32_t subvp_active_us = 0;
+	uint32_t vblank_blank_us = 0;
+	uint32_t max_vblank_mallregion = 0;
 	struct dc_crtc_timing *main_timing = NULL;
 	struct dc_crtc_timing *phantom_timing = NULL;
 	struct dc_crtc_timing *vblank_timing = NULL;
@@ -581,18 +581,18 @@ static bool subvp_vblank_schedulable(struct dml2_context *ctx, struct dc_state *
 		vblank_timing = &context->res_ctx.pipe_ctx[vblank_index].stream->timing;
 		// Prefetch time is equal to VACTIVE + BP + VSYNC of the phantom pipe
 		// Also include the prefetch end to mallstart delay time
-		prefetch_us = (phantom_timing->v_total - phantom_timing->v_front_porch) * phantom_timing->h_total /
+		prefetch_us = (uint32_t)((phantom_timing->v_total - phantom_timing->v_front_porch) * phantom_timing->h_total /
 				(double)(phantom_timing->pix_clk_100hz * 100) * 1000000 +
-				ctx->config.svp_pstate.subvp_prefetch_end_to_mall_start_us;
+				ctx->config.svp_pstate.subvp_prefetch_end_to_mall_start_us);
 		// P-State allow width and FW delays already included phantom_timing->v_addressable
-		mall_region_us = phantom_timing->v_addressable * phantom_timing->h_total /
-				(double)(phantom_timing->pix_clk_100hz * 100) * 1000000;
-		vblank_frame_us = vblank_timing->v_total * vblank_timing->h_total /
-				(double)(vblank_timing->pix_clk_100hz * 100) * 1000000;
-		vblank_blank_us =  (vblank_timing->v_total - vblank_timing->v_addressable) * vblank_timing->h_total /
-				(double)(vblank_timing->pix_clk_100hz * 100) * 1000000;
-		subvp_active_us = main_timing->v_addressable * main_timing->h_total /
-				(double)(main_timing->pix_clk_100hz * 100) * 1000000;
+		mall_region_us = (uint32_t)(phantom_timing->v_addressable * phantom_timing->h_total /
+				(double)(phantom_timing->pix_clk_100hz * 100) * 1000000);
+		vblank_frame_us = (uint32_t)(vblank_timing->v_total * vblank_timing->h_total /
+				(double)(vblank_timing->pix_clk_100hz * 100) * 1000000);
+		vblank_blank_us = (uint32_t)((vblank_timing->v_total - vblank_timing->v_addressable) * vblank_timing->h_total /
+				(double)(vblank_timing->pix_clk_100hz * 100) * 1000000);
+		subvp_active_us = (uint32_t)(main_timing->v_addressable * main_timing->h_total /
+				(double)(main_timing->pix_clk_100hz * 100) * 1000000);
 		max_vblank_mallregion = vblank_blank_us > mall_region_us ? vblank_blank_us : mall_region_us;
 
 		// Schedulable if VACTIVE region of the SubVP pipe can fit the MALL prefetch, VBLANK frame time,
@@ -694,10 +694,10 @@ static void set_phantom_stream_timing(struct dml2_context *ctx, struct dc_state
 	}
 
 	// Calculate lines required for pstate allow width and FW processing delays
-	pstate_width_fw_delay_lines = ((double)(ctx->config.svp_pstate.subvp_fw_processing_delay_us +
+	pstate_width_fw_delay_lines = (uint32_t)(((double)(ctx->config.svp_pstate.subvp_fw_processing_delay_us +
 			ctx->config.svp_pstate.subvp_pstate_allow_width_us) / 1000000) *
 			(ref_pipe->stream->timing.pix_clk_100hz * 100) /
-			(double)ref_pipe->stream->timing.h_total;
+			(double)ref_pipe->stream->timing.h_total);
 
 	// DML calculation for MALL region doesn't take into account FW delay
 	// and required pstate allow width for multi-display cases
@@ -712,7 +712,7 @@ static void set_phantom_stream_timing(struct dml2_context *ctx, struct dc_state
 	fp_and_sync_width_time = (phantom_stream->timing.v_front_porch + phantom_stream->timing.v_sync_width) * line_time;
 
 	if ((svp_vstartup * line_time) + fp_and_sync_width_time > cvt_rb_vblank_max) {
-		svp_vstartup = (cvt_rb_vblank_max - fp_and_sync_width_time) / line_time;
+		svp_vstartup = (unsigned int)((cvt_rb_vblank_max - fp_and_sync_width_time) / line_time);
 	}
 
 	// For backporch of phantom pipe, use vstartup of the main pipe
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_policy.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_policy.c
index ef693f608d59..ab2964811c5b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_policy.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_policy.c
@@ -123,9 +123,9 @@ int dml2_policy_build_synthetic_soc_states(struct dml2_policy_build_synthetic_so
 	struct dml2_policy_build_synthetic_soc_states_params *p)
 {
 	int i, j;
-	unsigned int min_fclk_mhz = p->in_states->state_array[0].fabricclk_mhz;
-	unsigned int min_dcfclk_mhz = p->in_states->state_array[0].dcfclk_mhz;
-	unsigned int min_socclk_mhz = p->in_states->state_array[0].socclk_mhz;
+	unsigned int min_fclk_mhz = (unsigned int)p->in_states->state_array[0].fabricclk_mhz;
+	unsigned int min_dcfclk_mhz = (unsigned int)p->in_states->state_array[0].dcfclk_mhz;
+	unsigned int min_socclk_mhz = (unsigned int)p->in_states->state_array[0].socclk_mhz;
 
 	int max_dcfclk_mhz = 0, max_dispclk_mhz = 0, max_dppclk_mhz = 0,
 		max_phyclk_mhz = 0, max_dtbclk_mhz = 0, max_fclk_mhz = 0,
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_translation_helper.c
index 8e0997441ee0..0d8ff236c6d0 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_translation_helper.c
@@ -508,11 +508,11 @@ void dml2_init_soc_states(struct dml2_context *dml2, const struct dc *in_dc,
 	/* DCFCLK stas values are project specific */
 	if ((dml2->v20.dml_core_ctx.project == dml_project_dcn32) ||
 		(dml2->v20.dml_core_ctx.project == dml_project_dcn321)) {
-		p->dcfclk_stas_mhz[0] = p->in_states->state_array[0].dcfclk_mhz;
+		p->dcfclk_stas_mhz[0] = (int)p->in_states->state_array[0].dcfclk_mhz;
 		p->dcfclk_stas_mhz[1] = 615;
 		p->dcfclk_stas_mhz[2] = 906;
 		p->dcfclk_stas_mhz[3] = 1324;
-		p->dcfclk_stas_mhz[4] = p->in_states->state_array[1].dcfclk_mhz;
+		p->dcfclk_stas_mhz[4] = (int)p->in_states->state_array[1].dcfclk_mhz;
 	} else if (dml2->v20.dml_core_ctx.project != dml_project_dcn35 &&
 			dml2->v20.dml_core_ctx.project != dml_project_dcn36 &&
 			dml2->v20.dml_core_ctx.project != dml_project_dcn351) {
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_utils.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_utils.c
index 86567e232415..1bc81e26a11f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_utils.c
@@ -333,7 +333,7 @@ void dml2_calculate_rq_and_dlg_params(const struct dc *dc, struct dc_state *cont
 		}
 
 		context->bw_ctx.bw.dcn.compbuf_size_kb -= context->res_ctx.pipe_ctx[dc_pipe_ctx_index].det_buffer_size_kb;
-		context->res_ctx.pipe_ctx[dc_pipe_ctx_index].plane_res.bw.dppclk_khz = dml_get_dppclk_calculated(&context->bw_ctx.dml2->v20.dml_core_ctx, dml_pipe_idx) * 1000;
+		context->res_ctx.pipe_ctx[dc_pipe_ctx_index].plane_res.bw.dppclk_khz = (int)(dml_get_dppclk_calculated(&context->bw_ctx.dml2->v20.dml_core_ctx, dml_pipe_idx) * 1000);
 		if (context->bw_ctx.bw.dcn.clk.dppclk_khz < context->res_ctx.pipe_ctx[dc_pipe_ctx_index].plane_res.bw.dppclk_khz)
 			context->bw_ctx.bw.dcn.clk.dppclk_khz = context->res_ctx.pipe_ctx[dc_pipe_ctx_index].plane_res.bw.dppclk_khz;
 
@@ -362,10 +362,10 @@ void dml2_calculate_rq_and_dlg_params(const struct dc *dc, struct dc_state *cont
 	context->bw_ctx.bw.dcn.clk.bw_dppclk_khz = context->bw_ctx.bw.dcn.clk.dppclk_khz;
 	context->bw_ctx.bw.dcn.clk.bw_dispclk_khz = context->bw_ctx.bw.dcn.clk.dispclk_khz;
 
-	context->bw_ctx.bw.dcn.clk.max_supported_dppclk_khz = in_ctx->v20.dml_core_ctx.states.state_array[in_ctx->v20.scratch.mode_support_params.out_lowest_state_idx].dppclk_mhz
-		* 1000;
-	context->bw_ctx.bw.dcn.clk.max_supported_dispclk_khz = in_ctx->v20.dml_core_ctx.states.state_array[in_ctx->v20.scratch.mode_support_params.out_lowest_state_idx].dispclk_mhz
-		* 1000;
+	context->bw_ctx.bw.dcn.clk.max_supported_dppclk_khz = (int)(in_ctx->v20.dml_core_ctx.states.state_array[in_ctx->v20.scratch.mode_support_params.out_lowest_state_idx].dppclk_mhz
+		* 1000);
+	context->bw_ctx.bw.dcn.clk.max_supported_dispclk_khz = (int)(in_ctx->v20.dml_core_ctx.states.state_array[in_ctx->v20.scratch.mode_support_params.out_lowest_state_idx].dispclk_mhz
+		* 1000);
 
 	if (dc->config.forced_clocks || dc->debug.max_disp_clk) {
 		context->bw_ctx.bw.dcn.clk.bw_dispclk_khz = context->bw_ctx.bw.dcn.clk.max_supported_dispclk_khz;
@@ -375,18 +375,18 @@ void dml2_calculate_rq_and_dlg_params(const struct dc *dc, struct dc_state *cont
 
 void dml2_extract_watermark_set(struct dcn_watermarks *watermark, struct display_mode_lib_st *dml_core_ctx)
 {
-	watermark->urgent_ns = dml_get_wm_urgent(dml_core_ctx) * 1000;
-	watermark->cstate_pstate.cstate_enter_plus_exit_ns = dml_get_wm_stutter_enter_exit(dml_core_ctx) * 1000;
-	watermark->cstate_pstate.cstate_exit_ns = dml_get_wm_stutter_exit(dml_core_ctx) * 1000;
-	watermark->cstate_pstate.pstate_change_ns = dml_get_wm_dram_clock_change(dml_core_ctx) * 1000;
-	watermark->pte_meta_urgent_ns = dml_get_wm_memory_trip(dml_core_ctx) * 1000;
-	watermark->frac_urg_bw_nom = dml_get_fraction_of_urgent_bandwidth(dml_core_ctx) * 1000;
-	watermark->frac_urg_bw_flip = dml_get_fraction_of_urgent_bandwidth_imm_flip(dml_core_ctx) * 1000;
-	watermark->urgent_latency_ns = dml_get_urgent_latency(dml_core_ctx) * 1000;
-	watermark->cstate_pstate.fclk_pstate_change_ns = dml_get_wm_fclk_change(dml_core_ctx) * 1000;
-	watermark->usr_retraining_ns = dml_get_wm_usr_retraining(dml_core_ctx) * 1000;
-	watermark->cstate_pstate.cstate_enter_plus_exit_z8_ns = dml_get_wm_z8_stutter_enter_exit(dml_core_ctx) * 1000;
-	watermark->cstate_pstate.cstate_exit_z8_ns = dml_get_wm_z8_stutter(dml_core_ctx) * 1000;
+	watermark->urgent_ns = (uint32_t)(dml_get_wm_urgent(dml_core_ctx) * 1000);
+	watermark->cstate_pstate.cstate_enter_plus_exit_ns = (uint32_t)(dml_get_wm_stutter_enter_exit(dml_core_ctx) * 1000);
+	watermark->cstate_pstate.cstate_exit_ns = (uint32_t)(dml_get_wm_stutter_exit(dml_core_ctx) * 1000);
+	watermark->cstate_pstate.pstate_change_ns = (uint32_t)(dml_get_wm_dram_clock_change(dml_core_ctx) * 1000);
+	watermark->pte_meta_urgent_ns = (uint32_t)(dml_get_wm_memory_trip(dml_core_ctx) * 1000);
+	watermark->frac_urg_bw_nom = (uint32_t)(dml_get_fraction_of_urgent_bandwidth(dml_core_ctx) * 1000);
+	watermark->frac_urg_bw_flip = (uint32_t)(dml_get_fraction_of_urgent_bandwidth_imm_flip(dml_core_ctx) * 1000);
+	watermark->urgent_latency_ns = (uint32_t)(dml_get_urgent_latency(dml_core_ctx) * 1000);
+	watermark->cstate_pstate.fclk_pstate_change_ns = (uint32_t)(dml_get_wm_fclk_change(dml_core_ctx) * 1000);
+	watermark->usr_retraining_ns = (uint32_t)(dml_get_wm_usr_retraining(dml_core_ctx) * 1000);
+	watermark->cstate_pstate.cstate_enter_plus_exit_z8_ns = (uint32_t)(dml_get_wm_z8_stutter_enter_exit(dml_core_ctx) * 1000);
+	watermark->cstate_pstate.cstate_exit_z8_ns = (uint32_t)(dml_get_wm_z8_stutter(dml_core_ctx) * 1000);
 }
 
 unsigned int dml2_calc_max_scaled_time(
@@ -434,9 +434,9 @@ void dml2_extract_writeback_wm(struct dc_state *context, struct display_mode_lib
 		for (j = 0 ; j < 4; j++) {
 			/*current dml only has one set of watermark, need to follow up*/
 			bw_writeback->mcif_wb_arb[i].cli_watermark[j] =
-					dml_get_wm_writeback_urgent(dml_core_ctx) * 1000;
+					(unsigned int)(dml_get_wm_writeback_urgent(dml_core_ctx) * 1000);
 			bw_writeback->mcif_wb_arb[i].pstate_watermark[j] =
-					dml_get_wm_writeback_dram_clock_change(dml_core_ctx) * 1000;
+					(unsigned int)(dml_get_wm_writeback_dram_clock_change(dml_core_ctx) * 1000);
 		}
 		if (context->res_ctx.pipe_ctx[i].stream->phy_pix_clk != 0) {
 			/* time_per_pixel should be in u6.6 format */
@@ -450,7 +450,7 @@ void dml2_extract_writeback_wm(struct dc_state *context, struct display_mode_lib
 					wbif_mode, 	wb_arb_params->cli_watermark[0]);
 		/*not required any more*/
 		bw_writeback->mcif_wb_arb[i].dram_speed_change_duration =
-			dml_get_wm_writeback_dram_clock_change(dml_core_ctx) * 1000;
+			(unsigned int)(dml_get_wm_writeback_dram_clock_change(dml_core_ctx) * 1000);
 
 	}
 }
-- 
2.43.0

