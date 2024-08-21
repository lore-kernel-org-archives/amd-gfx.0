Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4F63C52D7C
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Aug 2024 22:05:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5635710E718;
	Wed, 21 Aug 2024 22:05:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B/DPaCM2";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8D4E10E710
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Aug 2024 22:05:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e05riRhPvsp7yyMq5k6tS454pManQTQAxOr7BBTKOjr541P5+/XEWCJBRhuMFuvER0c8UDUUY5X3ltTKhoR3bYq1dAL22H9D4mbF0zIDbyXGvbODpkl2rTiN5AvjofzEWM5DM/7P5V8yNgcC/+sRJH8mkR54ZmJkWCUZYrzUzCc6QBAVHs4tcQm6UQXOIiUNZ3GiKdG+FFu1sfPNMnxhlXtj7DipyxweobOx4LsD4EwwNhHgRudHfAQNANjpGig7K2ymVxaZaHy7kmZ7YY6zCFchlLy8EeccMOQA7gON9XJABLQDE+bLPw9HKTUjPzZkFxh2oqG9yzh0Tk5mVyXXOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tlGT7G2wF0dspe9Z5N0YVVXIDKIVik76jzdV488pvDo=;
 b=GDe/K6jQW5rukthxbcE7xEdLFM0xUzhSXdptJ+Xvp6vWljq+txVrIITuhpeRAV5REbQ2KjTPgbl7D5V4IKzb1lQ7xlxEk/2+ZdzfjizpXmT2CUT1zWzAAYm3HZp7V/g1s/LNnDIaZ59+nu7YFK8+146NbV42QOioy31g0j2WDI9sU7BFArbTcPSZhJBdgQJ8Kb016v/ZS9ncAq1uKGmIWTvdwImwaMIcBUkRucFBAdTw6tpzAY1WigBk8slsl9+543f1/cvp0Piyj5g7wYpyXKwAshFWQgU21n8i0cAfVpLg3PWm2e+F5F/U4vV6FkJC+CqbxZFd3dHj1B3c7iDU/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tlGT7G2wF0dspe9Z5N0YVVXIDKIVik76jzdV488pvDo=;
 b=B/DPaCM2Yhx2w/nEgevDup6OGj1PZvt4zMVC3IzzO0RdA6MyicdPhP6PdTxoFpJuSeYEsS1HjBnHEZqsYtlC1GsQ1b1zk6QFbabh4b+cy1kYgIEvjPjuV6EjYZ8lM+fuh/aXgEq8o9SW490scJTClf3FivbqgLnIqH3L/7ScHoE=
Received: from BN9PR03CA0441.namprd03.prod.outlook.com (2603:10b6:408:113::26)
 by CH2PR12MB4293.namprd12.prod.outlook.com (2603:10b6:610:7e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.17; Wed, 21 Aug
 2024 22:04:55 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:408:113:cafe::ac) by BN9PR03CA0441.outlook.office365.com
 (2603:10b6:408:113::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Wed, 21 Aug 2024 22:04:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024 22:04:55 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 Aug
 2024 17:04:51 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Samson Tam
 <Samson.Tam@amd.com>, Jun Lei <jun.lei@amd.com>
Subject: [PATCH 13/16] drm/amd/display: add improvements for text display and
 HDR DWM and MPO
Date: Wed, 21 Aug 2024 18:01:55 -0400
Message-ID: <20240821220156.1498549-14-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821220156.1498549-1-zaeem.mohamed@amd.com>
References: <20240821220156.1498549-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|CH2PR12MB4293:EE_
X-MS-Office365-Filtering-Correlation-Id: 4946d31d-f9ef-4864-b39a-08dcc22d4a41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?39tr4P7am7GF0w6tkHoistadxKoBNNsgK9yDEM8tZOVSc8iX2UGQL5PVRi4e?=
 =?us-ascii?Q?i8rkkZUerVoyXoeQP8OrBIcYfePG2E2xv8NHGkIK7+3WiSId3EiekdnDaK/n?=
 =?us-ascii?Q?sLSuci0Q2igOsiCLpK95ucrOCOt9qlVZbDE07WnBZwiGwDPDw/un3ycZP1GL?=
 =?us-ascii?Q?4J2TQ1utDhH0fXLhTF49HX0M9xA9M1fM3ISM7tD5mjAqICBa2K1E5UvMp0to?=
 =?us-ascii?Q?bFyC5BTpKOMiZQdFzRzaJAw8jQO2AI6g3F0MTYIjS/IbNaDUOjyQ2N8KiZZo?=
 =?us-ascii?Q?lzPVOjFOTZGTZbJzlIsRqG13LiSPNnqIZtburQ0DyAT/siynL0xomVgFhILS?=
 =?us-ascii?Q?88VX3iEmr3Tx1X5pFArp9Y+MtQz1Jc8KbxVr3bQWOY2ZIaCDvtlfB0FnFdQh?=
 =?us-ascii?Q?GiNcwP8FsOGyedkemC3n6ceW7fv4FRd8EtLiAg0H2iq351HLWl0BbT8au8Ch?=
 =?us-ascii?Q?XQvAAUpu29pX8sT7DQyHgsHu2MGbVkaF9ORdVM6AriD3CWxMsz1GW7xiwubk?=
 =?us-ascii?Q?CQ7bqWpk4GTx3UVJBJ2hc7z5Oe2rW7RcY2xxBeWoyq8M4kd9sYjFhuGX4PgQ?=
 =?us-ascii?Q?eGV9MYmxFs56TgA3axlq0YN9bJa51yvRaeH/ZtFtR+ZmeHzn+uFYTnIM1DvC?=
 =?us-ascii?Q?zGgqDL3QOjggSzS3jwWcM4yCI7dgfX+u0u2nlR2vVHUtk1Y15PxmXP0pA47N?=
 =?us-ascii?Q?J5AZF63g+scp42A80yb2CeB0EbSsKTEr5JTG1uNE8pH5NstSV3EEIe0WEUkR?=
 =?us-ascii?Q?3cd/CmwLpgZzD/pevLUWJ10LzP1h2rHWl+AIgxIz4toaiNpHXrZPQnOni9hR?=
 =?us-ascii?Q?y7ZOloFyuD47ywYgARCLEdvfOKLckMmQca6CKA0XG4qNdeutzM8uPCmxIcR5?=
 =?us-ascii?Q?CqlJHVPP0qqjff+Ju81Rz5gdqApFC+C05NGtQ0SQpKLILvCGsD1Brb4hiuYx?=
 =?us-ascii?Q?GCQ/SR6vHyWAz0+Qp3GEKe1VIuMY4TtSQnptT3jWukwBvfRS8ILjhW+JAO1H?=
 =?us-ascii?Q?OS3nJYj4iOEH1JFPQ/HKQ+umzNezFhO9XnjRjGOecmspMweJyWEiSGrcBqmA?=
 =?us-ascii?Q?/txbnzxEC2IZ4ZVT4WcpKcQzFcNmdcGY9zmfaygyjFdg24cUFO2z6I/kZFJS?=
 =?us-ascii?Q?sFOxscwZhu3VVpfWxvJIxGVrje9UHxfAky59D259meoyzwtbXd57i5jtm9Eh?=
 =?us-ascii?Q?J3TLWx0SM+zPbRjkavk32+/IbbsyqBp6Nw7DRQS6mKLRp5+QALGcpB15mtHw?=
 =?us-ascii?Q?QwdHDfP+Kb957rgPh4tyM74xx3VEVdQ2pLwO39dXvYEvF6mCzgX3yqIRLzlI?=
 =?us-ascii?Q?FgE5bPwrAZXOiBXMG/kaxFFW2idOcyjqRJVBGdIv05IG88l1UecKMMcp7b3V?=
 =?us-ascii?Q?A3NXkd/tP2UohlUs2IPIgnrzzh7/Dhl+I3NXyGZ4hutO07NtEekcFlm9mXZZ?=
 =?us-ascii?Q?izaIUfqmCJ/wSN+1gXjbeXe2jYq7dTi+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 22:04:55.4279 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4946d31d-f9ef-4864-b39a-08dcc22d4a41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4293
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

[Why]
Tune settings for improved text display.
Handle differences between DWM and MPO in HDR path.

[How]
Update sharpener LBA table.
Use HDR multiplier to calculate scalar matrix coefficients
 for HDR RGB MPO path.
Update unit tests.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Signed-off-by: Samson Tam <Samson.Tam@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 .../gpu/drm/amd/display/dc/dc_spl_translate.c |   4 +
 drivers/gpu/drm/amd/display/dc/spl/Makefile   |   2 +-
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.c   | 127 +++++++++++----
 .../gpu/drm/amd/display/dc/spl/dc_spl_types.h |   2 +
 .../drm/amd/display/dc/spl/spl_custom_float.c | 151 ++++++++++++++++++
 .../drm/amd/display/dc/spl/spl_custom_float.h |  29 ++++
 6 files changed, 282 insertions(+), 33 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/spl/spl_custom_float.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/spl/spl_custom_float.h

diff --git a/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c b/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
index 92ad0bac182c..75d00c6a38f4 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
@@ -179,6 +179,10 @@ void translate_SPL_in_params_from_pipe_ctx(struct pipe_ctx *pipe_ctx, struct spl
 	 */
 	spl_in->is_fullscreen = dm_helpers_is_fullscreen(pipe_ctx->stream->ctx, pipe_ctx->stream);
 	spl_in->is_hdr_on = dm_helpers_is_hdr_on(pipe_ctx->stream->ctx, pipe_ctx->stream);
+	spl_in->hdr_multx100 = 0;
+	if (spl_in->is_hdr_on)
+		spl_in->hdr_multx100 = (uint32_t)dc_fixpt_floor(dc_fixpt_mul(plane_state->hdr_mult,
+			dc_fixpt_from_int(100)));
 }
 
 /// @brief Translate SPL output parameters to pipe context
diff --git a/drivers/gpu/drm/amd/display/dc/spl/Makefile b/drivers/gpu/drm/amd/display/dc/spl/Makefile
index 05764d4d4604..5edf3c6cf3e2 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/spl/Makefile
@@ -23,7 +23,7 @@
 # Makefile for the 'spl' sub-component of DAL.
 # It provides the scaling library interface.
 
-SPL = dc_spl.o dc_spl_scl_filters.o dc_spl_scl_easf_filters.o dc_spl_isharp_filters.o dc_spl_filters.o spl_fixpt31_32.o
+SPL = dc_spl.o dc_spl_scl_filters.o dc_spl_scl_easf_filters.o dc_spl_isharp_filters.o dc_spl_filters.o spl_fixpt31_32.o spl_custom_float.o
 
 AMD_DAL_SPL = $(addprefix $(AMDDALPATH)/dc/spl/,$(SPL))
 
diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c b/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
index f00bb2004d53..059d144bab85 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
+++ b/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
@@ -538,6 +538,14 @@ static bool spl_is_yuv420(enum spl_pixel_format format)
 	return false;
 }
 
+static bool spl_is_rgb8(enum spl_pixel_format format)
+{
+	if (format == SPL_PIXEL_FORMAT_ARGB8888)
+		return true;
+
+	return false;
+}
+
 /*Calculate inits and viewport */
 static void spl_calculate_inits_and_viewports(struct spl_in *spl_in,
 		struct spl_scratch *spl_scratch)
@@ -773,21 +781,12 @@ static bool enable_easf(struct spl_in *spl_in, struct spl_scratch *spl_scratch)
 	bool skip_easf = false;
 	bool lls_enable_easf = true;
 
-	/*
-	 * If lls_pref is LLS_PREF_DONT_CARE, then use pixel format and transfer
-	 *  function to determine whether to use LINEAR or NONLINEAR scaling
-	 */
-	if (spl_in->lls_pref == LLS_PREF_DONT_CARE)
-		lls_enable_easf = spl_choose_lls_policy(spl_in->basic_in.format,
-			spl_in->basic_in.tf_type, spl_in->basic_in.tf_predefined_type,
-			&spl_in->lls_pref);
+	if (spl_in->disable_easf)
+		skip_easf = true;
 
 	vratio = spl_fixpt_ceil(spl_scratch->scl_data.ratios.vert);
 	hratio = spl_fixpt_ceil(spl_scratch->scl_data.ratios.horz);
 
-	if (!lls_enable_easf || spl_in->disable_easf)
-		skip_easf = true;
-
 	/*
 	 * No EASF support for downscaling > 2:1
 	 * EASF support for upscaling or downscaling up to 2:1
@@ -795,6 +794,18 @@ static bool enable_easf(struct spl_in *spl_in, struct spl_scratch *spl_scratch)
 	if ((vratio > 2) || (hratio > 2))
 		skip_easf = true;
 
+	/*
+	 * If lls_pref is LLS_PREF_DONT_CARE, then use pixel format and transfer
+	 *  function to determine whether to use LINEAR or NONLINEAR scaling
+	 */
+	if (spl_in->lls_pref == LLS_PREF_DONT_CARE)
+		lls_enable_easf = spl_choose_lls_policy(spl_in->basic_in.format,
+			spl_in->basic_in.tf_type, spl_in->basic_in.tf_predefined_type,
+			&spl_in->lls_pref);
+
+	if (!lls_enable_easf)
+		skip_easf = true;
+
 	/* Check for linear scaling or EASF preferred */
 	if (spl_in->lls_pref != LLS_PREF_YES && !spl_in->prefer_easf)
 		skip_easf = true;
@@ -819,13 +830,13 @@ static bool spl_get_isharp_en(struct spl_in *spl_in,
 	struct spl_taps taps = spl_scratch->scl_data.taps;
 	bool fullscreen = spl_is_video_fullscreen(spl_in);
 
-	vratio = spl_fixpt_ceil(spl_scratch->scl_data.ratios.vert);
-	hratio = spl_fixpt_ceil(spl_scratch->scl_data.ratios.horz);
-
 	/* Return if adaptive sharpness is disabled */
 	if (spl_in->adaptive_sharpness.enable == false)
 		return enable_isharp;
 
+	vratio = spl_fixpt_ceil(spl_scratch->scl_data.ratios.vert);
+	hratio = spl_fixpt_ceil(spl_scratch->scl_data.ratios.horz);
+
 	/* No iSHARP support for downscaling */
 	if (vratio > 1 || hratio > 1)
 		return enable_isharp;
@@ -1154,10 +1165,44 @@ static void spl_set_dscl_prog_data(struct spl_in *spl_in, struct spl_scratch *sp
 	spl_set_filters_data(dscl_prog_data, data, enable_easf_v, enable_easf_h);
 }
 
+/* Calculate C0-C3 coefficients based on HDR_mult */
+static void spl_calculate_c0_c3_hdr(struct dscl_prog_data *dscl_prog_data, uint32_t hdr_multx100)
+{
+	struct spl_fixed31_32 hdr_mult, c0_mult, c1_mult, c2_mult;
+	struct spl_fixed31_32 c0_calc, c1_calc, c2_calc;
+	struct spl_custom_float_format fmt;
+
+	SPL_ASSERT(hdr_multx100);
+	hdr_mult = spl_fixpt_from_fraction((long long)hdr_multx100, 100LL);
+	c0_mult = spl_fixpt_from_fraction(2126LL, 10000LL);
+	c1_mult = spl_fixpt_from_fraction(7152LL, 10000LL);
+	c2_mult = spl_fixpt_from_fraction(722LL, 10000LL);
+
+	c0_calc = spl_fixpt_mul(hdr_mult, spl_fixpt_mul(c0_mult, spl_fixpt_from_fraction(
+		16384LL, 125LL)));
+	c1_calc = spl_fixpt_mul(hdr_mult, spl_fixpt_mul(c1_mult, spl_fixpt_from_fraction(
+		16384LL, 125LL)));
+	c2_calc = spl_fixpt_mul(hdr_mult, spl_fixpt_mul(c2_mult, spl_fixpt_from_fraction(
+		16384LL, 125LL)));
+
+	fmt.exponenta_bits = 5;
+	fmt.mantissa_bits = 10;
+	fmt.sign = true;
+
+	// fp1.5.10, C0 coefficient (LN_rec709:  HDR_MULT * 0.212600 * 2^14/125)
+	spl_convert_to_custom_float_format(c0_calc, &fmt, &dscl_prog_data->easf_matrix_c0);
+	// fp1.5.10, C1 coefficient (LN_rec709:  HDR_MULT * 0.715200 * 2^14/125)
+	spl_convert_to_custom_float_format(c1_calc, &fmt, &dscl_prog_data->easf_matrix_c1);
+	// fp1.5.10, C2 coefficient (LN_rec709:  HDR_MULT * 0.072200 * 2^14/125)
+	spl_convert_to_custom_float_format(c2_calc, &fmt, &dscl_prog_data->easf_matrix_c2);
+	dscl_prog_data->easf_matrix_c3 = 0x0; // fp1.5.10, C3 coefficient
+}
+
 /* Set EASF data */
 static void spl_set_easf_data(struct spl_scratch *spl_scratch, struct spl_out *spl_out, bool enable_easf_v,
 	bool enable_easf_h, enum linear_light_scaling lls_pref,
-	enum spl_pixel_format format, enum system_setup setup)
+	enum spl_pixel_format format, enum system_setup setup,
+	uint32_t hdr_multx100)
 {
 	struct dscl_prog_data *dscl_prog_data = spl_out->dscl_prog_data;
 	if (enable_easf_v) {
@@ -1463,16 +1508,10 @@ static void spl_set_easf_data(struct spl_scratch *spl_scratch, struct spl_out *s
 
 	if (lls_pref == LLS_PREF_YES)	{
 		dscl_prog_data->easf_ltonl_en = 1;	// Linear input
-		if (setup == HDR_L) {
-			dscl_prog_data->easf_matrix_c0 =
-				0x504E;	// fp1.5.10, C0 coefficient (LN_BT2020:  0.2627 * (2^14)/125 = 34.43750000)
-			dscl_prog_data->easf_matrix_c1 =
-				0x558E;	// fp1.5.10, C1 coefficient (LN_BT2020:  0.6780 * (2^14)/125 = 88.87500000)
-			dscl_prog_data->easf_matrix_c2 =
-				0x47C6;	// fp1.5.10, C2 coefficient (LN_BT2020:  0.0593 * (2^14)/125 = 7.77343750)
-			dscl_prog_data->easf_matrix_c3 =
-				0x0;	// fp1.5.10, C3 coefficient
-		} else { // SDR_L
+		if ((setup == HDR_L) && (spl_is_rgb8(format))) {
+			/* Calculate C0-C3 coefficients based on HDR multiplier */
+			spl_calculate_c0_c3_hdr(dscl_prog_data, hdr_multx100);
+		} else { // HDR_L ( DWM ) and SDR_L
 			dscl_prog_data->easf_matrix_c0 =
 				0x4EF7;	// fp1.5.10, C0 coefficient (LN_rec709:  0.2126 * (2^14)/125 = 27.86590720)
 			dscl_prog_data->easf_matrix_c1 =
@@ -1570,9 +1609,9 @@ static void spl_set_isharp_data(struct dscl_prog_data *dscl_prog_data,
 		dscl_prog_data->isharp_lba.base_seg[1] = 63; // ISHARP LBA PWL for Seg 1. BASE value in U0.6 format
 		dscl_prog_data->isharp_lba.slope_seg[1] = 0; // ISHARP LBA for Seg 1. SLOPE value in S5.3 format
 		// ISHARP_LBA_PWL_SEG2: ISHARP LBA PWL Segment 2
-		dscl_prog_data->isharp_lba.in_seg[2] = 312; // ISHARP LBA PWL for Seg 2. INPUT value in U0.10 format
+		dscl_prog_data->isharp_lba.in_seg[2] = 450; // ISHARP LBA PWL for Seg 2. INPUT value in U0.10 format
 		dscl_prog_data->isharp_lba.base_seg[2] = 63; // ISHARP LBA PWL for Seg 2. BASE value in U0.6 format
-		dscl_prog_data->isharp_lba.slope_seg[2] = 0x1D9; // ISHARP LBA for Seg 2. SLOPE value in S5.3 format = -39
+		dscl_prog_data->isharp_lba.slope_seg[2] = 0x18D; // ISHARP LBA for Seg 2. SLOPE value in S5.3 format = -115
 		// ISHARP_LBA_PWL_SEG3: ISHARP LBA PWL Segment 3
 		dscl_prog_data->isharp_lba.in_seg[3] = 520; // ISHARP LBA PWL for Seg 3.INPUT value in U0.10 format
 		dscl_prog_data->isharp_lba.base_seg[3] = 0; // ISHARP LBA PWL for Seg 3. BASE value in U0.6 format
@@ -1584,19 +1623,43 @@ static void spl_set_isharp_data(struct dscl_prog_data *dscl_prog_data,
 		// ISHARP_LBA_PWL_SEG5: ISHARP LBA PWL Segment 5
 		dscl_prog_data->isharp_lba.in_seg[5] = 520; // ISHARP LBA PWL for Seg 5.INPUT value in U0.10 format
 		dscl_prog_data->isharp_lba.base_seg[5] = 0;	// ISHARP LBA PWL for Seg 5. BASE value in U0.6 format
-	} else {
+	} else if (setup == HDR_L) {
 		// ISHARP_LBA_PWL_SEG0: ISHARP Local Brightness Adjustment PWL Segment 0
 		dscl_prog_data->isharp_lba.in_seg[0] = 0;	// ISHARP LBA PWL for Seg 0. INPUT value in U0.10 format
 		dscl_prog_data->isharp_lba.base_seg[0] = 0;	// ISHARP LBA PWL for Seg 0. BASE value in U0.6 format
 		dscl_prog_data->isharp_lba.slope_seg[0] = 32;	// ISHARP LBA for Seg 0. SLOPE value in S5.3 format
 		// ISHARP_LBA_PWL_SEG1: ISHARP LBA PWL Segment 1
-		dscl_prog_data->isharp_lba.in_seg[1] = 256;	// ISHARP LBA PWL for Seg 1. INPUT value in U0.10 format
+		dscl_prog_data->isharp_lba.in_seg[1] = 254;	// ISHARP LBA PWL for Seg 1. INPUT value in U0.10 format
+		dscl_prog_data->isharp_lba.base_seg[1] = 63; // ISHARP LBA PWL for Seg 1. BASE value in U0.6 format
+		dscl_prog_data->isharp_lba.slope_seg[1] = 0; // ISHARP LBA for Seg 1. SLOPE value in S5.3 format
+		// ISHARP_LBA_PWL_SEG2: ISHARP LBA PWL Segment 2
+		dscl_prog_data->isharp_lba.in_seg[2] = 559; // ISHARP LBA PWL for Seg 2. INPUT value in U0.10 format
+		dscl_prog_data->isharp_lba.base_seg[2] = 63; // ISHARP LBA PWL for Seg 2. BASE value in U0.6 format
+		dscl_prog_data->isharp_lba.slope_seg[2] = 0x10C; // ISHARP LBA for Seg 2. SLOPE value in S5.3 format = -244
+		// ISHARP_LBA_PWL_SEG3: ISHARP LBA PWL Segment 3
+		dscl_prog_data->isharp_lba.in_seg[3] = 592; // ISHARP LBA PWL for Seg 3.INPUT value in U0.10 format
+		dscl_prog_data->isharp_lba.base_seg[3] = 0; // ISHARP LBA PWL for Seg 3. BASE value in U0.6 format
+		dscl_prog_data->isharp_lba.slope_seg[3] = 0; // ISHARP LBA for Seg 3. SLOPE value in S5.3 format
+		// ISHARP_LBA_PWL_SEG4: ISHARP LBA PWL Segment 4
+		dscl_prog_data->isharp_lba.in_seg[4] = 1023; // ISHARP LBA PWL for Seg 4.INPUT value in U0.10 format
+		dscl_prog_data->isharp_lba.base_seg[4] = 0; // ISHARP LBA PWL for Seg 4. BASE value in U0.6 format
+		dscl_prog_data->isharp_lba.slope_seg[4] = 0; // ISHARP LBA for Seg 4. SLOPE value in S5.3 format
+		// ISHARP_LBA_PWL_SEG5: ISHARP LBA PWL Segment 5
+		dscl_prog_data->isharp_lba.in_seg[5] = 1023; // ISHARP LBA PWL for Seg 5.INPUT value in U0.10 format
+		dscl_prog_data->isharp_lba.base_seg[5] = 0;	// ISHARP LBA PWL for Seg 5. BASE value in U0.6 format
+	} else {
+		// ISHARP_LBA_PWL_SEG0: ISHARP Local Brightness Adjustment PWL Segment 0
+		dscl_prog_data->isharp_lba.in_seg[0] = 0;	// ISHARP LBA PWL for Seg 0. INPUT value in U0.10 format
+		dscl_prog_data->isharp_lba.base_seg[0] = 0;	// ISHARP LBA PWL for Seg 0. BASE value in U0.6 format
+		dscl_prog_data->isharp_lba.slope_seg[0] = 40;	// ISHARP LBA for Seg 0. SLOPE value in S5.3 format
+		// ISHARP_LBA_PWL_SEG1: ISHARP LBA PWL Segment 1
+		dscl_prog_data->isharp_lba.in_seg[1] = 204;	// ISHARP LBA PWL for Seg 1. INPUT value in U0.10 format
 		dscl_prog_data->isharp_lba.base_seg[1] = 63; // ISHARP LBA PWL for Seg 1. BASE value in U0.6 format
 		dscl_prog_data->isharp_lba.slope_seg[1] = 0; // ISHARP LBA for Seg 1. SLOPE value in S5.3 format
 		// ISHARP_LBA_PWL_SEG2: ISHARP LBA PWL Segment 2
-		dscl_prog_data->isharp_lba.in_seg[2] = 614; // ISHARP LBA PWL for Seg 2. INPUT value in U0.10 format
+		dscl_prog_data->isharp_lba.in_seg[2] = 818; // ISHARP LBA PWL for Seg 2. INPUT value in U0.10 format
 		dscl_prog_data->isharp_lba.base_seg[2] = 63; // ISHARP LBA PWL for Seg 2. BASE value in U0.6 format
-		dscl_prog_data->isharp_lba.slope_seg[2] = 0x1EC; // ISHARP LBA for Seg 2. SLOPE value in S5.3 format = -20
+		dscl_prog_data->isharp_lba.slope_seg[2] = 0x1D9; // ISHARP LBA for Seg 2. SLOPE value in S5.3 format = -39
 		// ISHARP_LBA_PWL_SEG3: ISHARP LBA PWL Segment 3
 		dscl_prog_data->isharp_lba.in_seg[3] = 1023; // ISHARP LBA PWL for Seg 3.INPUT value in U0.10 format
 		dscl_prog_data->isharp_lba.base_seg[3] = 0; // ISHARP LBA PWL for Seg 3. BASE value in U0.6 format
@@ -1696,7 +1759,7 @@ bool spl_calculate_scaler_params(struct spl_in *spl_in, struct spl_out *spl_out)
 
 	// Set EASF
 	spl_set_easf_data(&spl_scratch, spl_out, enable_easf_v, enable_easf_h, spl_in->lls_pref,
-		spl_in->basic_in.format, setup);
+		spl_in->basic_in.format, setup, spl_in->hdr_multx100);
 
 	// Set iSHARP
 	vratio = spl_fixpt_ceil(spl_scratch.scl_data.ratios.vert);
diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h b/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h
index 3d61c9825807..7c1a21c2305d 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h
+++ b/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h
@@ -10,6 +10,7 @@
 #define SPL_ASSERT(_bool) ((void *)0)
 #endif
 #include "spl_fixpt31_32.h"	// fixed31_32 and related functions
+#include "spl_custom_float.h" // custom float and related functions
 
 struct spl_size {
 	uint32_t width;
@@ -504,6 +505,7 @@ struct spl_in	{
 	bool is_hdr_on;
 	int h_active;
 	int v_active;
+	int hdr_multx100;
 };
 // end of SPL inputs
 
diff --git a/drivers/gpu/drm/amd/display/dc/spl/spl_custom_float.c b/drivers/gpu/drm/amd/display/dc/spl/spl_custom_float.c
new file mode 100644
index 000000000000..be2f34d034c5
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/spl/spl_custom_float.c
@@ -0,0 +1,151 @@
+// SPDX-License-Identifier: MIT
+//
+// Copyright 2024 Advanced Micro Devices, Inc.
+
+#include "spl_debug.h"
+#include "spl_custom_float.h"
+
+static bool spl_build_custom_float(struct spl_fixed31_32 value,
+			       const struct spl_custom_float_format *format,
+			       bool *negative,
+			       uint32_t *mantissa,
+			       uint32_t *exponenta)
+{
+	uint32_t exp_offset = (1 << (format->exponenta_bits - 1)) - 1;
+
+	const struct spl_fixed31_32 mantissa_constant_plus_max_fraction =
+		spl_fixpt_from_fraction((1LL << (format->mantissa_bits + 1)) - 1,
+				       1LL << format->mantissa_bits);
+
+	struct spl_fixed31_32 mantiss;
+
+	if (spl_fixpt_eq(value, spl_fixpt_zero)) {
+		*negative = false;
+		*mantissa = 0;
+		*exponenta = 0;
+		return true;
+	}
+
+	if (spl_fixpt_lt(value, spl_fixpt_zero)) {
+		*negative = format->sign;
+		value = spl_fixpt_neg(value);
+	} else {
+		*negative = false;
+	}
+
+	if (spl_fixpt_lt(value, spl_fixpt_one)) {
+		uint32_t i = 1;
+
+		do {
+			value = spl_fixpt_shl(value, 1);
+			++i;
+		} while (spl_fixpt_lt(value, spl_fixpt_one));
+
+		--i;
+
+		if (exp_offset <= i) {
+			*mantissa = 0;
+			*exponenta = 0;
+			return true;
+		}
+
+		*exponenta = exp_offset - i;
+	} else if (spl_fixpt_le(mantissa_constant_plus_max_fraction, value)) {
+		uint32_t i = 1;
+
+		do {
+			value = spl_fixpt_shr(value, 1);
+			++i;
+		} while (spl_fixpt_lt(mantissa_constant_plus_max_fraction, value));
+
+		*exponenta = exp_offset + i - 1;
+	} else {
+		*exponenta = exp_offset;
+	}
+
+	mantiss = spl_fixpt_sub(value, spl_fixpt_one);
+
+	if (spl_fixpt_lt(mantiss, spl_fixpt_zero) ||
+	    spl_fixpt_lt(spl_fixpt_one, mantiss))
+		mantiss = spl_fixpt_zero;
+	else
+		mantiss = spl_fixpt_shl(mantiss, format->mantissa_bits);
+
+	*mantissa = spl_fixpt_floor(mantiss);
+
+	return true;
+}
+
+static bool spl_setup_custom_float(const struct spl_custom_float_format *format,
+			       bool negative,
+			       uint32_t mantissa,
+			       uint32_t exponenta,
+			       uint32_t *result)
+{
+	uint32_t i = 0;
+	uint32_t j = 0;
+	uint32_t value = 0;
+
+	/* verification code:
+	 * once calculation is ok we can remove it
+	 */
+
+	const uint32_t mantissa_mask =
+		(1 << (format->mantissa_bits + 1)) - 1;
+
+	const uint32_t exponenta_mask =
+		(1 << (format->exponenta_bits + 1)) - 1;
+
+	if (mantissa & ~mantissa_mask) {
+		SPL_BREAK_TO_DEBUGGER();
+		mantissa = mantissa_mask;
+	}
+
+	if (exponenta & ~exponenta_mask) {
+		SPL_BREAK_TO_DEBUGGER();
+		exponenta = exponenta_mask;
+	}
+
+	/* end of verification code */
+
+	while (i < format->mantissa_bits) {
+		uint32_t mask = 1 << i;
+
+		if (mantissa & mask)
+			value |= mask;
+
+		++i;
+	}
+
+	while (j < format->exponenta_bits) {
+		uint32_t mask = 1 << j;
+
+		if (exponenta & mask)
+			value |= mask << i;
+
+		++j;
+	}
+
+	if (negative && format->sign)
+		value |= 1 << (i + j);
+
+	*result = value;
+
+	return true;
+}
+
+bool spl_convert_to_custom_float_format(struct spl_fixed31_32 value,
+				    const struct spl_custom_float_format *format,
+				    uint32_t *result)
+{
+	uint32_t mantissa;
+	uint32_t exponenta;
+	bool negative;
+
+	return spl_build_custom_float(value, format, &negative, &mantissa, &exponenta) &&
+				  spl_setup_custom_float(format,
+						     negative,
+						     mantissa,
+						     exponenta,
+						     result);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/spl/spl_custom_float.h b/drivers/gpu/drm/amd/display/dc/spl/spl_custom_float.h
new file mode 100644
index 000000000000..cdc4e107b9de
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/spl/spl_custom_float.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: MIT */
+
+/* Copyright 2024 Advanced Micro Devices, Inc. */
+
+#ifndef SPL_CUSTOM_FLOAT_H_
+#define SPL_CUSTOM_FLOAT_H_
+
+#include "spl_os_types.h"
+#include "spl_fixpt31_32.h"
+
+struct spl_custom_float_format {
+	uint32_t mantissa_bits;
+	uint32_t exponenta_bits;
+	bool sign;
+};
+
+struct spl_custom_float_value {
+	uint32_t mantissa;
+	uint32_t exponenta;
+	uint32_t value;
+	bool negative;
+};
+
+bool spl_convert_to_custom_float_format(
+	struct spl_fixed31_32 value,
+	const struct spl_custom_float_format *format,
+	uint32_t *result);
+
+#endif //SPL_CUSTOM_FLOAT_H_
-- 
2.34.1

