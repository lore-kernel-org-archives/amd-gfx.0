Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 775B0E7718C
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2024 21:51:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2391F10F084;
	Fri, 20 Dec 2024 21:51:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H+s1Y4rn";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20DE310F081
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2024 21:51:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n/iG34HSsG5Man2ak8FkvW+vFyqDrp2Fx88ncEDCYCPi8Bq/2kxBTQIiHmF7RybZ8cgXjFjx4u3Z/Fmd836x5KSXlvEkU+J1I6XQc0gKYvJ3GYEX/1PR91wGv7m8Z/B23RfkPddYayyn7yjGu3VDTiDePE3jTw29nnvuGEkWPBHA6JtByHEpcOZ0pdWcwlpf57vzbR0uK8YJbmZWB0eXo3XtDHBZMidDntwZRP7Bz8kpJA4sfLA6v1WiDNEYx+3LowlPWFt0beslow5XU8DthrohpZRYauOxW3GHv3xU/aphiHQt2Tpf0KaPhIOgpHChazeyWgGdx+0P2VBZvPHhYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iiKteatrjQUz1MdhC62ES/cF349IrbTSz4+11zG4e+0=;
 b=CvtqznzN1IIIdw7opQw52/hOlqoVeHsI9SoNmWsRu0P+onxVGukuqm+YwWl1BPzqYkOBgBaxcsJJ/onEsKhW3ymapTWtbVcxZMrGLpzR82eYKzxjqYSAHsDHNBXkFVvJi8n8H/uQv/sOkSHTZA1cmDRSyNx3ynoBQ3dfa5YObCfjJ5HiVnEon6MloTcT6KocsAC6q2PkYuCfR7jIt6FRwvOKIPXwp+pfjdBzAdMMlRa7xm+RTG7F0xP48Xed1H+KXegzLBXd60+lvDPXjBsQfy9xHueDfhnTKTH08Ngc9ZCtSeAg2XOXrAEEfEcTwtEFgPAwJB0jdSrmUQM3OpIuFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iiKteatrjQUz1MdhC62ES/cF349IrbTSz4+11zG4e+0=;
 b=H+s1Y4rn3R5oVIXqkrI0z/ekuemC+0ri38RFXkmBfdU31Ts0XR4nRPLeL0vfqR/oYAqHCi80Iq/mp5aH4Nr1mDhwzMY2P8zfvb2MQzi+WkhjPIsX1lGPSavyzYAm9w10W2TsKU3hUbSuCvtSE5j/jT2GwHbE8Efm/hscwWXK+zg=
Received: from SJ0PR13CA0120.namprd13.prod.outlook.com (2603:10b6:a03:2c5::35)
 by SA0PR12MB4494.namprd12.prod.outlook.com (2603:10b6:806:94::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 21:51:30 +0000
Received: from CO1PEPF000075EE.namprd03.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::6d) by SJ0PR13CA0120.outlook.office365.com
 (2603:10b6:a03:2c5::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.12 via Frontend Transport; Fri,
 20 Dec 2024 21:51:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000075EE.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 20 Dec 2024 21:51:29 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Dec
 2024 15:51:28 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 20 Dec 2024 15:51:27 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Samson Tam
 <Samson.Tam@amd.com>, Navid Assadian <navid.assadian@amd.com>
Subject: [PATCH 25/28] drm/amd/display: Clean up SPL code
Date: Fri, 20 Dec 2024 16:48:52 -0500
Message-ID: <20241220214855.2608618-26-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241220214855.2608618-1-Roman.Li@amd.com>
References: <20241220214855.2608618-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EE:EE_|SA0PR12MB4494:EE_
X-MS-Office365-Filtering-Correlation-Id: 68259c22-dd55-4516-1564-08dd214075df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?F61AAjncJ/nPTmXs/UqrGNXgWMpx3BiNTfBF3D79D1SEp7LLYISa81zXnRQo?=
 =?us-ascii?Q?e9SpHGl5BUMZXdplaeXJvp1PE3EZtRBpaZRlFys3YD6vqaCnlWpgpVcAv3as?=
 =?us-ascii?Q?tRVIUOno6kb9mGPZluNm6VDG58wvi2ivQx8z08Cl6iYgEr5bswxXbqE/oY4t?=
 =?us-ascii?Q?KFc7wnn3kslg7Ibv21Hk1AYT50MgowAcy3NhjPrGEHXTMxdHeiIX5sgB8Cjz?=
 =?us-ascii?Q?uxka0m39oEQW9edXWWul6ILFjtdUtcIOoPJVpgcl9meZ5AgowjH2/ChcJYzD?=
 =?us-ascii?Q?MRuMQT7vYS/ixM7YaGn5b/uTKBCiRVrcfX8WDrfSVMgwRgfHtSabSQs6eOJT?=
 =?us-ascii?Q?e/x6ijtYbQTAJBOvRpxPLwqlXI+BWzJHchYHy50wBnC2Uv8+niKGqEhKjQxo?=
 =?us-ascii?Q?sbMnjRzj2kTPndxhSAoVjVEBrprazimbsTsWhht2gocUCDU4HDCCycONHBbA?=
 =?us-ascii?Q?XQFdJO7vYifPhWZIomsKEEVfC63jFuSPoVtFQl5D2C7LcFhF68HfTZmlZk2i?=
 =?us-ascii?Q?Oy6g62HeCL48G3rtLJDYOA1rdK3v9u1xD8cfNGInSzw+5qFZQmqdtAZlCCm+?=
 =?us-ascii?Q?WY9z1uZHqMVAVS1FhL413brqYHNwHjqyDP77Duam3EcZCjiUFJzIacXHlDU5?=
 =?us-ascii?Q?LWPSd5aheEW7CgMbKCCopEvTKxEQkseTYn5Ilp9NZ6Jl7Dm+ADu2ca1HjRhz?=
 =?us-ascii?Q?s0OWpL8zUShB3OJUZTluduPfmT12MgvihuT5nr+8WF9SRPnQRxqLxn2kK3j6?=
 =?us-ascii?Q?9Wf556bSBr4JInCQ7oP4RZ6fRiqMpHvXVuC1odUyEbTOwPBbQSrVgMalg5wr?=
 =?us-ascii?Q?Ii2A+MmISFrIKuTipuTPykiSRxI+vxcgJUS1jppXLhtiD0uxVH32T4v+VEdH?=
 =?us-ascii?Q?AVXjrO+5rhe1fUwrrB3AXhjkBAAe2oN9oNcxSWGPMe4CI6/hAL5wpjhV4Xex?=
 =?us-ascii?Q?JTc2NL2gcw17/yzu7vRh4xXVUtlK1tDoPFceMd6cA251gqqO+7BTI38MNoUb?=
 =?us-ascii?Q?mv1/YkbTe4E2aAKws58ihDbgVpW16J7WQEC3V0SRJRQRiGoR/UaGuI6SY3F1?=
 =?us-ascii?Q?8RgSUL9+tgyOgXSD/t2Cwaru95hr4mfS/QlTSPaBcRrgR5jx54c7QsqPtHEC?=
 =?us-ascii?Q?ULJ7pKBYjzIUs9K+zSj8Hz4PrjzrHEGzjbortRH1SoyzhJDXhLcd3NLBC60E?=
 =?us-ascii?Q?RVqUvwEWsgBqADSadiTUB4gvXy4XaaxYPaHwwU8Yyb6nSdwFYkYowGCKBjlV?=
 =?us-ascii?Q?jUvdUibC3+v6BJ9ynEjlWOgEOJgjMZclk9Xob58695/LgwshzoJp394zLPSH?=
 =?us-ascii?Q?aSncTn4Rif8LVnCoYFl0AufMPctti/O20VWeWNWWXygdKx94071Hf+aCGnql?=
 =?us-ascii?Q?GMcZXXfMXPRcTYesKKq1MAGEbjxv1U8Mo2BFpgmA7bIeGoPVD4Kl4Tf2kJ0b?=
 =?us-ascii?Q?U3/mmvEjCdNT4H245/GAPnSCeDGmOUnYo8kXMrJbThoOwYUcwyiC0dzulT0Y?=
 =?us-ascii?Q?Wm6mu670C/ax5Jc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 21:51:29.3937 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68259c22-dd55-4516-1564-08dd214075df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075EE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4494
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
Use helper functions for checking formats
Apply cositing offset in rotation case

Reviewed-by: Navid Assadian <navid.assadian@amd.com>
Signed-off-by: Samson Tam <Samson.Tam@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.c | 88 ++++++++++-----------
 1 file changed, 43 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c b/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
index a7f36b5c53d1..38a9a0d68058 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
+++ b/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
@@ -11,6 +11,41 @@
 #define IDENTITY_RATIO(ratio) (spl_fixpt_u2d19(ratio) == (1 << 19))
 #define MIN_VIEWPORT_SIZE 12
 
+static bool spl_is_yuv420(enum spl_pixel_format format)
+{
+	if ((format >= SPL_PIXEL_FORMAT_420BPP8) &&
+		(format <= SPL_PIXEL_FORMAT_420BPP10))
+		return true;
+
+	return false;
+}
+
+static bool spl_is_rgb8(enum spl_pixel_format format)
+{
+	if (format == SPL_PIXEL_FORMAT_ARGB8888)
+		return true;
+
+	return false;
+}
+
+static bool spl_is_video_format(enum spl_pixel_format format)
+{
+	if (format >= SPL_PIXEL_FORMAT_VIDEO_BEGIN
+		&& format <= SPL_PIXEL_FORMAT_VIDEO_END)
+		return true;
+	else
+		return false;
+}
+
+static bool spl_is_subsampled_format(enum spl_pixel_format format)
+{
+	if (format >= SPL_PIXEL_FORMAT_SUBSAMPLED_BEGIN
+		&& format <= SPL_PIXEL_FORMAT_SUBSAMPLED_END)
+		return true;
+	else
+		return false;
+}
+
 static struct spl_rect intersect_rec(const struct spl_rect *r0, const struct spl_rect *r1)
 {
 	struct spl_rect rec;
@@ -408,8 +443,7 @@ static void spl_calculate_scaling_ratios(struct spl_in *spl_in,
 	spl_scratch->scl_data.ratios.horz_c = spl_scratch->scl_data.ratios.horz;
 	spl_scratch->scl_data.ratios.vert_c = spl_scratch->scl_data.ratios.vert;
 
-	if (spl_in->basic_in.format == SPL_PIXEL_FORMAT_420BPP8
-			|| spl_in->basic_in.format == SPL_PIXEL_FORMAT_420BPP10) {
+	if (spl_is_yuv420(spl_in->basic_in.format)) {
 		spl_scratch->scl_data.ratios.horz_c.value /= 2;
 		spl_scratch->scl_data.ratios.vert_c.value /= 2;
 	}
@@ -546,41 +580,6 @@ static void spl_calculate_init_and_vp(bool flip_scan_dir,
 		*vp_offset = src_size - *vp_offset - *vp_size;
 }
 
-static bool spl_is_yuv420(enum spl_pixel_format format)
-{
-	if ((format >= SPL_PIXEL_FORMAT_420BPP8) &&
-		(format <= SPL_PIXEL_FORMAT_420BPP10))
-		return true;
-
-	return false;
-}
-
-static bool spl_is_rgb8(enum spl_pixel_format format)
-{
-	if (format == SPL_PIXEL_FORMAT_ARGB8888)
-		return true;
-
-	return false;
-}
-
-static bool spl_is_video_format(enum spl_pixel_format format)
-{
-	if (format >= SPL_PIXEL_FORMAT_VIDEO_BEGIN
-			&& format <= SPL_PIXEL_FORMAT_VIDEO_END)
-		return true;
-	else
-		return false;
-}
-
-static bool spl_is_subsampled_format(enum spl_pixel_format format)
-{
-	if (format >= SPL_PIXEL_FORMAT_SUBSAMPLED_BEGIN
-			&& format <= SPL_PIXEL_FORMAT_SUBSAMPLED_END)
-		return true;
-	else
-		return false;
-}
-
 /*Calculate inits and viewport */
 static void spl_calculate_inits_and_viewports(struct spl_in *spl_in,
 		struct spl_scratch *spl_scratch)
@@ -591,8 +590,7 @@ static void spl_calculate_inits_and_viewports(struct spl_in *spl_in,
 	struct spl_rect recout_clip_in_recout_dst;
 	struct spl_rect overlap_in_active_timing;
 	struct spl_rect odm_slice = calculate_odm_slice_in_timing_active(spl_in);
-	int vpc_div = (spl_in->basic_in.format == SPL_PIXEL_FORMAT_420BPP8
-			|| spl_in->basic_in.format == SPL_PIXEL_FORMAT_420BPP10) ? 2 : 1;
+	int vpc_div = spl_is_subsampled_format(spl_in->basic_in.format) ? 2 : 1;
 	bool orthogonal_rotation, flip_vert_scan_dir, flip_horz_scan_dir;
 	struct spl_fixed31_32 init_adj_h = spl_fixpt_zero;
 	struct spl_fixed31_32 init_adj_v = spl_fixpt_zero;
@@ -620,11 +618,6 @@ static void spl_calculate_inits_and_viewports(struct spl_in *spl_in,
 			&flip_vert_scan_dir,
 			&flip_horz_scan_dir);
 
-	if (orthogonal_rotation) {
-		spl_swap(src.width, src.height);
-		spl_swap(flip_vert_scan_dir, flip_horz_scan_dir);
-	}
-
 	if (spl_is_subsampled_format(spl_in->basic_in.format)) {
 		/* this gives the direction of the cositing (negative will move
 		 * left, right otherwise)
@@ -647,7 +640,12 @@ static void spl_calculate_inits_and_viewports(struct spl_in *spl_in,
 			init_adj_v = spl_fixpt_zero;
 			break;
 		}
+	}
 
+	if (orthogonal_rotation) {
+		spl_swap(src.width, src.height);
+		spl_swap(flip_vert_scan_dir, flip_horz_scan_dir);
+		spl_swap(init_adj_h, init_adj_v);
 	}
 
 	spl_calculate_init_and_vp(
@@ -1600,7 +1598,7 @@ static void spl_set_easf_data(struct spl_scratch *spl_scratch, struct spl_out *s
 			0x0;	// fp1.5.10, C3 coefficient
 	}
 
-	if (spl_is_video_format(format)) { /* TODO: 0 = RGB, 1 = YUV */
+	if (spl_is_subsampled_format(format)) { /* TODO: 0 = RGB, 1 = YUV */
 		dscl_prog_data->easf_matrix_mode = 1;
 		/*
 		 * 2-bit, BF3 chroma mode correction calculation mode
-- 
2.34.1

