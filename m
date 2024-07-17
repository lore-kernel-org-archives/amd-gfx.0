Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EFB0C3DA62
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jul 2024 19:40:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A4A610E3A2;
	Wed, 17 Jul 2024 19:40:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3Ff5/9ts";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E77F310E3AE
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jul 2024 19:40:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wFYyYKTJIoolJcTmcBH8XcY9fbZQoRBnk73CuehgpgdplRRBR/txoD3xe5n+Gd3TorqpHoAEVVmesM2TJGzSvX4B5ypCN+Y+wsaafALoA0vOrhJWhcTsZXAnbDouyAV5RC2nOymWMUwELR91LEv38p3rFhME/hJx0bixjTbBahXOB4v1gS9jK4DBZLcbQ3ux2Gg1Eo8OJaBwdtS1L1ZuCtteVY8A83zUrfQSpAyO7uoIiaip0G60SBiDI9GWB10s93n5QH7JsF47FtUy65UCbJL2X7kmrBiaxKzSlqAW8V4itK0NNgfW9M06t0MIo5J8JUUe+QwPpKUBt/WG2MOCsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+5WdOJdLhyrIZclYZpw5FVfHyNQkiIRWFaAeoKKt+I=;
 b=ApvhNpYMiP4+eR4Rb7gYwbGzaJlBaDtbu8k0EK16nmyQzDM89b12t7rgTuDvfiULRIcnOPoNGsRP/Hdmhab3uRybvuYfCKTx0VfEeEMC2a8Chl+L3QkS+W/VbjJPuYSnWO54AyXedRMDrbkH5EInvp910E84ZikPNRncMtSciZwURz8tIk3J5nC8MiK4P/Ga5wvFpQE0J7zB0OrP0OZ3maB4q5DorAewWylr6yvKNQaX9DpgaGMQinq5REOcfyOCvjtdtBYAHarpbdbiFnNimsPsQhxdVdiRmto1fK48wHTwLbwMzTQf9xUDhiGUWK4o/hCYSVdJEFPf2JhWIk+lnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+5WdOJdLhyrIZclYZpw5FVfHyNQkiIRWFaAeoKKt+I=;
 b=3Ff5/9tsF+yo7kOXbFy0Ywp/wpbGL/G89htkr4t4jo9bcVMQ427hTtgM/4WQRYawXeLj0+hqZkK2IXBfP63yCRz7B0if5uSEfW7WsaiWPGnLefZ03JPGWnt2WPMnTeY899fq2LppzJPSer5qPaUVmgNKeEoUjkgldeDQ0Vpm+Go=
Received: from CH0PR03CA0355.namprd03.prod.outlook.com (2603:10b6:610:11a::12)
 by MW3PR12MB4411.namprd12.prod.outlook.com (2603:10b6:303:5e::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 17 Jul
 2024 19:40:01 +0000
Received: from DS3PEPF0000C37C.namprd04.prod.outlook.com
 (2603:10b6:610:11a:cafe::77) by CH0PR03CA0355.outlook.office365.com
 (2603:10b6:610:11a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Wed, 17 Jul 2024 19:40:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF0000C37C.mail.protection.outlook.com (10.167.23.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Wed, 17 Jul 2024 19:40:00 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 14:39:59 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 14:39:59 -0500
Received: from debian.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 17 Jul 2024 14:39:53 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Samson Tam
 <samson.tam@amd.com>, Alvin Lee <alvin.lee2@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
Subject: [PATCH 08/22] drm/amd/display: ensure EASF and ISHARP coefficients
 are programmed together
Date: Wed, 17 Jul 2024 19:38:47 +0000
Message-ID: <20240717193901.8821-9-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240717193901.8821-1-aurabindo.pillai@amd.com>
References: <20240717193901.8821-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37C:EE_|MW3PR12MB4411:EE_
X-MS-Office365-Filtering-Correlation-Id: 3373ba61-1527-4680-0fe1-08dca6983f2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gzA+l2Te+Z7NS9fD3PWh4VCSDqAT4XKf21qAZSgkkYNCO0GE937uVSnEzQE/?=
 =?us-ascii?Q?VpcNoae75ThWz7nj1s3xeDqWaf5dMs2tVD8XXTUoylJke7z4D1BBl2pgOcb/?=
 =?us-ascii?Q?rJtoNVbn/yYQ5awVCbIuxc/JfR76aQIg6uALmkd/zsYzoNea9BEcS2WMdZYk?=
 =?us-ascii?Q?Az96yiRx1le775gTAuxeTy0A8jm0jLTnnFqb/VPhjLHCrMW7EZ3nD+oqBJjS?=
 =?us-ascii?Q?tLXiOxzJqRQ58oLIIkpHTIciS7Ci1Mml8HekXucB4VDv2+BlfAeIBlwjfl6P?=
 =?us-ascii?Q?kDgSVLZd01vT08LWv45aO5PRntrq37OQOxf+G7DYRMr8d+glIiFtOstFGs0W?=
 =?us-ascii?Q?N5VcSYAu/sTfZw66/zvfU10kl5fv7nojVP2Ze7xNYuVbruEhyWIQsah7/GQW?=
 =?us-ascii?Q?Gy6H7ORBcp9yokxuxrgZGD3JeoyZdeEGHcLp5yQnvtSZcpotsg9drTtJ5ACi?=
 =?us-ascii?Q?DLjMqPSyGQOIR7qKr0zrFfT+8B0OU0GVBe+ax3ENm34jcBJBKw3xPcKSbKnu?=
 =?us-ascii?Q?AAAcfXexv9vMdQuX7ajfc6Fx//F55piEUoWR6tIhG1QDrV9mKgKP65Thg78u?=
 =?us-ascii?Q?dB+PZ8D5rGvVu7JZw3oU8ja4GGIdsr6G93S7wJs3C2y9uGzS4dkDcijMuWm7?=
 =?us-ascii?Q?X3pwS/uPHLiN0jxz2jOSjupwNjjU0u1aCAtoxBLxN/Qf8a+Fm33HBsMk5PPC?=
 =?us-ascii?Q?w3Vwq6e+W928sFA0uJB3kY4FuaOXrV1qvi4psZwL+9nFc6u6Bn+SGSBMJzRX?=
 =?us-ascii?Q?/qGdmM1hwdU4IMeory2gM1QhhkLS0Ox8jvPPuWeyx/vNIgyhBRSpxiUbfiS1?=
 =?us-ascii?Q?/XocFUlgwajjEv0I4MuhAcOQGDCCHQn60oSopahivdXjCPU92QF76ylgORbV?=
 =?us-ascii?Q?SyJhsE4V9xHdg70xwCTHBqoZyIljdA+SSeGQ6DHdV6mqlSXxDexZqSbrRzBk?=
 =?us-ascii?Q?bL/WbbJgaiInpNwhCw6E3zEqkSFnuq+6YhqfWMEIdn6uO+hwnCeQphYvC1V6?=
 =?us-ascii?Q?0j1G/Xq3pRYxOclpKoYPahyREfv/xf3sPpw5B9+LiPfBOoV7GpuM+lr1bhqa?=
 =?us-ascii?Q?+G4pYiq8UH4sd9DoT5vqvcnh4pBhzDpbeZYXzWtU7zwvToutC+9qLwVLAl/U?=
 =?us-ascii?Q?TApv0Uxvuj8r1XiBcbzb9PPv/yk78SOMrdUF4FzeSFmG/Px6Imno17adzXRP?=
 =?us-ascii?Q?Uz+gmj8GRU2A6tYcc4Djg5aDtzhzBGVoXVi6u2FyGeY9MGxTnVkl05FPLnyG?=
 =?us-ascii?Q?uXjfp85AOn1d4ALdjL0ilny6O6WhLlEvU1D7FtNBTF5ab4n2aYI2JaSiN3Xi?=
 =?us-ascii?Q?maiNL0qnAL7PgAs8t9IJvMxtJLMi2rM0YKDAepYWGb09uMyyBFVxliadwK70?=
 =?us-ascii?Q?Laz0I7QgMa/ihjwcJ6t+gMZlBj8h9/cX/Bu+lOiRG25RbFnRrEDctOdg78Wz?=
 =?us-ascii?Q?cB//HYiZmIPRHHXAt6RSJU2Pchc1AvFQ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 19:40:00.3831 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3373ba61-1527-4680-0fe1-08dca6983f2d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4411
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

From: Samson Tam <samson.tam@amd.com>

[Why]
EASF coefficients are programmed to RAM and then RAM selector is toggled.
 ISHARP coefficients are programmed after so they will not be in the same
 RAM block

[How]
Move ISHARP programming before EASF programming
Add flag if ISHARP coefficients are updated.  If so, then
 force EASF coefficients programming

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Samson Tam <samson.tam@amd.com>
---
 .../display/dc/dpp/dcn401/dcn401_dpp_dscl.c   | 28 +++++++++++++------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
index 27cbda1cf8cf..703d7b51c6c2 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
@@ -280,7 +280,8 @@ static void dpp401_dscl_set_scaler_filter(
 static void dpp401_dscl_set_scl_filter(
 		struct dcn401_dpp *dpp,
 		const struct scaler_data *scl_data,
-		bool chroma_coef_mode)
+		bool chroma_coef_mode,
+		bool force_coeffs_update)
 {
 	bool h_2tap_hardcode_coef_en = false;
 	bool v_2tap_hardcode_coef_en = false;
@@ -343,7 +344,7 @@ static void dpp401_dscl_set_scl_filter(
 							|| (filter_v_c && (filter_v_c != dpp->filter_v_c));
 		}
 
-		if (filter_updated) {
+		if ((filter_updated) || (force_coeffs_update)) {
 			uint32_t scl_mode = REG_READ(SCL_MODE);
 
 			if (!h_2tap_hardcode_coef_en && filter_h) {
@@ -955,9 +956,11 @@ static void dpp401_dscl_set_isharp_filter(
  *
  */
 static void dpp401_dscl_program_isharp(struct dpp *dpp_base,
-		const struct scaler_data *scl_data)
+		const struct scaler_data *scl_data,
+		bool *bs_coeffs_updated)
 {
 	struct dcn401_dpp *dpp = TO_DCN401_DPP(dpp_base);
+	*bs_coeffs_updated = false;
 
 	PERF_TRACE();
 	/* ISHARP_MODE */
@@ -1030,12 +1033,14 @@ static void dpp401_dscl_program_isharp(struct dpp *dpp_base,
 				dpp, scl_data->taps.v_taps,
 				SCL_COEF_VERTICAL_BLUR_SCALE,
 				scl_data->dscl_prog_data.filter_blur_scale_v);
+			*bs_coeffs_updated = true;
 		}
 		if (scl_data->dscl_prog_data.filter_blur_scale_h) {
 			dpp401_dscl_set_scaler_filter(
 				dpp, scl_data->taps.h_taps,
 				SCL_COEF_HORIZONTAL_BLUR_SCALE,
 				scl_data->dscl_prog_data.filter_blur_scale_h);
+			*bs_coeffs_updated = true;
 		}
 	}
 	PERF_TRACE();
@@ -1066,6 +1071,7 @@ void dpp401_dscl_set_scaler_manual_scale(struct dpp *dpp_base,
 			dpp_base, scl_data, dpp_base->ctx->dc->debug.always_scale);
 	bool ycbcr = scl_data->format >= PIXEL_FORMAT_VIDEO_BEGIN
 				&& scl_data->format <= PIXEL_FORMAT_VIDEO_END;
+	bool bs_coeffs_updated = false;
 
 	if (memcmp(&dpp->scl_data, scl_data, sizeof(*scl_data)) == 0)
 		return;
@@ -1125,7 +1131,7 @@ void dpp401_dscl_set_scaler_manual_scale(struct dpp *dpp_base,
 	if (dscl_mode == DSCL_MODE_SCALING_444_BYPASS) {
 		if (dpp->base.ctx->dc->config.prefer_easf)
 			dpp401_dscl_disable_easf(dpp_base, scl_data);
-		dpp401_dscl_program_isharp(dpp_base, scl_data);
+		dpp401_dscl_program_isharp(dpp_base, scl_data, &bs_coeffs_updated);
 		return;
 	}
 
@@ -1152,12 +1158,18 @@ void dpp401_dscl_set_scaler_manual_scale(struct dpp *dpp_base,
 		SCL_V_NUM_TAPS_C, v_num_taps_c,
 		SCL_H_NUM_TAPS_C, h_num_taps_c);
 
-	dpp401_dscl_set_scl_filter(dpp, scl_data, ycbcr);
+	/* ISharp configuration
+	 * - B&S coeffs are written to same coeff RAM as WB scaler coeffs
+	 * - coeff RAM toggle is in EASF programming
+	 * - if we are only programming B&S coeffs, then need to reprogram
+	 *   WB scaler coeffs and toggle coeff RAM together
+	 */
+	//if (dpp->base.ctx->dc->config.prefer_easf)
+	dpp401_dscl_program_isharp(dpp_base, scl_data, &bs_coeffs_updated);
+
+	dpp401_dscl_set_scl_filter(dpp, scl_data, ycbcr, bs_coeffs_updated);
 	/* Edge adaptive scaler function configuration */
 	if (dpp->base.ctx->dc->config.prefer_easf)
 		dpp401_dscl_program_easf(dpp_base, scl_data);
-	/* isharp configuration */
-	//if (dpp->base.ctx->dc->config.prefer_easf)
-	dpp401_dscl_program_isharp(dpp_base, scl_data);
 	PERF_TRACE();
 }
-- 
2.39.2

