Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8048AE6B27F
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Nov 2024 13:50:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD90810E9C8;
	Fri,  1 Nov 2024 13:50:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DC0omhFp";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B897A10E9C6
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Nov 2024 13:50:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XCtBlV8SRlPa7CgRg7Zx/tvMppVEaDzzNGHliiJRj0srSETPmp0n56WkwWTOL/KhNpheZm/HX7Nx6pbpZRHRNi+oCXQ/Frm7/AO1SCuki08nLEWei1Ud1WlWBehVv+U2YWZwGUvE9ONLAdIHKnNEK9LC8c+5YaVSSxaz8lqR9kNjK6ia5sY/a7/r9bHOxOBz/tS9bRwlJw85FJk7aDCtU1go8bMxeH7y1zjAX92ruAC4vlzJ9WZI0lNkhtPJezh2tE/VtjKV0PvQLrJgr2UzhfDUnD0OK0uVaFYTq5BAWjVzLJ1KmgStWbTudQEfJsM6WCwdopiIsLK9Iznz8LjhoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n326qJQtNaqxhO0O+8RbcRGf273WWnr3PFbo9heYjUc=;
 b=GwrOiRvLrdKnxztQNLp1FmSfVcHJgX6HlwriDI+oc2kX7zzTvyctcSAdWdACx1c7Y5A8vnwiE/eaLw/EdMzSo6R7XwlZDpstyedMTQ9ntOZCzKzlrGnCH273VbBZFaZJXK8e/FcaS3mkrBt/iYYRQXFAroi/uOyq4mJ7n2+d5PfGpcvxxPb9Y87QL444QRDDfV/utOFxkzJ03X6Yf9NGBwSrkUqJu9XyS6GjwejOQ9PXwe/9pxcKD/bgP5PSL743c9cxluI5ND6t3m/gSKLVIGPJcXkyeiAeqG+ILPJlSpjooG/69eoGpup3ykM5UpX8t7gmzDvPhtwfq2CTnvpI5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n326qJQtNaqxhO0O+8RbcRGf273WWnr3PFbo9heYjUc=;
 b=DC0omhFp06uc36bVX6p1n50qYl1Ryn+ZK1UBl6vFvQDWynGCS9QoxUp+DvoxUycycU6XKl9DDKqv/pBglaE+Lb44UpXMQFsgyVO0O1/vfPbm4WniMh9MsDxkV32+Ooq18a99doesrm9SJXoqhvd92ehWHUQ+Y/wYKtqj1MY5W/A=
Received: from BN0PR02CA0030.namprd02.prod.outlook.com (2603:10b6:408:e4::35)
 by IA1PR12MB8359.namprd12.prod.outlook.com (2603:10b6:208:3fc::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Fri, 1 Nov
 2024 13:50:14 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:e4:cafe::9c) by BN0PR02CA0030.outlook.office365.com
 (2603:10b6:408:e4::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.25 via Frontend
 Transport; Fri, 1 Nov 2024 13:50:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Fri, 1 Nov 2024 13:50:13 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Nov
 2024 08:50:12 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Samson Tam <Samson.Tam@amd.com>, Navid Assadian
 <Navid.Assadian@amd.com>
Subject: [PATCH 08/17] drm/amd/display: SPL cleanup
Date: Fri, 1 Nov 2024 09:49:31 -0400
Message-ID: <20241101134940.1426653-9-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241101134940.1426653-1-zaeem.mohamed@amd.com>
References: <20241101134940.1426653-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|IA1PR12MB8359:EE_
X-MS-Office365-Filtering-Correlation-Id: 1081d952-10ca-47bc-8bc3-08dcfa7c1c72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ASM83oKBqef66nhGtWgWFs2Q8y4jhRGBPuYi4fE6UlnPQeKFZGYmCopyYLQT?=
 =?us-ascii?Q?42WfV245JUk6QhCrUdmhKBhJrEaLir9SR5YhS1lzmDU/FQaWLG/vNu4z/PCg?=
 =?us-ascii?Q?IpGQz+yymfXQmMgI9CEw8XuFh1Xmkxwg6olT0lU1OuAsc0uQvZ5m+O356Msy?=
 =?us-ascii?Q?6qYzlg26pkupV57BwYdF158WYKwFwUzOCQdbHDUagkBSh+aSQZ9Q9r7yfFUe?=
 =?us-ascii?Q?ocS5M6VmX9MS4WuDNu014egcNv9Ac6hAJxlGrz4KKDz+v/1Oavxyq7pvpmbn?=
 =?us-ascii?Q?VqpWSK8OW+G5azJWG4Qw0W5GZ7zucBaUsmU4LRhp5k5E9BEorV7khn+pGTXW?=
 =?us-ascii?Q?0HFkPAyAmZBYM6qRzi+UBatwCWQvHxpOKCM4BipKM/gJeCeXxKckwMCnSbLZ?=
 =?us-ascii?Q?HWttlbd6jaMBT/sn/iB3CSQlF6RYLSmwq7kaLW55I6h7ZzVGT2Fm7Y6+o90t?=
 =?us-ascii?Q?YXh/J7U64GwJBurOKwmunvkvgeSOKDCKGbNPUS/ygfN1cgxVBephI1DWoW21?=
 =?us-ascii?Q?2RXd7Z21DUsYEUZVbK0CZ4737Zyi3f8NYku3sVr70jwcDAREI6SXT3ou2xzw?=
 =?us-ascii?Q?9y5ZUrF5nbVNxeFIGLSRNTDQ2xd2o7OchjgaDwK+EVd+Q7l125FcyyjIwVX7?=
 =?us-ascii?Q?mLF9kLEI9KHy5GngU4JuzOIfFHimzvOGDJ8Uj4qWT1D4RsTpGy982pMbKqU+?=
 =?us-ascii?Q?mmp2L22YQAhJZHy2dATQVZKgo7AaBeiASdQppWlE8Q5lVMUQUdYAVTjagJmM?=
 =?us-ascii?Q?KjZM43tIKb1xO9m8TAh1QRa/gCMnLq0FpVg4/1GyFALdQh5Y0KXcKBeF9TBL?=
 =?us-ascii?Q?fvrM+pLE5vK/Ban0zzefJYMknOoUEc4XAgp7G1MyHLAdBET8D6I5nlN4UEpA?=
 =?us-ascii?Q?Fo3de93GZI4HVIn8UaXpdH8ekEBQGPqqUgZbggXXA0+HC5+5OLDFSNHpTEsN?=
 =?us-ascii?Q?LsuhDbPM0B5CCN8JW8DUARQrXm6+urqcr8lLohOm96mDWHWjdDs4ATzLHaZO?=
 =?us-ascii?Q?iSGWy4cremc88MyV3y+9+SUBgvrmXqMwqXnp4LNCf7yDcwAsJGdbFoTQS29B?=
 =?us-ascii?Q?VVJbw/gBNry9PdK/TzpHi1ZFCJeUJh6LAGr2qG47ljUTkgFTmfPtQPGFJAdP?=
 =?us-ascii?Q?5pLH9Ih3eCw8rtyrcyXTW6MAZQIOl5nYbaNdSKZqdZ4pHzBuBz4XY2IgvwP7?=
 =?us-ascii?Q?0r5drZCKJbvrhmv5/iJtqR50YK7RismEfojhDp6EeVQGI0cx3zFjvs0kzlMI?=
 =?us-ascii?Q?MamX+RpSwLvc/bLUkiE7GWKrHhhkyk6Yf0KGZn96SXMUPAvnZXqclPLmLnWb?=
 =?us-ascii?Q?QFgB1zvugidm4gZtkI9HFaziPeC0byN/30jB2lBQsM4v3x9J30pRMsVZfGs4?=
 =?us-ascii?Q?8XtJ7SqwZS3dqTquNX8GRmXDA2XrT0mmAvKdN+mvG6Nn4Ejh7g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 13:50:13.9144 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1081d952-10ca-47bc-8bc3-08dcfa7c1c72
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8359
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

[Why & How]
Move from pointer to callback to reference callback directly
Missed renaming fixpt functions with spl prefix

Reviewed-by: Navid Assadian <Navid.Assadian@amd.com>
Signed-off-by: Samson Tam <Samson.Tam@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 .../gpu/drm/amd/display/dc/dc_spl_translate.c | 14 ++++----
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.c   |  2 +-
 .../gpu/drm/amd/display/dc/spl/dc_spl_types.h |  4 +--
 .../drm/amd/display/dc/spl/spl_fixpt31_32.c   | 34 +++++++++----------
 4 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c b/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
index 24aa9df892f3..c8d8e335fa37 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
@@ -8,13 +8,13 @@
 #include "dcn32/dcn32_dpp.h"
 #include "dcn401/dcn401_dpp.h"
 
-static struct spl_funcs dcn2_spl_funcs = {
+static struct spl_callbacks dcn2_spl_callbacks = {
 	.spl_calc_lb_num_partitions = dscl2_spl_calc_lb_num_partitions,
 };
-static struct spl_funcs dcn32_spl_funcs = {
+static struct spl_callbacks dcn32_spl_callbacks = {
 	.spl_calc_lb_num_partitions = dscl32_spl_calc_lb_num_partitions,
 };
-static struct spl_funcs dcn401_spl_funcs = {
+static struct spl_callbacks dcn401_spl_callbacks = {
 	.spl_calc_lb_num_partitions = dscl401_spl_calc_lb_num_partitions,
 };
 static void populate_splrect_from_rect(struct spl_rect *spl_rect, const struct rect *rect)
@@ -77,16 +77,16 @@ void translate_SPL_in_params_from_pipe_ctx(struct pipe_ctx *pipe_ctx, struct spl
 	// This is used to determine the vtap support
 	switch (plane_state->ctx->dce_version)	{
 	case DCN_VERSION_2_0:
-		spl_in->funcs = &dcn2_spl_funcs;
+		spl_in->callbacks = dcn2_spl_callbacks;
 		break;
 	case DCN_VERSION_3_2:
-		spl_in->funcs = &dcn32_spl_funcs;
+		spl_in->callbacks = dcn32_spl_callbacks;
 		break;
 	case DCN_VERSION_4_01:
-		spl_in->funcs = &dcn401_spl_funcs;
+		spl_in->callbacks = dcn401_spl_callbacks;
 		break;
 	default:
-		spl_in->funcs = &dcn2_spl_funcs;
+		spl_in->callbacks = dcn2_spl_callbacks;
 	}
 	// Make format field from spl_in point to plane_res scl_data format
 	spl_in->basic_in.format = (enum spl_pixel_format)pipe_ctx->plane_res.scl_data.format;
diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c b/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
index 9095da7b842b..a29a9f131e04 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
+++ b/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
@@ -981,7 +981,7 @@ static bool spl_get_optimal_number_of_taps(
 	else
 		lb_config = LB_MEMORY_CONFIG_0;
 	// Determine max vtap support by calculating how much line buffer can fit
-	spl_in->funcs->spl_calc_lb_num_partitions(spl_in->basic_out.alpha_en, &spl_scratch->scl_data,
+	spl_in->callbacks.spl_calc_lb_num_partitions(spl_in->basic_out.alpha_en, &spl_scratch->scl_data,
 			lb_config, &num_part_y, &num_part_c);
 	/* MAX_V_TAPS = MIN (NUM_LINES - MAX(CEILING(V_RATIO,1)-2, 0), 8) */
 	if (spl_fixpt_ceil(spl_scratch->scl_data.ratios.vert) > 2)
diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h b/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h
index 8b00ccb1dfda..55d557df4aa5 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h
+++ b/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h
@@ -497,7 +497,7 @@ enum scale_to_sharpness_policy {
 	SCALE_TO_SHARPNESS_ADJ_YUV = 1,
 	SCALE_TO_SHARPNESS_ADJ_ALL = 2
 };
-struct spl_funcs	{
+struct spl_callbacks {
 	void (*spl_calc_lb_num_partitions)
 		(bool alpha_en,
 		const struct spl_scaler_data *scl_data,
@@ -518,7 +518,7 @@ struct spl_in	{
 	// Basic slice information
 	int odm_slice_index;	// ODM Slice Index using get_odm_split_index
 	struct spl_taps scaling_quality; // Explicit Scaling Quality
-	struct spl_funcs *funcs;
+	struct spl_callbacks callbacks;
 	// Inputs for isharp and EASF
 	struct adaptive_sharpness adaptive_sharpness;	//	Adaptive Sharpness
 	enum linear_light_scaling lls_pref;	//	Linear Light Scaling
diff --git a/drivers/gpu/drm/amd/display/dc/spl/spl_fixpt31_32.c b/drivers/gpu/drm/amd/display/dc/spl/spl_fixpt31_32.c
index 5fd79d9c67e2..131f1e3949d3 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/spl_fixpt31_32.c
+++ b/drivers/gpu/drm/amd/display/dc/spl/spl_fixpt31_32.c
@@ -22,7 +22,7 @@ static inline unsigned long long abs_i64(
  * result = dividend / divisor
  * *remainder = dividend % divisor
  */
-static inline unsigned long long complete_integer_division_u64(
+static inline unsigned long long spl_complete_integer_division_u64(
 	unsigned long long dividend,
 	unsigned long long divisor,
 	unsigned long long *remainder)
@@ -60,7 +60,7 @@ struct spl_fixed31_32 spl_fixpt_from_fraction(long long numerator, long long den
 
 	/* determine integer part */
 
-	unsigned long long res_value = complete_integer_division_u64(
+	unsigned long long res_value = spl_complete_integer_division_u64(
 		arg1_value, arg2_value, &remainder);
 
 	SPL_ASSERT(res_value <= (unsigned long long)LONG_MAX);
@@ -286,7 +286,7 @@ struct spl_fixed31_32 spl_fixpt_cos(struct spl_fixed31_32 arg)
  *
  * Calculated as Taylor series.
  */
-static struct spl_fixed31_32 fixed31_32_exp_from_taylor_series(struct spl_fixed31_32 arg)
+static struct spl_fixed31_32 spl_fixed31_32_exp_from_taylor_series(struct spl_fixed31_32 arg)
 {
 	unsigned int n = 9;
 
@@ -345,14 +345,14 @@ struct spl_fixed31_32 spl_fixpt_exp(struct spl_fixed31_32 arg)
 
 		if (m > 0)
 			return spl_fixpt_shl(
-				fixed31_32_exp_from_taylor_series(r),
+				spl_fixed31_32_exp_from_taylor_series(r),
 				(unsigned char)m);
 		else
 			return spl_fixpt_div_int(
-				fixed31_32_exp_from_taylor_series(r),
+				spl_fixed31_32_exp_from_taylor_series(r),
 				1LL << -m);
 	} else if (arg.value != 0)
-		return fixed31_32_exp_from_taylor_series(arg);
+		return spl_fixed31_32_exp_from_taylor_series(arg);
 	else
 		return spl_fixpt_one;
 }
@@ -396,7 +396,7 @@ struct spl_fixed31_32 spl_fixpt_log(struct spl_fixed31_32 arg)
  * part in 32 bits. It is used in hw programming (scaler)
  */
 
-static inline unsigned int ux_dy(
+static inline unsigned int spl_ux_dy(
 	long long value,
 	unsigned int integer_bits,
 	unsigned int fractional_bits)
@@ -415,13 +415,13 @@ static inline unsigned int ux_dy(
 	return result | fractional_part;
 }
 
-static inline unsigned int clamp_ux_dy(
+static inline unsigned int spl_clamp_ux_dy(
 	long long value,
 	unsigned int integer_bits,
 	unsigned int fractional_bits,
 	unsigned int min_clamp)
 {
-	unsigned int truncated_val = ux_dy(value, integer_bits, fractional_bits);
+	unsigned int truncated_val = spl_ux_dy(value, integer_bits, fractional_bits);
 
 	if (value >= (1LL << (integer_bits + FIXED31_32_BITS_PER_FRACTIONAL_PART)))
 		return (1 << (integer_bits + fractional_bits)) - 1;
@@ -433,40 +433,40 @@ static inline unsigned int clamp_ux_dy(
 
 unsigned int spl_fixpt_u4d19(struct spl_fixed31_32 arg)
 {
-	return ux_dy(arg.value, 4, 19);
+	return spl_ux_dy(arg.value, 4, 19);
 }
 
 unsigned int spl_fixpt_u3d19(struct spl_fixed31_32 arg)
 {
-	return ux_dy(arg.value, 3, 19);
+	return spl_ux_dy(arg.value, 3, 19);
 }
 
 unsigned int spl_fixpt_u2d19(struct spl_fixed31_32 arg)
 {
-	return ux_dy(arg.value, 2, 19);
+	return spl_ux_dy(arg.value, 2, 19);
 }
 
 unsigned int spl_fixpt_u0d19(struct spl_fixed31_32 arg)
 {
-	return ux_dy(arg.value, 0, 19);
+	return spl_ux_dy(arg.value, 0, 19);
 }
 
 unsigned int spl_fixpt_clamp_u0d14(struct spl_fixed31_32 arg)
 {
-	return clamp_ux_dy(arg.value, 0, 14, 1);
+	return spl_clamp_ux_dy(arg.value, 0, 14, 1);
 }
 
 unsigned int spl_fixpt_clamp_u0d10(struct spl_fixed31_32 arg)
 {
-	return clamp_ux_dy(arg.value, 0, 10, 1);
+	return spl_clamp_ux_dy(arg.value, 0, 10, 1);
 }
 
 int spl_fixpt_s4d19(struct spl_fixed31_32 arg)
 {
 	if (arg.value < 0)
-		return -(int)ux_dy(spl_fixpt_abs(arg).value, 4, 19);
+		return -(int)spl_ux_dy(spl_fixpt_abs(arg).value, 4, 19);
 	else
-		return ux_dy(arg.value, 4, 19);
+		return spl_ux_dy(arg.value, 4, 19);
 }
 
 struct spl_fixed31_32 spl_fixpt_from_ux_dy(unsigned int value,
-- 
2.34.1

