Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9383C021B5
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 15:58:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5183D10EAD1;
	Fri, 21 Feb 2025 15:58:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="id3qkp2K";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A7A210EACD
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 15:57:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AONsi6i22ZWW5y3bUmrVo6pzPJPaB48GkAJTqaLaR8bq8fpaSqRYnRDx1AjQOwtbRrfAuo/RI3AS8eQmbHpXe2s6Qxu+FBA3h6OjX/7fnXiLHPfKJSfD1U7yr5yiU5z+XYC24okYFdFGC2iOyGE1goP87p459rHA8qlZU2enUgt5H9ioDAbqr9iTZZb0ljrhXsuZRWDURg9tKFKllmAj+J6Sw5ec8iQ9sSRSGzb4Lx8th9RPzkAH3oxFUVLhd1bIfAS8ciliFOqrHNQkGVz3j5Tvyzl/coI4HRqT9lJb1ft5aMUOK285nm8zo1Citsz6tsxIvFc58a+FJBXKr4C5eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6fYoYWjHT8qHOpxP24OGqdDXxwZV6FMJOuT1zJipXE=;
 b=x9nLN3POdUQMaSp0EA+Kgd9G9bm7IhOFEksArfEqlouI2x+sIjbWFHR6UM577GwRGHVyLeLQG9ZseSsbJspLaw62+IpFkI+ntvsSkhgbU9yKnuAAcX6qt8O5d5vgJlp6PzXlnHNHuQxoZ6QI+iDAxs3kABFfWZwCSio2a4UwTWTbhzUEKiVMq6kxNnSCdpFBb+ij9iNlZQ0YHDy2xCE8LwGBBG0wVWnl2V/wO33A2kN8hXAgcDmBupf0UKdfEykTxS4lhZRs+bnqwgkYgY+klEsN5WMcCurHn/GyJIXEMUhGlLlnr7ZWCEhQIJamL+31alY6aFSrYuKwefaTvn7klw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6fYoYWjHT8qHOpxP24OGqdDXxwZV6FMJOuT1zJipXE=;
 b=id3qkp2KcjFkrhL86SpSbDzEXg/a5v28sUx1QU3TmOAsYda/QMZUmmif/d7g5lxlybghD+rJRW5AydiB6SobFIyLUL/r25PisXo5kJLMLAKuWVDHYRi+RkKqGMLitgCVcmKrXzszmjfwrjVgGrksDdt3lowzOalR9cmip2LMpWQ=
Received: from BN8PR15CA0062.namprd15.prod.outlook.com (2603:10b6:408:80::39)
 by CY8PR12MB9035.namprd12.prod.outlook.com (2603:10b6:930:77::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Fri, 21 Feb
 2025 15:57:54 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:408:80:cafe::67) by BN8PR15CA0062.outlook.office365.com
 (2603:10b6:408:80::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Fri,
 21 Feb 2025 15:57:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 15:57:53 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 09:57:51 -0600
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Navid Assadian <Navid.Assadian@amd.com>, Samson Tam
 <Samson.Tam@amd.com>
Subject: [PATCH 06/24] drm/amd/display: Add opp recout adjustment
Date: Fri, 21 Feb 2025 10:57:03 -0500
Message-ID: <20250221155721.1727682-7-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221155721.1727682-1-zaeem.mohamed@amd.com>
References: <20250221155721.1727682-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|CY8PR12MB9035:EE_
X-MS-Office365-Filtering-Correlation-Id: 85661596-9530-42ff-c698-08dd52908029
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Sc0Vhwp+coPSgajWGXWLfT8F3u2o6ltqDP90Yf6cYaUgSxDGnQ6oRifuGSd0?=
 =?us-ascii?Q?zFrYqpL/WLvX2lwaepozlzNfb+wbCQ0IHdzo4kqEYdFdbB6KFzfnZQWrE4aj?=
 =?us-ascii?Q?7VdwpVfZPwag5P1Xh/iK89AtSoBUGwzhK4+D1ymle4VNZ0ruJHpJM2ooW6Wt?=
 =?us-ascii?Q?WZShPacMfEYi2B3PFCdwJgHsVgF5xoagcNOvDtuV6R1nJhdQFu+u2++rwjW0?=
 =?us-ascii?Q?G/0IHgHCdtc0kBOayU7zbtoTRU1B8dMDPWQuZ3OAMAs1Pp03vzPnU2Sdy85N?=
 =?us-ascii?Q?nnErpW+DKprTSU+8SWNr2RnVAUjHFV0zFUDC6ndwzMKP84d4RpTnT2S1Vqq6?=
 =?us-ascii?Q?FuuX97AebVrULdKK5ADXupZbCTT+dhKxG/Y0XQt47+PbmiAgGSiLxtFrn4K3?=
 =?us-ascii?Q?Qnma1WbLS7As96rRTmoXlucvWMEnEvstE8oLhhgyHX4nf/RZQKesYgCuRXBB?=
 =?us-ascii?Q?6q6aoxB6L1MdRsC07Re1G7LB2Zx9aG2HPWv6b8Ca4MZtgFMF2Eko++UFB51S?=
 =?us-ascii?Q?YwfiY3O0Foct1IHN3l9WedzYG8dO6HRuYtbN/kvpGpku8fqDkYA5mYapT/ZV?=
 =?us-ascii?Q?QUkFqc7sb1yNDlKM5s1lmSQgE88geluZdq2lbmB3yCb+oKxHf/eig8134tgv?=
 =?us-ascii?Q?XG8Mmqz03bVfKBtt+ny3MgbxoHFfYtB66rQArGg6mqYqMV6AelkjpZT0Ko67?=
 =?us-ascii?Q?C7V32tzTFyYsnhOmKLacg7DwKjMN3i58P/R69JMGaFJ0aOujKTlhgx2CYyTY?=
 =?us-ascii?Q?Gp59N/OpVCzrsXP9HZ784CuCSvwt3swHZkfDZsBbbnA9RhWkthgfcp3ayOmz?=
 =?us-ascii?Q?qa9rknQefHfVPrBxFM/1C7YSXeT1mFKlDCHzTftbTs5tyh/T/+UzrMeWRw+D?=
 =?us-ascii?Q?z4Px+YqIA9FhRrZfvrpUYJCqYjXs1FhkUd8wX0OpgQ386eCyT6y1vcP/3QOk?=
 =?us-ascii?Q?bWO7DSw00/21UDDFl5G3sKQ1QRWnK5oXPdFsCuVXHRmHX1NBm7Q0Cb/uAbpQ?=
 =?us-ascii?Q?rCNJvTzEsZsAfl32sHTnhu1iHtWVDeN2sxpY2vwo/veWPZI+3D/RaFvOCIcW?=
 =?us-ascii?Q?PerldxmG7m9k+uyNkp8kZECNVwurK28zkdTwKCbx+zEMRH0t6HovlZ+Rr0vs?=
 =?us-ascii?Q?9uHKaQESOBUYhiOdAZnr9aH1XiCnPbVu7Vx0YZAvLS/UmK2gIQzkzvv9pB6X?=
 =?us-ascii?Q?XgqsnYWgWSjFocH02DM4YjjK3IYNzL1aYTmZeevqXDAhiXbwq9I/rfAIB5xz?=
 =?us-ascii?Q?gr0dQGJVsS32XkHBSrJXKPA5EsEKJiurhnkUQ1ib82zBIkbHSxVpxacRdz20?=
 =?us-ascii?Q?CC0cOtespgD9bCWfP5f4oN8Vv0vfJGTG414vyBzDFGanzAWJ780SXS+wLihx?=
 =?us-ascii?Q?P0cNHWqsFin3bKNEZR4y3/8bdM2D9ReEFZPxxHYYLUbW9srS6+IVqkCY0aNq?=
 =?us-ascii?Q?BjU32igZ+RMGLxMRW5uJWX1xqyu5AasgRdwSJw0d9OVIcHB2mTXewLlD65I5?=
 =?us-ascii?Q?fxvwZoSWUjQLhKQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 15:57:53.4686 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85661596-9530-42ff-c698-08dd52908029
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB9035
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

From: Navid Assadian <Navid.Assadian@amd.com>

[Why]
For subsampled YUV output formats, more pixels can get fetched and be
used for scaling.

[How]
Add the adjustment to the calculated recout, so the viewport covers the
corresponding pixels on the source plane.

Signed-off-by: Navid Assadian <Navid.Assadian@amd.com>
Reviewed-by: Samson Tam <Samson.Tam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c  | 31 +++++++++++++++----
 .../drm/amd/display/dc/sspl/dc_spl_types.h    | 10 ++++++
 2 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
index 31495c9978b0..72a79288ab79 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
+++ b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
@@ -76,6 +76,21 @@ static struct spl_rect shift_rec(const struct spl_rect *rec_in, int x, int y)
 	return rec_out;
 }
 
+static void spl_opp_adjust_rect(struct spl_rect *rec, const struct spl_opp_adjust *adjust)
+{
+	if ((rec->x + adjust->x) >= 0)
+		rec->x += adjust->x;
+
+	if ((rec->y + adjust->y) >= 0)
+		rec->y += adjust->y;
+
+	if ((rec->width + adjust->width) >= 1)
+		rec->width += adjust->width;
+
+	if ((rec->height + adjust->height) >= 1)
+		rec->height += adjust->height;
+}
+
 static struct spl_rect calculate_plane_rec_in_timing_active(
 		struct spl_in *spl_in,
 		const struct spl_rect *rec_in)
@@ -723,13 +738,15 @@ static void spl_handle_3d_recout(struct spl_in *spl_in, struct spl_rect *recout)
 	}
 }
 
-static void spl_clamp_viewport(struct spl_rect *viewport)
+static void spl_clamp_viewport(struct spl_rect *viewport, int min_viewport_size)
 {
+	if (min_viewport_size == 0)
+		min_viewport_size = MIN_VIEWPORT_SIZE;
 	/* Clamp minimum viewport size */
-	if (viewport->height < MIN_VIEWPORT_SIZE)
-		viewport->height = MIN_VIEWPORT_SIZE;
-	if (viewport->width < MIN_VIEWPORT_SIZE)
-		viewport->width = MIN_VIEWPORT_SIZE;
+	if (viewport->height < min_viewport_size)
+		viewport->height = min_viewport_size;
+	if (viewport->width < min_viewport_size)
+		viewport->width = min_viewport_size;
 }
 
 static enum scl_mode spl_get_dscl_mode(const struct spl_in *spl_in,
@@ -1764,6 +1781,8 @@ static bool spl_calculate_number_of_taps(struct spl_in *spl_in, struct spl_scrat
 	spl_calculate_recout(spl_in, spl_scratch, spl_out);
 	/* depends on pixel format */
 	spl_calculate_scaling_ratios(spl_in, spl_scratch, spl_out);
+	/* Adjust recout for opp if needed */
+	spl_opp_adjust_rect(&spl_scratch->scl_data.recout, &spl_in->basic_in.opp_recout_adjust);
 	/* depends on scaling ratios and recout, does not calculate offset yet */
 	spl_calculate_viewport_size(spl_in, spl_scratch);
 
@@ -1800,7 +1819,7 @@ bool spl_calculate_scaler_params(struct spl_in *spl_in, struct spl_out *spl_out)
 	// Handle 3d recout
 	spl_handle_3d_recout(spl_in, &spl_scratch.scl_data.recout);
 	// Clamp
-	spl_clamp_viewport(&spl_scratch.scl_data.viewport);
+	spl_clamp_viewport(&spl_scratch.scl_data.viewport, spl_in->min_viewport_size);
 
 	// Save all calculated parameters in dscl_prog_data structure to program hw registers
 	spl_set_dscl_prog_data(spl_in, &spl_scratch, spl_out, enable_easf_v, enable_easf_h, enable_isharp);
diff --git a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_types.h b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_types.h
index 467af9dd90de..0130673ceee6 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_types.h
+++ b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_types.h
@@ -427,6 +427,14 @@ struct spl_out	{
 
 // SPL inputs
 
+// opp extra adjustment for rect
+struct spl_opp_adjust {
+	int x;
+	int y;
+	int width;
+	int height;
+};
+
 // Basic input information
 struct basic_in	{
 	enum spl_pixel_format format; // Pixel Format
@@ -444,6 +452,7 @@ struct basic_in	{
 		} num_slices_recout_width;
 	} num_h_slices_recout_width_align;
 	int mpc_h_slice_index; // previous mpc_combine_v - split_idx
+	struct spl_opp_adjust opp_recout_adjust;
 	// Inputs for adaptive scaler - TODO
 	enum spl_transfer_func_type tf_type; /* Transfer function type */
 	enum spl_transfer_func_predefined tf_predefined_type; /* Transfer function predefined type */
@@ -535,6 +544,7 @@ struct spl_in	{
 	bool is_hdr_on;
 	int h_active;
 	int v_active;
+	int min_viewport_size;
 	int sdr_white_level_nits;
 	enum sharpen_policy sharpen_policy;
 };
-- 
2.34.1

