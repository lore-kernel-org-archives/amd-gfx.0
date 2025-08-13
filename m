Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F61C87FCF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Aug 2025 23:27:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E59010E7E0;
	Wed, 13 Aug 2025 23:27:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UFpX22t2";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B226310E7E0
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 23:27:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ScT3PAQ06KCYke/x2+smb1LrjdkWRtnXynXgEOkz4E/KLKh/rXHn6wF7eEnITVQDe6cNZQpb8jP9GIBqvBawMuQVhkphgxildRUbGQ1jTsEFgsd756g2u+ZSunnyLmI9wM2gKUdl8cz10zRPDY3YA7zR0yPEWJ42vcmGkXvqErNSeisq2HFUM6YW1ikUUKHeOqAqOw8PXUVt449EffEoPbmGbbwX46uNK1oAhZqcqnBFBQ4IQUxaT6Ke2ghOaPNjUtuk8e0Aphc+5VPhwwIY5XJHruj/ZoDySLwPd8W9BnpWrKAnu9Eoz/1zzEkTIGQdM9s7SB3bhTYBzgrxCNiZRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nWJFzz5PBoaq6S3ZaC2KMYXuOBaf7+75824me/GTnU0=;
 b=ge5UFILpC7gQo7OEhTeyk+w9l/Qj/3W1B3k44Df8E5gN/ypI5r9P1STCM3MFWC6/Zk/14WooRLjH4Kss6aZmFV4DprcsLMdBXBqdoMA4JjtLewc+eG4CwctF3xNWdQL0jgegjjGjBRiCaTJPXYNKNpfdjWWqwz2Ss6kpt8tQEa7+VfKQYWecv9NiiCeJT8c/7e/52/W8JIjT0bz7sGw5cnKrsWGsQ6fZeF/GYS5Oi6QGamKOqc4xauqXpxqEfDezT7bnMhVK5fLKaBS/BtRO1fkfxW3VE9a8xjxnr8MI92H6zuyU74yY6yiF5i+iEDz5nA2ptSKorknbB85aVxl6mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nWJFzz5PBoaq6S3ZaC2KMYXuOBaf7+75824me/GTnU0=;
 b=UFpX22t2f2zaxzHPDEXnx02DLoppgVUJgyzwRlBwzGAUg1BnCHehFIjXfWqWqh+ndQG41Uu7czWm2Cs/KdbjO3hCTyHnFkcp5+1XJnlmivJdSfLuEuMwBwuo+tGEVnk4foPCvTsQVww8RhZcIAkkiDjOTkWIjMUeaYujJrPzBLo=
Received: from DM6PR05CA0062.namprd05.prod.outlook.com (2603:10b6:5:335::31)
 by LV9PR12MB9805.namprd12.prod.outlook.com (2603:10b6:408:2ee::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Wed, 13 Aug
 2025 23:27:03 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:335:cafe::5f) by DM6PR05CA0062.outlook.office365.com
 (2603:10b6:5:335::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.15 via Frontend Transport; Wed,
 13 Aug 2025 23:27:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 23:27:02 +0000
Received: from SATLEXMB03.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Aug
 2025 18:26:59 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Lohita Mudimela <lohita.mudimela@amd.com>, Ilya Bakoulin
 <ilya.bakoulin@amd.com>, Martin Leung <martin.leung@amd.com>
Subject: [PATCH 02/11] drm/amd/display: Refactor DPP enum for backwards
 compatibility
Date: Wed, 13 Aug 2025 17:18:10 -0600
Message-ID: <20250813232532.2661638-3-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250813232532.2661638-1-alex.hung@amd.com>
References: <20250813232532.2661638-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|LV9PR12MB9805:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a7f0fc6-394c-4417-4616-08dddac0e8bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eBHII1o99OIOPy2+qbnxQCUy8hUCRRCzuQ1hTsaXyIAW9hh2Rf27GWACGkH6?=
 =?us-ascii?Q?8StrYefnZejz45DfunY3jENNw1b8Se6MaEgImXi96d97jEj4PpCYK3KOwuQA?=
 =?us-ascii?Q?19eZ57HlLM5iBfv2g7oGDEWzh7Mo5HA96MVmW+88Lym7R08trSRllKcvur/R?=
 =?us-ascii?Q?09eASyPWYdmxvNnn9PZb8ITHvvTGo22hjobc4xnulWt89VZGap10i9N8gotH?=
 =?us-ascii?Q?OgGHHov0e9EjHEdEFZm3q9fg5uamXEVUBG43NQ+ICg6relGiWAxtY8OmPSw4?=
 =?us-ascii?Q?f7hV50bEsc6oHAWQzUyLdzYa3OO9SI8f0dXk/DxMXytbGn8RM0FZipjdinro?=
 =?us-ascii?Q?Q9uViNjqLuEW3S6TNkFuWEoosg/bA5/bVlDaFD+8zgRFnjFpJtoee70MOogc?=
 =?us-ascii?Q?Y301RYnHr1DXX1E7aDSMriPubQFZc8+upmlYzLanSVq4xr/GgSAWwPP8iGLI?=
 =?us-ascii?Q?rw/Ty3otC6w0gXD0C+pf0eYkpLCeY8KKpWOWxLdZ1YBba7WAoEvulxnN6QrA?=
 =?us-ascii?Q?7Hm5YDi4LvKSjrjPaxeDS3FJ1iRlDli2b51UDwBa5s5Lo8Y4YIAQ0bWp+MiJ?=
 =?us-ascii?Q?inJx6lnIo0OQ5eESvkvdgVjhUWvSc45/gwjiXjx7LxamH3nbmIrcWMahHC/t?=
 =?us-ascii?Q?Rf8G3oPCHpfV6EHj67hKUGPy2YSm7Nhy1+URJv8TgWFZJqZlbq6wbarhYlAY?=
 =?us-ascii?Q?WW4ArRIkOm8O7Kw3CwaQnSj5ZRr1QBWao/F04h+D5CkqdR6fX8+dK9Zz/f5Q?=
 =?us-ascii?Q?36m8D0+nUFtsbCd8mZHLCKc5ZlAxxfv9SOe3ujsXJCMq5kEDDkYt7/nQQIsQ?=
 =?us-ascii?Q?5nBTwX2EN+hncx7i3gQHS9lc8kk7UpWhpBTewUS+f7eU+FZaWzQQiK7r8O2a?=
 =?us-ascii?Q?3+ebi4sw5nyAmpC68vVYbstUnVxDroq38hWNOyebcW317xSZSLXMCzVd0T/q?=
 =?us-ascii?Q?mfZwTwndrzhhnWdr5W7hqp1ELk/xKtd8TL//CfF+e8T8m+zsD918FMLmk3i7?=
 =?us-ascii?Q?Tn1GxYuwGgQh7Ioq4g8ydrWO38JiaXHN68YfZu7U4z3ewkUeyimFLUCqOpEr?=
 =?us-ascii?Q?ToXmkrW/mDY8oF9JAX0y+D1bbdsRpJt5r510RGuy6+zrhHyu+B1qS/hU/mT6?=
 =?us-ascii?Q?UMQtrWxK9NtSCXbT8WyR7I1C05t3Q5tPY16kaPrnv3VAw1Mj+5Gr9WxizEQp?=
 =?us-ascii?Q?Pem+UpqSWumGvF3CFL1hN8OaZ/ZZplpdZcBI5wBZ+xsratBBY9L9uoTfKP4n?=
 =?us-ascii?Q?lTOMhFsjteLjAGhAraSYzGNcHNwWq7trphMZ/jSYq1JRCw5a0qmQFIbpOzrw?=
 =?us-ascii?Q?Nx9RVHYtedCt0YYe86FoD+9qu5RZCYze8SMAr9lFupSob2cnqS5ViXI6YTKs?=
 =?us-ascii?Q?yxpc1kwXwcmYQ9KPfnI9bM6AM+ARv5LRxx3lcRRw0A9twMutXyz9iBh0bTpp?=
 =?us-ascii?Q?O/uoA0n1ocG89BtXN4yJrjsYvHzDg8hTBTN71mepNgdIPcrnbpNlJTPvjorv?=
 =?us-ascii?Q?NcM5aJ5EhiUOOtfK62jEbNTLcURb7h3P3bek?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 23:27:02.9079 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a7f0fc6-394c-4417-4616-08dddac0e8bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9805
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

From: Lohita Mudimela <lohita.mudimela@amd.com>

[WHY]
Conflict for enum type in DPP source files.

[HOW]
Refactor DPP source files to resolve the enum conflicts.

Reviewed-by: Ilya Bakoulin <ilya.bakoulin@amd.com>
Reviewed-by: Martin Leung <martin.leung@amd.com>
Signed-off-by: Lohita Mudimela <lohita.mudimela@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../amd/display/dc/dpp/dcn401/dcn401_dpp.h    | 10 ++++++
 .../display/dc/dpp/dcn401/dcn401_dpp_dscl.c   | 36 +++++++------------
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.h b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.h
index 5a6a861402b3..5f6b431ec398 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.h
@@ -673,6 +673,16 @@ struct dcn401_dpp {
 	struct pwl_params pwl_data;
 };
 
+enum dcn401_dscl_mode_sel {
+	DCN401_DSCL_MODE_SCALING_444_BYPASS = 0,
+	DCN401_DSCL_MODE_SCALING_444_RGB_ENABLE = 1,
+	DCN401_DSCL_MODE_SCALING_444_YCBCR_ENABLE = 2,
+	DCN401_DSCL_MODE_SCALING_420_YCBCR_ENABLE = 3,
+	DCN401_DSCL_MODE_SCALING_420_LUMA_BYPASS = 4,
+	DCN401_DSCL_MODE_SCALING_420_CHROMA_BYPASS = 5,
+	DCN401_DSCL_MODE_DSCL_BYPASS = 6
+};
+
 bool dpp401_construct(struct dcn401_dpp *dpp401,
 	struct dc_context *ctx,
 	uint32_t inst,
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
index 2f92e7d4981b..6df3419f825f 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
@@ -78,16 +78,6 @@ enum dscl_autocal_mode {
 	AUTOCAL_MODE_AUTOREPLICATE = 3
 };
 
-enum dscl_mode_sel {
-	DSCL_MODE_SCALING_444_BYPASS = 0,
-	DSCL_MODE_SCALING_444_RGB_ENABLE = 1,
-	DSCL_MODE_SCALING_444_YCBCR_ENABLE = 2,
-	DSCL_MODE_SCALING_420_YCBCR_ENABLE = 3,
-	DSCL_MODE_SCALING_420_LUMA_BYPASS = 4,
-	DSCL_MODE_SCALING_420_CHROMA_BYPASS = 5,
-	DSCL_MODE_DSCL_BYPASS = 6
-};
-
 static int dpp401_dscl_get_pixel_depth_val(enum lb_pixel_depth depth)
 {
 	if (depth == LB_PIXEL_DEPTH_30BPP)
@@ -122,7 +112,7 @@ static bool dpp401_dscl_is_420_format(enum pixel_format format)
 		return false;
 }
 
-static enum dscl_mode_sel dpp401_dscl_get_dscl_mode(
+static enum dcn401_dscl_mode_sel dpp401_dscl_get_dscl_mode(
 		struct dpp *dpp_base,
 		const struct scaler_data *data,
 		bool dbg_always_scale)
@@ -132,7 +122,7 @@ static enum dscl_mode_sel dpp401_dscl_get_dscl_mode(
 	if (dpp_base->caps->dscl_data_proc_format == DSCL_DATA_PRCESSING_FIXED_FORMAT) {
 		/* DSCL is processing data in fixed format */
 		if (data->format == PIXEL_FORMAT_FP16)
-			return DSCL_MODE_DSCL_BYPASS;
+			return DCN401_DSCL_MODE_DSCL_BYPASS;
 	}
 
 	if (data->ratios.horz.value == one
@@ -140,20 +130,20 @@ static enum dscl_mode_sel dpp401_dscl_get_dscl_mode(
 			&& data->ratios.horz_c.value == one
 			&& data->ratios.vert_c.value == one
 			&& !dbg_always_scale)
-		return DSCL_MODE_SCALING_444_BYPASS;
+		return DCN401_DSCL_MODE_SCALING_444_BYPASS;
 
 	if (!dpp401_dscl_is_420_format(data->format)) {
 		if (dpp401_dscl_is_video_format(data->format))
-			return DSCL_MODE_SCALING_444_YCBCR_ENABLE;
+			return DCN401_DSCL_MODE_SCALING_444_YCBCR_ENABLE;
 		else
-			return DSCL_MODE_SCALING_444_RGB_ENABLE;
+			return DCN401_DSCL_MODE_SCALING_444_RGB_ENABLE;
 	}
 	if (data->ratios.horz.value == one && data->ratios.vert.value == one)
-		return DSCL_MODE_SCALING_420_LUMA_BYPASS;
+		return DCN401_DSCL_MODE_SCALING_420_LUMA_BYPASS;
 	if (data->ratios.horz_c.value == one && data->ratios.vert_c.value == one)
-		return DSCL_MODE_SCALING_420_CHROMA_BYPASS;
+		return DCN401_DSCL_MODE_SCALING_420_CHROMA_BYPASS;
 
-	return DSCL_MODE_SCALING_420_YCBCR_ENABLE;
+	return DCN401_DSCL_MODE_SCALING_420_YCBCR_ENABLE;
 }
 
 static void dpp401_power_on_dscl(
@@ -1071,7 +1061,7 @@ void dpp401_dscl_set_scaler_manual_scale(struct dpp *dpp_base,
 	uint32_t v_num_taps_c = scl_data->taps.v_taps_c - 1;
 	uint32_t h_num_taps = scl_data->taps.h_taps - 1;
 	uint32_t h_num_taps_c = scl_data->taps.h_taps_c - 1;
-	enum dscl_mode_sel dscl_mode = dpp401_dscl_get_dscl_mode(
+	enum dcn401_dscl_mode_sel dscl_mode = dpp401_dscl_get_dscl_mode(
 			dpp_base, scl_data, dpp_base->ctx->dc->debug.always_scale);
 	bool ycbcr = scl_data->format >= PIXEL_FORMAT_VIDEO_BEGIN
 				&& scl_data->format <= PIXEL_FORMAT_VIDEO_END;
@@ -1102,7 +1092,7 @@ void dpp401_dscl_set_scaler_manual_scale(struct dpp *dpp_base,
 	dpp->scl_data = *scl_data;
 
 	if ((dpp->base.ctx->dc->config.use_spl) && (!dpp->base.ctx->dc->debug.disable_spl)) {
-		dscl_mode = (enum dscl_mode_sel) scl_data->dscl_prog_data.dscl_mode;
+		dscl_mode = (enum dcn401_dscl_mode_sel) scl_data->dscl_prog_data.dscl_mode;
 		rect = (struct rect *)&scl_data->dscl_prog_data.recout;
 		mpc_width = scl_data->dscl_prog_data.mpc_size.width;
 		mpc_height = scl_data->dscl_prog_data.mpc_size.height;
@@ -1112,7 +1102,7 @@ void dpp401_dscl_set_scaler_manual_scale(struct dpp *dpp_base,
 		h_num_taps_c = scl_data->dscl_prog_data.taps.h_taps_c;
 	}
 	if (dpp_base->ctx->dc->debug.enable_mem_low_power.bits.dscl) {
-		if (dscl_mode != DSCL_MODE_DSCL_BYPASS)
+		if (dscl_mode != DCN401_DSCL_MODE_DSCL_BYPASS)
 			dpp401_power_on_dscl(dpp_base, true);
 	}
 
@@ -1139,7 +1129,7 @@ void dpp401_dscl_set_scaler_manual_scale(struct dpp *dpp_base,
 	/* SCL mode */
 	REG_UPDATE(SCL_MODE, DSCL_MODE, dscl_mode);
 
-	if (dscl_mode == DSCL_MODE_DSCL_BYPASS) {
+	if (dscl_mode == DCN401_DSCL_MODE_DSCL_BYPASS) {
 		if (dpp_base->ctx->dc->debug.enable_mem_low_power.bits.dscl)
 			dpp401_power_on_dscl(dpp_base, false);
 		return;
@@ -1149,7 +1139,7 @@ void dpp401_dscl_set_scaler_manual_scale(struct dpp *dpp_base,
 	lb_config =  dpp401_dscl_find_lb_memory_config(dpp, scl_data);
 	dpp401_dscl_set_lb(dpp, &scl_data->lb_params, lb_config);
 
-	if (dscl_mode == DSCL_MODE_SCALING_444_BYPASS) {
+	if (dscl_mode == DCN401_DSCL_MODE_SCALING_444_BYPASS) {
 		if (dpp->base.ctx->dc->config.prefer_easf)
 			dpp401_dscl_disable_easf(dpp_base, scl_data);
 		dpp401_dscl_program_isharp(dpp_base, scl_data, program_isharp_1dlut, &bs_coeffs_updated);
-- 
2.43.0

