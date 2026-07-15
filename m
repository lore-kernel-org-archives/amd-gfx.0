Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E134C44501
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:49:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0F9410F0B3;
	Wed, 15 Jul 2026 13:49:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BaWSCxPT";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010060.outbound.protection.outlook.com [52.101.56.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47A3B10F0B3
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:49:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=onRTYIZsEXp7TEsmqgNOW08aM64J6ejrRbpMylV0hieKbhPcLNdf9fc+mXbqOW7lV2WW6y8sd3QVZQGUvn/Ulz5QA03mJs+cBCJYBwLRO70jx9XNJ9nIlanw1CViRxvJS+Ewp4HW8OEWCClB5LSj1GL/dK6HKnMFkVQLyMJ+B/taO3iDGfRGhLxhLKd8+gfSRO9fAAEcrWeFLBWy85/VPBRh90PX6G/0HfoSLJqLmBd2mOaMIy9k5+Pskl1r9GWVQTzLoSBhW9w5AGnrs1s8VXS7MIWsfVxr7CNjyQ8b/Jd1XzIbgbVoy8d30Hqdnj8LTcg83Z7eGSsymlVi54Wrlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NW4/cYRCMVcZ0SySQBvVzWYuyo194cORmNbaQVTCGDU=;
 b=iIIeWD+9kkebcLflaYEMt92zeaw06sgZfkvdQUNhTsXN3rP1hLe0NANovc9t5ylYHeLxr/k+Np+X51gOQEWdGz9OwS9OBTQDxt+JFlLWWg4ihU5QtVVEP+2Vw8ZdxMFgAI+rem4TvXm0GWveyxTuUKdGnImMT/vF70VhyxXhCc1tXlVPfITd/QuEl+nfk4JoricPYubxDLxv9QUrY9618vAJO0Q3feykMUcAynvp/FJiGy6k3VDGHvrKKk+z7AT3v71na8uVQGDAsb2x8rr668PxncaQFaWMNrKfBwxcT8fSWyu0JFlBbeXB0Pl6C9hZMJOaDE/2fpt4yVersEm9Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NW4/cYRCMVcZ0SySQBvVzWYuyo194cORmNbaQVTCGDU=;
 b=BaWSCxPTn747943rglkS2RAypy1mFB759N/8g0qPVDbfwZPEkcxZrHGD0ADeb8iHLpfB8EgMbPIyZhGaUMap5eF7USrt2p3l7O9u4XAiy7BPDKq8YArNM4/xWplFu6VM+QFnLccaWousI7uNeD14DsEg/4hXTo9D2RABy3fWPLI=
Received: from MN2PR01CA0038.prod.exchangelabs.com (2603:10b6:208:23f::7) by
 SJ1PR12MB6194.namprd12.prod.outlook.com (2603:10b6:a03:458::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Wed, 15 Jul
 2026 13:49:22 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:23f:cafe::86) by MN2PR01CA0038.outlook.office365.com
 (2603:10b6:208:23f::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.11 via Frontend Transport; Wed,
 15 Jul 2026 13:49:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:49:21 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:49:21 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:49:12 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Wayne Lin <Wayne.Lin@amd.com>
Subject: [PATCH 69/70] drm/amd/display: Add SPL UPSP upsampling and YUV422
 scaling support
Date: Wed, 15 Jul 2026 21:38:19 +0800
Message-ID: <20260715134432.1975118-70-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|SJ1PR12MB6194:EE_
X-MS-Office365-Filtering-Correlation-Id: f6e58a00-640a-4f36-3868-08dee277dfe5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|6133799003|22082099003|18002099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: 9AwMbfYGRx+xt4LJKRM5330cEew+3AxfLfhnPOxei2vc7feCx3YAbukPDdpO8LB5dROMbnVdjSgwfFBeFz2Sd879lOa+RXcvHwbjLc5ywiQbYDU01jqh/TnEfg7KgdCO868u0pZ52BWs32s4HnE2y6GuqxbPqG4LgRdpLVmcvGYzNJTx3faavHTVtr5YfSEvcaw/GQMLxnhdLqfrlDvZiS53RifMuzPgx1S7yeSHLosvBnHyHiOs1M35Ha7Vm4ooZJqEyJE799sDnIMCm0KpbIq9m9hi5wac6FsmjoXIXwGqTOjbllfvm/ZMZcFd7bQ1a7/kMtSjHFjlXy2C62sX4kALiQAcI593973zafvfaJL7mHs7Z2vTM5kIlb0UQM8Pt1oSkRdnFimXsJK4abd7WU+3EWmMCSDvuLb//9rFkI0ghqEud/RIUABXeRHoRKy7xK7Nn6VafHhtUsJ3vWvnbLcJOqMQBEBr/DUPW7x9baZDzj1T3fGvj+yrVHcMP7kJ9KAJtN0VhR1Cfn4bSlr7coqKvqS6bL+Pqi8RP4ERnqllw9S3lhreQhBOr6W3A1CtRIlRKn1FM1KOfutvS61jykhdtwTAy7jQ+CCBFSSqHVkMZDZiXHx9SecM5ZyOkB9RkOAfbuE9uz1swVWZYd/QSrPEFu5/YGKafSjVB66hSwEPJCwhLI7BZN+U7E1QbQkSI1waDiadok5Szlr/yiVSlQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(6133799003)(22082099003)(18002099003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eKoOaQF1xk4zH7769ZJZnRVcslE/YjGtpOs1oU7mV5cm9sIaMz5noE7ZTVeThW+3NAKewdlmqd2jF+UnV13SXJQ2/hqHL1ksTYAWjqpzrNGiNTBbs85B2YrATL4rL2Z8cICebIlLA5BPg6pkuIyocKqnuXPLO1922nfH1vRtOUr4nom5gPF4IwkjHe7JVsEEbZtHTZzzR1eh2jOR7TfkJL9IY96IaVGGkK/DWGgzywfB6LCB87eMbH57F4Wk9kW5et8U1GT0HOFAvSq5MYjllrDoxCVLGRSj0iuRIqOipTr08b5N1yT/pMHg94gAtklf2lL0SgjDAS7ilYn+XFc/2BIFj+T3wKe7f5o9p8yPXiEvWSzfbtNGtVOljW3mU7aXDiTKk3v3wGNIDRAa7yjnHF6pbxoiK1PMimaz4/9G6I3ilgSPwDLOdJPOES+TWNwI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:49:21.8068 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6e58a00-640a-4f36-3868-08dee277dfe5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6194
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

- Add YUV422/YUV444 pixel format definitions
- Handle YUV422 chroma scaling ratios
- Use separate horizontal and vertical viewport divisors
- Add UPSP upsampling register programming
- Refine tap selection for horizontally and vertically subsampled formats

Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c  | 202 ++++++++++++++++--
 .../drm/amd/display/dc/sspl/dc_spl_types.h    |  58 ++++-
 2 files changed, 234 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
index d8aebaff7c3f..1f1318769d5b 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
+++ b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
@@ -9,7 +9,6 @@
 
 #define IDENTITY_RATIO(ratio) (SPL_NAMESPACE(spl_fixpt_u3d19(ratio)) == (1 << 19))
 #define MIN_VIEWPORT_SIZE 12
-
 static bool spl_is_yuv420(enum spl_pixel_format format)
 {
 	if ((format >= SPL_PIXEL_FORMAT_420BPP8) &&
@@ -19,6 +18,15 @@ static bool spl_is_yuv420(enum spl_pixel_format format)
 	return false;
 }
 
+static bool spl_is_yuv422(enum spl_pixel_format format)
+{
+	if ((format >= SPL_PIXEL_FORMAT_422BPP8) &&
+		(format <= SPL_PIXEL_FORMAT_422BPP12))
+		return true;
+
+	return false;
+}
+
 static bool spl_is_rgb8(enum spl_pixel_format format)
 {
 	if (format == SPL_PIXEL_FORMAT_ARGB8888)
@@ -468,6 +476,12 @@ static void spl_calculate_scaling_ratios(struct spl_in *spl_in,
 	if (spl_is_yuv420(spl_in->basic_in.format)) {
 		spl_scratch->scl_data.ratios.horz_c.value /= 2;
 		spl_scratch->scl_data.ratios.vert_c.value /= 2;
+	} else if (spl_is_yuv422(spl_in->basic_in.format)) {
+		if (spl_in->basic_in.rotation == SPL_ROTATION_ANGLE_90 ||
+			spl_in->basic_in.rotation == SPL_ROTATION_ANGLE_270)
+			spl_scratch->scl_data.ratios.vert_c.value /= 2;
+		else
+			spl_scratch->scl_data.ratios.horz_c.value /= 2;
 	}
 	spl_scratch->scl_data.ratios.horz = spl_fixpt_truncate(
 			spl_scratch->scl_data.ratios.horz, 19);
@@ -612,7 +626,8 @@ static void spl_calculate_inits_and_viewports(struct spl_in *spl_in,
 	struct spl_rect recout_clip_in_recout_dst;
 	struct spl_rect overlap_in_active_timing;
 	struct spl_rect odm_slice = calculate_odm_slice_in_timing_active(spl_in);
-	int vpc_div = spl_is_subsampled_format(spl_in->basic_in.format) ? 2 : 1;
+	int vp_hc_div = spl_is_subsampled_format(spl_in->basic_in.format) ? 2 : 1;
+	int vp_vc_div = spl_is_yuv420(spl_in->basic_in.format) ? 2 : 1;
 	bool orthogonal_rotation, flip_vert_scan_dir, flip_horz_scan_dir;
 	struct spl_fixed31_32 init_adj_h = spl_fixpt_zero;
 	struct spl_fixed31_32 init_adj_v = spl_fixpt_zero;
@@ -667,6 +682,7 @@ static void spl_calculate_inits_and_viewports(struct spl_in *spl_in,
 	if (orthogonal_rotation) {
 		spl_swap(src.width, src.height);
 		spl_swap(flip_vert_scan_dir, flip_horz_scan_dir);
+		spl_swap(vp_hc_div, vp_vc_div);
 		spl_swap(init_adj_h, init_adj_v);
 	}
 
@@ -685,7 +701,7 @@ static void spl_calculate_inits_and_viewports(struct spl_in *spl_in,
 			flip_horz_scan_dir,
 			recout_clip_in_recout_dst.x,
 			spl_scratch->scl_data.recout.width,
-			src.width / vpc_div,
+			src.width / vp_hc_div,
 			spl_scratch->scl_data.taps.h_taps_c,
 			spl_scratch->scl_data.ratios.horz_c,
 			init_adj_h,
@@ -707,7 +723,7 @@ static void spl_calculate_inits_and_viewports(struct spl_in *spl_in,
 			flip_vert_scan_dir,
 			recout_clip_in_recout_dst.y,
 			spl_scratch->scl_data.recout.height,
-			src.height / vpc_div,
+			src.height / vp_vc_div,
 			spl_scratch->scl_data.taps.v_taps_c,
 			spl_scratch->scl_data.ratios.vert_c,
 			init_adj_v,
@@ -719,12 +735,13 @@ static void spl_calculate_inits_and_viewports(struct spl_in *spl_in,
 		spl_swap(spl_scratch->scl_data.viewport.width, spl_scratch->scl_data.viewport.height);
 		spl_swap(spl_scratch->scl_data.viewport_c.x, spl_scratch->scl_data.viewport_c.y);
 		spl_swap(spl_scratch->scl_data.viewport_c.width, spl_scratch->scl_data.viewport_c.height);
+		spl_swap(vp_hc_div, vp_vc_div);
 	}
 	spl_scratch->scl_data.viewport.x += src.x;
 	spl_scratch->scl_data.viewport.y += src.y;
-	SPL_ASSERT(src.x % vpc_div == 0 && src.y % vpc_div == 0);
-	spl_scratch->scl_data.viewport_c.x += src.x / vpc_div;
-	spl_scratch->scl_data.viewport_c.y += src.y / vpc_div;
+	SPL_ASSERT(src.x % vp_hc_div == 0 && src.y % vp_vc_div == 0);
+	spl_scratch->scl_data.viewport_c.x += src.x / vp_hc_div;
+	spl_scratch->scl_data.viewport_c.y += src.y / vp_vc_div;
 }
 
 static void spl_handle_3d_recout(struct spl_in *spl_in, struct spl_rect *recout)
@@ -760,6 +777,7 @@ static enum scl_mode spl_get_dscl_mode(const struct spl_in *spl_in,
 				const struct spl_scaler_data *data,
 				bool enable_isharp, bool enable_easf)
 {
+	(void)enable_easf;
 	const long long one = spl_fixpt_one.value;
 	enum spl_pixel_format pixel_format = spl_in->basic_in.format;
 
@@ -894,7 +912,8 @@ static bool spl_get_isharp_en(struct spl_in *spl_in,
 static void spl_get_taps_non_adaptive_scaler(
 		struct spl_scratch *spl_scratch,
 		const struct spl_taps *in_taps,
-		bool is_subsampled)
+		bool is_horz_subsampled,
+		bool is_vert_subsampled)
 {
 	bool check_max_downscale = false;
 
@@ -959,11 +978,10 @@ static void spl_get_taps_non_adaptive_scaler(
 		spl_scratch->scl_data.taps.h_taps = 1;
 	if (IDENTITY_RATIO(spl_scratch->scl_data.ratios.vert))
 		spl_scratch->scl_data.taps.v_taps = 1;
-	if (IDENTITY_RATIO(spl_scratch->scl_data.ratios.horz_c) && !is_subsampled)
+	if (IDENTITY_RATIO(spl_scratch->scl_data.ratios.horz_c) && !is_horz_subsampled)
 		spl_scratch->scl_data.taps.h_taps_c = 1;
-	if (IDENTITY_RATIO(spl_scratch->scl_data.ratios.vert_c) && !is_subsampled)
+	if (IDENTITY_RATIO(spl_scratch->scl_data.ratios.vert_c) && !is_vert_subsampled)
 		spl_scratch->scl_data.taps.v_taps_c = 1;
-
 }
 
 /* Calculate optimal number of taps */
@@ -977,12 +995,13 @@ static bool spl_get_optimal_number_of_taps(
 	unsigned int min_taps_y, min_taps_c;
 	enum lb_memory_config lb_config;
 	bool skip_easf          = false;
-	bool is_subsampled = spl_is_subsampled_format(spl_in->basic_in.format);
+	bool is_horz_subsampled = spl_is_subsampled_format(spl_in->basic_in.format);
+	bool is_vert_subsampled = spl_is_yuv420(spl_in->basic_in.format);
 
 	if (spl_scratch->scl_data.viewport.width > spl_scratch->scl_data.h_active &&
 		max_downscale_src_width != 0 &&
 		spl_scratch->scl_data.viewport.width > max_downscale_src_width) {
-		spl_get_taps_non_adaptive_scaler(spl_scratch, in_taps, is_subsampled);
+		spl_get_taps_non_adaptive_scaler(spl_scratch, in_taps, is_horz_subsampled, is_vert_subsampled);
 		*enable_easf_v = false;
 		*enable_easf_h = false;
 		*enable_isharp = false;
@@ -991,7 +1010,7 @@ static bool spl_get_optimal_number_of_taps(
 
 	/* Disable adaptive scaler and sharpener when integer scaling is enabled */
 	if (spl_in->scaling_quality.integer_scaling) {
-		spl_get_taps_non_adaptive_scaler(spl_scratch, in_taps, is_subsampled);
+		spl_get_taps_non_adaptive_scaler(spl_scratch, in_taps, is_horz_subsampled, is_vert_subsampled);
 		*enable_easf_v = false;
 		*enable_easf_h = false;
 		*enable_isharp = false;
@@ -1007,15 +1026,15 @@ static bool spl_get_optimal_number_of_taps(
 	 * taps = 4 for upscaling
 	 */
 	if (skip_easf) {
-		spl_get_taps_non_adaptive_scaler(spl_scratch, in_taps, is_subsampled);
+		spl_get_taps_non_adaptive_scaler(spl_scratch, in_taps, is_horz_subsampled, is_vert_subsampled);
 	}
 	else {
-		if (spl_is_video_format(spl_in->basic_in.format)) {
+		if (spl_is_subsampled_format(spl_in->basic_in.format)) {
 			spl_scratch->scl_data.taps.h_taps = 6;
 			spl_scratch->scl_data.taps.v_taps = 6;
 			spl_scratch->scl_data.taps.h_taps_c = 4;
 			spl_scratch->scl_data.taps.v_taps_c = 4;
-		} else { /* RGB */
+		} else { /* RGB / YUV444 */
 			spl_scratch->scl_data.taps.h_taps = 6;
 			spl_scratch->scl_data.taps.v_taps = 6;
 			spl_scratch->scl_data.taps.h_taps_c = 6;
@@ -1149,10 +1168,10 @@ static bool spl_get_optimal_number_of_taps(
 			(IDENTITY_RATIO(spl_scratch->scl_data.ratios.vert))) {
 			spl_scratch->scl_data.taps.h_taps = 1;
 			spl_scratch->scl_data.taps.v_taps = 1;
-			if (IDENTITY_RATIO(spl_scratch->scl_data.ratios.horz_c) && !is_subsampled)
+			if (IDENTITY_RATIO(spl_scratch->scl_data.ratios.horz_c) && !is_horz_subsampled)
 				spl_scratch->scl_data.taps.h_taps_c = 1;
 
-			if (IDENTITY_RATIO(spl_scratch->scl_data.ratios.vert_c) && !is_subsampled)
+			if (IDENTITY_RATIO(spl_scratch->scl_data.ratios.vert_c) && !is_vert_subsampled)
 				spl_scratch->scl_data.taps.v_taps_c = 1;
 
 			*enable_easf_v = false;
@@ -1166,11 +1185,11 @@ static bool spl_get_optimal_number_of_taps(
 				(IDENTITY_RATIO(spl_scratch->scl_data.ratios.vert)))
 				spl_scratch->scl_data.taps.v_taps = 1;
 
-			if ((!*enable_easf_h) && !is_subsampled &&
+			if ((!*enable_easf_h) && !is_horz_subsampled &&
 				(IDENTITY_RATIO(spl_scratch->scl_data.ratios.horz_c)))
 				spl_scratch->scl_data.taps.h_taps_c = 1;
 
-			if ((!*enable_easf_v) && !is_subsampled &&
+			if ((!*enable_easf_v) && !is_vert_subsampled &&
 				(IDENTITY_RATIO(spl_scratch->scl_data.ratios.vert_c)))
 				spl_scratch->scl_data.taps.v_taps_c = 1;
 
@@ -1693,6 +1712,7 @@ static void spl_set_isharp_data(struct dscl_prog_data *dscl_prog_data,
 		const struct spl_scaler_data *data, struct spl_fixed31_32 ratio,
 		enum system_setup setup, enum scale_to_sharpness_policy scale_to_sharpness_policy)
 {
+	(void)format;
 	/* Turn off sharpener if not required */
 	if (!enable_isharp) {
 		dscl_prog_data->isharp_en = 0;
@@ -1823,6 +1843,144 @@ static void spl_set_isharp_data(struct dscl_prog_data *dscl_prog_data,
 	SPL_NAMESPACE(spl_set_blur_scale_data(dscl_prog_data, data));
 }
 
+static void determine_upsp_values(struct spl_in *spl_in, struct dscl_prog_data *dscl_prog_data)
+{
+	dscl_prog_data->upsp_mode = spl_in->upsp_mode;
+
+	if (dscl_prog_data->upsp_mode == UPSP_BYPASS) { //Set all UPSP register fields to 0 if bypass
+		dscl_prog_data->upsp_v_num_taps = UPSP_2_TAPS;
+		dscl_prog_data->upsp_h_num_taps = UPSP_2_TAPS;
+		dscl_prog_data->upsp_boundary_mode = UPSP_BOUNDARY_EDGE;
+		dscl_prog_data->upsp_v_init_int = 0x0;
+		dscl_prog_data->upsp_v_init_frac = 0x0;
+		dscl_prog_data->upsp_v_coef_tap0_p0 = 0x0;
+		dscl_prog_data->upsp_v_coef_tap1_p0 = 0x0;
+		dscl_prog_data->upsp_v_coef_tap2_p0 = 0x0;
+		dscl_prog_data->upsp_v_coef_tap3_p0 = 0x0;
+		dscl_prog_data->upsp_v_coef_tap0_p1 = 0x0;
+		dscl_prog_data->upsp_v_coef_tap1_p1 = 0x0;
+		dscl_prog_data->upsp_v_coef_tap2_p1 = 0x0;
+		dscl_prog_data->upsp_v_coef_tap3_p1 = 0x0;
+		dscl_prog_data->upsp_h_init_int = 0x0;
+		dscl_prog_data->upsp_h_init_frac = 0x0;
+		dscl_prog_data->upsp_h_coef_tap0_p0 = 0x0;
+		dscl_prog_data->upsp_h_coef_tap1_p0 = 0x0;
+		dscl_prog_data->upsp_h_coef_tap2_p0 = 0x0;
+		dscl_prog_data->upsp_h_coef_tap3_p0 = 0x0;
+		dscl_prog_data->upsp_h_coef_tap0_p1 = 0x0;
+		dscl_prog_data->upsp_h_coef_tap1_p1 = 0x0;
+		dscl_prog_data->upsp_h_coef_tap2_p1 = 0x0;
+		dscl_prog_data->upsp_h_coef_tap3_p1 = 0x0;
+		dscl_prog_data->upsp_clamp_max = 0x0;
+		dscl_prog_data->upsp_clamp_min = 0x0;
+	} else {
+		dscl_prog_data->upsp_v_num_taps = UPSP_4_TAPS;
+		dscl_prog_data->upsp_h_num_taps = UPSP_4_TAPS;
+		dscl_prog_data->upsp_boundary_mode = UPSP_BOUNDARY_EDGE;
+		dscl_prog_data->upsp_clamp_max = 0xFFF;//4095
+		dscl_prog_data->upsp_clamp_min = 0x0;
+
+		if (spl_in->basic_in.cositing == CHROMA_COSITING_TOPLEFT) { //Vertical Subsampling: Co-sited
+			if (dscl_prog_data->upsp_v_num_taps == UPSP_4_TAPS) {
+				dscl_prog_data->upsp_v_init_int = 0x3;
+				dscl_prog_data->upsp_v_init_frac = 0x0;
+				dscl_prog_data->upsp_v_coef_tap0_p0 = 0x00;
+				dscl_prog_data->upsp_v_coef_tap1_p0 = 0x40;
+				dscl_prog_data->upsp_v_coef_tap2_p0 = 0x00;
+				dscl_prog_data->upsp_v_coef_tap3_p0 = 0x00;
+				dscl_prog_data->upsp_v_coef_tap0_p1 = 0xFC;
+				dscl_prog_data->upsp_v_coef_tap1_p1 = 0x24;
+				dscl_prog_data->upsp_v_coef_tap2_p1 = 0x24;
+				dscl_prog_data->upsp_v_coef_tap3_p1 = 0xFC;
+			} else { //2 taps
+				dscl_prog_data->upsp_v_init_int = 0x2;
+				dscl_prog_data->upsp_v_init_frac = 0x0;
+				dscl_prog_data->upsp_v_coef_tap0_p0 = 0x40;
+				dscl_prog_data->upsp_v_coef_tap1_p0 = 0x00;
+				dscl_prog_data->upsp_v_coef_tap2_p0 = 0x00;
+				dscl_prog_data->upsp_v_coef_tap3_p0 = 0x00;
+				dscl_prog_data->upsp_v_coef_tap0_p1 = 0x20;
+				dscl_prog_data->upsp_v_coef_tap1_p1 = 0x20;
+				dscl_prog_data->upsp_v_coef_tap2_p1 = 0x00;
+				dscl_prog_data->upsp_v_coef_tap3_p1 = 0x00;
+			}
+		} else { //Vertical Subsampling: Interstitial
+			if (dscl_prog_data->upsp_v_num_taps == UPSP_4_TAPS) {
+				dscl_prog_data->upsp_v_init_int = 0x2;
+				dscl_prog_data->upsp_v_init_frac = 0x1;
+				dscl_prog_data->upsp_v_coef_tap0_p0 = 0xFB;
+				dscl_prog_data->upsp_v_coef_tap1_p0 = 0x2F;
+				dscl_prog_data->upsp_v_coef_tap2_p0 = 0x19;
+				dscl_prog_data->upsp_v_coef_tap3_p0 = 0xFD;
+				dscl_prog_data->upsp_v_coef_tap0_p1 = 0xFD;
+				dscl_prog_data->upsp_v_coef_tap1_p1 = 0x19;
+				dscl_prog_data->upsp_v_coef_tap2_p1 = 0x2F;
+				dscl_prog_data->upsp_v_coef_tap3_p1 = 0xFB;
+			} else { //2 taps
+				dscl_prog_data->upsp_v_init_int = 0x1;
+				dscl_prog_data->upsp_v_init_frac = 0x1;
+				dscl_prog_data->upsp_v_coef_tap0_p0 = 0x28;
+				dscl_prog_data->upsp_v_coef_tap1_p0 = 0x18;
+				dscl_prog_data->upsp_v_coef_tap2_p0 = 0x00;
+				dscl_prog_data->upsp_v_coef_tap3_p0 = 0x00;
+				dscl_prog_data->upsp_v_coef_tap0_p1 = 0x18;
+				dscl_prog_data->upsp_v_coef_tap1_p1 = 0x28;
+				dscl_prog_data->upsp_v_coef_tap2_p1 = 0x00;
+				dscl_prog_data->upsp_v_coef_tap3_p1 = 0x00;
+			}
+		}
+		if (spl_in->basic_in.cositing == CHROMA_COSITING_LEFT || spl_in->basic_in.cositing == CHROMA_COSITING_TOPLEFT) { //Horizontal Subsampling: Co-sited
+			if (dscl_prog_data->upsp_h_num_taps == UPSP_4_TAPS) {
+				dscl_prog_data->upsp_h_init_int = 0x3;
+				dscl_prog_data->upsp_h_init_frac = 0x0;
+				dscl_prog_data->upsp_h_coef_tap0_p0 = 0x00;
+				dscl_prog_data->upsp_h_coef_tap1_p0 = 0x40;
+				dscl_prog_data->upsp_h_coef_tap2_p0 = 0x00;
+				dscl_prog_data->upsp_h_coef_tap3_p0 = 0x00;
+				dscl_prog_data->upsp_h_coef_tap0_p1 = 0xFC;
+				dscl_prog_data->upsp_h_coef_tap1_p1 = 0x24;
+				dscl_prog_data->upsp_h_coef_tap2_p1 = 0x24;
+				dscl_prog_data->upsp_h_coef_tap3_p1 = 0xFC;
+			} else { //2 taps
+				dscl_prog_data->upsp_h_init_int = 0x2;
+				dscl_prog_data->upsp_h_init_frac = 0x0;
+				dscl_prog_data->upsp_h_coef_tap0_p0 = 0x40;
+				dscl_prog_data->upsp_h_coef_tap1_p0 = 0x00;
+				dscl_prog_data->upsp_h_coef_tap2_p0 = 0x00;
+				dscl_prog_data->upsp_h_coef_tap3_p0 = 0x00;
+				dscl_prog_data->upsp_h_coef_tap0_p1 = 0x20;
+				dscl_prog_data->upsp_h_coef_tap1_p1 = 0x20;
+				dscl_prog_data->upsp_h_coef_tap2_p1 = 0x00;
+				dscl_prog_data->upsp_h_coef_tap3_p1 = 0x00;
+			}
+		} else { //Horizontal Subsampling: Interstitial
+			if (dscl_prog_data->upsp_h_num_taps == UPSP_4_TAPS) {
+				dscl_prog_data->upsp_h_init_int = 0x2;
+				dscl_prog_data->upsp_h_init_frac = 0x1;
+				dscl_prog_data->upsp_h_coef_tap0_p0 = 0xFB;
+				dscl_prog_data->upsp_h_coef_tap1_p0 = 0x2F;
+				dscl_prog_data->upsp_h_coef_tap2_p0 = 0x19;
+				dscl_prog_data->upsp_h_coef_tap3_p0 = 0xFD;
+				dscl_prog_data->upsp_h_coef_tap0_p1 = 0xFD;
+				dscl_prog_data->upsp_h_coef_tap1_p1 = 0x19;
+				dscl_prog_data->upsp_h_coef_tap2_p1 = 0x2F;
+				dscl_prog_data->upsp_h_coef_tap3_p1 = 0xFB;
+			} else { //2 taps
+				dscl_prog_data->upsp_h_init_int = 0x1;
+				dscl_prog_data->upsp_h_init_frac = 0x1;
+				dscl_prog_data->upsp_h_coef_tap0_p0 = 0x28;
+				dscl_prog_data->upsp_h_coef_tap1_p0 = 0x18;
+				dscl_prog_data->upsp_h_coef_tap2_p0 = 0x00;
+				dscl_prog_data->upsp_h_coef_tap3_p0 = 0x00;
+				dscl_prog_data->upsp_h_coef_tap0_p1 = 0x18;
+				dscl_prog_data->upsp_h_coef_tap1_p1 = 0x28;
+				dscl_prog_data->upsp_h_coef_tap2_p1 = 0x00;
+				dscl_prog_data->upsp_h_coef_tap3_p1 = 0x00;
+			}
+		}
+	}
+}
+
 /* Calculate recout, scaling ratio, and viewport, then get optimal number of taps */
 static bool spl_calculate_number_of_taps(struct spl_in *spl_in, struct spl_scratch *spl_scratch, struct spl_out *spl_out,
 	bool *enable_easf_v, bool *enable_easf_h, bool *enable_isharp)
@@ -1865,6 +2023,8 @@ bool SPL_NAMESPACE(spl_calculate_scaler_params(struct spl_in *spl_in, struct spl
 	bool enable_isharp = false;
 	const struct spl_scaler_data *data = &spl_scratch.scl_data;
 
+	determine_upsp_values(spl_in, spl_out->dscl_prog_data);
+
 	res = spl_calculate_number_of_taps(spl_in, &spl_scratch, spl_out,
 		&enable_easf_v, &enable_easf_h, &enable_isharp);
 
diff --git a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_types.h b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_types.h
index 20e4e52a77ac..b24f1ef3fe17 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_types.h
+++ b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_types.h
@@ -62,17 +62,21 @@ enum spl_pixel_format {
 	/*video*/
 	SPL_PIXEL_FORMAT_420BPP8,
 	SPL_PIXEL_FORMAT_420BPP10,
+	SPL_PIXEL_FORMAT_422BPP8,
+	SPL_PIXEL_FORMAT_422BPP10,
+	SPL_PIXEL_FORMAT_422BPP12,
+	SPL_PIXEL_FORMAT_444BPP8,
+	SPL_PIXEL_FORMAT_444BPP10,
 	/*end of pixel format definition*/
 	SPL_PIXEL_FORMAT_GRPH_BEGIN = SPL_PIXEL_FORMAT_INDEX8,
 	SPL_PIXEL_FORMAT_GRPH_END = SPL_PIXEL_FORMAT_FP16,
 	SPL_PIXEL_FORMAT_SUBSAMPLED_BEGIN = SPL_PIXEL_FORMAT_420BPP8,
-	SPL_PIXEL_FORMAT_SUBSAMPLED_END = SPL_PIXEL_FORMAT_420BPP10,
+	SPL_PIXEL_FORMAT_SUBSAMPLED_END = SPL_PIXEL_FORMAT_422BPP12,
 	SPL_PIXEL_FORMAT_VIDEO_BEGIN = SPL_PIXEL_FORMAT_420BPP8,
-	SPL_PIXEL_FORMAT_VIDEO_END = SPL_PIXEL_FORMAT_420BPP10,
+	SPL_PIXEL_FORMAT_VIDEO_END = SPL_PIXEL_FORMAT_444BPP10,
 	SPL_PIXEL_FORMAT_INVALID,
 	SPL_PIXEL_FORMAT_UNKNOWN
 };
-
 enum lb_memory_config {
 	/* Enable all 3 pieces of memory */
 	LB_MEMORY_CONFIG_0 = 0,
@@ -88,7 +92,6 @@ enum lb_memory_config {
 	 */
 	LB_MEMORY_CONFIG_3 = 3
 };
-
 /* Rotation angle */
 enum spl_rotation_angle {
 	SPL_ROTATION_ANGLE_0 = 0,
@@ -128,6 +131,23 @@ enum chroma_cositing {
 	CHROMA_COSITING_COUNT
 };
 
+enum upsp_mode {
+	UPSP_BYPASS = 0,
+	UPSP_HORIZONTAL_UPSAMPLING_ONLY,
+	UPSP_VERTICAL_UPSAMPLING_ONLY,
+	UPSP_HORIZONTAL_VERTICAL_UPSAMPLING
+};
+
+enum upsp_num_taps {
+	UPSP_2_TAPS,
+	UPSP_4_TAPS
+};
+
+enum upsp_boundary_mode {
+	UPSP_BOUNDARY_EDGE, //Replace out of bound samples with the edge samples
+	UPSP_BOUNDARY_BLACK //Replace out of bound samples with black as 12bpc(0x800)
+};
+
 // Scratch space for calculating scaler params
 struct spl_scaler_data {
 	int h_active;
@@ -253,7 +273,7 @@ enum isharp_en	{
 #define ISHARP_LUT_TABLE_SIZE 32
 // Below struct holds values that can be directly used to program
 // hardware registers. No conversion/clamping is required
-struct dscl_prog_data {
+struct dscl_prog_data	{
 	struct spl_rect recout; // RECOUT - set based on scl_data.recout
 	struct mpc_size mpc_size;
 	uint32_t dscl_mode;
@@ -395,6 +415,33 @@ struct dscl_prog_data {
 	uint32_t easf_matrix_c1;
 	uint32_t easf_matrix_c2;
 	uint32_t easf_matrix_c3;
+	// UPSP registers
+	uint32_t upsp_mode;//UPSP_MODE
+	uint32_t upsp_v_num_taps;
+	uint32_t upsp_v_init_int;
+	uint32_t upsp_v_init_frac;
+	uint32_t upsp_h_num_taps;
+	uint32_t upsp_h_init_int;
+	uint32_t upsp_h_init_frac;
+	uint32_t upsp_boundary_mode;
+	uint32_t upsp_v_coef_tap0_p0;//UPSP_V_COEF_P0
+	uint32_t upsp_v_coef_tap1_p0;
+	uint32_t upsp_v_coef_tap2_p0;
+	uint32_t upsp_v_coef_tap3_p0;
+	uint32_t upsp_v_coef_tap0_p1;//UPSP_V_COEF_P1
+	uint32_t upsp_v_coef_tap1_p1;
+	uint32_t upsp_v_coef_tap2_p1;
+	uint32_t upsp_v_coef_tap3_p1;
+	uint32_t upsp_h_coef_tap0_p0;//UPSP_H_COEF_P0
+	uint32_t upsp_h_coef_tap1_p0;
+	uint32_t upsp_h_coef_tap2_p0;
+	uint32_t upsp_h_coef_tap3_p0;
+	uint32_t upsp_h_coef_tap0_p1;//UPSP_H_COEF_P1
+	uint32_t upsp_h_coef_tap1_p1;
+	uint32_t upsp_h_coef_tap2_p1;
+	uint32_t upsp_h_coef_tap3_p1;
+	uint32_t upsp_clamp_max;//UPSP_CLAMP
+	uint32_t upsp_clamp_min;
 	// iSharp
 	uint32_t isharp_en;     //      ISHARP_EN
 	struct isharp_noise_det isharp_noise_det;       //      ISHARP_NOISEDET
@@ -554,6 +601,7 @@ struct spl_in	{
 	int min_viewport_size;
 	int sdr_white_level_nits;
 	enum sharpen_policy sharpen_policy;
+	enum upsp_mode upsp_mode;
 };
 // end of SPL inputs
 
-- 
2.43.0

