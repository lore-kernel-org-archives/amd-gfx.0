Return-Path: <SRS0=9Rk5=3F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25714C33CB3
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 20:14:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFFFD206D9
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 20:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JP9O6HS+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFFFD206D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68F8B6E2E6;
	Thu, 16 Jan 2020 20:14:36 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 254326E287
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 20:14:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHjZ5GHZQ/rpXBQ1Vt6NJ/Htuy3V1Eet08HrrNip1snCM+ilvxFdsYr27IJtk0mcnKvfin4/F0f0KEqaw3A899hBSG5u8x67rmK0eNxFI6ExMHDZAH9QQjTp3xcidPQcgjEJ90hu+FWZ4AYHpyjI3rStvKGvGGnRaz4hoeBMN4V7wy5eJ7vHwuiMipsspYi05mMwFKq/zIdi+yCTNDvNzPbSGV8Cx5cqMDGB0KVDs7pFCka1hGPkfsjdAA1kx70OxGMjWtCjhwbwLFIR8dgY2DMhF9wOSFiCDc2NBTKgEt9zrS7IlOnG6NpUZbFPdvmjXuQhqM/0/PVP5RwFaOVvBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZC4sOYu9csWkNSpjJT4id99f8IyULoZGAEt6Mk24eE8=;
 b=VoIXApQJdVNoMkOyFslMC61TDg1106n6uZNUDWwQ7VKfFeibke8Fph8Sk7NPmJWcTg1pZsHT15KFON++0H7yA9B1TI0u26KaXvjsSIZR/ZyNQ5ej1ssXYT3vBzTxDlqFNaZQcNafsmGq3v0QgHIFAWk1tng8C7UjJgyRmoNILfKjYBkIlExBK1i8VlAuVjUGSg8jhaHx1rgcFp0RAt0vzKT0+Y7gpdFvqYc0o8Pmns6ECacSYOOXK2HY0ClZz1paU0J8q7pjmbT8Wxl6wy6smpqfVJ0oJuAlSvvh1gO23OEQyj+yuxBUjfoXRJ1ZqWtsALSNuNZ17ZlPoIzPP2PxYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZC4sOYu9csWkNSpjJT4id99f8IyULoZGAEt6Mk24eE8=;
 b=JP9O6HS+LJgUc3Qom3xLs6fHmRpW08CKNN+R0am8wjqyBWoets0yQI+SQnhMwVJXRv1rTMYI9EabrYMiMQy65x/mTImuiWFK4sk45v6h0K2fE+44PqEbtNpXc1pYIQu67IUTg8+B7N8DknP4uVClW2OXsROVVp4a+4F+5OAFP1c=
Received: from DM5PR12CA0007.namprd12.prod.outlook.com (2603:10b6:4:1::17) by
 BY5PR12MB4003.namprd12.prod.outlook.com (2603:10b6:a03:196::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20; Thu, 16 Jan
 2020 20:14:29 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::200) by DM5PR12CA0007.outlook.office365.com
 (2603:10b6:4:1::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend
 Transport; Thu, 16 Jan 2020 20:14:28 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2644.19 via Frontend Transport; Thu, 16 Jan 2020 20:14:28 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 16 Jan
 2020 14:14:27 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 16 Jan 2020 14:14:26 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/22] drm/amd/display: Refactor to remove diags specific rgam
 func
Date: Thu, 16 Jan 2020 15:14:06 -0500
Message-ID: <20200116201418.2254-11-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200116201418.2254-1-Bhawanpreet.Lakha@amd.com>
References: <20200116201418.2254-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(346002)(39860400002)(376002)(428003)(189003)(199004)(478600001)(4326008)(36756003)(336012)(26005)(81156014)(2616005)(70206006)(426003)(81166006)(6916009)(70586007)(8676002)(8936002)(7696005)(186003)(6666004)(316002)(54906003)(2906002)(1076003)(30864003)(5660300002)(86362001)(356004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BY5PR12MB4003; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 700e7a6b-c08e-49d4-cdc6-08d79ac0b0d9
X-MS-TrafficTypeDiagnostic: BY5PR12MB4003:
X-Microsoft-Antispam-PRVS: <BY5PR12MB400348BF910ACBBC9DFD0FDEF9360@BY5PR12MB4003.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 02843AA9E0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r6WunXnIQOXvLDywab0DE+GrxdWnFcT19qkRWzkbbDsAsENEPyLCB341RirWRCx/GLw9yb4JQuVPUywysA2H1JXtwm7vSQBmj0LRpRzS7Xv1n0YVDSBLdv/V/zz397JZ8/zeQ3VeubbEqHT5y/jerN2V8bDCsi9JJiEfyzXw0ZeYB5+zsroyDfFVVb9B7nV7JBp5JlJ1Enc/hGNMMDuW6ktB+dEUzQ6fuB+y9+aX1vf41/cOGualDplNEtkzos8+WGS1RxZrEYuxwgFmaf2sRQ3Fi0kYIkhSpLoE8y0GZ9kFHVg/wPUTUxoO82yqvTIHaYYQfw3vAKp9eaUAZl10qGaWV14PVFpBMqrnYYLf/7jsMIUFr5ZJE8gCc8MBYTux2lILjfJIV8Nq5Qr3stlcxjqadm++hJ1QAwz7GQVad/aSSedEa8MyKNQeOnSUAiol
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2020 20:14:28.6646 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 700e7a6b-c08e-49d4-cdc6-08d79ac0b0d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4003
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
Cc: sunpeng.li@amd.com, rodrigo.siqueira@amd.com, harry.wentland@amd.com,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

[Why]
It has duplicate code for building regamma curve

[How]
Remove the duplicate code and use the same function for building regamma

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Reviewed-by: Krunoslav Kovac <Krunoslav.Kovac@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 .../amd/display/modules/color/color_gamma.c   | 307 ++++++++----------
 .../amd/display/modules/color/color_gamma.h   |   4 -
 2 files changed, 129 insertions(+), 182 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
index 1b278c42809a..cac09d500fda 100644
--- a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
+++ b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
@@ -1673,129 +1673,6 @@ static bool map_regamma_hw_to_x_user(
 
 #define _EXTRA_POINTS 3
 
-bool mod_color_calculate_regamma_params(struct dc_transfer_func *output_tf,
-		const struct dc_gamma *ramp, bool mapUserRamp, bool canRomBeUsed,
-		const struct freesync_hdr_tf_params *fs_params)
-{
-	struct dc_transfer_func_distributed_points *tf_pts = &output_tf->tf_pts;
-	struct dividers dividers;
-
-	struct pwl_float_data *rgb_user = NULL;
-	struct pwl_float_data_ex *rgb_regamma = NULL;
-	struct gamma_pixel *axis_x = NULL;
-	struct pixel_gamma_point *coeff = NULL;
-	enum dc_transfer_func_predefined tf = TRANSFER_FUNCTION_SRGB;
-	bool ret = false;
-
-	if (output_tf->type == TF_TYPE_BYPASS)
-		return false;
-
-	/* we can use hardcoded curve for plain SRGB TF */
-	if (output_tf->type == TF_TYPE_PREDEFINED && canRomBeUsed == true &&
-			output_tf->tf == TRANSFER_FUNCTION_SRGB) {
-		if (ramp == NULL)
-			return true;
-		if ((ramp->is_identity && ramp->type != GAMMA_CS_TFM_1D) ||
-				(!mapUserRamp && ramp->type == GAMMA_RGB_256))
-			return true;
-	}
-
-	output_tf->type = TF_TYPE_DISTRIBUTED_POINTS;
-
-	if (ramp && ramp->type != GAMMA_CS_TFM_1D &&
-			(mapUserRamp || ramp->type != GAMMA_RGB_256)) {
-		rgb_user = kvcalloc(ramp->num_entries + _EXTRA_POINTS,
-			    sizeof(*rgb_user),
-			    GFP_KERNEL);
-		if (!rgb_user)
-			goto rgb_user_alloc_fail;
-
-		axis_x = kvcalloc(ramp->num_entries + 3, sizeof(*axis_x),
-				GFP_KERNEL);
-		if (!axis_x)
-			goto axis_x_alloc_fail;
-
-		dividers.divider1 = dc_fixpt_from_fraction(3, 2);
-		dividers.divider2 = dc_fixpt_from_int(2);
-		dividers.divider3 = dc_fixpt_from_fraction(5, 2);
-
-		build_evenly_distributed_points(
-				axis_x,
-				ramp->num_entries,
-				dividers);
-
-		if (ramp->type == GAMMA_RGB_256 && mapUserRamp)
-			scale_gamma(rgb_user, ramp, dividers);
-		else if (ramp->type == GAMMA_RGB_FLOAT_1024)
-			scale_gamma_dx(rgb_user, ramp, dividers);
-	}
-
-	rgb_regamma = kvcalloc(MAX_HW_POINTS + _EXTRA_POINTS,
-			       sizeof(*rgb_regamma),
-			       GFP_KERNEL);
-	if (!rgb_regamma)
-		goto rgb_regamma_alloc_fail;
-
-	coeff = kvcalloc(MAX_HW_POINTS + _EXTRA_POINTS, sizeof(*coeff),
-			 GFP_KERNEL);
-	if (!coeff)
-		goto coeff_alloc_fail;
-
-	tf = output_tf->tf;
-	if (tf == TRANSFER_FUNCTION_PQ) {
-		tf_pts->end_exponent = 7;
-		tf_pts->x_point_at_y1_red = 125;
-		tf_pts->x_point_at_y1_green = 125;
-		tf_pts->x_point_at_y1_blue = 125;
-
-		build_pq(rgb_regamma,
-				MAX_HW_POINTS,
-				coordinates_x,
-				output_tf->sdr_ref_white_level);
-	} else if (tf == TRANSFER_FUNCTION_GAMMA22 &&
-			fs_params != NULL && fs_params->skip_tm == 0) {
-		build_freesync_hdr(rgb_regamma,
-				MAX_HW_POINTS,
-				coordinates_x,
-				fs_params);
-	} else if (tf == TRANSFER_FUNCTION_HLG) {
-		build_freesync_hdr(rgb_regamma,
-				MAX_HW_POINTS,
-				coordinates_x,
-				fs_params);
-
-	} else {
-		tf_pts->end_exponent = 0;
-		tf_pts->x_point_at_y1_red = 1;
-		tf_pts->x_point_at_y1_green = 1;
-		tf_pts->x_point_at_y1_blue = 1;
-
-		build_regamma(rgb_regamma,
-				MAX_HW_POINTS,
-				coordinates_x, tf);
-	}
-	map_regamma_hw_to_x_user(ramp, coeff, rgb_user,
-			coordinates_x, axis_x, rgb_regamma,
-			MAX_HW_POINTS, tf_pts,
-			(mapUserRamp || (ramp && ramp->type != GAMMA_RGB_256)) &&
-			(ramp && ramp->type != GAMMA_CS_TFM_1D));
-
-	if (ramp && ramp->type == GAMMA_CS_TFM_1D)
-		apply_lut_1d(ramp, MAX_HW_POINTS, tf_pts);
-
-	ret = true;
-
-	kvfree(coeff);
-coeff_alloc_fail:
-	kvfree(rgb_regamma);
-rgb_regamma_alloc_fail:
-	kvfree(axis_x);
-axis_x_alloc_fail:
-	kvfree(rgb_user);
-rgb_user_alloc_fail:
-	return ret;
-}
-
 bool calculate_user_regamma_coeff(struct dc_transfer_func *output_tf,
 		const struct regamma_lut *regamma)
 {
@@ -2043,14 +1920,14 @@ bool mod_color_calculate_degamma_params(struct dc_transfer_func *input_tf,
 	return ret;
 }
 
-
-bool  mod_color_calculate_curve(enum dc_transfer_func_predefined trans,
+static bool calculate_curve(enum dc_transfer_func_predefined trans,
 				struct dc_transfer_func_distributed_points *points,
+				struct pwl_float_data_ex *rgb_regamma,
+				const struct freesync_hdr_tf_params *fs_params,
 				uint32_t sdr_ref_white_level)
 {
 	uint32_t i;
 	bool ret = false;
-	struct pwl_float_data_ex *rgb_regamma = NULL;
 
 	if (trans == TRANSFER_FUNCTION_UNITY ||
 		trans == TRANSFER_FUNCTION_LINEAR) {
@@ -2060,68 +1937,33 @@ bool  mod_color_calculate_curve(enum dc_transfer_func_predefined trans,
 		points->x_point_at_y1_blue = 1;
 
 		for (i = 0; i <= MAX_HW_POINTS ; i++) {
-			points->red[i]    = coordinates_x[i].x;
-			points->green[i]  = coordinates_x[i].x;
-			points->blue[i]   = coordinates_x[i].x;
+			rgb_regamma[i].r = coordinates_x[i].x;
+			rgb_regamma[i].g = coordinates_x[i].x;
+			rgb_regamma[i].b = coordinates_x[i].x;
 		}
+
 		ret = true;
 	} else if (trans == TRANSFER_FUNCTION_PQ) {
-		rgb_regamma = kvcalloc(MAX_HW_POINTS + _EXTRA_POINTS,
-				       sizeof(*rgb_regamma),
-				       GFP_KERNEL);
-		if (!rgb_regamma)
-			goto rgb_regamma_alloc_fail;
 		points->end_exponent = 7;
 		points->x_point_at_y1_red = 125;
 		points->x_point_at_y1_green = 125;
 		points->x_point_at_y1_blue = 125;
 
-
 		build_pq(rgb_regamma,
 				MAX_HW_POINTS,
 				coordinates_x,
 				sdr_ref_white_level);
-		for (i = 0; i <= MAX_HW_POINTS ; i++) {
-			points->red[i]    = rgb_regamma[i].r;
-			points->green[i]  = rgb_regamma[i].g;
-			points->blue[i]   = rgb_regamma[i].b;
-		}
-		ret = true;
-
-		kvfree(rgb_regamma);
-	} else if (trans == TRANSFER_FUNCTION_SRGB ||
-		trans == TRANSFER_FUNCTION_BT709 ||
-		trans == TRANSFER_FUNCTION_GAMMA22 ||
-		trans == TRANSFER_FUNCTION_GAMMA24 ||
-		trans == TRANSFER_FUNCTION_GAMMA26) {
-		rgb_regamma = kvcalloc(MAX_HW_POINTS + _EXTRA_POINTS,
-				       sizeof(*rgb_regamma),
-				       GFP_KERNEL);
-		if (!rgb_regamma)
-			goto rgb_regamma_alloc_fail;
-		points->end_exponent = 0;
-		points->x_point_at_y1_red = 1;
-		points->x_point_at_y1_green = 1;
-		points->x_point_at_y1_blue = 1;
 
-		build_regamma(rgb_regamma,
+		ret = true;
+	} else if (trans == TRANSFER_FUNCTION_GAMMA22 &&
+			fs_params != NULL && fs_params->skip_tm == 0) {
+		build_freesync_hdr(rgb_regamma,
 				MAX_HW_POINTS,
 				coordinates_x,
-				trans);
-		for (i = 0; i <= MAX_HW_POINTS ; i++) {
-			points->red[i]    = rgb_regamma[i].r;
-			points->green[i]  = rgb_regamma[i].g;
-			points->blue[i]   = rgb_regamma[i].b;
-		}
-		ret = true;
+				fs_params);
 
-		kvfree(rgb_regamma);
+		ret = true;
 	} else if (trans == TRANSFER_FUNCTION_HLG) {
-		rgb_regamma = kvcalloc(MAX_HW_POINTS + _EXTRA_POINTS,
-				       sizeof(*rgb_regamma),
-				       GFP_KERNEL);
-		if (!rgb_regamma)
-			goto rgb_regamma_alloc_fail;
 		points->end_exponent = 4;
 		points->x_point_at_y1_red = 12;
 		points->x_point_at_y1_green = 12;
@@ -2131,18 +1973,127 @@ bool  mod_color_calculate_curve(enum dc_transfer_func_predefined trans,
 				MAX_HW_POINTS,
 				coordinates_x,
 				80, 1000);
-		for (i = 0; i <= MAX_HW_POINTS ; i++) {
-			points->red[i]    = rgb_regamma[i].r;
-			points->green[i]  = rgb_regamma[i].g;
-			points->blue[i]   = rgb_regamma[i].b;
-		}
+
+		ret = true;
+	} else {
+		// trans == TRANSFER_FUNCTION_SRGB
+		// trans == TRANSFER_FUNCTION_BT709
+		// trans == TRANSFER_FUNCTION_GAMMA22
+		// trans == TRANSFER_FUNCTION_GAMMA24
+		// trans == TRANSFER_FUNCTION_GAMMA26
+		points->end_exponent = 0;
+		points->x_point_at_y1_red = 1;
+		points->x_point_at_y1_green = 1;
+		points->x_point_at_y1_blue = 1;
+
+		build_regamma(rgb_regamma,
+				MAX_HW_POINTS,
+				coordinates_x,
+				trans);
+
 		ret = true;
-		kvfree(rgb_regamma);
 	}
-rgb_regamma_alloc_fail:
+
 	return ret;
 }
 
+bool mod_color_calculate_regamma_params(struct dc_transfer_func *output_tf,
+		const struct dc_gamma *ramp, bool mapUserRamp, bool canRomBeUsed,
+		const struct freesync_hdr_tf_params *fs_params)
+{
+	struct dc_transfer_func_distributed_points *tf_pts = &output_tf->tf_pts;
+	struct dividers dividers;
+
+	struct pwl_float_data *rgb_user = NULL;
+	struct pwl_float_data_ex *rgb_regamma = NULL;
+	struct gamma_pixel *axis_x = NULL;
+	struct pixel_gamma_point *coeff = NULL;
+	enum dc_transfer_func_predefined tf = TRANSFER_FUNCTION_SRGB;
+	bool ret = false;
+
+	if (output_tf->type == TF_TYPE_BYPASS)
+		return false;
+
+	/* we can use hardcoded curve for plain SRGB TF */
+	if (output_tf->type == TF_TYPE_PREDEFINED && canRomBeUsed == true &&
+			output_tf->tf == TRANSFER_FUNCTION_SRGB) {
+		if (ramp == NULL)
+			return true;
+		if ((ramp->is_identity && ramp->type != GAMMA_CS_TFM_1D) ||
+				(!mapUserRamp && ramp->type == GAMMA_RGB_256))
+			return true;
+	}
+
+	output_tf->type = TF_TYPE_DISTRIBUTED_POINTS;
+
+	if (ramp && ramp->type != GAMMA_CS_TFM_1D &&
+			(mapUserRamp || ramp->type != GAMMA_RGB_256)) {
+		rgb_user = kvcalloc(ramp->num_entries + _EXTRA_POINTS,
+			    sizeof(*rgb_user),
+			    GFP_KERNEL);
+		if (!rgb_user)
+			goto rgb_user_alloc_fail;
+
+		axis_x = kvcalloc(ramp->num_entries + 3, sizeof(*axis_x),
+				GFP_KERNEL);
+		if (!axis_x)
+			goto axis_x_alloc_fail;
+
+		dividers.divider1 = dc_fixpt_from_fraction(3, 2);
+		dividers.divider2 = dc_fixpt_from_int(2);
+		dividers.divider3 = dc_fixpt_from_fraction(5, 2);
+
+		build_evenly_distributed_points(
+				axis_x,
+				ramp->num_entries,
+				dividers);
+
+		if (ramp->type == GAMMA_RGB_256 && mapUserRamp)
+			scale_gamma(rgb_user, ramp, dividers);
+		else if (ramp->type == GAMMA_RGB_FLOAT_1024)
+			scale_gamma_dx(rgb_user, ramp, dividers);
+	}
+
+	rgb_regamma = kvcalloc(MAX_HW_POINTS + _EXTRA_POINTS,
+			       sizeof(*rgb_regamma),
+			       GFP_KERNEL);
+	if (!rgb_regamma)
+		goto rgb_regamma_alloc_fail;
+
+	coeff = kvcalloc(MAX_HW_POINTS + _EXTRA_POINTS, sizeof(*coeff),
+			 GFP_KERNEL);
+	if (!coeff)
+		goto coeff_alloc_fail;
+
+	tf = output_tf->tf;
+
+	ret = calculate_curve(tf,
+			tf_pts,
+			rgb_regamma,
+			fs_params,
+			output_tf->sdr_ref_white_level);
+
+	if (ret) {
+		map_regamma_hw_to_x_user(ramp, coeff, rgb_user,
+				coordinates_x, axis_x, rgb_regamma,
+				MAX_HW_POINTS, tf_pts,
+				(mapUserRamp || (ramp && ramp->type != GAMMA_RGB_256)) &&
+				(ramp && ramp->type != GAMMA_CS_TFM_1D));
+
+		if (ramp && ramp->type == GAMMA_CS_TFM_1D)
+			apply_lut_1d(ramp, MAX_HW_POINTS, tf_pts);
+	}
+
+	kvfree(coeff);
+coeff_alloc_fail:
+	kvfree(rgb_regamma);
+rgb_regamma_alloc_fail:
+	kvfree(axis_x);
+axis_x_alloc_fail:
+	kvfree(rgb_user);
+rgb_user_alloc_fail:
+	return ret;
+}
 
 bool  mod_color_calculate_degamma_curve(enum dc_transfer_func_predefined trans,
 				struct dc_transfer_func_distributed_points *points)
diff --git a/drivers/gpu/drm/amd/display/modules/color/color_gamma.h b/drivers/gpu/drm/amd/display/modules/color/color_gamma.h
index 44ddea58523a..9994817a9a03 100644
--- a/drivers/gpu/drm/amd/display/modules/color/color_gamma.h
+++ b/drivers/gpu/drm/amd/display/modules/color/color_gamma.h
@@ -103,10 +103,6 @@ bool mod_color_calculate_regamma_params(struct dc_transfer_func *output_tf,
 bool mod_color_calculate_degamma_params(struct dc_transfer_func *output_tf,
 		const struct dc_gamma *ramp, bool mapUserRamp);
 
-bool mod_color_calculate_curve(enum dc_transfer_func_predefined  trans,
-		struct dc_transfer_func_distributed_points *points,
-		uint32_t sdr_ref_white_level);
-
 bool mod_color_calculate_degamma_curve(enum dc_transfer_func_predefined trans,
 				struct dc_transfer_func_distributed_points *points);
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
