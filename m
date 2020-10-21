Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3172C56202
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:23:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 667D42224E
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="SZldMsLa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 667D42224E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60B0A6EDD1;
	Wed, 21 Oct 2020 14:23:30 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D63B36EDD1
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 14:23:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ld68PAJMvFbcJPPeAhDxQdz2vVCPP8lsE6qvpeHh1GBc6hmCLhAhNUYspQEqJrCLBvp04a9gIPFEeIdqpSo5TySMAHLEjvhAK01x3nJyOjGmHLqiHreK2k4pPJ1z8X2STpgA9+wrb1JiGXk9U4hBm38Pv0hZQG37tz8tbjGavQldklkYZA+iJi3oS/+4fmKyY+34QC7ndF+qkDvhZLWlXXM1+5/+WU3pZ+E4zln5i1NNBnB85vyXE22uqJwLiYKcmLjRdW6THwuY12eoKDH9TviZ5FTvEB653jlfCXETopxJ+fMn9r0rj7X3WLKvKr+aBqMODZaJDO+suHDWb9mWbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EvZduaNNx/3P7PkRdSsfJSnY/v4v3u23Y39J61f11iE=;
 b=VyA2rrpxU/FJadTIstaYZDWmx7qa5xlwPG07NdF9QvkQBYacfYfhVijoFsiTvAH/NTPzPv3FmORwKLLr2ds7k16Z2NMUiKceM1qpnXYzwP92lLK+GUA2iu+2Ahtl8gKOjp65wLrclEcTColT2c9FU6/GvD5AJP/C19HWkoT7zIxguu7t6YgUe+NkRWlMTZznIY9qdUAwNi50dcqTz8LWWU2j0YHT/glW7qAVg6RWma8O8WeJWZxDlgJyZhjbzcVTZH2IpKE2uXfulMZPUIXKqblu6wPBL9oBRT1hlOLkztdWQcDO8ELchvNJwl7haXOn4eu/Apx+BZMuvPIN9V2dTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EvZduaNNx/3P7PkRdSsfJSnY/v4v3u23Y39J61f11iE=;
 b=SZldMsLadji2AEj5lyzw/xQENDsFY68Ysi7Z0JNRpgvmovZvlC+wXWyqCTVukH97gnbhp47ganzhxjpMhUgIGDCjnZHjFuPhNDuSuxtsH1pr+psS9HtQOGU9jyjGR0Nzm4uPV7RJMgGBgpM2nzjOFNvo1PmIpoR9eUAzJKpQCys=
Received: from DM5PR16CA0030.namprd16.prod.outlook.com (2603:10b6:4:15::16) by
 MWHPR1201MB0272.namprd12.prod.outlook.com (2603:10b6:301:52::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Wed, 21 Oct
 2020 14:23:22 +0000
Received: from DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:15:cafe::6d) by DM5PR16CA0030.outlook.office365.com
 (2603:10b6:4:15::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Wed, 21 Oct 2020 14:23:22 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT047.mail.protection.outlook.com (10.13.172.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 14:23:22 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 09:23:21 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 21 Oct 2020 09:23:20 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 21/33] drm/amd/display: Fix max brightness pixel accuracy
Date: Wed, 21 Oct 2020 10:22:45 -0400
Message-ID: <20201021142257.190969-22-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201021142257.190969-1-aurabindo.pillai@amd.com>
References: <20201021142257.190969-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc2c8886-8267-41f4-c723-08d875ccdd75
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0272:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0272CFCF58782FAAE295C2CD8B1C0@MWHPR1201MB0272.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RTyMKJWJURyHDq9QEx6LfCMLm42vV5AHSYK4f7gKcPah50vfwAiQKUfwwWMZr3y7wK5yqjejOOUMzQEb9enFmSvIKT8wv14DJrIYdcdl2NT63ZVakHsbBe0kGj0YfM+1dyvVviJ9qCT9USqqKSUo9yUvJQBmRcgC5vp1CN1Qcck5zvkMR6NdymQtAqp44tgn2DeXK338q1fk7tuB+0GbmIRI56RJTnf8WlTGKFNc4N76R3qNkYj6ZlBZ5EORc3sOTBZMnpWM9qcxFrNK+3OIts5ra4TATXn0Y7qbVk74FoZxEreKQScHzWh2wuoFd/H4P/U8usdFET0rMYkuEzY2wnvDwSANp55IrU/GEbJ8MFz8IflJXrTUngYZj8XHeqtxnC6ggW1MGKArjFGQHFJiUQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(39860400002)(376002)(46966005)(316002)(8676002)(6666004)(44832011)(336012)(426003)(8936002)(26005)(81166007)(5660300002)(47076004)(6916009)(2616005)(82740400003)(82310400003)(86362001)(4326008)(54906003)(478600001)(83380400001)(7696005)(70206006)(2906002)(186003)(356005)(36756003)(1076003)(70586007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 14:23:22.1197 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc2c8886-8267-41f4-c723-08d875ccdd75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0272
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
Cc: Felipe Clark <Felipe.Clark@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Clark <felclark@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Clark <felclark@amd.com>

[WHY]
It was detected in some Freesync HDR tests that displays were not
reaching their maximum nominal brightness.

[HOW]
The Multi-plane combiner (MPC) Output Gamma (OGAM) block builds a
discrete Lookup Table (LUT). When the display's maximum brightness
falls in between two values, having to be linearly interpolated by
the hardware, rounding issues might occur that will cause the
display to never reach its maximum brightness.
The fix involves doing the calculations backwards, ensuring that
the interpolation in the maximum brightness values translates to an
output of 1.0.

Signed-off-by: Felipe Clark <Felipe.Clark@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../amd/display/modules/color/color_gamma.c   | 110 ++++++++++++++----
 1 file changed, 89 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
index b8695660b480..e866da639637 100644
--- a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
+++ b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
@@ -151,7 +151,7 @@ static void compute_de_pq(struct fixed31_32 in_x, struct fixed31_32 *out_y)
 	div = dc_fixpt_sub(c2, dc_fixpt_mul(c3, l_pow_m1));
 
 	base2 = dc_fixpt_div(base, div);
-	//avoid complex numbers
+	// avoid complex numbers
 	if (dc_fixpt_lt(base2, dc_fixpt_zero))
 		base2 = dc_fixpt_sub(dc_fixpt_zero, base2);
 
@@ -161,7 +161,7 @@ static void compute_de_pq(struct fixed31_32 in_x, struct fixed31_32 *out_y)
 }
 
 
-/*de gamma, none linear to linear*/
+/* de gamma, non-linear to linear */
 static void compute_hlg_eotf(struct fixed31_32 in_x,
 		struct fixed31_32 *out_y,
 		uint32_t sdr_white_level, uint32_t max_luminance_nits)
@@ -193,7 +193,7 @@ static void compute_hlg_eotf(struct fixed31_32 in_x,
 
 }
 
-/*re gamma, linear to none linear*/
+/* re gamma, linear to non-linear */
 static void compute_hlg_oetf(struct fixed31_32 in_x, struct fixed31_32 *out_y,
 		uint32_t sdr_white_level, uint32_t max_luminance_nits)
 {
@@ -830,7 +830,7 @@ static bool build_regamma(struct pwl_float_data_ex *rgb_regamma,
 
 	i = 0;
 	while (i <= hw_points_num) {
-		/*TODO use y vs r,g,b*/
+		/* TODO use y vs r,g,b */
 		rgb->r = translate_from_linear_space_ex(
 			coord_x->x, coeff, 0, cal_buffer);
 		rgb->g = rgb->r;
@@ -937,6 +937,7 @@ static bool build_freesync_hdr(struct pwl_float_data_ex *rgb_regamma,
 	uint32_t i;
 	struct pwl_float_data_ex *rgb = rgb_regamma;
 	const struct hw_x_point *coord_x = coordinate_x;
+	const struct hw_x_point *prv_coord_x = coord_x;
 	struct fixed31_32 scaledX = dc_fixpt_zero;
 	struct fixed31_32 scaledX1 = dc_fixpt_zero;
 	struct fixed31_32 max_display;
@@ -947,6 +948,9 @@ static bool build_freesync_hdr(struct pwl_float_data_ex *rgb_regamma,
 	bool use_eetf = false;
 	bool is_clipped = false;
 	struct fixed31_32 sdr_white_level;
+	struct fixed31_32 coordX_diff;
+	struct fixed31_32 out_dist_max;
+	struct fixed31_32 bright_norm;
 
 	if (fs_params->max_content == 0 ||
 			fs_params->max_display == 0)
@@ -975,7 +979,7 @@ static bool build_freesync_hdr(struct pwl_float_data_ex *rgb_regamma,
 	for (i = 32; i <= hw_points_num; i++) {
 		if (!is_clipped) {
 			if (use_eetf) {
-				/*max content is equal 1 */
+				/* max content is equal 1 */
 				scaledX1 = dc_fixpt_div(coord_x->x,
 						dc_fixpt_div(max_content, sdr_white_level));
 				hermite_spline_eetf(scaledX1, max_display, min_display,
@@ -990,21 +994,65 @@ static bool build_freesync_hdr(struct pwl_float_data_ex *rgb_regamma,
 				else
 					output = calculate_gamma22(scaledX, use_eetf, cal_buffer);
 
+				// Ensure output respects reasonable boundaries
+				output = dc_fixpt_clamp(output, dc_fixpt_zero, dc_fixpt_one);
+
 				rgb->r = output;
 				rgb->g = output;
 				rgb->b = output;
 			} else {
+				/* Here clipping happens for the first time */
 				is_clipped = true;
-				rgb->r = clip;
-				rgb->g = clip;
-				rgb->b = clip;
+
+				/* The next few lines implement the equation
+				 * output = prev_out +
+				 * (coord_x->x - prev_coord_x->x) *
+				 * (1.0 - prev_out) /
+				 * (maxDisp/sdr_white_level - prevCoordX)
+				 *
+				 * This equation interpolates the first point
+				 * after max_display/80 so that the slope from
+				 * hw_x_before_max and hw_x_after_max is such
+				 * that we hit Y=1.0 at max_display/80.
+				 */
+
+				coordX_diff = dc_fixpt_sub(coord_x->x, prv_coord_x->x);
+				out_dist_max = dc_fixpt_sub(dc_fixpt_one, output);
+				bright_norm = dc_fixpt_div(max_display, sdr_white_level);
+
+				output = dc_fixpt_add(
+					output, dc_fixpt_mul(
+						coordX_diff, dc_fixpt_div(
+							out_dist_max,
+							dc_fixpt_sub(bright_norm, prv_coord_x->x)
+						)
+					)
+				);
+
+				/* Relaxing the maximum boundary to 1.07 (instead of 1.0)
+				 * because the last point in the curve must be such that
+				 * the maximum display pixel brightness interpolates to
+				 * exactly 1.0. The worst case scenario was calculated
+				 * around 1.057, so the limit of 1.07 leaves some safety
+				 * margin.
+				 */
+				output = dc_fixpt_clamp(output, dc_fixpt_zero,
+					dc_fixpt_from_fraction(107, 100));
+
+				rgb->r = output;
+				rgb->g = output;
+				rgb->b = output;
 			}
 		} else {
+			/* Every other clipping after the first
+			 * one is dealt with here
+			 */
 			rgb->r = clip;
 			rgb->g = clip;
 			rgb->b = clip;
 		}
 
+		prv_coord_x = coord_x;
 		++coord_x;
 		++rgb;
 	}
@@ -1073,7 +1121,7 @@ static void build_hlg_degamma(struct pwl_float_data_ex *degamma,
 	const struct hw_x_point *coord_x = coordinate_x;
 
 	i = 0;
-	//check when i == 434
+	// check when i == 434
 	while (i != hw_points_num + 1) {
 		compute_hlg_eotf(coord_x->x, &rgb->r, sdr_white_level, max_luminance_nits);
 		rgb->g = rgb->r;
@@ -1097,7 +1145,7 @@ static void build_hlg_regamma(struct pwl_float_data_ex *regamma,
 
 	i = 0;
 
-	//when i == 471
+	// when i == 471
 	while (i != hw_points_num + 1) {
 		compute_hlg_oetf(coord_x->x, &rgb->r, sdr_white_level, max_luminance_nits);
 		rgb->g = rgb->r;
@@ -1331,6 +1379,8 @@ static void apply_lut_1d(
 	struct fixed31_32 lut1;
 	struct fixed31_32 lut2;
 	const int max_lut_index = 4095;
+	const struct fixed31_32 penult_lut_index_f =
+			dc_fixpt_from_int(max_lut_index-1);
 	const struct fixed31_32 max_lut_index_f =
 			dc_fixpt_from_int(max_lut_index);
 	int32_t index = 0, index_next = 0;
@@ -1355,10 +1405,21 @@ static void apply_lut_1d(
 			index = dc_fixpt_floor(norm_y);
 			index_f = dc_fixpt_from_int(index);
 
-			if (index < 0 || index > max_lut_index)
+			if (index < 0)
 				continue;
 
-			index_next = (index == max_lut_index) ? index : index+1;
+			if (index <= max_lut_index)
+				index_next = (index == max_lut_index) ? index : index+1;
+			else {
+				/* Here we are dealing with the last point in the curve,
+				 * which in some cases might exceed the range given by
+				 * max_lut_index. So we interpolate the value using
+				 * max_lut_index and max_lut_index - 1.
+				 */
+				index = max_lut_index - 1;
+				index_next = max_lut_index;
+				index_f = penult_lut_index_f;
+			}
 
 			if (color == 0) {
 				lut1 = ramp->entries.red[index];
@@ -1586,9 +1647,7 @@ static void build_new_custom_resulted_curve(
 	uint32_t hw_points_num,
 	struct dc_transfer_func_distributed_points *tf_pts)
 {
-	uint32_t i;
-
-	i = 0;
+	uint32_t i = 0;
 
 	while (i != hw_points_num + 1) {
 		tf_pts->red[i] = dc_fixpt_clamp(
@@ -1637,7 +1696,8 @@ static bool map_regamma_hw_to_x_user(
 	const struct pwl_float_data_ex *rgb_regamma,
 	uint32_t hw_points_num,
 	struct dc_transfer_func_distributed_points *tf_pts,
-	bool mapUserRamp)
+	bool mapUserRamp,
+	bool doClamping)
 {
 	/* setup to spare calculated ideal regamma values */
 
@@ -1665,8 +1725,10 @@ static bool map_regamma_hw_to_x_user(
 		}
 	}
 
-	/* this should be named differently, all it does is clamp to 0-1 */
-	build_new_custom_resulted_curve(hw_points_num, tf_pts);
+	if (doClamping) {
+		/* this should be named differently, all it does is clamp to 0-1 */
+		build_new_custom_resulted_curve(hw_points_num, tf_pts);
+	}
 
 	return true;
 }
@@ -1914,11 +1976,12 @@ bool mod_color_calculate_degamma_params(struct dc_color_caps *dc_caps,
 			++i;
 		}
 	} else {
-		//clamps to 0-1
+		// clamps to 0-1
 		map_regamma_hw_to_x_user(ramp, coeff, rgb_user,
 				coordinates_x, axis_x, curve,
 				MAX_HW_POINTS, tf_pts,
-				mapUserRamp && ramp && ramp->type == GAMMA_RGB_256);
+				mapUserRamp && ramp && ramp->type == GAMMA_RGB_256,
+				true);
 	}
 
 
@@ -2034,6 +2097,7 @@ bool mod_color_calculate_regamma_params(struct dc_transfer_func *output_tf,
 	struct gamma_pixel *axis_x = NULL;
 	struct pixel_gamma_point *coeff = NULL;
 	enum dc_transfer_func_predefined tf = TRANSFER_FUNCTION_SRGB;
+	bool doClamping = true;
 	bool ret = false;
 
 	if (output_tf->type == TF_TYPE_BYPASS)
@@ -2100,11 +2164,15 @@ bool mod_color_calculate_regamma_params(struct dc_transfer_func *output_tf,
 			cal_buffer);
 
 	if (ret) {
+		doClamping = !(output_tf->tf == TRANSFER_FUNCTION_GAMMA22 &&
+			fs_params != NULL && fs_params->skip_tm == 0);
+
 		map_regamma_hw_to_x_user(ramp, coeff, rgb_user,
 				coordinates_x, axis_x, rgb_regamma,
 				MAX_HW_POINTS, tf_pts,
 				(mapUserRamp || (ramp && ramp->type != GAMMA_RGB_256)) &&
-				(ramp && ramp->type != GAMMA_CS_TFM_1D));
+				(ramp && ramp->type != GAMMA_CS_TFM_1D),
+				doClamping);
 
 		if (ramp && ramp->type == GAMMA_CS_TFM_1D)
 			apply_lut_1d(ramp, MAX_HW_POINTS, tf_pts);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
