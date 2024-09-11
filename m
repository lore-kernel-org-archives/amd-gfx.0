Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24414EE57C0
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Sep 2024 16:23:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C359D10EA52;
	Wed, 11 Sep 2024 16:23:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5U6ajDRw";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2243A10EA52
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Sep 2024 16:23:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xYJSY7cpPBh1ztDNowkGxweUuxCxlLnvBWHw2eYu14oadmPYBCbnLMzevk3YCZv9mJQwQIULzv6B20CPaFrCDEJ/85yVWZSBX9GioIi4ssqKXF1hmB7erujm4hg+jbDsVCoawRsfVp1VAYt3bQP25J4Cqpwd8xFIObrZELT46LJof278CBriIqtKiqTpBNd0AxHXtBTYcOgwr5EgUlRdMj/Z1Yf23UCkn0RtyK7uHH7Rkjv4RPD2c1stjmS0pW0C8SH8HRTQngeZA9IkqOz5n5FvX7DaOB8wzotqyNiPPQxe15rFyBMuZrfy8Osgyaij/GAclGDjOzrG/OI9qCXTZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8saem52heQtmrxTKVaE6TPkO8GB21vcAdKOHgDfmEbc=;
 b=v6kC8H/WqxM5N+KejK/JgRkAdN9UF/rUAn6qAu9BGYXGocUpNLEooU+KnyqT2FAUcnYADm742vQJ9/RdbByChx+VVGoffb/Oq0MGtEIao1D8HZwK4KxAX+5Z8aSnG2UIFVu7vAF51IzwRxPxjYssRnfpGIJKBN2LyAnYu0nGPFZcWw1nJ1dAKacmFo5kBEqGIXR2SAiXmaBTH81+WZ2TFgNZCILqY4j6y08+YiOD2JA67Z5Ju9ncc/PGdne/Vu7u+WtLfDIQTFR40UF18yaW39IleFvWQHiy0pZ2xH32ELS2afz+Z9KJEF1VZq0YdGnEROctChOmXavB6jodk0ouaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8saem52heQtmrxTKVaE6TPkO8GB21vcAdKOHgDfmEbc=;
 b=5U6ajDRwkge+hss5VSBRjSC1ByE/TEoEjkXbPwnsooaPpkfhpvc38ADID1hGbFalm4zFp9TMoH2oSC4V9k9/VsGGv2jANIj8dz6cr16M+Kq4hdfvkJ9s/nH5ISiAQ3PVU1+0W2ol8FAGQIEcxwItVuRa08PYjilQeRXVMsURF30=
Received: from BN0PR04CA0122.namprd04.prod.outlook.com (2603:10b6:408:ed::7)
 by LV2PR12MB5966.namprd12.prod.outlook.com (2603:10b6:408:171::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Wed, 11 Sep
 2024 16:23:29 +0000
Received: from BL02EPF0002992B.namprd02.prod.outlook.com
 (2603:10b6:408:ed:cafe::b9) by BN0PR04CA0122.outlook.office365.com
 (2603:10b6:408:ed::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Wed, 11 Sep 2024 16:23:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0002992B.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 16:23:29 +0000
Received: from shire.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Sep
 2024 11:23:26 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Samson Tam <Samson.Tam@amd.com>, Jun Lei
 <jun.lei@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 08/23] drm/amd/display: Add debug options to change sharpen
 policies
Date: Wed, 11 Sep 2024 10:20:50 -0600
Message-ID: <20240911162105.3567133-9-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911162105.3567133-1-alex.hung@amd.com>
References: <20240911162105.3567133-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992B:EE_|LV2PR12MB5966:EE_
X-MS-Office365-Filtering-Correlation-Id: 4761febd-bc13-42f9-03c1-08dcd27e121b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kerSuSzqYm3jzXPKXvCB8oYPdRMOsVYneewBe68+M1fjDauAWPTlJZfLiqlS?=
 =?us-ascii?Q?l6LznE3HW2Qk6XlahlHqStoW/qMM/RL4nLrNuVrByivChmQlxOVYpyaNUvtj?=
 =?us-ascii?Q?w22sbiJRqG0zaeEiQSYPpLrnsAEC5B3dyoljMn+A9xWnyMtqpZXnkY24hFz5?=
 =?us-ascii?Q?AtH/weetbaUvAaszOaC4Zq/dHsZWDIxv3lo7FVi3FqkKq6hTOfXnKJhgqGm5?=
 =?us-ascii?Q?qU7a4eS5yVu+ZIJDywiblebLU9wkjxwNjZsLF/tmgqj6hD8yxr6K+VLiXmAJ?=
 =?us-ascii?Q?jNp3YdMixWJIo4krbWJhh7eWuocSfubca6HYNMvxF1gJ7IcJ0C+Jxa2GD95j?=
 =?us-ascii?Q?NqYb8UnYwxys3Rx9LK9whFQ9XJUe0Wht4JeHWkQfH4B/esvF63OeRc8MVSzC?=
 =?us-ascii?Q?HS4eYZU5DKrwioCpa6bWHJEHOD24wdFQ8EJoy2v2OA8VVMO8PnpimMGbRzLC?=
 =?us-ascii?Q?PDv0V8wbUQehT4tMZAgiS7mSI8zlRXaSlgROpn2mnrdpYrPEVc8/xPc9NrdP?=
 =?us-ascii?Q?t2S7F4vOMhgn5oX9VASlcYBZVvaEbQmMpxOTszMPSz62RCaSUB7Yu/mCSLJO?=
 =?us-ascii?Q?f37Xf9nRp+YL4ZCwpSwbFDn3Pc5OXvOiv5SnjYTs4T6k4gsAcUCiuxkU39qo?=
 =?us-ascii?Q?aBBhjph3CqTbnF9VqC4w/Q3S+dt7Nzle9Z4HPv98EwTOJNJ4WaxuScXz1UCQ?=
 =?us-ascii?Q?Vnds2gOjYHcIE/GdV4bFRiiDk4vBqpU94a9Tw6LE0x3jhpVNn7/8FbUVPp7m?=
 =?us-ascii?Q?NKOiFtxawOA+cPvOqLQ+3YXm/Lp0J4TpljfMvAHaIOe/ZqCj4n3l6BnDWV/A?=
 =?us-ascii?Q?RKLUuSEeF1QuBHKe7750Xm4bLtPiZhMnxIuUB/Sa1DjcoHNre3a2BRNVPFNC?=
 =?us-ascii?Q?ve6qV1f8Mk773+cAMPRdd1xzdNVUmpn+/YPWP855q9DDxnngRcyY46kEGqVs?=
 =?us-ascii?Q?x4VdoLcgiH67alRcZ4FZgpgK/EGaCFI4OCZapiFsM0KsvRKRDQMtGwAuOckW?=
 =?us-ascii?Q?f15ugY5z+dirxK9t06NCVIo/JWFVPIO1Nfiqf3sA7NL3F/dDcQ70QH1/XjHN?=
 =?us-ascii?Q?WscwIlQGjz7lSt5BKHAoWbWKW+oyD0KYiur+WSloTXMxGeDIuC6ih3+bU4YW?=
 =?us-ascii?Q?BC7oGi57o2eL0HHB5Rr714r/3eLeAf5V8p803lu6oGSLPzVKx4Dld1ZdJtBc?=
 =?us-ascii?Q?cy9l42/QBYUyjbT1dJi2Ha1vOgkJ3NXt544UOW+VlUFUWBRT2/4FDzeB0PEA?=
 =?us-ascii?Q?N+Ny+jW9UhUaxlx9Vjy4iqc5kuWij/LJ1lDa3tRPXsnMH6SIV5KDppsP0W5c?=
 =?us-ascii?Q?QwuJ7MS7boXbWTzovDvb9MycUezXvG6w0BbYtMnIurh7+IaEBnyMo00IliSL?=
 =?us-ascii?Q?t6RIIlCBEgSRLKqCDxHkuMBtG82v6XIFHn16yvTAZe3zMsfEVhNg18BtV1t3?=
 =?us-ascii?Q?kmZ32euKKno=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 16:23:29.0459 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4761febd-bc13-42f9-03c1-08dcd27e121b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5966
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

From: Samson Tam <Samson.Tam@amd.com>

[WHY]
Add options to change sharpen policy based on surface format
and scaling ratios.

[HOW]
Add sharpen_policy to change policy based on surface format
and scale_to_sharpness_policy based on scaling ratios.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Signed-off-by: Samson Tam <Samson.Tam@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +
 .../gpu/drm/amd/display/dc/dc_spl_translate.c |  5 ++
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.c   | 34 ++++++--
 .../display/dc/spl/dc_spl_isharp_filters.c    | 85 +++++++++++++++++--
 .../display/dc/spl/dc_spl_isharp_filters.h    |  9 +-
 .../gpu/drm/amd/display/dc/spl/dc_spl_types.h | 12 +++
 6 files changed, 128 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index dcf8a90e961d..7c4812dd1a71 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1056,6 +1056,8 @@ struct dc_debug_options {
 	unsigned int force_lls;
 	bool notify_dpia_hr_bw;
 	bool enable_ips_visual_confirm;
+	unsigned int sharpen_policy;
+	unsigned int scale_to_sharpness_policy;
 };
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c b/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
index f711fc2e3e65..603552dbd771 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
@@ -186,6 +186,11 @@ void translate_SPL_in_params_from_pipe_ctx(struct pipe_ctx *pipe_ctx, struct spl
 
 	spl_in->h_active = pipe_ctx->plane_res.scl_data.h_active;
 	spl_in->v_active = pipe_ctx->plane_res.scl_data.v_active;
+
+	spl_in->debug.sharpen_policy = (enum sharpen_policy)pipe_ctx->stream->ctx->dc->debug.sharpen_policy;
+	spl_in->debug.scale_to_sharpness_policy =
+		(enum scale_to_sharpness_policy)pipe_ctx->stream->ctx->dc->debug.scale_to_sharpness_policy;
+
 	/* Check if it is stream is in fullscreen and if its HDR.
 	 * Use this to determine sharpness levels
 	 */
diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c b/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
index a59aa6b59687..f7a654b3a092 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
+++ b/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
@@ -813,6 +813,14 @@ static bool enable_easf(struct spl_in *spl_in, struct spl_scratch *spl_scratch)
 	return skip_easf;
 }
 
+/* Check if video is in fullscreen mode */
+static bool spl_is_video_fullscreen(struct spl_in *spl_in)
+{
+	if (spl_is_yuv420(spl_in->basic_in.format) && spl_in->is_fullscreen)
+		return true;
+	return false;
+}
+
 static bool spl_get_isharp_en(struct spl_in *spl_in,
 	struct spl_scratch *spl_scratch)
 {
@@ -820,6 +828,7 @@ static bool spl_get_isharp_en(struct spl_in *spl_in,
 	int vratio = 0;
 	int hratio = 0;
 	struct spl_taps taps = spl_scratch->scl_data.taps;
+	bool fullscreen = spl_is_video_fullscreen(spl_in);
 
 	/* Return if adaptive sharpness is disabled */
 	if (spl_in->adaptive_sharpness.enable == false)
@@ -835,9 +844,15 @@ static bool spl_get_isharp_en(struct spl_in *spl_in,
 	// Scaling is up to 1:1 (no scaling) or upscaling
 
 	/*
-	 * Apply sharpness to all RGB surfaces and to
-	 *  NV12/P010 surfaces
+	 * Apply sharpness to RGB and YUV (NV12/P010)
+	 *  surfaces based on policy setting
 	 */
+	if (!spl_is_yuv420(spl_in->basic_in.format) &&
+		(spl_in->debug.sharpen_policy == SHARPEN_YUV))
+		return enable_isharp;
+	else if ((spl_is_yuv420(spl_in->basic_in.format) && !fullscreen) &&
+		(spl_in->debug.sharpen_policy == SHARPEN_RGB_FULLSCREEN_YUV))
+		return enable_isharp;
 
 	/*
 	 * Apply sharpness if supports horizontal taps 4,6 AND
@@ -1562,7 +1577,7 @@ static void spl_set_isharp_data(struct dscl_prog_data *dscl_prog_data,
 		struct adaptive_sharpness adp_sharpness, bool enable_isharp,
 		enum linear_light_scaling lls_pref, enum spl_pixel_format format,
 		const struct spl_scaler_data *data, struct spl_fixed31_32 ratio,
-		enum system_setup setup)
+		enum system_setup setup, enum scale_to_sharpness_policy scale_to_sharpness_policy)
 {
 	/* Turn off sharpener if not required */
 	if (!enable_isharp) {
@@ -1570,6 +1585,11 @@ static void spl_set_isharp_data(struct dscl_prog_data *dscl_prog_data,
 		return;
 	}
 
+	spl_build_isharp_1dlut_from_reference_curve(ratio, setup, adp_sharpness,
+		scale_to_sharpness_policy);
+	dscl_prog_data->isharp_delta = spl_get_pregen_filter_isharp_1D_lut(setup);
+	dscl_prog_data->sharpness_level = adp_sharpness.sharpness_level;
+
 	dscl_prog_data->isharp_en = 1;	// ISHARP_EN
 	// Set ISHARP_NOISEDET_MODE if htaps = 6-tap
 	if (data->taps.h_taps == 6) {
@@ -1667,11 +1687,6 @@ static void spl_set_isharp_data(struct dscl_prog_data *dscl_prog_data,
 		dscl_prog_data->isharp_lba.base_seg[5] = 0;	// ISHARP LBA PWL for Seg 5. BASE value in U0.6 format
 	}
 
-
-	spl_build_isharp_1dlut_from_reference_curve(ratio, setup, adp_sharpness);
-	dscl_prog_data->isharp_delta = spl_get_pregen_filter_isharp_1D_lut(setup);
-	dscl_prog_data->sharpness_level = adp_sharpness.sharpness_level;
-
 	// Program the nldelta soft clip values
 	if (lls_pref == LLS_PREF_YES) {
 		dscl_prog_data->isharp_nldelta_sclip.enable_p = 0;	/* ISHARP_NLDELTA_SCLIP_EN_P */
@@ -1766,7 +1781,8 @@ bool spl_calculate_scaler_params(struct spl_in *spl_in, struct spl_out *spl_out)
 		isharp_scale_ratio = spl_scratch.scl_data.recip_ratios.horz;
 
 	spl_set_isharp_data(spl_out->dscl_prog_data, spl_in->adaptive_sharpness, enable_isharp,
-		spl_in->lls_pref, spl_in->basic_in.format, data, isharp_scale_ratio, setup);
+		spl_in->lls_pref, spl_in->basic_in.format, data, isharp_scale_ratio, setup,
+		spl_in->debug.scale_to_sharpness_policy);
 
 	return res;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl_isharp_filters.c b/drivers/gpu/drm/amd/display/dc/spl/dc_spl_isharp_filters.c
index 33712f50d303..e0572252c640 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/dc_spl_isharp_filters.c
+++ b/drivers/gpu/drm/amd/display/dc/spl/dc_spl_isharp_filters.c
@@ -500,6 +500,15 @@ struct isharp_1D_lut_pregen filter_isharp_1D_lut_pregen[NUM_SHARPNESS_SETUPS] =
 	},
 };
 
+struct scale_ratio_to_sharpness_level_adj sharpness_level_adj[NUM_SHARPNESS_ADJ_LEVELS] = {
+	{1125, 1000, 0},
+	{11, 10, 1},
+	{1075, 1000, 2},
+	{105, 100, 3},
+	{1025, 1000, 4},
+	{1, 1, 5},
+};
+
 const uint32_t *spl_get_filter_isharp_1D_lut_0(void)
 {
 	return filter_isharp_1D_lut_0;
@@ -541,19 +550,72 @@ uint16_t *spl_get_filter_isharp_bs_3tap_64p(void)
 	return filter_isharp_bs_3tap_64p_s1_12;
 }
 
-static unsigned int spl_calculate_sharpness_level(int discrete_sharpness_level, enum system_setup setup,
-		struct spl_sharpness_range sharpness_range)
+static unsigned int spl_calculate_sharpness_level_adj(struct spl_fixed31_32 ratio)
+{
+	int j;
+	struct spl_fixed31_32 ratio_level;
+	struct scale_ratio_to_sharpness_level_adj *lookup_ptr;
+	unsigned int sharpness_level_down_adj;
+
+	/*
+	 * Adjust sharpness level based on current scaling ratio
+	 *
+	 * We have 5 discrete scaling ratios which we will use to adjust the
+	 *  sharpness level down by 1 as we pass each ratio.  The ratios
+	 *  are
+	 *
+	 * 1.125 upscale and higher - no adj
+	 * 1.100 - under 1.125 - adj level down 1
+	 * 1.075 - under 1.100 - adj level down 2
+	 * 1.050 - under 1.075 - adj level down 3
+	 * 1.025 - under 1.050 - adj level down 4
+	 * 1.000 - under 1.025 - adj level down 5
+	 *
+	 */
+	j = 0;
+	sharpness_level_down_adj = 0;
+	lookup_ptr = sharpness_level_adj;
+	while (j < NUM_SHARPNESS_ADJ_LEVELS) {
+		ratio_level = spl_fixpt_from_fraction(lookup_ptr->ratio_numer,
+			lookup_ptr->ratio_denom);
+		if (ratio.value >= ratio_level.value) {
+			sharpness_level_down_adj = lookup_ptr->level_down_adj;
+			break;
+		}
+		lookup_ptr++;
+		j++;
+	}
+	return sharpness_level_down_adj;
+}
+
+static unsigned int spl_calculate_sharpness_level(struct spl_fixed31_32 ratio,
+		int discrete_sharpness_level, enum system_setup setup,
+		struct spl_sharpness_range sharpness_range,
+		enum scale_to_sharpness_policy scale_to_sharpness_policy)
 {
 	unsigned int sharpness_level = 0;
+	unsigned int sharpness_level_down_adj = 0;
 
 	int min_sharpness, max_sharpness, mid_sharpness;
 
+	/*
+	 * Adjust sharpness level if policy requires we adjust it based on
+	 *  scale ratio.  Based on scale ratio, we may adjust the sharpness
+	 *  level down by a certain number of steps.  We will not select
+	 *  a sharpness value of 0 so the lowest sharpness level will be
+	 *  0 or 1 depending on what the min_sharpness is
+	 *
+	 * If the policy is no required, this code maybe removed at a later
+	 *  date
+	 */
 	switch (setup) {
 
 	case HDR_L:
 		min_sharpness = sharpness_range.hdr_rgb_min;
 		max_sharpness = sharpness_range.hdr_rgb_max;
 		mid_sharpness = sharpness_range.hdr_rgb_mid;
+		if (scale_to_sharpness_policy == SCALE_TO_SHARPNESS_ADJ_ALL)
+			sharpness_level_down_adj = spl_calculate_sharpness_level_adj(ratio);
 		break;
 	case HDR_NL:
 		/* currently no use case, use Non-linear SDR values for now */
@@ -561,15 +623,26 @@ static unsigned int spl_calculate_sharpness_level(int discrete_sharpness_level,
 		min_sharpness = sharpness_range.sdr_yuv_min;
 		max_sharpness = sharpness_range.sdr_yuv_max;
 		mid_sharpness = sharpness_range.sdr_yuv_mid;
+		if (scale_to_sharpness_policy >= SCALE_TO_SHARPNESS_ADJ_YUV)
+			sharpness_level_down_adj = spl_calculate_sharpness_level_adj(ratio);
 		break;
 	case SDR_L:
 	default:
 		min_sharpness = sharpness_range.sdr_rgb_min;
 		max_sharpness = sharpness_range.sdr_rgb_max;
 		mid_sharpness = sharpness_range.sdr_rgb_mid;
+		if (scale_to_sharpness_policy == SCALE_TO_SHARPNESS_ADJ_ALL)
+			sharpness_level_down_adj = spl_calculate_sharpness_level_adj(ratio);
 		break;
 	}
 
+	if ((min_sharpness == 0) && (sharpness_level_down_adj >= discrete_sharpness_level))
+		discrete_sharpness_level = 1;
+	else if (sharpness_level_down_adj >= discrete_sharpness_level)
+		discrete_sharpness_level = 0;
+	else
+		discrete_sharpness_level -= sharpness_level_down_adj;
+
 	int lower_half_step_size = (mid_sharpness - min_sharpness) / 5;
 	int upper_half_step_size = (max_sharpness - mid_sharpness) / 5;
 
@@ -584,7 +657,7 @@ static unsigned int spl_calculate_sharpness_level(int discrete_sharpness_level,
 }
 
 void spl_build_isharp_1dlut_from_reference_curve(struct spl_fixed31_32 ratio, enum system_setup setup,
-	struct adaptive_sharpness sharpness)
+	struct adaptive_sharpness sharpness, enum scale_to_sharpness_policy scale_to_sharpness_policy)
 {
 	uint8_t *byte_ptr_1dlut_src, *byte_ptr_1dlut_dst;
 	struct spl_fixed31_32 sharp_base, sharp_calc, sharp_level;
@@ -594,8 +667,9 @@ void spl_build_isharp_1dlut_from_reference_curve(struct spl_fixed31_32 ratio, en
 	uint32_t filter_pregen_store[ISHARP_LUT_TABLE_SIZE];
 
 	/* Custom sharpnessX1000 value */
-	unsigned int sharpnessX1000 = spl_calculate_sharpness_level(sharpness.sharpness_level,
-			setup, sharpness.sharpness_range);
+	unsigned int sharpnessX1000 = spl_calculate_sharpness_level(ratio,
+			sharpness.sharpness_level, setup,
+			sharpness.sharpness_range, scale_to_sharpness_policy);
 	sharp_level = spl_fixpt_from_fraction(sharpnessX1000, 1000);
 
 	/*
@@ -606,7 +680,6 @@ void spl_build_isharp_1dlut_from_reference_curve(struct spl_fixed31_32 ratio, en
 		(filter_isharp_1D_lut_pregen[setup].sharpness_denom == 1000))
 		return;
 
-
 	/*
 	 * Calculate LUT_128_gained with this equation:
 	 *
diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl_isharp_filters.h b/drivers/gpu/drm/amd/display/dc/spl/dc_spl_isharp_filters.h
index fe0b12571f2c..afcc66206ca2 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/dc_spl_isharp_filters.h
+++ b/drivers/gpu/drm/amd/display/dc/spl/dc_spl_isharp_filters.h
@@ -20,11 +20,11 @@ uint16_t *spl_get_filter_isharp_bs_3tap_64p(void);
 const uint16_t *spl_get_filter_isharp_wide_6tap_64p(void);
 uint16_t *spl_dscl_get_blur_scale_coeffs_64p(int taps);
 
-struct scale_ratio_to_sharpness_level_lookup {
+#define NUM_SHARPNESS_ADJ_LEVELS 6
+struct scale_ratio_to_sharpness_level_adj {
 	unsigned int ratio_numer;
 	unsigned int ratio_denom;
-	unsigned int sharpness_numer;
-	unsigned int sharpness_denom;
+	unsigned int level_down_adj; /* adjust sharpness level down */
 };
 
 struct isharp_1D_lut_pregen {
@@ -45,6 +45,7 @@ void spl_init_blur_scale_coeffs(void);
 void spl_set_blur_scale_data(struct dscl_prog_data *dscl_prog_data,
 	const struct spl_scaler_data *data);
 
-void spl_build_isharp_1dlut_from_reference_curve(struct spl_fixed31_32 ratio, enum system_setup setup, struct adaptive_sharpness sharpness);
+void spl_build_isharp_1dlut_from_reference_curve(struct spl_fixed31_32 ratio, enum system_setup setup,
+	struct adaptive_sharpness sharpness, enum scale_to_sharpness_policy scale_to_sharpness_policy);
 uint32_t *spl_get_pregen_filter_isharp_1D_lut(enum system_setup setup);
 #endif /* __DC_SPL_ISHARP_FILTERS_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h b/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h
index 74f2a8c42f4f..425d4a282c7a 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h
+++ b/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h
@@ -487,6 +487,16 @@ enum linear_light_scaling	{	// convert it in translation logic
 	LLS_PREF_YES,
 	LLS_PREF_NO
 };
+enum sharpen_policy {
+	SHARPEN_ALWAYS = 0,
+	SHARPEN_YUV = 1,
+	SHARPEN_RGB_FULLSCREEN_YUV = 2
+};
+enum scale_to_sharpness_policy {
+	NO_SCALE_TO_SHARPNESS_ADJ = 0,
+	SCALE_TO_SHARPNESS_ADJ_YUV = 1,
+	SCALE_TO_SHARPNESS_ADJ_ALL = 2
+};
 struct spl_funcs	{
 	void (*spl_calc_lb_num_partitions)
 		(bool alpha_en,
@@ -499,6 +509,8 @@ struct spl_funcs	{
 struct spl_debug {
 	int visual_confirm_base_offset;
 	int visual_confirm_dpp_offset;
+	enum sharpen_policy sharpen_policy;
+	enum scale_to_sharpness_policy scale_to_sharpness_policy;
 };
 
 struct spl_in	{
-- 
2.34.1

