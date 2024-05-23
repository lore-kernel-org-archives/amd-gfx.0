Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29BA8C25B75
	for <amd-gfx@archiver.kernel.org>; Thu, 23 May 2024 19:20:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C40610F29F;
	Thu, 23 May 2024 19:20:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bu/yg6ht";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2074.outbound.protection.outlook.com [40.107.95.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C354C10F29F
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 May 2024 19:20:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vc7x9apMVadtDnA/XUlkEEPydNLEmVKZcbx0qBXBSovLBwyfWfvMjRe28K6RQHfBOvSYPRtPn4BnvDf3nPecgLw+WhLpkd/E0SmXCF++p9/JUVLn+XvaL0tgOmgGvS6e8ljDpyvFuhsS2qGpHGGOpAYz4aP/KLIVLT/4O0HR+fRKHq+AE+UWuVCcizuAOK6WbJh9g5oaJZiqRM0xXV0m6eS+GH0SeofYn2z2S4K6mvA9ON2BkHECVxBDAL2wxrPg73Is7wKfCjVZDvL7lLmDRk96WNb/KtETriMklIyAXuSMuNJJ8m0AkuSt2eZJQ97HCrPgdhtNmdvY9ukCZc7fOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tz2wHvNK0HiaHGTCOCTbJ768eoNJBTG2KRmUPf3VutM=;
 b=KS8F8g5uEk28whEnfssmhwRdYPeuX0jecBPC3FH0CgvGlrpsmj0t4aF/Skntwxh590Cy45fZ9cvy1zZyLH9EfID1dTdp6ToMAo/15WpZ9GK3wBymc2l9EFsEUdzN3EBbS1p/zSj7NzWGAbF4qJ0yQLZxkytFcxU+/An4SrsdY6AChkIoFKAOQ+KY0RuGe2KXZ9rxEFgDpGlxwAuYQKNpKJ4c4XLTFL8mUCjswxJ3F9WMHAZ2z2pgetIcMf4JlwlF5BITlqXYZrNjVGctQx+YEh/3vAvw36VpKUpvFHukuwPTf7gRGU8OTTQXR8ITLq4JLmww3PJGnMOF3jCALLfTNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tz2wHvNK0HiaHGTCOCTbJ768eoNJBTG2KRmUPf3VutM=;
 b=bu/yg6htHEoxi1s6ySGKoHC/meA1EK1e64MObfTI3pk+ZwxHjzS6K7vCB22H/NCZtUVwrV7PLlCwvTgRIQLpMpjOkIQwOzsePqZjII9819qOHKRPnztDmUbeUmIY0FOI7nr3AUNxomtvtDBTZGZtUBm1TE2z3+RU73BCIKjqJYo=
Received: from DM6PR01CA0027.prod.exchangelabs.com (2603:10b6:5:296::32) by
 DM4PR12MB5795.namprd12.prod.outlook.com (2603:10b6:8:62::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.35; Thu, 23 May 2024 19:20:41 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:5:296:cafe::da) by DM6PR01CA0027.outlook.office365.com
 (2603:10b6:5:296::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22 via Frontend
 Transport; Thu, 23 May 2024 19:20:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024 19:20:40 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 23 May
 2024 14:20:39 -0500
Received: from debian.net (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 23 May 2024 14:20:34 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
 <rodrigo.siqueira@amd.com>, <aurabindo.pillai@amd.com>, Samson Tam
 <Samson.Tam@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Subject: [PATCH 02/13] drm/amd/display: Enable ISHARP support for DCN401
Date: Thu, 23 May 2024 19:20:16 +0000
Message-ID: <20240523192027.50630-2-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240523192027.50630-1-aurabindo.pillai@amd.com>
References: <20240523192027.50630-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|DM4PR12MB5795:EE_
X-MS-Office365-Filtering-Correlation-Id: 031add31-7d85-4a7c-eff9-08dc7b5d6f45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LEiycj0lE5nzvU6NVEGawmJQWf71eTkf+CJ/dZ15M8FtzsVDK/Xww0G70JO2?=
 =?us-ascii?Q?yxoXUaG62vjx0t03QAtZk9QwBi59/bj0KOHjrGDdGjLmKajalOQp9xAEVY8+?=
 =?us-ascii?Q?v58Qeavma9EZ6wg9+A1ncHsQjE/8hIgNhexNz+K1sFyfL5u1agnUV//ayGZa?=
 =?us-ascii?Q?WMz0nWREc48ke6/y6rUu9VYHKCkEBoJO3meyhi9gVodXqSSISAfetiPzKS/w?=
 =?us-ascii?Q?9QhqHcRKJ/dUojQtJO7g7/2sXFuwRGGWh+SlrljuD92dOUpISUVRbX1Ojasl?=
 =?us-ascii?Q?H6JNkal8BYxtIta++Hh0BqlqZJ2C9kBL+1e3Ml9sDzQJCVs7SqK/qkV0exPI?=
 =?us-ascii?Q?HL6B+JZ7msavuba36x8H9SKXTiY1oX9dDCSR4KoRODYcXY60x9cbwJNivHMJ?=
 =?us-ascii?Q?sB9TbwcRSIVVaysL/QhE9E0BSPQ6Z+lvuBJhXdshMmb3ORm+2SMRSvNh7OJI?=
 =?us-ascii?Q?fmIqZGWWM88rCOR7aDmYqjRqBnsVrcfMRy0hnFZtvkjNTZbtC+nU4GQILJWm?=
 =?us-ascii?Q?wNH6dRLgaqsX0WKIieXR8Y/jGzLmxV7h7cq/GOQ/G30bqLUVxYHtSqi1Lske?=
 =?us-ascii?Q?4ymkERT62bu3YFPi7JcC/9pn5+4MZuWrOu6JgbUY+OmCWFyvqKioLnN8j4MP?=
 =?us-ascii?Q?oSA6+3kMGRI0eIYZWtlyBOF0UDJgbFgR9GLiApW6tYJJOCIyKFuXrMp0LiRt?=
 =?us-ascii?Q?xPLS12GDETefQcPdriOWFzwz5lEL9N79c3R9gZGugbrAvVFKYmjX0BGrOqai?=
 =?us-ascii?Q?GLlbCUWXqir0eYSrMt12sejRGq0NsUv+6B0qM2DkGBCPU9TJJQFclSYaDDjz?=
 =?us-ascii?Q?ZblY/7v+9GApvnxkTDTzGk8NzyvNHgGWovtvLV24igom3i1d0vK/yg2myzYk?=
 =?us-ascii?Q?yw9bp/Eb+82RQbSTsMwIh35WsGq6MBjgeHxZmQqynM6WSiwjzgBnZFPRlslJ?=
 =?us-ascii?Q?p+Hzzix9r7I9Eg1GrXY6eM4/ek3Mq37x/nZQoXWleiH4/bLS3x6SOn+cja0W?=
 =?us-ascii?Q?e+YCpGaorR7yDpNu98P32wgdJFbFdIROOuNEZbbwn+leKeRAGjegQOQ2YWDW?=
 =?us-ascii?Q?qXs/RJU8R/Bl4/FlqleHGTAJZwYRouEB2cHESlOmS1tvgbuefHe/KbyumR32?=
 =?us-ascii?Q?30CzNEs9e4b0Re1hA2pR8tRtsaPZUT310yLk9eeHS7PTQGEfPM2mFhAmfOnj?=
 =?us-ascii?Q?4IkQI/sEVHEB3v2SEFEqjFJEHzHDP/md5K3WU01MFiE4GVtwMnVDnMOC6e7O?=
 =?us-ascii?Q?8fpa6p5RSNNJchIr4vFwHz/Dt3A56FAw0/6SFpsVDTj87OWTH1dwCpy8Z8lW?=
 =?us-ascii?Q?LcNFWznOJhnBGeYHsuXSk2+ZNgsck6BriBAnHaljd5Wvi6147jW0y04OwSGB?=
 =?us-ascii?Q?jE40fD4JIaeIV+eHh64lGsZidKtD?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 19:20:40.7234 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 031add31-7d85-4a7c-eff9-08dc7b5d6f45
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5795
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
Enable sharpener support for DCN401

[How]
- Removed memcmp check that was preventing ISHARP from being enabled.
- Add missing ISHARP register defines, masks, and writes.
- Add programming of Blur and Scale coefficients.
- Program FMT_MODE and NLDELTA registers based on LLS_PREF and pixel
- format
- Only enable ISHARP for YUV420
- Add disabling of ISHARP
- Add debug flags and registry keys for debugging ISHARP.
- Set default to medium level

Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Samson Tam <Samson.Tam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h           |   1 +
 .../gpu/drm/amd/display/dc/dc_spl_translate.c |  29 ++--
 .../display/dc/dpp/dcn401/dcn401_dpp_dscl.c   | 149 ++++++++++++++----
 .../dc/resource/dcn401/dcn401_resource.h      |  13 ++
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.c   |  81 ++++++++--
 .../display/dc/spl/dc_spl_isharp_filters.c    |   8 +-
 .../display/dc/spl/dc_spl_isharp_filters.h    |   4 +-
 .../gpu/drm/amd/display/dc/spl/dc_spl_types.h |   3 +
 8 files changed, 223 insertions(+), 65 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index a711e3fd6f1b..1055970d3888 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1040,6 +1040,7 @@ struct dc_debug_options {
 	unsigned int force_cositing;
 	unsigned int disable_spl;
 	unsigned int force_easf;
+	unsigned int force_sharpness;
 	unsigned int force_lls;
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c b/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
index 6e37b166802b..bc760448a378 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
@@ -134,16 +134,25 @@ void translate_SPL_in_params_from_pipe_ctx(struct pipe_ctx *pipe_ctx, struct spl
 		spl_in->prefer_easf = false;
 	else if (pipe_ctx->stream->ctx->dc->debug.force_easf == 2)
 		spl_in->disable_easf = true;
-	// Translate adaptive sharpening preference
-	spl_in->adaptive_sharpness.enable = plane_state->adaptive_sharpness_en;
-	if (plane_state->sharpnessX1000 == 0)	{
-		spl_in->adaptive_sharpness.enable = false;
-	} else if (plane_state->sharpnessX1000 < 999)	{
-		spl_in->adaptive_sharpness.sharpness = SHARPNESS_LOW;
-	} else if (plane_state->sharpnessX1000 < 1999)	{
-		spl_in->adaptive_sharpness.sharpness = SHARPNESS_MID;
-	} else	{	// Any other value is high sharpness
-		spl_in->adaptive_sharpness.sharpness = SHARPNESS_HIGH;
+	/* Translate adaptive sharpening preference */
+	if (pipe_ctx->stream->ctx->dc->debug.force_sharpness > 0) {
+		spl_in->adaptive_sharpness.enable = (pipe_ctx->stream->ctx->dc->debug.force_sharpness > 1) ? true : false;
+		if (pipe_ctx->stream->ctx->dc->debug.force_sharpness == 2)
+			spl_in->adaptive_sharpness.sharpness = SHARPNESS_LOW;
+		else if (pipe_ctx->stream->ctx->dc->debug.force_sharpness == 3)
+			spl_in->adaptive_sharpness.sharpness = SHARPNESS_MID;
+		else if (pipe_ctx->stream->ctx->dc->debug.force_sharpness >= 4)
+			spl_in->adaptive_sharpness.sharpness = SHARPNESS_HIGH;
+	} else {
+		spl_in->adaptive_sharpness.enable = plane_state->adaptive_sharpness_en;
+		if (plane_state->sharpnessX1000 == 0)
+			spl_in->adaptive_sharpness.enable = false;
+		else if (plane_state->sharpnessX1000 < 999)
+			spl_in->adaptive_sharpness.sharpness = SHARPNESS_LOW;
+		else if (plane_state->sharpnessX1000 < 1999)
+			spl_in->adaptive_sharpness.sharpness = SHARPNESS_MID;
+		else // Any other value is high sharpness
+			spl_in->adaptive_sharpness.sharpness = SHARPNESS_HIGH;
 	}
 	// Translate linear light scaling preference
 	if (pipe_ctx->stream->ctx->dc->debug.force_lls > 0)
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
index 4b1e52803c7a..6cb3fa4b585c 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
@@ -949,6 +949,9 @@ static void dpp401_dscl_set_isharp_filter(
 {
 	int level;
 	uint32_t filter_data;
+	if (filter == NULL)
+		return;
+
 	REG_UPDATE(ISHARP_DELTA_CTRL,
 		ISHARP_DELTA_LUT_HOST_SELECT, 0);
 	for (level = 0; level < NUM_LEVELS; level++)	{
@@ -972,41 +975,121 @@ static void dpp401_dscl_program_isharp(struct dpp *dpp_base,
 		const struct scaler_data *scl_data)
 {
 	struct dcn401_dpp *dpp = TO_DCN401_DPP(dpp_base);
-	const struct dscl_prog_data *data;
-
-	if (memcmp(&dpp->scl_data, scl_data, sizeof(*scl_data)) == 0)
-		return;
 
 	PERF_TRACE();
-	dpp->scl_data = *scl_data;
-	data = &scl_data->dscl_prog_data;
-
-	REG_SET(ISHARP_MODE, 0,	ISHARP_EN, data->isharp_en);
-
-	REG_SET(ISHARP_MODE, 0,	              ISHARP_NOISEDET_EN,    data->isharp_noise_det.enable);
-	REG_SET(ISHARP_MODE, 0,               ISHARP_NOISEDET_MODE,  data->isharp_noise_det.mode);
-	REG_SET(ISHARP_NOISEDET_THRESHOLD, 0, ISHARP_NOISEDET_UTHRE, data->isharp_noise_det.uthreshold);
-	REG_SET(ISHARP_NOISEDET_THRESHOLD, 0, ISHARP_NOISEDET_DTHRE, data->isharp_noise_det.dthreshold);
-	REG_SET(ISHARP_MODE, 0,               ISHARP_NOISEDET_MODE,  data->isharp_noise_det.mode);
-	REG_SET(ISHARP_NOISEDET_THRESHOLD, 0, ISHARP_NOISEDET_UTHRE, data->isharp_noise_det.uthreshold);
-	REG_SET(ISHARP_NOISEDET_THRESHOLD, 0, ISHARP_NOISEDET_DTHRE, data->isharp_noise_det.dthreshold);
-	REG_SET(ISHARP_NOISE_GAIN_PWL, 0, ISHARP_NOISEDET_PWL_START_IN, data->isharp_noise_det.pwl_start_in);
-	REG_SET(ISHARP_NOISE_GAIN_PWL, 0, ISHARP_NOISEDET_PWL_END_IN, data->isharp_noise_det.pwl_end_in);
-	REG_SET(ISHARP_NOISE_GAIN_PWL, 0, ISHARP_NOISEDET_PWL_SLOPE, data->isharp_noise_det.pwl_slope);
-
-	REG_SET(ISHARP_MODE, 0, ISHARP_LBA_MODE, data->isharp_lba.mode);
-	// TODO: ISHARP_LBA: IN_SEG, BASE_SEG, SLOPE_SEG
-	REG_SET(ISHARP_MODE, 0, ISHARP_FMT_MODE, data->isharp_fmt.mode);
-	REG_SET(ISHARP_MODE, 0, ISHARP_FMT_NORM, data->isharp_fmt.norm);
-
-	dpp401_dscl_set_isharp_filter(dpp, data->isharp_delta);
-
-	REG_SET(ISHARP_NLDELTA_SOFT_CLIP, 0, ISHARP_NLDELTA_SCLIP_EN_P,    data->isharp_nldelta_sclip.enable_p);
-	REG_SET(ISHARP_NLDELTA_SOFT_CLIP, 0, ISHARP_NLDELTA_SCLIP_PIVOT_P, data->isharp_nldelta_sclip.pivot_p);
-	REG_SET(ISHARP_NLDELTA_SOFT_CLIP, 0, ISHARP_NLDELTA_SCLIP_SLOPE_P, data->isharp_nldelta_sclip.slope_p);
-	REG_SET(ISHARP_NLDELTA_SOFT_CLIP, 0, ISHARP_NLDELTA_SCLIP_EN_N,    data->isharp_nldelta_sclip.enable_n);
-	REG_SET(ISHARP_NLDELTA_SOFT_CLIP, 0, ISHARP_NLDELTA_SCLIP_PIVOT_N, data->isharp_nldelta_sclip.pivot_n);
-	REG_SET(ISHARP_NLDELTA_SOFT_CLIP, 0, ISHARP_NLDELTA_SCLIP_SLOPE_N, data->isharp_nldelta_sclip.slope_n);
+	/* ISHARP_EN */
+	REG_UPDATE(ISHARP_MODE,
+		ISHARP_EN, scl_data->dscl_prog_data.isharp_en);
+	/* ISHARP_NOISEDET_EN */
+	REG_UPDATE(ISHARP_MODE,
+		ISHARP_NOISEDET_EN, scl_data->dscl_prog_data.isharp_noise_det.enable);
+	/* ISHARP_NOISEDET_MODE */
+	REG_UPDATE(ISHARP_MODE,
+		ISHARP_NOISEDET_MODE, scl_data->dscl_prog_data.isharp_noise_det.mode);
+	/* ISHARP_NOISEDET_UTHRE */
+	REG_UPDATE(ISHARP_NOISEDET_THRESHOLD,
+		ISHARP_NOISEDET_UTHRE, scl_data->dscl_prog_data.isharp_noise_det.uthreshold);
+	/* ISHARP_NOISEDET_DTHRE */
+	REG_UPDATE(ISHARP_NOISEDET_THRESHOLD,
+		ISHARP_NOISEDET_DTHRE, scl_data->dscl_prog_data.isharp_noise_det.dthreshold);
+	REG_UPDATE(ISHARP_MODE,
+		ISHARP_NOISEDET_MODE, scl_data->dscl_prog_data.isharp_noise_det.mode);
+	/* ISHARP_NOISEDET_UTHRE */
+	REG_UPDATE(ISHARP_NOISEDET_THRESHOLD,
+		ISHARP_NOISEDET_UTHRE, scl_data->dscl_prog_data.isharp_noise_det.uthreshold);
+	/* ISHARP_NOISEDET_DTHRE */
+	REG_UPDATE(ISHARP_NOISEDET_THRESHOLD,
+		ISHARP_NOISEDET_DTHRE, scl_data->dscl_prog_data.isharp_noise_det.dthreshold);
+	/* ISHARP_NOISEDET_PWL_START_IN */
+	REG_UPDATE(ISHARP_NOISE_GAIN_PWL,
+		ISHARP_NOISEDET_PWL_START_IN, scl_data->dscl_prog_data.isharp_noise_det.pwl_start_in);
+	/* ISHARP_NOISEDET_PWL_END_IN */
+	REG_UPDATE(ISHARP_NOISE_GAIN_PWL,
+		ISHARP_NOISEDET_PWL_END_IN, scl_data->dscl_prog_data.isharp_noise_det.pwl_end_in);
+	/* ISHARP_NOISEDET_PWL_SLOPE */
+	REG_UPDATE(ISHARP_NOISE_GAIN_PWL,
+		ISHARP_NOISEDET_PWL_SLOPE, scl_data->dscl_prog_data.isharp_noise_det.pwl_slope);
+	/* ISHARP_LBA_MODE */
+	REG_UPDATE(ISHARP_MODE,
+		ISHARP_LBA_MODE, scl_data->dscl_prog_data.isharp_lba.mode);
+	/* ISHARP_LBA: IN_SEG, BASE_SEG, SLOPE_SEG */
+	REG_UPDATE(ISHARP_LBA_PWL_SEG0,
+		ISHARP_LBA_PWL_IN_SEG0, scl_data->dscl_prog_data.isharp_lba.in_seg[0]);
+	REG_UPDATE(ISHARP_LBA_PWL_SEG0,
+		ISHARP_LBA_PWL_BASE_SEG0, scl_data->dscl_prog_data.isharp_lba.base_seg[0]);
+	REG_UPDATE(ISHARP_LBA_PWL_SEG0,
+		ISHARP_LBA_PWL_SLOPE_SEG0, scl_data->dscl_prog_data.isharp_lba.slope_seg[0]);
+	REG_UPDATE(ISHARP_LBA_PWL_SEG1,
+		ISHARP_LBA_PWL_IN_SEG1, scl_data->dscl_prog_data.isharp_lba.in_seg[1]);
+	REG_UPDATE(ISHARP_LBA_PWL_SEG1,
+		ISHARP_LBA_PWL_BASE_SEG1, scl_data->dscl_prog_data.isharp_lba.base_seg[1]);
+	REG_UPDATE(ISHARP_LBA_PWL_SEG1,
+		ISHARP_LBA_PWL_SLOPE_SEG1, scl_data->dscl_prog_data.isharp_lba.slope_seg[1]);
+	REG_UPDATE(ISHARP_LBA_PWL_SEG2,
+		ISHARP_LBA_PWL_IN_SEG2, scl_data->dscl_prog_data.isharp_lba.in_seg[2]);
+	REG_UPDATE(ISHARP_LBA_PWL_SEG2,
+		ISHARP_LBA_PWL_BASE_SEG2, scl_data->dscl_prog_data.isharp_lba.base_seg[2]);
+	REG_UPDATE(ISHARP_LBA_PWL_SEG2,
+		ISHARP_LBA_PWL_SLOPE_SEG2, scl_data->dscl_prog_data.isharp_lba.slope_seg[2]);
+	REG_UPDATE(ISHARP_LBA_PWL_SEG3,
+		ISHARP_LBA_PWL_IN_SEG3, scl_data->dscl_prog_data.isharp_lba.in_seg[3]);
+	REG_UPDATE(ISHARP_LBA_PWL_SEG3,
+		ISHARP_LBA_PWL_BASE_SEG3, scl_data->dscl_prog_data.isharp_lba.base_seg[3]);
+	REG_UPDATE(ISHARP_LBA_PWL_SEG3,
+		ISHARP_LBA_PWL_SLOPE_SEG3, scl_data->dscl_prog_data.isharp_lba.slope_seg[3]);
+	REG_UPDATE(ISHARP_LBA_PWL_SEG4,
+		ISHARP_LBA_PWL_IN_SEG4, scl_data->dscl_prog_data.isharp_lba.in_seg[4]);
+	REG_UPDATE(ISHARP_LBA_PWL_SEG4,
+		ISHARP_LBA_PWL_BASE_SEG4, scl_data->dscl_prog_data.isharp_lba.base_seg[4]);
+	REG_UPDATE(ISHARP_LBA_PWL_SEG4,
+		ISHARP_LBA_PWL_SLOPE_SEG4, scl_data->dscl_prog_data.isharp_lba.slope_seg[4]);
+	REG_UPDATE(ISHARP_LBA_PWL_SEG5,
+		ISHARP_LBA_PWL_IN_SEG5, scl_data->dscl_prog_data.isharp_lba.in_seg[5]);
+	REG_UPDATE(ISHARP_LBA_PWL_SEG5,
+		ISHARP_LBA_PWL_BASE_SEG5, scl_data->dscl_prog_data.isharp_lba.base_seg[5]);
+
+	/* ISHARP_FMT_MODE */
+	REG_UPDATE(ISHARP_MODE,
+		ISHARP_FMT_MODE, scl_data->dscl_prog_data.isharp_fmt.mode);
+	/* ISHARP_FMT_NORM */
+	REG_UPDATE(ISHARP_MODE,
+		ISHARP_FMT_NORM, scl_data->dscl_prog_data.isharp_fmt.norm);
+	/* ISHARP_DELTA_LUT */
+	dpp401_dscl_set_isharp_filter(dpp, scl_data->dscl_prog_data.isharp_delta);
+	/* ISHARP_NLDELTA_SCLIP_EN_P */
+	REG_UPDATE(ISHARP_NLDELTA_SOFT_CLIP,
+		ISHARP_NLDELTA_SCLIP_EN_P, scl_data->dscl_prog_data.isharp_nldelta_sclip.enable_p);
+	/* ISHARP_NLDELTA_SCLIP_PIVOT_P */
+	REG_UPDATE(ISHARP_NLDELTA_SOFT_CLIP,
+		ISHARP_NLDELTA_SCLIP_PIVOT_P, scl_data->dscl_prog_data.isharp_nldelta_sclip.pivot_p);
+	/* ISHARP_NLDELTA_SCLIP_SLOPE_P */
+	REG_UPDATE(ISHARP_NLDELTA_SOFT_CLIP,
+		ISHARP_NLDELTA_SCLIP_SLOPE_P, scl_data->dscl_prog_data.isharp_nldelta_sclip.slope_p);
+	/* ISHARP_NLDELTA_SCLIP_EN_N */
+	REG_UPDATE(ISHARP_NLDELTA_SOFT_CLIP,
+		ISHARP_NLDELTA_SCLIP_EN_N, scl_data->dscl_prog_data.isharp_nldelta_sclip.enable_n);
+	/* ISHARP_NLDELTA_SCLIP_PIVOT_N */
+	REG_UPDATE(ISHARP_NLDELTA_SOFT_CLIP,
+		ISHARP_NLDELTA_SCLIP_PIVOT_N, scl_data->dscl_prog_data.isharp_nldelta_sclip.pivot_n);
+	/* ISHARP_NLDELTA_SCLIP_SLOPE_N */
+	REG_UPDATE(ISHARP_NLDELTA_SOFT_CLIP,
+		ISHARP_NLDELTA_SCLIP_SLOPE_N, scl_data->dscl_prog_data.isharp_nldelta_sclip.slope_n);
+
+	/* Blur and Scale Coefficients - SCL_COEF_RAM_TAP_SELECT */
+	if (scl_data->dscl_prog_data.isharp_en) {
+		if (scl_data->dscl_prog_data.filter_blur_scale_v) {
+			dpp401_dscl_set_scaler_filter(
+				dpp, scl_data->taps.v_taps,
+				SCL_COEF_VERTICAL_BLUR_SCALE,
+				scl_data->dscl_prog_data.filter_blur_scale_v);
+		}
+		if (scl_data->dscl_prog_data.filter_blur_scale_h) {
+			dpp401_dscl_set_scaler_filter(
+				dpp, scl_data->taps.h_taps,
+				SCL_COEF_HORIZONTAL_BLUR_SCALE,
+				scl_data->dscl_prog_data.filter_blur_scale_h);
+		}
+	}
 	PERF_TRACE();
 } // dpp401_dscl_program_isharp
 /**
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h
index a638c410e32a..c04c8b8f2114 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h
@@ -387,6 +387,19 @@ bool dcn401_validate_bandwidth(struct dc *dc,
 	SRI_ARR(DSCL_EASF_V_BF3_PWL_SEG5, DSCL, id),                             \
 	SRI_ARR(DSCL_SC_MATRIX_C0C1, DSCL, id),                                  \
 	SRI_ARR(DSCL_SC_MATRIX_C2C3, DSCL, id),                                  \
+	SRI_ARR(ISHARP_MODE, DSCL, id),                                          \
+	SRI_ARR(ISHARP_NOISEDET_THRESHOLD, DSCL, id),                            \
+	SRI_ARR(ISHARP_NOISE_GAIN_PWL, DSCL, id),                                \
+	SRI_ARR(ISHARP_LBA_PWL_SEG0, DSCL, id),                                  \
+	SRI_ARR(ISHARP_LBA_PWL_SEG1, DSCL, id),                                  \
+	SRI_ARR(ISHARP_LBA_PWL_SEG2, DSCL, id),                                  \
+	SRI_ARR(ISHARP_LBA_PWL_SEG3, DSCL, id),                                  \
+	SRI_ARR(ISHARP_LBA_PWL_SEG4, DSCL, id),                                  \
+	SRI_ARR(ISHARP_LBA_PWL_SEG5, DSCL, id),                                  \
+	SRI_ARR(ISHARP_DELTA_CTRL, DSCL, id),                                    \
+	SRI_ARR(ISHARP_DELTA_DATA, DSCL, id),                                    \
+	SRI_ARR(ISHARP_DELTA_INDEX, DSCL, id),                                   \
+	SRI_ARR(ISHARP_NLDELTA_SOFT_CLIP, DSCL, id),                             \
 	SRI_ARR(SCL_VERT_FILTER_INIT_BOT, DSCL, id),                             \
 	SRI_ARR(SCL_VERT_FILTER_INIT_BOT_C, DSCL, id)
 
diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c b/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
index 82fbd2b59c70..2836f28fa3af 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
+++ b/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
@@ -913,6 +913,25 @@ static void spl_set_filters_data(struct dscl_prog_data *dscl_prog_data,
 	dscl_prog_data->filter_v_c = spl_dscl_get_filter_coeffs_64p(
 				data->taps.v_taps_c, data->ratios.vert_c);
 }
+
+static const uint16_t *spl_dscl_get_blur_scale_coeffs_64p(int taps)
+{
+	if ((taps == 3) || (taps == 4) || (taps == 6))
+		return spl_get_filter_isharp_bs_4tap_64p();
+	else {
+		/* should never happen, bug */
+		return NULL;
+	}
+}
+static void spl_set_blur_scale_data(struct dscl_prog_data *dscl_prog_data,
+		const struct spl_scaler_data *data)
+{
+	dscl_prog_data->filter_blur_scale_h = spl_dscl_get_blur_scale_coeffs_64p(
+				data->taps.h_taps);
+	dscl_prog_data->filter_blur_scale_v = spl_dscl_get_blur_scale_coeffs_64p(
+				data->taps.v_taps);
+}
+
 /* Populate dscl prog data structure from scaler data calculated by SPL */
 static void spl_set_dscl_prog_data(struct spl_in *spl_in, struct spl_out *spl_out)
 {
@@ -1226,10 +1245,18 @@ static void spl_set_isharp_noise_det_mode(struct dscl_prog_data *dscl_prog_data)
 	else if (dscl_prog_data->taps.h_taps == 3)
 		dscl_prog_data->isharp_noise_det.mode = 0;	// ISHARP_NOISEDET_MODE
 };
-/* Set EASF data */
+/* Set Sharpener data */
 static void spl_set_isharp_data(struct dscl_prog_data *dscl_prog_data,
-		struct adaptive_sharpness adp_sharpness)
+		struct adaptive_sharpness adp_sharpness, bool enable_isharp,
+		enum linear_light_scaling lls_pref, enum spl_pixel_format format,
+		const struct spl_scaler_data *data)
 {
+	/* Turn off sharpener if not required */
+	if (!enable_isharp) {
+		dscl_prog_data->isharp_en = 0;
+		return;
+	}
+
 	dscl_prog_data->isharp_en = 1;	// ISHARP_EN
 	dscl_prog_data->isharp_noise_det.enable = 1;	// ISHARP_NOISEDET_EN
 	// Set ISHARP_NOISEDET_MODE if htaps = 6-tap
@@ -1243,7 +1270,11 @@ static void spl_set_isharp_data(struct dscl_prog_data *dscl_prog_data,
 	dscl_prog_data->isharp_noise_det.pwl_end_in = 13;	// ISHARP_NOISEDET_PWL_END_IN
 	dscl_prog_data->isharp_noise_det.pwl_slope = 1623;	// ISHARP_NOISEDET_PWL_SLOPE
 
-	dscl_prog_data->isharp_fmt.mode = 1;	//	ISHARP_FMT_MODE
+	if ((lls_pref == LLS_PREF_NO) && !spl_is_yuv420(format)) /* ISHARP_FMT_MODE */
+		dscl_prog_data->isharp_fmt.mode = 1;
+	else
+		dscl_prog_data->isharp_fmt.mode = 0;
+
 	dscl_prog_data->isharp_fmt.norm = 0x3C00;	// ISHARP_FMT_NORM
 	dscl_prog_data->isharp_lba.mode = 0;	// ISHARP_LBA_MODE
 	// ISHARP_LBA_PWL_SEG0: ISHARP Local Brightness Adjustment PWL Segment 0
@@ -1269,7 +1300,7 @@ static void spl_set_isharp_data(struct dscl_prog_data *dscl_prog_data,
 	// ISHARP_LBA_PWL_SEG5: ISHARP LBA PWL Segment 5
 	dscl_prog_data->isharp_lba.in_seg[5] = 1023; // ISHARP LBA PWL for Seg 5.INPUT value in U0.10 format
 	dscl_prog_data->isharp_lba.base_seg[5] = 0;	// ISHARP LBA PWL for Seg 5. BASE value in U0.6 format
-	switch (adp_sharpness.sharpness)	{
+	switch (adp_sharpness.sharpness) {
 	case SHARPNESS_LOW:
 		dscl_prog_data->isharp_delta = spl_get_filter_isharp_1D_lut_0p5x();
 		break;
@@ -1284,17 +1315,28 @@ static void spl_set_isharp_data(struct dscl_prog_data *dscl_prog_data,
 	}
 
 	// Program the nldelta soft clip values
-	dscl_prog_data->isharp_nldelta_sclip.enable_p = 1;	//	ISHARP_NLDELTA_SCLIP_EN_P
-	dscl_prog_data->isharp_nldelta_sclip.pivot_p = 70;	//	ISHARP_NLDELTA_SCLIP_PIVOT_P
-	dscl_prog_data->isharp_nldelta_sclip.slope_p = 24;	//	ISHARP_NLDELTA_SCLIP_SLOPE_P
-	dscl_prog_data->isharp_nldelta_sclip.enable_n = 1;	//	ISHARP_NLDELTA_SCLIP_EN_N
-	dscl_prog_data->isharp_nldelta_sclip.pivot_n = 70;	//	ISHARP_NLDELTA_SCLIP_PIVOT_N
-	dscl_prog_data->isharp_nldelta_sclip.slope_n = 24;	//	ISHARP_NLDELTA_SCLIP_SLOPE_N
+	if (lls_pref == LLS_PREF_YES) {
+		dscl_prog_data->isharp_nldelta_sclip.enable_p = 0;	/* ISHARP_NLDELTA_SCLIP_EN_P */
+		dscl_prog_data->isharp_nldelta_sclip.pivot_p = 0;	/* ISHARP_NLDELTA_SCLIP_PIVOT_P */
+		dscl_prog_data->isharp_nldelta_sclip.slope_p = 0;	/* ISHARP_NLDELTA_SCLIP_SLOPE_P */
+		dscl_prog_data->isharp_nldelta_sclip.enable_n = 1;	/* ISHARP_NLDELTA_SCLIP_EN_N */
+		dscl_prog_data->isharp_nldelta_sclip.pivot_n = 71;	/* ISHARP_NLDELTA_SCLIP_PIVOT_N */
+		dscl_prog_data->isharp_nldelta_sclip.slope_n = 16;	/* ISHARP_NLDELTA_SCLIP_SLOPE_N */
+	} else {
+		dscl_prog_data->isharp_nldelta_sclip.enable_p = 1;	/* ISHARP_NLDELTA_SCLIP_EN_P */
+		dscl_prog_data->isharp_nldelta_sclip.pivot_p = 70;	/* ISHARP_NLDELTA_SCLIP_PIVOT_P */
+		dscl_prog_data->isharp_nldelta_sclip.slope_p = 24;	/* ISHARP_NLDELTA_SCLIP_SLOPE_P */
+		dscl_prog_data->isharp_nldelta_sclip.enable_n = 1;	/* ISHARP_NLDELTA_SCLIP_EN_N */
+		dscl_prog_data->isharp_nldelta_sclip.pivot_n = 70;	/* ISHARP_NLDELTA_SCLIP_PIVOT_N */
+		dscl_prog_data->isharp_nldelta_sclip.slope_n = 24;	/* ISHARP_NLDELTA_SCLIP_SLOPE_N */
+	}
 
 	// Set the values as per lookup table
+	spl_set_blur_scale_data(dscl_prog_data, data);
 }
 static bool spl_get_isharp_en(struct adaptive_sharpness adp_sharpness,
-		int vscale_ratio, int hscale_ratio, struct spl_taps taps)
+		int vscale_ratio, int hscale_ratio, struct spl_taps taps,
+		enum spl_pixel_format format)
 {
 	bool enable_isharp = false;
 
@@ -1307,6 +1349,10 @@ static bool spl_get_isharp_en(struct adaptive_sharpness adp_sharpness,
 	}
 	// Scaling is up to 1:1 (no scaling) or upscaling
 
+	/* Only apply sharpness to NV12 and not P010 */
+	if (format != SPL_PIXEL_FORMAT_420BPP8)
+		return enable_isharp;
+
 	// LB support horizontal taps 4,6 or vertical taps 3, 4, 6
 	if (taps.h_taps == 4 || taps.h_taps == 6 ||
 		taps.v_taps == 3 || taps.v_taps == 4 || taps.v_taps == 6) {
@@ -1342,13 +1388,14 @@ static bool spl_choose_lls_policy(enum spl_pixel_format format,
 	return false;
 }
 
-/* Caclulate scaler parameters */
+/* Calculate scaler parameters */
 bool spl_calculate_scaler_params(struct spl_in *spl_in, struct spl_out *spl_out)
 {
 	bool res = false;
 	bool enable_easf_v = false;
 	bool enable_easf_h = false;
 	bool lls_enable_easf = true;
+	const struct spl_scaler_data *data = &spl_out->scl_data;
 	// All SPL calls
 	/* recout calculation */
 	/* depends on h_active */
@@ -1400,10 +1447,12 @@ bool spl_calculate_scaler_params(struct spl_in *spl_in, struct spl_out *spl_out)
 	}
 	// Set EASF
 	spl_set_easf_data(spl_out->dscl_prog_data, enable_easf_v, enable_easf_h, spl_in->lls_pref,
-		spl_in->basic_in.format);	// Set iSHARP
+		spl_in->basic_in.format);
+	// Set iSHARP
 	bool enable_isharp = spl_get_isharp_en(spl_in->adaptive_sharpness, vratio, hratio,
-								spl_out->scl_data.taps);
-	if (enable_isharp)
-		spl_set_isharp_data(spl_out->dscl_prog_data, spl_in->adaptive_sharpness);
+		spl_out->scl_data.taps, spl_in->basic_in.format);
+	spl_set_isharp_data(spl_out->dscl_prog_data, spl_in->adaptive_sharpness, enable_isharp,
+		spl_in->lls_pref, spl_in->basic_in.format, data);
+
 	return res;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl_isharp_filters.c b/drivers/gpu/drm/amd/display/dc/spl/dc_spl_isharp_filters.c
index 26b48b3576a5..8bc838c7c3c5 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/dc_spl_isharp_filters.c
+++ b/drivers/gpu/drm/amd/display/dc/spl/dc_spl_isharp_filters.c
@@ -241,7 +241,7 @@ static const uint32_t filter_isharp_1D_lut_2p0x[32] = {
 // <CoefType>		LanczosEd
 // <CoefQuant>		S1.10
 //========================================================
-static const uint32_t filter_isharp_wide_6tap_64p[198] = {
+static const uint16_t filter_isharp_wide_6tap_64p[198] = {
 0x0000, 0x0000, 0x0400, 0x0000, 0x0000, 0x0000,
 0x0003, 0x0FF3, 0x0400, 0x000D, 0x0FFD, 0x0000,
 0x0006, 0x0FE7, 0x03FE, 0x001C, 0x0FF9, 0x0000,
@@ -285,7 +285,7 @@ static const uint32_t filter_isharp_wide_6tap_64p[198] = {
 // <CoefType>		Blur & Scale LPF
 // <CoefQuant>		S1.10
 //========================================================
-static const uint32_t filter_isharp_bs_4tap_64p[198] = {
+static const uint16_t filter_isharp_bs_4tap_64p[198] = {
 0x0000, 0x00E5, 0x0237, 0x00E4, 0x0000, 0x0000,
 0x0000, 0x00DE, 0x0237, 0x00EB, 0x0000, 0x0000,
 0x0000, 0x00D7, 0x0236, 0x00F2, 0x0001, 0x0000,
@@ -340,11 +340,11 @@ const uint32_t *spl_get_filter_isharp_1D_lut_2p0x(void)
 {
 	return filter_isharp_1D_lut_2p0x;
 }
-const uint32_t *spl_get_filter_isharp_wide_6tap_64p(void)
+const uint16_t *spl_get_filter_isharp_wide_6tap_64p(void)
 {
 	return filter_isharp_wide_6tap_64p;
 }
-const uint32_t *spl_get_filter_isharp_bs_4tap_64p(void)
+const uint16_t *spl_get_filter_isharp_bs_4tap_64p(void)
 {
 	return filter_isharp_bs_4tap_64p;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl_isharp_filters.h b/drivers/gpu/drm/amd/display/dc/spl/dc_spl_isharp_filters.h
index ff189d86e534..1aaf4c50c1bc 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/dc_spl_isharp_filters.h
+++ b/drivers/gpu/drm/amd/display/dc/spl/dc_spl_isharp_filters.h
@@ -12,6 +12,6 @@ const uint32_t *spl_get_filter_isharp_1D_lut_0p5x(void);
 const uint32_t *spl_get_filter_isharp_1D_lut_1p0x(void);
 const uint32_t *spl_get_filter_isharp_1D_lut_1p5x(void);
 const uint32_t *spl_get_filter_isharp_1D_lut_2p0x(void);
-const uint32_t *spl_get_filter_isharp_bs_4tap_64p(void);
-const uint32_t *spl_get_filter_isharp_wide_6tap_64p(void);
+const uint16_t *spl_get_filter_isharp_bs_4tap_64p(void);
+const uint16_t *spl_get_filter_isharp_wide_6tap_64p(void);
 #endif /* __DC_SPL_ISHARP_FILTERS_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h b/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h
index 0c9edee0582e..a8f7fccfa16b 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h
+++ b/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h
@@ -393,6 +393,9 @@ struct dscl_prog_data {
 	struct isharp_fmt isharp_fmt;   //      ISHARP_FMT
 	const uint32_t *isharp_delta;
 	struct isharp_nldelta_sclip isharp_nldelta_sclip;       //      ISHARP_NLDELTA_SCLIP
+	/* blur and scale filter */
+	const uint16_t *filter_blur_scale_v;
+	const uint16_t *filter_blur_scale_h;
 };
 
 /* SPL input and output definitions */
-- 
2.39.2

