Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 442CEC04A6A
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 06:07:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E040810E2CD;
	Wed, 16 Aug 2023 06:07:51 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C61B910E2CD
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 06:07:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LBE1OyTDyOME8f9GQLUwHyuLit9ssyQ9obEyRFF9wnqqcdj4+S0fXorIKXaZ6069qxJ8Ndl4nZrmo89RrU8R0zWpHzoiA5EYi3Is4lHmjgHtGe3dUVsf258Epw87lg17aiIb1BiiP8/16eiK/n3GKGfnne8/HkmULGO8/5hTK/pJMnLlL7e2m/csG7Lj56RYtlsgSDDFkh+A/1jpgVHqeP2docHy9idT+7Zggigzp67JbErz/laoTA4aF9iugxR3PoZgpCk6zsRFuaUhN+oxV14ZGUauAal9gGISlyZaDHxB5LesKb0teOOi+40LRZmwtHTKFuSBhDyYXossR4BGNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dTbU9oUBDSeDYoB94s4pgadnW3B8ZPkjjxE4c2Y0THI=;
 b=C61GbEP3aL+ZkeRVIZkwU0Oxf39elV9qZzmtwvP9lGChc9u0PEw48ZWbL2riQ0osqNUh32IKhI0tI5QhwmbeKl2ow2QLcovEMrmq3vroiVWuLoUgNVX9Fq4wkZ+IOcL7X4tDUfJvW0mgEmMdNfCCwBBBJuF/M6McLx0aMSeGEZFOIIVnnlmeAu664bkFFfjavJhtgTspGY53kgsHJ/3CdggSTft7t+hws3cOTJ+7S3Mbe6JalevanRU/Us+3yfeT3D9LyECYWIz7OU/feWliNQ74gHq3w69SyNxqAfgpAp1RJw7V5CIybg58kGvOoi9P0F9GmNousAdT5ABP6D9nrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTbU9oUBDSeDYoB94s4pgadnW3B8ZPkjjxE4c2Y0THI=;
 b=tJSOvaWpcRaSYBi4UsLfjxrtVKi12r1wXRBiZi4e4o4kGnlo9IPJGSV7vwYnI7GsAD4AHsLHQ0sjVB0nHkYbgWgn6qINOHVuwuKdjnEIF7/tvXfUCVlB+1rywISZHO+EXQe3njwuSN6N4DQgMo5g20sP4mgfzKZ7i4mPmcw5gCA=
Received: from CY8PR10CA0003.namprd10.prod.outlook.com (2603:10b6:930:4f::24)
 by BL1PR12MB5922.namprd12.prod.outlook.com (2603:10b6:208:399::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 06:07:44 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:930:4f:cafe::1d) by CY8PR10CA0003.outlook.office365.com
 (2603:10b6:930:4f::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Wed, 16 Aug 2023 06:07:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 16 Aug 2023 06:07:44 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 01:07:43 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 01:07:43 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 16 Aug 2023 01:07:38 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/16] drm/amd/display: PQ tail accuracy
Date: Wed, 16 Aug 2023 14:06:45 +0800
Message-ID: <20230816060658.2141009-4-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230816060658.2141009-1-Wayne.Lin@amd.com>
References: <20230816060658.2141009-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|BL1PR12MB5922:EE_
X-MS-Office365-Filtering-Correlation-Id: 72e195ed-5a19-402f-411f-08db9e1f1b7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j4K5MyQeoHO2EKqG9t/XGHszy49BzFzPeH7ZNJtC/aFe+608U4YdJv1eMxj3aRtpBtURuiO4HxQUbNMru2n3ZGcbruwCx5XSKvqOPCWYS0BFvWqgY5/blGzXv4/PiKRXyFxkpqjyTJxFnGArLMYnnW+h7Hni9Q7epOlvD3nAGKlZbVHRE6ULOThM++YmGUvnaCqAhv/mghnR3miH/ws6uVs9fDAx39GG5GE59QpcGcgOC+NDVBZZ/Kk176VanPCWOmUIeNKAZ2pLBGMck9xCxLCOVJFnQvLZIV2Wj/482JYLfuf/s28v7WInAwZukaMsZvDTboUGZyrINQnnUDB+xeX2RdIGt62WT0ktLSj1qzE0WNMrJEbTt5LZH8wWmplMU+SK+VDwFrN8N4Gf4HYGrJuq45+blof9rEPUfexmfGPqD12ZyKmg7VgIIvq2veEt8sFwTVOjw4G89xGxNCOskTEahGWB6ir0j0fIiYw4a8Qzfd4Y/wNdytoAF5D587MNJnaZ9T0fuEiGNaGuQ9qrX6PyCs9EjZdQf4C8iuOMUsh8kvfc9sxpnNiMBRYv/TJ2/J44lhUC72Q92fWd1QtEnGtDZEe1PvtMw6EVWpe0md9ra3mFcHPslb8GCWz6TN3dU27WZmI0Rui4x0KGKQP6hIqNf1ova1aB9C6yiH+jPfn9/90baGKV3JTJf/e182p4ohBHS2oYa3e7j25xKiSPx9bKMIM4UrMkudUbIA40h39S78DAlVzxeFY3bEeQwnYwBVlKbFKiH7cbXANNcS6m7A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(376002)(39860400002)(396003)(82310400011)(451199024)(186009)(1800799009)(46966006)(40470700004)(36840700001)(7696005)(6666004)(478600001)(336012)(83380400001)(426003)(2616005)(26005)(1076003)(2906002)(316002)(41300700001)(70586007)(6916009)(70206006)(54906003)(5660300002)(8676002)(4326008)(8936002)(36756003)(40460700003)(40480700001)(36860700001)(47076005)(356005)(81166007)(86362001)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 06:07:44.4135 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72e195ed-5a19-402f-411f-08db9e1f1b7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5922
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
Cc: stylon.wang@amd.com, Krunoslav Kovac <krunoslav.kovac@amd.com>,
 Anthony Koo <anthony.koo@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Krunoslav Kovac <krunoslav.kovac@amd.com>

[WHY & HOW]
HW LUTs changed slightly in DCN3: 256 base+slope pairs were replaced by
257 bases. Code was still calculating all 256 base+slope and then
creating 257th pt as last base + last slope.
This was done in wrong format, and then "fixed" it by making the last
two points the same thus making the last slope=0.
However, this also created some precision problems near the end that
are not visible but they do show up with capture cards.

Solution is to calculate 257 and remove deltas since we no longer have
those HW registers.

Reviewed-by: Anthony Koo <anthony.koo@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Krunoslav Kovac <krunoslav.kovac@amd.com>
---
 .../amd/display/dc/dcn30/dcn30_cm_common.c    | 104 ++++++------------
 .../gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c  |  17 ---
 2 files changed, 33 insertions(+), 88 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
index e0df9b0065f9..ddb344056d40 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
@@ -114,7 +114,6 @@ bool cm3_helper_translate_curve_to_hw_format(
 	struct pwl_result_data *rgb;
 	struct pwl_result_data *rgb_plus_1;
 	struct pwl_result_data *rgb_minus_1;
-	struct fixed31_32 end_value;
 
 	int32_t region_start, region_end;
 	int32_t i;
@@ -176,7 +175,7 @@ bool cm3_helper_translate_curve_to_hw_format(
 				NUMBER_SW_SEGMENTS;
 		for (i = start_index; i < start_index + NUMBER_SW_SEGMENTS;
 				i += increment) {
-			if (j == hw_points - 1)
+			if (j == hw_points)
 				break;
 			rgb_resulted[j].red = output_tf->tf_pts.red[i];
 			rgb_resulted[j].green = output_tf->tf_pts.green[i];
@@ -187,13 +186,13 @@ bool cm3_helper_translate_curve_to_hw_format(
 
 	/* last point */
 	start_index = (region_end + MAX_LOW_POINT) * NUMBER_SW_SEGMENTS;
-	rgb_resulted[hw_points - 1].red = output_tf->tf_pts.red[start_index];
-	rgb_resulted[hw_points - 1].green = output_tf->tf_pts.green[start_index];
-	rgb_resulted[hw_points - 1].blue = output_tf->tf_pts.blue[start_index];
+	rgb_resulted[hw_points].red = output_tf->tf_pts.red[start_index];
+	rgb_resulted[hw_points].green = output_tf->tf_pts.green[start_index];
+	rgb_resulted[hw_points].blue = output_tf->tf_pts.blue[start_index];
 
-	rgb_resulted[hw_points].red = rgb_resulted[hw_points - 1].red;
-	rgb_resulted[hw_points].green = rgb_resulted[hw_points - 1].green;
-	rgb_resulted[hw_points].blue = rgb_resulted[hw_points - 1].blue;
+	rgb_resulted[hw_points+1].red = rgb_resulted[hw_points].red;
+	rgb_resulted[hw_points+1].green = rgb_resulted[hw_points].green;
+	rgb_resulted[hw_points+1].blue = rgb_resulted[hw_points].blue;
 
 	// All 3 color channels have same x
 	corner_points[0].red.x = dc_fixpt_pow(dc_fixpt_from_int(2),
@@ -220,34 +219,16 @@ bool cm3_helper_translate_curve_to_hw_format(
 	/* see comment above, m_arrPoints[1].y should be the Y value for the
 	 * region end (m_numOfHwPoints), not last HW point(m_numOfHwPoints - 1)
 	 */
-	corner_points[1].red.y = rgb_resulted[hw_points - 1].red;
-	corner_points[1].green.y = rgb_resulted[hw_points - 1].green;
-	corner_points[1].blue.y = rgb_resulted[hw_points - 1].blue;
+	corner_points[1].red.y = rgb_resulted[hw_points].red;
+	corner_points[1].green.y = rgb_resulted[hw_points].green;
+	corner_points[1].blue.y = rgb_resulted[hw_points].blue;
 	corner_points[1].red.slope = dc_fixpt_zero;
 	corner_points[1].green.slope = dc_fixpt_zero;
 	corner_points[1].blue.slope = dc_fixpt_zero;
 
-	if (output_tf->tf == TRANSFER_FUNCTION_PQ || output_tf->tf == TRANSFER_FUNCTION_HLG) {
-		/* for PQ/HLG, we want to have a straight line from last HW X point,
-		 * and the slope to be such that we hit 1.0 at 10000/1000 nits.
-		 */
-
-		if (output_tf->tf == TRANSFER_FUNCTION_PQ)
-			end_value = dc_fixpt_from_int(125);
-		else
-			end_value = dc_fixpt_from_fraction(125, 10);
-
-		corner_points[1].red.slope = dc_fixpt_div(
-			dc_fixpt_sub(dc_fixpt_one, corner_points[1].red.y),
-			dc_fixpt_sub(end_value, corner_points[1].red.x));
-		corner_points[1].green.slope = dc_fixpt_div(
-			dc_fixpt_sub(dc_fixpt_one, corner_points[1].green.y),
-			dc_fixpt_sub(end_value, corner_points[1].green.x));
-		corner_points[1].blue.slope = dc_fixpt_div(
-			dc_fixpt_sub(dc_fixpt_one, corner_points[1].blue.y),
-			dc_fixpt_sub(end_value, corner_points[1].blue.x));
-	}
-	lut_params->hw_points_num = hw_points;
+	// DCN3+ have 257 pts in lieu of no separate slope registers
+	// Prior HW had 256 base+slope pairs
+	lut_params->hw_points_num = hw_points + 1;
 
 	k = 0;
 	for (i = 1; i < MAX_REGIONS_NUMBER; i++) {
@@ -267,38 +248,37 @@ bool cm3_helper_translate_curve_to_hw_format(
 	rgb_plus_1 = rgb_resulted + 1;
 	rgb_minus_1 = rgb;
 
-	i = 1;
-	while (i != hw_points + 1) {
-		if (i >= hw_points - 1) {
-			if (dc_fixpt_lt(rgb_plus_1->red, rgb->red))
-				rgb_plus_1->red = dc_fixpt_add(rgb->red, rgb_minus_1->delta_red);
-			if (dc_fixpt_lt(rgb_plus_1->green, rgb->green))
-				rgb_plus_1->green = dc_fixpt_add(rgb->green, rgb_minus_1->delta_green);
-			if (dc_fixpt_lt(rgb_plus_1->blue, rgb->blue))
-				rgb_plus_1->blue = dc_fixpt_add(rgb->blue, rgb_minus_1->delta_blue);
-		}
-
-		rgb->delta_red   = dc_fixpt_sub(rgb_plus_1->red,   rgb->red);
-		rgb->delta_green = dc_fixpt_sub(rgb_plus_1->green, rgb->green);
-		rgb->delta_blue  = dc_fixpt_sub(rgb_plus_1->blue,  rgb->blue);
+	if (fixpoint == true) {
+		i = 1;
+		while (i != hw_points + 2) {
+			if (i >= hw_points) {
+				if (dc_fixpt_lt(rgb_plus_1->red, rgb->red))
+					rgb_plus_1->red = dc_fixpt_add(rgb->red,
+							rgb_minus_1->delta_red);
+				if (dc_fixpt_lt(rgb_plus_1->green, rgb->green))
+					rgb_plus_1->green = dc_fixpt_add(rgb->green,
+							rgb_minus_1->delta_green);
+				if (dc_fixpt_lt(rgb_plus_1->blue, rgb->blue))
+					rgb_plus_1->blue = dc_fixpt_add(rgb->blue,
+							rgb_minus_1->delta_blue);
+			}
 
-		if (fixpoint == true) {
 			rgb->delta_red_reg   = dc_fixpt_clamp_u0d10(rgb->delta_red);
 			rgb->delta_green_reg = dc_fixpt_clamp_u0d10(rgb->delta_green);
 			rgb->delta_blue_reg  = dc_fixpt_clamp_u0d10(rgb->delta_blue);
 			rgb->red_reg         = dc_fixpt_clamp_u0d14(rgb->red);
 			rgb->green_reg       = dc_fixpt_clamp_u0d14(rgb->green);
 			rgb->blue_reg        = dc_fixpt_clamp_u0d14(rgb->blue);
-		}
 
-		++rgb_plus_1;
-		rgb_minus_1 = rgb;
-		++rgb;
-		++i;
+			++rgb_plus_1;
+			rgb_minus_1 = rgb;
+			++rgb;
+			++i;
+		}
 	}
 	cm3_helper_convert_to_custom_float(rgb_resulted,
 						lut_params->corner_points,
-						hw_points, fixpoint);
+						hw_points+1, fixpoint);
 
 	return true;
 }
@@ -603,24 +583,6 @@ bool cm3_helper_convert_to_custom_float(
 			return false;
 		}
 
-		if (!convert_to_custom_float_format(rgb->delta_red, &fmt,
-						    &rgb->delta_red_reg)) {
-			BREAK_TO_DEBUGGER();
-			return false;
-		}
-
-		if (!convert_to_custom_float_format(rgb->delta_green, &fmt,
-						    &rgb->delta_green_reg)) {
-			BREAK_TO_DEBUGGER();
-			return false;
-		}
-
-		if (!convert_to_custom_float_format(rgb->delta_blue, &fmt,
-						    &rgb->delta_blue_reg)) {
-			BREAK_TO_DEBUGGER();
-			return false;
-		}
-
 		++rgb;
 		++i;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c
index 6cf40c1332bc..d1500b223858 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c
@@ -278,22 +278,10 @@ static void mpc3_program_ogam_pwl(
 {
 	uint32_t i;
 	struct dcn30_mpc *mpc30 = TO_DCN30_MPC(mpc);
-	uint32_t last_base_value_red = rgb[num-1].red_reg + rgb[num-1].delta_red_reg;
-	uint32_t last_base_value_green = rgb[num-1].green_reg + rgb[num-1].delta_green_reg;
-	uint32_t last_base_value_blue = rgb[num-1].blue_reg + rgb[num-1].delta_blue_reg;
-
-	/*the entries of DCN3AG gamma LUTs take 18bit base values as opposed to
-	 *38 base+delta values per entry in earlier DCN architectures
-	 *last base value for our lut is compute by adding the last base value
-	 *in our data + last delta
-	 */
 
 	if (is_rgb_equal(rgb,  num)) {
 		for (i = 0 ; i < num; i++)
 			REG_SET(MPCC_OGAM_LUT_DATA[mpcc_id], 0, MPCC_OGAM_LUT_DATA, rgb[i].red_reg);
-
-		REG_SET(MPCC_OGAM_LUT_DATA[mpcc_id], 0, MPCC_OGAM_LUT_DATA, last_base_value_red);
-
 	} else {
 
 		REG_UPDATE(MPCC_OGAM_LUT_CONTROL[mpcc_id],
@@ -302,8 +290,6 @@ static void mpc3_program_ogam_pwl(
 		for (i = 0 ; i < num; i++)
 			REG_SET(MPCC_OGAM_LUT_DATA[mpcc_id], 0, MPCC_OGAM_LUT_DATA, rgb[i].red_reg);
 
-		REG_SET(MPCC_OGAM_LUT_DATA[mpcc_id], 0, MPCC_OGAM_LUT_DATA, last_base_value_red);
-
 		REG_SET(MPCC_OGAM_LUT_INDEX[mpcc_id], 0, MPCC_OGAM_LUT_INDEX, 0);
 
 		REG_UPDATE(MPCC_OGAM_LUT_CONTROL[mpcc_id],
@@ -312,8 +298,6 @@ static void mpc3_program_ogam_pwl(
 		for (i = 0 ; i < num; i++)
 			REG_SET(MPCC_OGAM_LUT_DATA[mpcc_id], 0, MPCC_OGAM_LUT_DATA, rgb[i].green_reg);
 
-		REG_SET(MPCC_OGAM_LUT_DATA[mpcc_id], 0, MPCC_OGAM_LUT_DATA, last_base_value_green);
-
 		REG_SET(MPCC_OGAM_LUT_INDEX[mpcc_id], 0, MPCC_OGAM_LUT_INDEX, 0);
 
 		REG_UPDATE(MPCC_OGAM_LUT_CONTROL[mpcc_id],
@@ -322,7 +306,6 @@ static void mpc3_program_ogam_pwl(
 		for (i = 0 ; i < num; i++)
 			REG_SET(MPCC_OGAM_LUT_DATA[mpcc_id], 0, MPCC_OGAM_LUT_DATA, rgb[i].blue_reg);
 
-		REG_SET(MPCC_OGAM_LUT_DATA[mpcc_id], 0, MPCC_OGAM_LUT_DATA, last_base_value_blue);
 	}
 
 }
-- 
2.37.3

