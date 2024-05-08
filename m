Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CC45C19F4F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 May 2024 17:17:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A601E113120;
	Wed,  8 May 2024 17:17:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MxH0YUTK";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7763C113120
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 May 2024 17:17:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BcNpulLP9BOHt7c9+YYbxBXyrcMvfqqSk0GeBdqB1q/lGiS+xSjITD+4aiXJtR+oPAUdJiIv8tY1Q2+bct3DFZXGg7sZyAdY16x0OtI6oyfPHR9Tioh7SsiPaxPN6P/V9rsAh+9PbzjJv084gYS91cOYwHqgQ8NbUuO8aD0VM1/JZ1bI7XxtRY7CKm+Nx2Fk3uab76gubm0dpK4sPInwFbSimvGG1WV8Pa5gj3nJmUfeF5JpUTCkulRA/BylRIAi0wbhpYNlNfE8mOw75tWZ+xWjGlOLdDdrJ1yXbehFX1L6PeCTDU68qN8ZNXrUQMdmZfWqqMeeeZNLyg22jo8wKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oeCUswfHTKmvF/ywUZzeXEba8KmRpYtT7qOmJwvTdHc=;
 b=cK+a0dCZsFkzJPmLsW3EHs5oLIDQyeHbBS2rPpFnrwexe1cJwyxNsxpLH517tK2NdW52PBDyLBBwlP2idec71N76h18R71BoWFWM0t76IVZ33SkFGWVQzoIT5nKznZZaM4VsNNa7TdS/W3VIb1Ncmyzj/RoWonmpwfadAPT1xmbEEbdkruzJF2jUyH+twf4smaJjRPw+FEJ4wGWVYJpPR43LQnDWppXPac+Shu1NNDT/aDvb/CnpC/HShhsyfKN9eP8Mt48gKi/Ne+hx4+EO0hy4CCDTl8iEuqN222lS4x7pp7VCQqwb29sKv/AgNjTaRpsUYo4DNgPmqte8HweeeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oeCUswfHTKmvF/ywUZzeXEba8KmRpYtT7qOmJwvTdHc=;
 b=MxH0YUTKkaFQ8yqcMdOujnREd3qf5OnU+hFJDpFDf81MaSHgIMt5+5nGarbr25BflEnD7i2ZBoZZ6sQm5373xIOaCLBcwCC6gi1DPl32IM90ct+/lMVAK3E2doScH2/ThQmqKyacAMgmRlmIqlInAMJ6CwR+pODNkPgO5jwNueI=
Received: from BN9PR03CA0526.namprd03.prod.outlook.com (2603:10b6:408:131::21)
 by LV3PR12MB9165.namprd12.prod.outlook.com (2603:10b6:408:19f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.39; Wed, 8 May
 2024 17:17:14 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:408:131:cafe::38) by BN9PR03CA0526.outlook.office365.com
 (2603:10b6:408:131::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43 via Frontend
 Transport; Wed, 8 May 2024 17:17:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 8 May 2024 17:17:14 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 8 May
 2024 12:17:11 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>, George Shen <george.shen@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 10/20] drm/amd/display: Add left edge pixel for YCbCr422/420 +
 ODM pipe split
Date: Wed, 8 May 2024 11:13:10 -0600
Message-ID: <20240508171320.3292065-11-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508171320.3292065-1-alex.hung@amd.com>
References: <20240508171320.3292065-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|LV3PR12MB9165:EE_
X-MS-Office365-Filtering-Correlation-Id: af927d2d-9fb9-473a-5cf9-08dc6f82b4ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?E48ri9ocQUsxvxPaYoZTgacoId4ZTQw1ahwfKA2bLPf+HeYNMng3B/CCoQC7?=
 =?us-ascii?Q?cTuiFo9zi1P4XqV3Nit3z5BOvvdYFzTrBgDaHhlSRa9yzeFo5VQ66l5Hrh69?=
 =?us-ascii?Q?oysLxy3xYneVms6qCOlDeKkLBWfBrllwutqDZsQwp7HGfQBxyfrw3N0Z+Zvw?=
 =?us-ascii?Q?MsSgHE9z24JZlNsgYYHqouAX/rtMOTWMRWAqyFy6g0SAfaITlh2Zt8E6QzOR?=
 =?us-ascii?Q?Qt5lpgA1nKY1iZFjAvVwsJPjUrG5pOYpBtm6rkQSfGa3lt2KWERZVxj3AMqI?=
 =?us-ascii?Q?+fKWOM6Zdp+pGKddyTbI9FGlatvAJMAWpOxJvJkUP+tIQ+T030E1hbb3toT9?=
 =?us-ascii?Q?Yeejd3N29eMa62ckSuTFTgTbRysPe5rKrAy7JqtP0Yu/hScHetHvoXChEmOH?=
 =?us-ascii?Q?+gF8XlsCNfU/7tWkWPJTIV57TsW2PmYd2B4D5W0Je1BQhvqVf3/uPkRmaQY3?=
 =?us-ascii?Q?gktJReS44Km3q2vAoCiVHlEx63Ke8ccNNHRnLTkqyiiO+1DkJxRwrGSi4NLO?=
 =?us-ascii?Q?/MWX2uug1C0ZMfDR/9NaFUW7JOQwiGZYwu0MvGaqC+1woXKhvwHbT1a1Q0WP?=
 =?us-ascii?Q?7qs+mTd+n7h/gM2Uh34b6MVBL2WrsWwX6WAxlQkp3WT1vk2pyJCleilsO8OW?=
 =?us-ascii?Q?TYSjj7Y3JSuPIlvcnFVZrQvzLYljxZxaLeuyvhl8HoAE4RjtISm9XSNmZCth?=
 =?us-ascii?Q?Fleb1oBYECbxVFnxgHB1qHhBWjCkozWh7+RP9Obu7W8Y2nHEnXOSDM9bzm7s?=
 =?us-ascii?Q?EMGjRNu2louH5RIxg+m8tbQqOazcX9LxKnPuphnwZIw/RJzL6sTkVkG4i0JM?=
 =?us-ascii?Q?EG5DfRFU1DcqVggI2Hk4OU01T43ythQ6o4e2Xjp9Dj8xHc03cFbWo9L393h6?=
 =?us-ascii?Q?zMvUeS4kAyrQ7V32qygvor2n1W80RF2UUV2wrROs6n6pyQbmonTy+UHKwvNk?=
 =?us-ascii?Q?kyTJHI7MddWuHXjktueiEnOC2Dwig+bTvKVJu4d2CmbX/Gram1D3+tpRxHD2?=
 =?us-ascii?Q?TQV+niASGb4C4N9bKFVsxxipbkeY8F+OQm49qckpDRJXxsKhKdSG/AxVNIXe?=
 =?us-ascii?Q?0O25X1WPv2P+zDe34JQFHlDobADrJl5bcWL3ufDPpt8z/L2P+mSpavzHhO9+?=
 =?us-ascii?Q?SZJKB5rU4wP8lgimcNLzH+zSEBJ9m5gM0jRszis0Ehxkhjss19xXfjxe/owk?=
 =?us-ascii?Q?asJq18reDDWqsI5cvjXWh9sqO+HfyPftHBQpBSffA9D1MzAiDUsL+QfySiO2?=
 =?us-ascii?Q?fKqLnm5KHy+tvcmuKz8uI51ks6rO4aUOwsanjiWT16hGtBN3H7sDxbJ5QhYm?=
 =?us-ascii?Q?5/V3SV6Sg5c0qQ4smtORWXA0MohtuSADHl7EJYHYdsSeO9bZJG5wEqwwIEST?=
 =?us-ascii?Q?JuhR2EoN2lOe2A8lxStXkyE+9Yl7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 17:17:14.6925 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af927d2d-9fb9-473a-5cf9-08dc6f82b4ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9165
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

[WHY]
Currently 3-tap chroma subsampling is used for YCbCr422/420. When ODM
pipesplit is used, pixels on the left edge of ODM slices need one extra
pixel from the right edge of the previous slice to calculate the correct
chroma value.

Without this change, the chroma value is slightly different than
expected. This is usually imperceptible visually, but it impacts test
pattern CRCs for compliance test automation.

[HOW]
Update logic to use the register for adding extra left edge pixel for
YCbCr422/420 ODM cases.

Reviewed-by: George Shen <george.shen@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  9 ++-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_opp.c  | 25 +++++--
 .../gpu/drm/amd/display/dc/dcn20/dcn20_opp.h  |  4 +-
 .../drm/amd/display/dc/dcn201/dcn201_opp.c    |  1 +
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   | 67 +++++++++----------
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c |  4 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  8 ++-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  4 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 48 ++++++++-----
 drivers/gpu/drm/amd/display/dc/inc/hw/opp.h   |  7 +-
 .../amd/display/dc/inc/hw/timing_generator.h  |  2 +-
 .../amd/display/dc/optc/dcn20/dcn20_optc.c    |  6 +-
 .../amd/display/dc/optc/dcn20/dcn20_optc.h    |  2 +-
 .../amd/display/dc/optc/dcn30/dcn30_optc.c    |  6 +-
 .../amd/display/dc/optc/dcn30/dcn30_optc.h    |  2 +-
 .../amd/display/dc/optc/dcn31/dcn31_optc.c    |  8 +--
 .../amd/display/dc/optc/dcn314/dcn314_optc.c  |  7 +-
 .../amd/display/dc/optc/dcn32/dcn32_optc.c    |  7 +-
 .../amd/display/dc/optc/dcn35/dcn35_optc.c    |  7 +-
 .../amd/display/dc/optc/dcn401/dcn401_optc.c  | 22 ++----
 20 files changed, 140 insertions(+), 106 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index fd03d7129ffa..fd624b1fee25 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2110,12 +2110,19 @@ struct rect resource_get_odm_slice_src_rect(struct pipe_ctx *pipe_ctx)
 	struct rect odm_slice_dst;
 	struct rect odm_slice_src;
 	struct pipe_ctx *opp_head = resource_get_opp_head(pipe_ctx);
+	struct output_pixel_processor *opp = opp_head->stream_res.opp;
 	uint32_t left_edge_extra_pixel_count;
 
 	odm_slice_dst = resource_get_odm_slice_dst_rect(opp_head);
 	odm_slice_src = odm_slice_dst;
 
-	left_edge_extra_pixel_count = 0;
+	if (opp->funcs->opp_get_left_edge_extra_pixel_count)
+		left_edge_extra_pixel_count =
+				opp->funcs->opp_get_left_edge_extra_pixel_count(
+						opp, pipe_ctx->stream->timing.pixel_encoding,
+						resource_is_pipe_type(opp_head, OTG_MASTER));
+	else
+		left_edge_extra_pixel_count = 0;
 
 	odm_slice_src.x -= left_edge_extra_pixel_count;
 	odm_slice_src.width += left_edge_extra_pixel_count;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_opp.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_opp.c
index fbf1b6370eb2..f5fe0cac7cb0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_opp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_opp.c
@@ -23,6 +23,7 @@
  *
  */
 
+#include "core_types.h"
 #include "dm_services.h"
 #include "dcn20_opp.h"
 #include "reg_helper.h"
@@ -350,19 +351,32 @@ bool opp2_dpg_is_pending(struct output_pixel_processor *opp)
 	return (dpg_en == 1 && double_buffer_pending == 1);
 }
 
-void opp2_program_left_edge_extra_pixel (
+void opp2_program_left_edge_extra_pixel(
 		struct output_pixel_processor *opp,
-		bool count)
+		enum dc_pixel_encoding pixel_encoding,
+		bool is_primary)
 {
 	struct dcn20_opp *oppn20 = TO_DCN20_OPP(opp);
+	uint32_t count = opp2_get_left_edge_extra_pixel_count(opp, pixel_encoding, is_primary);
 
-	/* Specifies the number of extra left edge pixels that are supplied to
+	/*
+	 * Specifies the number of extra left edge pixels that are supplied to
 	 * the 422 horizontal chroma sub-sample filter.
-	 * Note that when left edge pixel is not "0", fmt pixel encoding can be in either 420 or 422 mode
-	 * */
+	 */
 	REG_UPDATE(FMT_422_CONTROL, FMT_LEFT_EDGE_EXTRA_PIXEL_COUNT, count);
 }
 
+uint32_t opp2_get_left_edge_extra_pixel_count(struct output_pixel_processor *opp,
+		enum dc_pixel_encoding pixel_encoding, bool is_primary)
+{
+	if ((pixel_encoding == PIXEL_ENCODING_YCBCR422 || pixel_encoding == PIXEL_ENCODING_YCBCR420) &&
+			!opp->ctx->dc->debug.force_chroma_subsampling_1tap &&
+			!is_primary)
+		return 1;
+	else
+		return 0;
+}
+
 /*****************************************/
 /* Constructor, Destructor               */
 /*****************************************/
@@ -380,6 +394,7 @@ static struct opp_funcs dcn20_opp_funcs = {
 		.opp_dpg_set_blank_color = opp2_dpg_set_blank_color,
 		.opp_destroy = opp1_destroy,
 		.opp_program_left_edge_extra_pixel = opp2_program_left_edge_extra_pixel,
+		.opp_get_left_edge_extra_pixel_count = opp2_get_left_edge_extra_pixel_count,
 };
 
 void dcn20_opp_construct(struct dcn20_opp *oppn20,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_opp.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_opp.h
index 8f186abd558d..34936e6c49f3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_opp.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_opp.h
@@ -167,6 +167,8 @@ void opp2_dpg_set_blank_color(
 
 void opp2_program_left_edge_extra_pixel (
 		struct output_pixel_processor *opp,
-		bool count);
+		enum dc_pixel_encoding pixel_encoding, bool is_primary);
 
+uint32_t opp2_get_left_edge_extra_pixel_count(struct output_pixel_processor *opp,
+		enum dc_pixel_encoding pixel_encoding, bool is_primary);
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_opp.c b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_opp.c
index 6a71ba3dfc63..e83367a9b6b3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_opp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_opp.c
@@ -54,6 +54,7 @@ static struct opp_funcs dcn201_opp_funcs = {
 		.opp_dpg_set_blank_color = opp2_dpg_set_blank_color,
 		.opp_destroy = opp1_destroy,
 		.opp_program_left_edge_extra_pixel = opp2_program_left_edge_extra_pixel,
+		.opp_get_left_edge_extra_pixel_count = opp2_get_left_edge_extra_pixel_count,
 };
 
 void dcn201_opp_construct(struct dcn201_opp *oppn201,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 5623a48cf3fd..d085c9ff9d38 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -820,9 +820,8 @@ enum dc_status dcn20_enable_stream_timing(
 	struct dc_stream_state *stream = pipe_ctx->stream;
 	struct drr_params params = {0};
 	unsigned int event_triggers = 0;
-	struct pipe_ctx *odm_pipe;
 	int opp_cnt = 1;
-	int opp_inst[MAX_PIPES] = { pipe_ctx->stream_res.opp->inst };
+	int opp_inst[MAX_PIPES] = {0};
 	bool interlace = stream->timing.flags.INTERLACE;
 	int i;
 	struct mpc_dwb_flow_control flow_control;
@@ -832,6 +831,9 @@ enum dc_status dcn20_enable_stream_timing(
 	bool rate_control_2x_pclk = (interlace || is_two_pixels_per_container);
 	unsigned int k1_div = PIXEL_RATE_DIV_NA;
 	unsigned int k2_div = PIXEL_RATE_DIV_NA;
+	int odm_slice_width;
+	int last_odm_slice_width;
+	struct pipe_ctx *opp_heads[MAX_PIPES];
 
 	if (hws->funcs.calculate_dccg_k1_k2_values && dc->res_pool->dccg->funcs->set_pixel_rate_div) {
 		hws->funcs.calculate_dccg_k1_k2_values(pipe_ctx, &k1_div, &k2_div);
@@ -850,16 +852,17 @@ enum dc_status dcn20_enable_stream_timing(
 
 	/* TODO check if timing_changed, disable stream if timing changed */
 
-	for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
-		opp_inst[opp_cnt] = odm_pipe->stream_res.opp->inst;
-		opp_cnt++;
-	}
+	opp_cnt = resource_get_opp_heads_for_otg_master(pipe_ctx, &context->res_ctx, opp_heads);
+	for (i = 0; i < opp_cnt; i++)
+		opp_inst[opp_cnt] = opp_heads[i]->stream_res.opp->inst;
 
+	odm_slice_width = resource_get_odm_slice_dst_width(pipe_ctx, false);
+	last_odm_slice_width = resource_get_odm_slice_dst_width(pipe_ctx, true);
 	if (opp_cnt > 1)
 		pipe_ctx->stream_res.tg->funcs->set_odm_combine(
 				pipe_ctx->stream_res.tg,
-				opp_inst, opp_cnt,
-				&pipe_ctx->stream->timing);
+				opp_inst, opp_cnt, odm_slice_width,
+				last_odm_slice_width);
 
 	/* HW program guide assume display already disable
 	 * by unplug sequence. OTG assume stop.
@@ -927,14 +930,15 @@ enum dc_status dcn20_enable_stream_timing(
 		}
 	}
 
-	for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe)
-		odm_pipe->stream_res.opp->funcs->opp_pipe_clock_control(
-				odm_pipe->stream_res.opp,
+	for (i = 0; i < opp_cnt; i++) {
+		opp_heads[i]->stream_res.opp->funcs->opp_pipe_clock_control(
+				opp_heads[i]->stream_res.opp,
 				true);
-
-	pipe_ctx->stream_res.opp->funcs->opp_pipe_clock_control(
-			pipe_ctx->stream_res.opp,
-			true);
+		opp_heads[i]->stream_res.opp->funcs->opp_program_left_edge_extra_pixel(
+				opp_heads[i]->stream_res.opp,
+				stream->timing.pixel_encoding,
+				resource_is_pipe_type(opp_heads[i], OTG_MASTER));
+	}
 
 	hws->funcs.blank_pixel_data(dc, pipe_ctx, true);
 
@@ -1175,6 +1179,8 @@ void dcn20_update_odm(struct dc *dc, struct dc_state *context, struct pipe_ctx *
 	struct pipe_ctx *odm_pipe;
 	int opp_cnt = 1;
 	int opp_inst[MAX_PIPES] = { pipe_ctx->stream_res.opp->inst };
+	int odm_slice_width = resource_get_odm_slice_dst_width(pipe_ctx, false);
+	int last_odm_slice_width = resource_get_odm_slice_dst_width(pipe_ctx, true);
 
 	for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
 		opp_inst[opp_cnt] = odm_pipe->stream_res.opp->inst;
@@ -1185,7 +1191,7 @@ void dcn20_update_odm(struct dc *dc, struct dc_state *context, struct pipe_ctx *
 		pipe_ctx->stream_res.tg->funcs->set_odm_combine(
 				pipe_ctx->stream_res.tg,
 				opp_inst, opp_cnt,
-				&pipe_ctx->stream->timing);
+				odm_slice_width, last_odm_slice_width);
 	else
 		pipe_ctx->stream_res.tg->funcs->set_odm_bypass(
 				pipe_ctx->stream_res.tg, &pipe_ctx->stream->timing);
@@ -1203,12 +1209,7 @@ void dcn20_blank_pixel_data(
 	enum controller_dp_test_pattern test_pattern = CONTROLLER_DP_TEST_PATTERN_SOLID_COLOR;
 	enum controller_dp_color_space test_pattern_color_space = CONTROLLER_DP_COLOR_SPACE_UDEFINED;
 	struct pipe_ctx *odm_pipe;
-	int odm_cnt = 1;
-	int h_active = stream->timing.h_addressable + stream->timing.h_border_left + stream->timing.h_border_right;
-	int v_active = stream->timing.v_addressable + stream->timing.v_border_bottom + stream->timing.v_border_top;
-	int odm_slice_width, last_odm_slice_width, offset = 0;
-	bool is_two_pixels_per_container =
-			pipe_ctx->stream_res.tg->funcs->is_two_pixels_per_container(&stream->timing);
+	struct rect odm_slice_src;
 
 	if (stream->link->test_pattern_enabled)
 		return;
@@ -1216,13 +1217,6 @@ void dcn20_blank_pixel_data(
 	/* get opp dpg blank color */
 	color_space_to_black_color(dc, color_space, &black_color);
 
-	for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe)
-		odm_cnt++;
-	odm_slice_width = h_active / odm_cnt;
-	if ((odm_slice_width % 2) && is_two_pixels_per_container)
-		odm_slice_width++;
-	last_odm_slice_width = h_active - odm_slice_width * (odm_cnt - 1);
-
 	if (blank) {
 		dc->hwss.set_abm_immediate_disable(pipe_ctx);
 
@@ -1237,28 +1231,29 @@ void dcn20_blank_pixel_data(
 	odm_pipe = pipe_ctx;
 
 	while (odm_pipe->next_odm_pipe) {
+		odm_slice_src = resource_get_odm_slice_src_rect(odm_pipe);
 		dc->hwss.set_disp_pattern_generator(dc,
 				odm_pipe,
 				test_pattern,
 				test_pattern_color_space,
 				stream->timing.display_color_depth,
 				&black_color,
-				odm_slice_width,
-				v_active,
-				offset);
-		offset += odm_slice_width;
+				odm_slice_src.width,
+				odm_slice_src.height,
+				odm_slice_src.x);
 		odm_pipe = odm_pipe->next_odm_pipe;
 	}
 
+	odm_slice_src = resource_get_odm_slice_src_rect(odm_pipe);
 	dc->hwss.set_disp_pattern_generator(dc,
 			odm_pipe,
 			test_pattern,
 			test_pattern_color_space,
 			stream->timing.display_color_depth,
 			&black_color,
-			last_odm_slice_width,
-			v_active,
-			offset);
+			odm_slice_src.width,
+			odm_slice_src.height,
+			odm_slice_src.x);
 
 	if (!blank)
 		if (stream_res->abm) {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
index 0b12a69e2df0..1d853241ca32 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
@@ -160,6 +160,8 @@ void dcn314_update_odm(struct dc *dc, struct dc_state *context, struct pipe_ctx
 	struct pipe_ctx *odm_pipe;
 	int opp_cnt = 0;
 	int opp_inst[MAX_PIPES] = {0};
+	int odm_slice_width = resource_get_odm_slice_dst_width(pipe_ctx, false);
+	int last_odm_slice_width = resource_get_odm_slice_dst_width(pipe_ctx, true);
 
 	opp_cnt = get_odm_config(pipe_ctx, opp_inst);
 
@@ -167,7 +169,7 @@ void dcn314_update_odm(struct dc *dc, struct dc_state *context, struct pipe_ctx
 		pipe_ctx->stream_res.tg->funcs->set_odm_combine(
 				pipe_ctx->stream_res.tg,
 				opp_inst, opp_cnt,
-				&pipe_ctx->stream->timing);
+				odm_slice_width, last_odm_slice_width);
 	else
 		pipe_ctx->stream_res.tg->funcs->set_odm_bypass(
 				pipe_ctx->stream_res.tg, &pipe_ctx->stream->timing);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index df0fceb11ae1..7aaef3709baa 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -1078,6 +1078,8 @@ void dcn32_update_odm(struct dc *dc, struct dc_state *context, struct pipe_ctx *
 	struct pipe_ctx *odm_pipe;
 	int opp_cnt = 0;
 	int opp_inst[MAX_PIPES] = {0};
+	int odm_slice_width = resource_get_odm_slice_dst_width(pipe_ctx, false);
+	int last_odm_slice_width = resource_get_odm_slice_dst_width(pipe_ctx, true);
 
 	opp_cnt = get_odm_config(pipe_ctx, opp_inst);
 
@@ -1085,7 +1087,7 @@ void dcn32_update_odm(struct dc *dc, struct dc_state *context, struct pipe_ctx *
 		pipe_ctx->stream_res.tg->funcs->set_odm_combine(
 				pipe_ctx->stream_res.tg,
 				opp_inst, opp_cnt,
-				&pipe_ctx->stream->timing);
+				odm_slice_width, last_odm_slice_width);
 	else
 		pipe_ctx->stream_res.tg->funcs->set_odm_bypass(
 				pipe_ctx->stream_res.tg, &pipe_ctx->stream->timing);
@@ -1094,6 +1096,10 @@ void dcn32_update_odm(struct dc *dc, struct dc_state *context, struct pipe_ctx *
 		odm_pipe->stream_res.opp->funcs->opp_pipe_clock_control(
 				odm_pipe->stream_res.opp,
 				true);
+		odm_pipe->stream_res.opp->funcs->opp_program_left_edge_extra_pixel(
+				odm_pipe->stream_res.opp,
+				pipe_ctx->stream->timing.pixel_encoding,
+				resource_is_pipe_type(odm_pipe, OTG_MASTER));
 	}
 
 	if (pipe_ctx->stream_res.dsc) {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index bddcd23a2727..6d40e93b5497 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -451,6 +451,8 @@ void dcn35_update_odm(struct dc *dc, struct dc_state *context, struct pipe_ctx *
 	struct pipe_ctx *odm_pipe;
 	int opp_cnt = 0;
 	int opp_inst[MAX_PIPES] = {0};
+	int odm_slice_width = resource_get_odm_slice_dst_width(pipe_ctx, false);
+	int last_odm_slice_width = resource_get_odm_slice_dst_width(pipe_ctx, true);
 
 	opp_cnt = get_odm_config(pipe_ctx, opp_inst);
 
@@ -458,7 +460,7 @@ void dcn35_update_odm(struct dc *dc, struct dc_state *context, struct pipe_ctx *
 		pipe_ctx->stream_res.tg->funcs->set_odm_combine(
 				pipe_ctx->stream_res.tg,
 				opp_inst, opp_cnt,
-				&pipe_ctx->stream->timing);
+				odm_slice_width, last_odm_slice_width);
 	else
 		pipe_ctx->stream_res.tg->funcs->set_odm_bypass(
 				pipe_ctx->stream_res.tg, &pipe_ctx->stream->timing);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 5b87186598e6..c01cf2a2f786 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -744,20 +744,20 @@ static void enable_stream_timing_calc(
 		unsigned int *tmds_div,
 		int *opp_inst,
 		int *opp_cnt,
+		struct pipe_ctx *opp_heads[MAX_PIPES],
 		bool *manual_mode,
 		struct drr_params *params,
 		unsigned int *event_triggers)
 {
 	struct dc_stream_state *stream = pipe_ctx->stream;
-	struct pipe_ctx *odm_pipe;
+	int i;
 
 	if (dc_is_tmds_signal(stream->signal) || dc_is_virtual_signal(stream->signal))
 		dcn401_calculate_dccg_tmds_div_value(pipe_ctx, tmds_div);
 
-	for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
-		opp_inst[*opp_cnt] = odm_pipe->stream_res.opp->inst;
-		(*opp_cnt)++;
-	}
+	*opp_cnt = resource_get_opp_heads_for_otg_master(pipe_ctx, &context->res_ctx, opp_heads);
+	for (i = 0; i < *opp_cnt; i++)
+		opp_inst[i] = opp_heads[i]->stream_res.opp->inst;
 
 	if (dc_is_tmds_signal(stream->signal)) {
 		stream->link->phy_state.symclk_ref_cnts.otg = 1;
@@ -786,18 +786,21 @@ enum dc_status dcn401_enable_stream_timing(
 	struct dc_stream_state *stream = pipe_ctx->stream;
 	struct drr_params params = {0};
 	unsigned int event_triggers = 0;
-	struct pipe_ctx *odm_pipe;
 	int opp_cnt = 1;
-	int opp_inst[MAX_PIPES] = { pipe_ctx->stream_res.opp->inst };
+	int opp_inst[MAX_PIPES] = {0};
+	struct pipe_ctx *opp_heads[MAX_PIPES];
 	bool manual_mode;
 	unsigned int tmds_div = PIXEL_RATE_DIV_NA;
 	unsigned int unused_div = PIXEL_RATE_DIV_NA;
+	int odm_slice_width;
+	int last_odm_slice_width;
+	int i;
 
 	if (!resource_is_pipe_type(pipe_ctx, OTG_MASTER))
 		return DC_OK;
 
 	enable_stream_timing_calc(pipe_ctx, context, dc, &tmds_div, opp_inst,
-			&opp_cnt, &manual_mode, &params, &event_triggers);
+			&opp_cnt, opp_heads, &manual_mode, &params, &event_triggers);
 
 	if (dc->res_pool->dccg->funcs->set_pixel_rate_div) {
 		dc->res_pool->dccg->funcs->set_pixel_rate_div(
@@ -807,11 +810,14 @@ enum dc_status dcn401_enable_stream_timing(
 
 	/* TODO check if timing_changed, disable stream if timing changed */
 
-	if (opp_cnt > 1)
+	if (opp_cnt > 1) {
+		odm_slice_width = resource_get_odm_slice_dst_width(pipe_ctx, false);
+		last_odm_slice_width = resource_get_odm_slice_dst_width(pipe_ctx, true);
 		pipe_ctx->stream_res.tg->funcs->set_odm_combine(
 				pipe_ctx->stream_res.tg,
 				opp_inst, opp_cnt,
-				&pipe_ctx->stream->timing);
+				odm_slice_width, last_odm_slice_width);
+	}
 
 	/* HW program guide assume display already disable
 	 * by unplug sequence. OTG assume stop.
@@ -840,10 +846,15 @@ enum dc_status dcn401_enable_stream_timing(
 			pipe_ctx->stream->signal,
 			true);
 
-	for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe)
-		odm_pipe->stream_res.opp->funcs->opp_pipe_clock_control(
-				odm_pipe->stream_res.opp,
+	for (i = 0; i < opp_cnt; i++) {
+		opp_heads[i]->stream_res.opp->funcs->opp_pipe_clock_control(
+				opp_heads[i]->stream_res.opp,
 				true);
+		opp_heads[i]->stream_res.opp->funcs->opp_program_left_edge_extra_pixel(
+				opp_heads[i]->stream_res.opp,
+				stream->timing.pixel_encoding,
+				resource_is_pipe_type(opp_heads[i], OTG_MASTER));
+	}
 
 	pipe_ctx->stream_res.opp->funcs->opp_pipe_clock_control(
 			pipe_ctx->stream_res.opp,
@@ -1593,6 +1604,8 @@ void dcn401_update_odm(struct dc *dc, struct dc_state *context,
 	struct pipe_ctx *opp_heads[MAX_PIPES];
 	int opp_inst[MAX_PIPES] = {0};
 	int opp_head_count;
+	int odm_slice_width = resource_get_odm_slice_dst_width(otg_master, false);
+	int last_odm_slice_width = resource_get_odm_slice_dst_width(otg_master, true);
 	int i;
 
 	opp_head_count = resource_get_opp_heads_for_otg_master(
@@ -1604,16 +1617,21 @@ void dcn401_update_odm(struct dc *dc, struct dc_state *context,
 		otg_master->stream_res.tg->funcs->set_odm_combine(
 				otg_master->stream_res.tg,
 				opp_inst, opp_head_count,
-				&otg_master->stream->timing);
+				odm_slice_width, last_odm_slice_width);
 	else
 		otg_master->stream_res.tg->funcs->set_odm_bypass(
 				otg_master->stream_res.tg,
 				&otg_master->stream->timing);
 
-	for (i = 0; i < opp_head_count; i++)
+	for (i = 0; i < opp_head_count; i++) {
 		opp_heads[i]->stream_res.opp->funcs->opp_pipe_clock_control(
 				opp_heads[i]->stream_res.opp,
 				true);
+		opp_heads[i]->stream_res.opp->funcs->opp_program_left_edge_extra_pixel(
+				opp_heads[i]->stream_res.opp,
+				opp_heads[i]->stream->timing.pixel_encoding,
+				resource_is_pipe_type(opp_heads[i], OTG_MASTER));
+	}
 
 	update_dsc_for_odm_change(dc, context, otg_master);
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/opp.h b/drivers/gpu/drm/amd/display/dc/inc/hw/opp.h
index d89c92370d5b..127fb1a51654 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/opp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/opp.h
@@ -346,8 +346,13 @@ struct opp_funcs {
 
 	void (*opp_program_left_edge_extra_pixel)(
 			struct output_pixel_processor *opp,
-			bool count);
+			enum dc_pixel_encoding pixel_encoding,
+			bool is_primary);
 
+	uint32_t (*opp_get_left_edge_extra_pixel_count)(
+			struct output_pixel_processor *opp,
+			enum dc_pixel_encoding pixel_encoding,
+			bool is_primary);
 };
 
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
index a347425c1da2..cd4826f329c1 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
@@ -313,7 +313,7 @@ struct timing_generator_funcs {
 	 * OPP(s) and turn on/off ODM memory.
 	 */
 	void (*set_odm_combine)(struct timing_generator *optc, int *opp_id, int opp_cnt,
-			struct dc_crtc_timing *timing);
+			int segment_width, int last_segment_width);
 	void (*get_odm_combine_segments)(struct timing_generator *tg, int *odm_segments);
 	void (*set_h_timing_div_manual_mode)(struct timing_generator *optc, bool manual_mode);
 	void (*set_gsl)(struct timing_generator *optc, const struct gsl_params *params);
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.c
index 314a0cee08ae..43417cff2c9b 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.c
@@ -179,11 +179,9 @@ void optc2_set_odm_bypass(struct timing_generator *optc,
 }
 
 void optc2_set_odm_combine(struct timing_generator *optc, int *opp_id, int opp_cnt,
-		struct dc_crtc_timing *timing)
+		int segment_width, int last_segment_width)
 {
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
-	int mpcc_hactive = (timing->h_addressable + timing->h_border_left + timing->h_border_right)
-			/ opp_cnt;
 	uint32_t memory_mask;
 
 	ASSERT(opp_cnt == 2);
@@ -213,7 +211,7 @@ void optc2_set_odm_combine(struct timing_generator *optc, int *opp_id, int opp_c
 			OPTC_SEG1_SRC_SEL, opp_id[1]);
 
 	REG_UPDATE(OPTC_WIDTH_CONTROL,
-			OPTC_SEGMENT_WIDTH, mpcc_hactive);
+			OPTC_SEGMENT_WIDTH, segment_width);
 
 	REG_SET(OTG_H_TIMING_CNTL, 0, OTG_H_TIMING_DIV_BY2, 1);
 	optc1->opp_count = opp_cnt;
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.h
index 1f8bc7fce9fc..364034b19028 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.h
@@ -105,7 +105,7 @@ void optc2_set_odm_bypass(struct timing_generator *optc,
 		const struct dc_crtc_timing *dc_crtc_timing);
 
 void optc2_set_odm_combine(struct timing_generator *optc, int *opp_id, int opp_cnt,
-		struct dc_crtc_timing *timing);
+		int segment_width, int last_segment_width);
 
 void optc2_get_optc_source(struct timing_generator *optc,
 		uint32_t *num_of_src_opp,
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.c
index c805fd2a48a1..abcd03d78668 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.c
@@ -216,11 +216,9 @@ void optc3_set_odm_bypass(struct timing_generator *optc,
 }
 
 void optc3_set_odm_combine(struct timing_generator *optc, int *opp_id, int opp_cnt,
-		struct dc_crtc_timing *timing)
+		int segment_width, int last_segment_width)
 {
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
-	int mpcc_hactive = (timing->h_addressable + timing->h_border_left + timing->h_border_right)
-			/ opp_cnt;
 	uint32_t memory_mask = 0;
 
 	/* TODO: In pseudocode but does not affect maximus, delete comment if we dont need on asic
@@ -267,7 +265,7 @@ void optc3_set_odm_combine(struct timing_generator *optc, int *opp_id, int opp_c
 	}
 
 	REG_UPDATE(OPTC_WIDTH_CONTROL,
-			OPTC_SEGMENT_WIDTH, mpcc_hactive);
+			OPTC_SEGMENT_WIDTH, segment_width);
 
 	REG_SET(OTG_H_TIMING_CNTL, 0, OTG_H_TIMING_DIV_MODE, opp_cnt - 1);
 	optc1->opp_count = opp_cnt;
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.h
index d3a056c12b0d..bda974d432ea 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.h
@@ -352,7 +352,7 @@ void optc3_set_timing_db_mode(struct timing_generator *optc, bool enable);
 void optc3_set_odm_bypass(struct timing_generator *optc,
 		const struct dc_crtc_timing *dc_crtc_timing);
 void optc3_set_odm_combine(struct timing_generator *optc, int *opp_id, int opp_cnt,
-		struct dc_crtc_timing *timing);
+		int segment_width, int last_segment_width);
 void optc3_wait_drr_doublebuffer_pending_clear(struct timing_generator *optc);
 void optc3_tg_init(struct timing_generator *optc);
 void optc3_set_vtotal_min_max(struct timing_generator *optc, int vtotal_min, int vtotal_max);
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c
index 84d2ba31e2ca..de83761edce8 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c
@@ -41,13 +41,11 @@
 	optc1->tg_shift->field_name, optc1->tg_mask->field_name
 
 static void optc31_set_odm_combine(struct timing_generator *optc, int *opp_id, int opp_cnt,
-		struct dc_crtc_timing *timing)
+		int segment_width, int last_segment_width)
 {
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
-	int mpcc_hactive = (timing->h_addressable + timing->h_border_left + timing->h_border_right)
-			/ opp_cnt;
 	uint32_t memory_mask = 0;
-	int mem_count_per_opp = (mpcc_hactive + 2559) / 2560;
+	int mem_count_per_opp = (segment_width + 2559) / 2560;
 
 	/* Assume less than 6 pipes */
 	if (opp_cnt == 4) {
@@ -85,7 +83,7 @@ static void optc31_set_odm_combine(struct timing_generator *optc, int *opp_id, i
 	}
 
 	REG_UPDATE(OPTC_WIDTH_CONTROL,
-			OPTC_SEGMENT_WIDTH, mpcc_hactive);
+			OPTC_SEGMENT_WIDTH, segment_width);
 
 	REG_SET(OTG_H_TIMING_CNTL, 0, OTG_H_TIMING_DIV_MODE, opp_cnt - 1);
 	optc1->opp_count = opp_cnt;
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.c
index 9022fb2ffca4..633d62addd4d 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.c
@@ -48,12 +48,11 @@
  */
 
 static void optc314_set_odm_combine(struct timing_generator *optc, int *opp_id, int opp_cnt,
-		struct dc_crtc_timing *timing)
+		int segment_width, int last_segment_width)
 {
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
 	uint32_t memory_mask = 0;
-	int h_active = timing->h_addressable + timing->h_border_left + timing->h_border_right;
-	int mpcc_hactive = h_active / opp_cnt;
+	int h_active = segment_width * opp_cnt;
 	/* Each memory instance is 2048x(314x2) bits to support half line of 4096 */
 	int odm_mem_count = (h_active + 2047) / 2048;
 
@@ -96,7 +95,7 @@ static void optc314_set_odm_combine(struct timing_generator *optc, int *opp_id,
 	}
 
 	REG_UPDATE(OPTC_WIDTH_CONTROL,
-			OPTC_SEGMENT_WIDTH, mpcc_hactive);
+			OPTC_SEGMENT_WIDTH, segment_width);
 
 	REG_UPDATE(OTG_H_TIMING_CNTL,
 			OTG_H_TIMING_DIV_MODE, opp_cnt - 1);
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
index c18d580279a8..6c837409df42 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
@@ -43,12 +43,11 @@
 	optc1->tg_shift->field_name, optc1->tg_mask->field_name
 
 static void optc32_set_odm_combine(struct timing_generator *optc, int *opp_id, int opp_cnt,
-		struct dc_crtc_timing *timing)
+		int segment_width, int last_segment_width)
 {
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
 	uint32_t memory_mask = 0;
-	int h_active = timing->h_addressable + timing->h_border_left + timing->h_border_right;
-	int mpcc_hactive = h_active / opp_cnt;
+	int h_active = segment_width * opp_cnt;
 	/* Each memory instance is 2048x(32x2) bits to support half line of 4096 */
 	int odm_mem_count = (h_active + 2047) / 2048;
 
@@ -91,7 +90,7 @@ static void optc32_set_odm_combine(struct timing_generator *optc, int *opp_id, i
 	}
 
 	REG_UPDATE(OPTC_WIDTH_CONTROL,
-			OPTC_SEGMENT_WIDTH, mpcc_hactive);
+			OPTC_SEGMENT_WIDTH, segment_width);
 
 	REG_UPDATE(OTG_H_TIMING_CNTL,
 			OTG_H_TIMING_DIV_MODE, opp_cnt - 1);
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
index cf8da22492dc..7c9faa507ec2 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
@@ -55,12 +55,11 @@
  * Return: void.
  */
 static void optc35_set_odm_combine(struct timing_generator *optc, int *opp_id, int opp_cnt,
-		struct dc_crtc_timing *timing)
+		int segment_width, int last_segment_width)
 {
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
 	uint32_t memory_mask = 0;
-	int h_active = timing->h_addressable + timing->h_border_left + timing->h_border_right;
-	int mpcc_hactive = h_active / opp_cnt;
+	int h_active = segment_width * opp_cnt;
 	/* Each memory instance is 2048x(314x2) bits to support half line of 4096 */
 	int odm_mem_count = (h_active + 2047) / 2048;
 
@@ -103,7 +102,7 @@ static void optc35_set_odm_combine(struct timing_generator *optc, int *opp_id, i
 	}
 
 	REG_UPDATE(OPTC_WIDTH_CONTROL,
-			OPTC_SEGMENT_WIDTH, mpcc_hactive);
+			OPTC_SEGMENT_WIDTH, segment_width);
 
 	REG_UPDATE(OTG_H_TIMING_CNTL, OTG_H_TIMING_DIV_MODE, opp_cnt - 1);
 	optc1->opp_count = opp_cnt;
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
index 099658bcd77f..8ab788b6e6c1 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
@@ -102,22 +102,12 @@ static uint32_t decide_odm_mem_bit_map(int *opp_id, int opp_cnt, int h_active)
 }
 
 static void optc401_set_odm_combine(struct timing_generator *optc, int *opp_id,
-		int opp_cnt, struct dc_crtc_timing *timing)
+		int opp_cnt, int segment_width, int last_segment_width)
 {
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
-	uint32_t h_active = timing->h_addressable +
-			timing->h_border_left + timing->h_border_right;
+	uint32_t h_active = segment_width * (opp_cnt - 1) + last_segment_width;
 	uint32_t odm_mem_bit_map = decide_odm_mem_bit_map(
 			opp_id, opp_cnt, h_active);
-	uint32_t odm_segment_width;
-	uint32_t odm_segment_width_last;
-	bool is_two_pixels_per_container = optc->funcs->is_two_pixels_per_container(timing);
-
-	odm_segment_width = h_active / opp_cnt;
-	if ((odm_segment_width % 2) && is_two_pixels_per_container)
-		odm_segment_width++;
-	odm_segment_width_last =
-			h_active - odm_segment_width * (opp_cnt - 1);
 
 	REG_SET(OPTC_MEMORY_CONFIG, 0,
 		OPTC_MEM_SEL, odm_mem_bit_map);
@@ -129,7 +119,7 @@ static void optc401_set_odm_combine(struct timing_generator *optc, int *opp_id,
 				OPTC_SEG0_SRC_SEL, opp_id[0],
 				OPTC_SEG1_SRC_SEL, opp_id[1]);
 		REG_UPDATE(OPTC_WIDTH_CONTROL,
-					OPTC_SEGMENT_WIDTH, odm_segment_width);
+					OPTC_SEGMENT_WIDTH, segment_width);
 
 		REG_UPDATE(OTG_H_TIMING_CNTL,
 				OTG_H_TIMING_DIV_MODE, H_TIMING_DIV_BY2);
@@ -141,10 +131,10 @@ static void optc401_set_odm_combine(struct timing_generator *optc, int *opp_id,
 				OPTC_SEG1_SRC_SEL, opp_id[1],
 				OPTC_SEG2_SRC_SEL, opp_id[2]);
 		REG_UPDATE(OPTC_WIDTH_CONTROL,
-				OPTC_SEGMENT_WIDTH, odm_segment_width);
+				OPTC_SEGMENT_WIDTH, segment_width);
 		REG_UPDATE(OPTC_WIDTH_CONTROL2,
 				OPTC_SEGMENT_WIDTH_LAST,
-				odm_segment_width_last);
+				last_segment_width);
 		/* In ODM combine 3:1 mode ODM packs 4 pixels per data transfer
 		 * so OTG_H_TIMING_DIV_MODE should be configured to
 		 * H_TIMING_DIV_BY4 even though ODM combines 3 OPP inputs, it
@@ -161,7 +151,7 @@ static void optc401_set_odm_combine(struct timing_generator *optc, int *opp_id,
 				OPTC_SEG2_SRC_SEL, opp_id[2],
 				OPTC_SEG3_SRC_SEL, opp_id[3]);
 		REG_UPDATE(OPTC_WIDTH_CONTROL,
-					OPTC_SEGMENT_WIDTH, odm_segment_width);
+					OPTC_SEGMENT_WIDTH, segment_width);
 		REG_UPDATE(OTG_H_TIMING_CNTL,
 				OTG_H_TIMING_DIV_MODE, H_TIMING_DIV_BY4);
 		break;
-- 
2.34.1

