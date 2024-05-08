Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AA1CC04FFE
	for <amd-gfx@archiver.kernel.org>; Wed,  8 May 2024 17:18:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19823113132;
	Wed,  8 May 2024 17:18:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Oa44e7Rq";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 560D111312B
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 May 2024 17:18:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S4nthgKnFDYJlOWna1i4u8ckakkHP+TJmYVZWHf4z/JRAgExZibFTlRIzBOpkSZdrsLnbWACIspf3gICm2v4OBBIdrK1ybPTiJVPrYzFbnz4jRmFtVnVFHgm5bIDS7ZTxM6RGbWcMpUWxusH3z8jUzVGsQ7lpHq3HrePdS+tis7n+0pRBDZOBp2hF6wMQd63vh+V31KH97n6xQEGVctOJcGz/DZhl8iZUJ5I+786pk5qPFvO4ePkb5r764oPU/89w6Gy+0iAXtFpozDTkJIyEz0FSRiPPd9bkH6EGfIU90emKM5VfWZ6AT/q8lpwvHHr0WLsHy6TnnbVXNK3n0Kgew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F7xJq4TmvVlCG1957y8LFz5J/2V1kKEzxBmzPyshVcU=;
 b=geRUeGQicBFVX/1etWDUGDodqBYg9zv8X9akgp+C8Okr3WyXFQEkbSRXGgEX2u8uwkIhjaUKHVq6Xgi+mhjgpLgETPFBISDuJIxHGfQkss6kirWzmm4XmNyhRZRzCkw0YaSWCmc51uE1BjplEIbQU092GB7HPyhAqTsnUWTE1ssQ5wluABZJYcW7tuWQY6fHYr80VPi8s9ePQzApF5E52gB+6PBnGfjbDDMRs2QThW93ZpUuFVBrhtehYx3/WO4zyawFzI8+4567Ryq3mmXaVtYyFrtmsZ2fd/x7pjLopobIGgCwtHccIRqbIh+gosLP0ZSYKoWgr3Lcs8e11O3lvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7xJq4TmvVlCG1957y8LFz5J/2V1kKEzxBmzPyshVcU=;
 b=Oa44e7RqG9S63PGQuUMlMUkphXBLiJugweUWfTAEbRXAvo5sW5qaKCIETZn9D+E+1hEQwg8Bjw7oL3X8hfsQaCVCbaenDL1YP87QTRjzfn9Bc/D4hNAIaL0RhpVpsRKmva5m2gT1+iursKMiKhwYumgoGq8iUNGQ9qghrRxmks4=
Received: from BN9PR03CA0641.namprd03.prod.outlook.com (2603:10b6:408:13b::16)
 by MN0PR12MB5955.namprd12.prod.outlook.com (2603:10b6:208:37e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Wed, 8 May
 2024 17:18:23 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:408:13b:cafe::c0) by BN9PR03CA0641.outlook.office365.com
 (2603:10b6:408:13b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42 via Frontend
 Transport; Wed, 8 May 2024 17:18:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.0 via Frontend Transport; Wed, 8 May 2024 17:18:23 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 8 May
 2024 12:18:20 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>, Dillon Varone <dillon.varone@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 15/20] drm/amd/display: Allow higher DSC slice support for
 small timings on dcn401
Date: Wed, 8 May 2024 11:13:15 -0600
Message-ID: <20240508171320.3292065-16-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|MN0PR12MB5955:EE_
X-MS-Office365-Filtering-Correlation-Id: 93f63594-f19f-492b-b9d1-08dc6f82dd88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|82310400017|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JPShDmvTxw23K0Z9X6D39tOvklnPVNQQT6TsSrFrG6DjCniH7mGA2a4Knwdx?=
 =?us-ascii?Q?YUiAreILc18tgBkwuMJP56lX/WZ80324knkzroElqMfNf8zVJ+ixd/QLfdJB?=
 =?us-ascii?Q?fOvhzhJ9+q2/jK8qS0rLC4a0p66N6o9YxsoobCTq5HWFIxEccJUCkoDzQvpP?=
 =?us-ascii?Q?uCrGxNob7kzfDHbgKKAnc34upMbvJGMVoi9WVU/7+istK3zdRDNDNTuCrhSf?=
 =?us-ascii?Q?xoEuoDjoTzV39sThHt7x9qL5XMnHu3Rxv/wRa6G/zF48+riSx0ToVatWYclg?=
 =?us-ascii?Q?HAiWJKg0432xHOI6BS8hvHB45UvETa7wMTFrf2QMjE1Y+fFPDX/obDWik38K?=
 =?us-ascii?Q?qFd2i/y/zRZaAwyYoj0TWwx0frr3pvDOOtfuLaHmCqLd7Yf2DbmODrxcbpAu?=
 =?us-ascii?Q?LI3JLSYXeIYXXg6g3HBGCnKeF9ELrcBe+qUErDfxJjGCXjTa040hNsCPB6Nv?=
 =?us-ascii?Q?0Cr3A4l70zf3d8dcCBblGuIvTxr1CMWUxOoTWGGhGypOFIaRbVH8Bj6VKBtt?=
 =?us-ascii?Q?S2U7uhkYiJsJ/Qb1vpyDOFiA1zCGezn/4qp+IuTWts+DN7rdVjLY0NLPWyl1?=
 =?us-ascii?Q?t7yBC+zCQB8qzNHh/ON9g7MPYxG+6QGIldQfwjPwEstMu6Y6D6uDhLVCoPDb?=
 =?us-ascii?Q?bsbqqSWn4AQwx8Q+ESahzMwfmYQjphkdvPAq+eVal63IW/ABJ9OfnXdvSq+P?=
 =?us-ascii?Q?XLmAxjvzs9yzBRRQ2D2XWtC+xv6vZXODRRG1AkBw7WuVbfufvs8/Y/KiYwPu?=
 =?us-ascii?Q?xa92d6GH7eLmCDOh2FEw6k6kzoHt/KjsJwpi91NRaDZe+CuIEN7ojf04ChMh?=
 =?us-ascii?Q?v9K1yGTyvlWBRMhQW08CHObBHlB4whuF5vQwg+33Q5zoiwUV7cBwIYj+pg5k?=
 =?us-ascii?Q?pUiZC7s27SUOuVFwCfQWnLik9YiF63tcKmjjVSKLeIEhMJiKjsQdE0xjgqSt?=
 =?us-ascii?Q?wk64vHvvaEJ806eZSm5i9zfU9gdfGo2qoutLnasW/R4Idmvnp1PTSvt4CUWY?=
 =?us-ascii?Q?ugmWO6DrlMzShgp8+Hn/4Cxkq6BaqSpo/HFNnVWXLqf5n0/Cw8vTRrcddNUA?=
 =?us-ascii?Q?UVg/0m37ehNlugoP8eTDbBjZ2f6wt/Gpbe+7RYxCDCV+ICmL05NTKgeWzKTu?=
 =?us-ascii?Q?UbSprqIMXFhYWvbBvWPOHTAjhbfkbglYN8vJSpGtiuBXQuigoULD34RWH2Pp?=
 =?us-ascii?Q?5qXzpEyCmeN8kbtLCymucs05sQ84ZjzmEVPW1sIJ7rDqjWsWH8g480NH8nSq?=
 =?us-ascii?Q?w3U6m8rMMPWnwN8T3ax/zXD2CDDcjldjr/UAgS+g4QY0alKD+XldsAIhvMYO?=
 =?us-ascii?Q?J6NxhIOpKMhem1d3HAtuawJ9+UgMWiXf88+ewxR2kwbJyood/kPBoIPi/vbu?=
 =?us-ascii?Q?t4VhGyYOxmW+rvOfNdegFwnSZYfF?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400017)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 17:18:23.2455 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93f63594-f19f-492b-b9d1-08dc6f82dd88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5955
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
DML2.1 has added the support to determine ODM combine based on DSC slice
count limitation. This support would allow us to support DSC slice higher
than 4 on small timings. The change will allow higher DSC slice support
independent from pixel clock in use.

[HOW]
Add a DCN401 get_enc_caps function to allow the support for DSC slice count
higher than 4.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../amd/display/dc/dsc/dcn401/dcn401_dsc.c    | 412 ++----------------
 1 file changed, 39 insertions(+), 373 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c
index 845686d57919..52f23bb554af 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c
@@ -9,6 +9,9 @@
 #include "dsc/dscc_types.h"
 #include "dsc/rc_calc.h"
 
+#define MAX_THROUGHPUT_PER_DSC_100HZ 20000000
+#define MAX_DSC_UNIT_COMBINE 4
+
 static void dsc_write_to_registers(struct display_stream_compressor *dsc, const struct dsc_reg_values *reg_vals);
 
 /* Object I/F functions */
@@ -22,9 +25,10 @@ static void dsc401_enable(struct display_stream_compressor *dsc, int opp_pipe);
 static void dsc401_disable(struct display_stream_compressor *dsc);
 static void dsc401_disconnect(struct display_stream_compressor *dsc);
 static void dsc401_wait_disconnect_pending_clear(struct display_stream_compressor *dsc);
+static void dsc401_get_enc_caps(struct dsc_enc_caps *dsc_enc_caps, int pixel_clock_100Hz);
 
 const struct dsc_funcs dcn401_dsc_funcs = {
-	.dsc_get_enc_caps = dsc2_get_enc_caps,
+	.dsc_get_enc_caps = dsc401_get_enc_caps,
 	.dsc_read_state = dsc401_read_state,
 	.dsc_validate_stream = dsc401_validate_stream,
 	.dsc_set_config = dsc401_set_config,
@@ -48,9 +52,6 @@ const struct dsc_funcs dcn401_dsc_funcs = {
 #define DC_LOGGER \
 	dsc->ctx->logger
 
-#define DCN401_MAX_PIXEL_CLOCK_Mhz      1188
-#define DCN401_MAX_DISPLAY_CLOCK_Mhz    1200
-
 enum dsc_bits_per_comp {
 	DSC_BPC_8 = 8,
 	DSC_BPC_10 = 10,
@@ -78,50 +79,40 @@ void dsc401_construct(struct dcn401_dsc *dsc,
 	dsc->max_image_width = 5184;
 }
 
-/* This returns the capabilities for a single DSC encoder engine. Number of slices and total throughput
- * can be doubled, tripled etc. by using additional DSC engines.
- */
-//static void dsc401_get_enc_caps(struct dsc_enc_caps *dsc_enc_caps, int pixel_clock_100Hz)
-//{
-//	dsc_enc_caps->dsc_version = 0x21; /* v1.2 - DP spec defined it in reverse order and we kept it */
-//
-//	/*dsc_enc_caps->slice_caps.bits.NUM_SLICES_1 = 1;
-//	dsc_enc_caps->slice_caps.bits.NUM_SLICES_2 = 1;
-//	dsc_enc_caps->slice_caps.bits.NUM_SLICES_3 = 1;
-//	dsc_enc_caps->slice_caps.bits.NUM_SLICES_4 = 1;
-//
-//	dsc_enc_caps->lb_bit_depth = 13;
-//	dsc_enc_caps->is_block_pred_supported = true;
-//
-//	dsc_enc_caps->color_formats.bits.RGB = 1;
-//	dsc_enc_caps->color_formats.bits.YCBCR_444 = 1;
-//	dsc_enc_caps->color_formats.bits.YCBCR_SIMPLE_422 = 1;
-//	dsc_enc_caps->color_formats.bits.YCBCR_NATIVE_422 = 0;
-//	dsc_enc_caps->color_formats.bits.YCBCR_NATIVE_420 = 1;
-//
-//	dsc_enc_caps->color_depth.bits.COLOR_DEPTH_8_BPC = 1;
-//	dsc_enc_caps->color_depth.bits.COLOR_DEPTH_10_BPC = 1;
-//	dsc_enc_caps->color_depth.bits.COLOR_DEPTH_12_BPC = 1;
-//
-//	/* Maximum total throughput with all the slices combined. This is different from how DP spec specifies it.
-//	 * Our decoder's total throughput in Pix/s is equal to DISPCLK. This is then shared between slices.
-//	 * The value below is the absolute maximum value. The actual throughput may be lower, but it'll always
-//	 * be sufficient to process the input pixel rate fed into a single DSC engine.
-//	 */
-//	/*dsc_enc_caps->max_total_throughput_mps = DCN401_MAX_DISPLAY_CLOCK_Mhz;
-//
-//	/* For pixel clock bigger than a single-pipe limit we'll need two engines, which then doubles our
-//	 * throughput and number of slices, but also introduces a lower limit of 2 slices
-//	 */
-//	/*if (pixel_clock_100Hz >= DCN401_MAX_PIXEL_CLOCK_Mhz*10000) {
-//		dsc_enc_caps->slice_caps.bits.NUM_SLICES_1 = 0;
-//		dsc_enc_caps->slice_caps.bits.NUM_SLICES_8 = 1;
-//		dsc_enc_caps->max_total_throughput_mps = DCN401_MAX_DISPLAY_CLOCK_Mhz * 2;
-//	}
-//
-//	dsc_enc_caps->max_slice_width = 5184; /* (including 64 overlap pixels for eDP MSO mode) */
-//	/*dsc_enc_caps->bpp_increment_div = 16; /* 1/16th of a bit */
-//}
+static void dsc401_get_enc_caps(struct dsc_enc_caps *dsc_enc_caps, int pixel_clock_100Hz)
+{
+	int min_dsc_unit_required = (pixel_clock_100Hz + MAX_THROUGHPUT_PER_DSC_100HZ - 1) / MAX_THROUGHPUT_PER_DSC_100HZ;
+
+	dsc_enc_caps->dsc_version = 0x21; /* v1.2 - DP spec defined it in reverse order and we kept it */
+
+	/* 1 slice is only supported with 1 DSC unit */
+	dsc_enc_caps->slice_caps.bits.NUM_SLICES_1 = min_dsc_unit_required == 1 ? 1 : 0;
+	/* 2 slice is only supported with 1 or 2 DSC units */
+	dsc_enc_caps->slice_caps.bits.NUM_SLICES_2 = (min_dsc_unit_required == 1 || min_dsc_unit_required == 2) ? 1 : 0;
+	/* 3 slice is only supported with 1 DSC unit */
+	dsc_enc_caps->slice_caps.bits.NUM_SLICES_3 = min_dsc_unit_required == 1 ? 1 : 0;
+	dsc_enc_caps->slice_caps.bits.NUM_SLICES_4 = 1;
+	dsc_enc_caps->slice_caps.bits.NUM_SLICES_8 = 1;
+	dsc_enc_caps->slice_caps.bits.NUM_SLICES_12 = 1;
+	dsc_enc_caps->slice_caps.bits.NUM_SLICES_16 = 1;
+
+	dsc_enc_caps->lb_bit_depth = 13;
+	dsc_enc_caps->is_block_pred_supported = true;
+
+	dsc_enc_caps->color_formats.bits.RGB = 1;
+	dsc_enc_caps->color_formats.bits.YCBCR_444 = 1;
+	dsc_enc_caps->color_formats.bits.YCBCR_SIMPLE_422 = 1;
+	dsc_enc_caps->color_formats.bits.YCBCR_NATIVE_422 = 0;
+	dsc_enc_caps->color_formats.bits.YCBCR_NATIVE_420 = 1;
+
+	dsc_enc_caps->color_depth.bits.COLOR_DEPTH_8_BPC = 1;
+	dsc_enc_caps->color_depth.bits.COLOR_DEPTH_10_BPC = 1;
+	dsc_enc_caps->color_depth.bits.COLOR_DEPTH_12_BPC = 1;
+	dsc_enc_caps->max_total_throughput_mps = MAX_THROUGHPUT_PER_DSC_100HZ * MAX_DSC_UNIT_COMBINE;
+
+	dsc_enc_caps->max_slice_width = 5184; /* (including 64 overlap pixels for eDP MSO mode) */
+	dsc_enc_caps->bpp_increment_div = 16; /* 1/16th of a bit */
+}
 
 /* this function read dsc related register fields to be logged later in dcn10_log_hw_state
  * into a dcn_dsc_state struct.
@@ -154,19 +145,6 @@ static bool dsc401_validate_stream(struct display_stream_compressor *dsc, const
 	return dsc_prepare_config(dsc_cfg, &dsc401->reg_vals, &dsc_optc_cfg);
 }
 
-/*
-static void dsc_config_log(struct display_stream_compressor *dsc, const struct dsc_config *config)
-{
-	DC_LOG_DSC("\tnum_slices_h %d", config->dc_dsc_cfg.num_slices_h);
-	DC_LOG_DSC("\tnum_slices_v %d", config->dc_dsc_cfg.num_slices_v);
-	DC_LOG_DSC("\tbits_per_pixel %d (%d.%04d)",
-		config->dc_dsc_cfg.bits_per_pixel,
-		config->dc_dsc_cfg.bits_per_pixel / 16,
-		((config->dc_dsc_cfg.bits_per_pixel % 16) * 10000) / 16);
-	DC_LOG_DSC("\tcolor_depth %d", config->color_depth);
-}
-*/
-
 static void dsc401_set_config(struct display_stream_compressor *dsc, const struct dsc_config *dsc_cfg,
 		struct dsc_optc_config *dsc_optc_cfg)
 {
@@ -182,28 +160,6 @@ static void dsc401_set_config(struct display_stream_compressor *dsc, const struc
 	dsc_write_to_registers(dsc, &dsc401->reg_vals);
 }
 
-/*
-static bool dsc401_get_packed_pps(struct display_stream_compressor *dsc, const struct dsc_config *dsc_cfg, uint8_t *dsc_packed_pps)
-{
-	bool is_config_ok;
-	struct dsc_reg_values dsc_reg_vals;
-	struct dsc_optc_config dsc_optc_cfg;
-
-	memset(&dsc_reg_vals, 0, sizeof(dsc_reg_vals));
-	memset(&dsc_optc_cfg, 0, sizeof(dsc_optc_cfg));
-
-	DC_LOG_DSC("Getting packed DSC PPS for DSC Config:");
-	dsc_config_log(dsc, dsc_cfg);
-	DC_LOG_DSC("DSC Picture Parameter Set (PPS):");
-	is_config_ok = dsc_prepare_config(dsc_cfg, &dsc_reg_vals, &dsc_optc_cfg);
-	ASSERT(is_config_ok);
-	drm_dsc_pps_payload_pack((struct drm_dsc_picture_parameter_set *)dsc_packed_pps, &dsc_reg_vals.pps);
-	dsc_log_pps(dsc, &dsc_reg_vals.pps);
-
-	return is_config_ok;
-}
-*/
-
 static void dsc401_enable(struct display_stream_compressor *dsc, int opp_pipe)
 {
 	struct dcn401_dsc *dsc401 = TO_DCN401_DSC(dsc);
@@ -265,296 +221,6 @@ static void dsc401_disconnect(struct display_stream_compressor *dsc)
 		DSCRM_DSC_FORWARD_EN, 0);
 }
 
-/* This module's internal functions */
-//static void dsc_log_pps(struct display_stream_compressor *dsc, struct drm_dsc_config *pps)
-//{
-//	int i;
-//	int bits_per_pixel = pps->bits_per_pixel;
-//
-//	DC_LOG_DSC("\tdsc_version_major %d", pps->dsc_version_major);
-//	DC_LOG_DSC("\tdsc_version_minor %d", pps->dsc_version_minor);
-//	DC_LOG_DSC("\tbits_per_component %d", pps->bits_per_component);
-//	DC_LOG_DSC("\tline_buf_depth %d", pps->line_buf_depth);
-//	DC_LOG_DSC("\tblock_pred_enable %d", pps->block_pred_enable);
-//	DC_LOG_DSC("\tconvert_rgb %d", pps->convert_rgb);
-//	DC_LOG_DSC("\tsimple_422 %d", pps->simple_422);
-//	DC_LOG_DSC("\tvbr_enable %d", pps->vbr_enable);
-//	DC_LOG_DSC("\tbits_per_pixel %d (%d.%04d)", bits_per_pixel, bits_per_pixel / 16, ((bits_per_pixel % 16) * 10000) / 16);
-//	DC_LOG_DSC("\tpic_height %d", pps->pic_height);
-//	DC_LOG_DSC("\tpic_width %d", pps->pic_width);
-//	DC_LOG_DSC("\tslice_height %d", pps->slice_height);
-//	DC_LOG_DSC("\tslice_width %d", pps->slice_width);
-//	DC_LOG_DSC("\tslice_chunk_size %d", pps->slice_chunk_size);
-//	DC_LOG_DSC("\tinitial_xmit_delay %d", pps->initial_xmit_delay);
-//	DC_LOG_DSC("\tinitial_dec_delay %d", pps->initial_dec_delay);
-//	DC_LOG_DSC("\tinitial_scale_value %d", pps->initial_scale_value);
-//	DC_LOG_DSC("\tscale_increment_interval %d", pps->scale_increment_interval);
-//	DC_LOG_DSC("\tscale_decrement_interval %d", pps->scale_decrement_interval);
-//	DC_LOG_DSC("\tfirst_line_bpg_offset %d", pps->first_line_bpg_offset);
-//	DC_LOG_DSC("\tnfl_bpg_offset %d", pps->nfl_bpg_offset);
-//	DC_LOG_DSC("\tslice_bpg_offset %d", pps->slice_bpg_offset);
-//	DC_LOG_DSC("\tinitial_offset %d", pps->initial_offset);
-//	DC_LOG_DSC("\tfinal_offset %d", pps->final_offset);
-//	DC_LOG_DSC("\tflatness_min_qp %d", pps->flatness_min_qp);
-//	DC_LOG_DSC("\tflatness_max_qp %d", pps->flatness_max_qp);
-//	/* DC_LOG_DSC("\trc_parameter_set %d", pps->rc_parameter_set); */
-//	/*DC_LOG_DSC("\tnative_420 %d", pps->native_420);
-//	DC_LOG_DSC("\tnative_422 %d", pps->native_422);
-//	DC_LOG_DSC("\tsecond_line_bpg_offset %d", pps->second_line_bpg_offset);
-//	DC_LOG_DSC("\tnsl_bpg_offset %d", pps->nsl_bpg_offset);
-//	DC_LOG_DSC("\tsecond_line_offset_adj %d", pps->second_line_offset_adj);
-//	DC_LOG_DSC("\trc_model_size %d", pps->rc_model_size);
-//	DC_LOG_DSC("\trc_edge_factor %d", pps->rc_edge_factor);
-//	DC_LOG_DSC("\trc_quant_incr_limit0 %d", pps->rc_quant_incr_limit0);
-//	DC_LOG_DSC("\trc_quant_incr_limit1 %d", pps->rc_quant_incr_limit1);
-//	DC_LOG_DSC("\trc_tgt_offset_high %d", pps->rc_tgt_offset_high);
-//	DC_LOG_DSC("\trc_tgt_offset_low %d", pps->rc_tgt_offset_low);
-//
-//	for (i = 0; i < NUM_BUF_RANGES - 1; i++)
-//		DC_LOG_DSC("\trc_buf_thresh[%d] %d", i, pps->rc_buf_thresh[i]);
-//
-//	for (i = 0; i < NUM_BUF_RANGES; i++) {
-//		DC_LOG_DSC("\trc_range_parameters[%d].range_min_qp %d", i, pps->rc_range_params[i].range_min_qp);
-//		DC_LOG_DSC("\trc_range_parameters[%d].range_max_qp %d", i, pps->rc_range_params[i].range_max_qp);
-//		DC_LOG_DSC("\trc_range_parameters[%d].range_bpg_offset %d", i, pps->rc_range_params[i].range_bpg_offset);
-//	}
-//}
-//
-//static void dsc_override_rc_params(struct rc_params *rc, const struct dc_dsc_rc_params_override *override)
-//{
-//	uint8_t i;
-//
-//	rc->rc_model_size = override->rc_model_size;
-//	for (i = 0; i < DC_DSC_RC_BUF_THRESH_SIZE; i++)
-//		rc->rc_buf_thresh[i] = override->rc_buf_thresh[i];
-//	for (i = 0; i < DC_DSC_QP_SET_SIZE; i++) {
-//		rc->qp_min[i] = override->rc_minqp[i];
-//		rc->qp_max[i] = override->rc_maxqp[i];
-//		rc->ofs[i] = override->rc_offset[i];
-//	}
-//
-//	rc->rc_tgt_offset_hi = override->rc_tgt_offset_hi;
-//	rc->rc_tgt_offset_lo = override->rc_tgt_offset_lo;
-//	rc->rc_edge_factor = override->rc_edge_factor;
-//	rc->rc_quant_incr_limit0 = override->rc_quant_incr_limit0;
-//	rc->rc_quant_incr_limit1 = override->rc_quant_incr_limit1;
-//
-//	rc->initial_fullness_offset = override->initial_fullness_offset;
-//	rc->initial_xmit_delay = override->initial_delay;
-//
-//	rc->flatness_min_qp = override->flatness_min_qp;
-//	rc->flatness_max_qp = override->flatness_max_qp;
-//	rc->flatness_det_thresh = override->flatness_det_thresh;
-//}
-
-//
-//static bool dsc_prepare_config(const struct dsc_config *dsc_cfg, struct dsc_reg_values *dsc_reg_vals,
-//			struct dsc_optc_config *dsc_optc_cfg)
-//{
-//	struct dsc_parameters dsc_params;
-//	struct rc_params rc;
-//
-//	/* Validate input parameters */
-//	/*ASSERT(dsc_cfg->dc_dsc_cfg.num_slices_h);
-//	ASSERT(dsc_cfg->dc_dsc_cfg.num_slices_v);
-//	ASSERT(dsc_cfg->dc_dsc_cfg.version_minor == 1 || dsc_cfg->dc_dsc_cfg.version_minor == 2);
-//	ASSERT(dsc_cfg->pic_width);
-//	ASSERT(dsc_cfg->pic_height);
-//	ASSERT((dsc_cfg->dc_dsc_cfg.version_minor == 1 &&
-//		  (8 <= dsc_cfg->dc_dsc_cfg.linebuf_depth && dsc_cfg->dc_dsc_cfg.linebuf_depth <= 13)) ||
-//		(dsc_cfg->dc_dsc_cfg.version_minor == 2 &&
-//		  ((8 <= dsc_cfg->dc_dsc_cfg.linebuf_depth && dsc_cfg->dc_dsc_cfg.linebuf_depth <= 15) ||
-//		    dsc_cfg->dc_dsc_cfg.linebuf_depth == 0)));
-//	ASSERT(96 <= dsc_cfg->dc_dsc_cfg.bits_per_pixel && dsc_cfg->dc_dsc_cfg.bits_per_pixel <= 0x3ff); // 6.0 <= bits_per_pixel <= 63.9375
-//
-//	if (!dsc_cfg->dc_dsc_cfg.num_slices_v || !dsc_cfg->dc_dsc_cfg.num_slices_h ||
-//		!(dsc_cfg->dc_dsc_cfg.version_minor == 1 || dsc_cfg->dc_dsc_cfg.version_minor == 2) ||
-//		!dsc_cfg->pic_width || !dsc_cfg->pic_height ||
-//		!((dsc_cfg->dc_dsc_cfg.version_minor == 1 && // v1.1 line buffer depth range:
-//			8 <= dsc_cfg->dc_dsc_cfg.linebuf_depth && dsc_cfg->dc_dsc_cfg.linebuf_depth <= 13) ||
-//		(dsc_cfg->dc_dsc_cfg.version_minor == 2 && // v1.2 line buffer depth range:
-//			((8 <= dsc_cfg->dc_dsc_cfg.linebuf_depth && dsc_cfg->dc_dsc_cfg.linebuf_depth <= 15) ||
-//			dsc_cfg->dc_dsc_cfg.linebuf_depth == 0))) ||
-//		!(96 <= dsc_cfg->dc_dsc_cfg.bits_per_pixel && dsc_cfg->dc_dsc_cfg.bits_per_pixel <= 0x3ff)) {
-//		dm_output_to_console("%s: Invalid parameters\n", __func__);
-//		return false;
-//	}
-//
-//	dsc_init_reg_values(dsc_reg_vals);
-//
-//	/* Copy input config */
-//	/*dsc_reg_vals->pixel_format = dsc_dc_pixel_encoding_to_dsc_pixel_format(dsc_cfg->pixel_encoding, dsc_cfg->dc_dsc_cfg.ycbcr422_simple);
-//	dsc_reg_vals->num_slices_h = dsc_cfg->dc_dsc_cfg.num_slices_h;
-//	dsc_reg_vals->num_slices_v = dsc_cfg->dc_dsc_cfg.num_slices_v;
-//	dsc_reg_vals->pps.dsc_version_minor = dsc_cfg->dc_dsc_cfg.version_minor;
-//	dsc_reg_vals->pps.pic_width = dsc_cfg->pic_width;
-//	dsc_reg_vals->pps.pic_height = dsc_cfg->pic_height;
-//	dsc_reg_vals->pps.bits_per_component = dsc_dc_color_depth_to_dsc_bits_per_comp(dsc_cfg->color_depth);
-//	dsc_reg_vals->pps.block_pred_enable = dsc_cfg->dc_dsc_cfg.block_pred_enable;
-//	dsc_reg_vals->pps.line_buf_depth = dsc_cfg->dc_dsc_cfg.linebuf_depth;
-//	dsc_reg_vals->alternate_ich_encoding_en = dsc_reg_vals->pps.dsc_version_minor == 1 ? 0 : 1;
-//	dsc_reg_vals->ich_reset_at_eol = (dsc_cfg->is_odm || dsc_reg_vals->num_slices_h > 1) ? 0xF : 0;
-//
-//	// TODO: in addition to validating slice height (pic height must be divisible by slice height),
-//	// see what happens when the same condition doesn't apply for slice_width/pic_width.
-//	dsc_reg_vals->pps.slice_width = dsc_cfg->pic_width / dsc_cfg->dc_dsc_cfg.num_slices_h;
-//	dsc_reg_vals->pps.slice_height = dsc_cfg->pic_height / dsc_cfg->dc_dsc_cfg.num_slices_v;
-//
-//	ASSERT(dsc_reg_vals->pps.slice_height * dsc_cfg->dc_dsc_cfg.num_slices_v == dsc_cfg->pic_height);
-//	if (!(dsc_reg_vals->pps.slice_height * dsc_cfg->dc_dsc_cfg.num_slices_v == dsc_cfg->pic_height)) {
-//		dm_output_to_console("%s: pix height %d not divisible by num_slices_v %d\n\n", __func__, dsc_cfg->pic_height, dsc_cfg->dc_dsc_cfg.num_slices_v);
-//		return false;
-//	}
-//
-//	dsc_reg_vals->bpp_x32 = dsc_cfg->dc_dsc_cfg.bits_per_pixel << 1;
-//	if (dsc_reg_vals->pixel_format == DSC_PIXFMT_NATIVE_YCBCR420 || dsc_reg_vals->pixel_format == DSC_PIXFMT_NATIVE_YCBCR422)
-//		dsc_reg_vals->pps.bits_per_pixel = dsc_reg_vals->bpp_x32;
-//	else
-//		dsc_reg_vals->pps.bits_per_pixel = dsc_reg_vals->bpp_x32 >> 1;
-//
-//	dsc_reg_vals->pps.convert_rgb = dsc_reg_vals->pixel_format == DSC_PIXFMT_RGB ? 1 : 0;
-//	dsc_reg_vals->pps.native_422 = (dsc_reg_vals->pixel_format == DSC_PIXFMT_NATIVE_YCBCR422);
-//	dsc_reg_vals->pps.native_420 = (dsc_reg_vals->pixel_format == DSC_PIXFMT_NATIVE_YCBCR420);
-//	dsc_reg_vals->pps.simple_422 = (dsc_reg_vals->pixel_format == DSC_PIXFMT_SIMPLE_YCBCR422);
-//
-//	calc_rc_params(&rc, &dsc_reg_vals->pps);
-//
-//	if (dsc_cfg->dc_dsc_cfg.rc_params_ovrd)
-//		dsc_override_rc_params(&rc, dsc_cfg->dc_dsc_cfg.rc_params_ovrd);
-//
-//	if (dscc_compute_dsc_parameters(&dsc_reg_vals->pps, &rc, &dsc_params)) {
-//		dm_output_to_console("%s: DSC config failed\n", __func__);
-//		return false;
-//	}
-//
-//	dsc_update_from_dsc_parameters(dsc_reg_vals, &dsc_params);
-//
-//	dsc_optc_cfg->bytes_per_pixel = dsc_params.bytes_per_pixel;
-//	dsc_optc_cfg->slice_width = dsc_reg_vals->pps.slice_width;
-//	dsc_optc_cfg->is_pixel_format_444 = dsc_reg_vals->pixel_format == DSC_PIXFMT_RGB ||
-//					dsc_reg_vals->pixel_format == DSC_PIXFMT_YCBCR444 ||
-//					dsc_reg_vals->pixel_format == DSC_PIXFMT_SIMPLE_YCBCR422;
-//
-//	return true;
-//}
-//static enum dsc_pixel_format dsc_dc_pixel_encoding_to_dsc_pixel_format(enum dc_pixel_encoding dc_pix_enc, bool is_ycbcr422_simple)
-//{
-//	enum dsc_pixel_format dsc_pix_fmt = DSC_PIXFMT_UNKNOWN;
-//
-//	/* NOTE: We don't support DSC_PIXFMT_SIMPLE_YCBCR422 */
-//
-//	/*switch (dc_pix_enc) {
-//	case PIXEL_ENCODING_RGB:
-//		dsc_pix_fmt = DSC_PIXFMT_RGB;
-//		break;
-//	case PIXEL_ENCODING_YCBCR422:
-//		if (is_ycbcr422_simple)
-//			dsc_pix_fmt = DSC_PIXFMT_SIMPLE_YCBCR422;
-//		else
-//			dsc_pix_fmt = DSC_PIXFMT_NATIVE_YCBCR422;
-//		break;
-//	case PIXEL_ENCODING_YCBCR444:
-//		dsc_pix_fmt = DSC_PIXFMT_YCBCR444;
-//		break;
-//	case PIXEL_ENCODING_YCBCR420:
-//		dsc_pix_fmt = DSC_PIXFMT_NATIVE_YCBCR420;
-//		break;
-//	default:
-//		dsc_pix_fmt = DSC_PIXFMT_UNKNOWN;
-//		break;
-//	}
-//
-//	ASSERT(dsc_pix_fmt != DSC_PIXFMT_UNKNOWN);
-//	return dsc_pix_fmt;
-//}
-//static enum dsc_bits_per_comp dsc_dc_color_depth_to_dsc_bits_per_comp(enum dc_color_depth dc_color_depth)
-//{
-//	enum dsc_bits_per_comp bpc = DSC_BPC_UNKNOWN;
-//
-//	switch (dc_color_depth) {
-//	case COLOR_DEPTH_888:
-//		bpc = DSC_BPC_8;
-//		break;
-//	case COLOR_DEPTH_101010:
-//		bpc = DSC_BPC_10;
-//		break;
-//	case COLOR_DEPTH_121212:
-//		bpc = DSC_BPC_12;
-//		break;
-//	default:
-//		bpc = DSC_BPC_UNKNOWN;
-//		break;
-//	}
-//
-//	return bpc;
-//}
-//static void dsc_init_reg_values(struct dsc_reg_values *reg_vals)
-//{
-//	int i;
-//
-//	memset(reg_vals, 0, sizeof(struct dsc_reg_values));
-//
-//	/* Non-PPS values */
-//	/*reg_vals->dsc_clock_enable            = 1;
-//	reg_vals->dsc_clock_gating_disable    = 0;
-//	reg_vals->underflow_recovery_en       = 0;
-//	reg_vals->underflow_occurred_int_en   = 0;
-//	reg_vals->underflow_occurred_status   = 0;
-//	reg_vals->ich_reset_at_eol            = 0;
-//	reg_vals->alternate_ich_encoding_en   = 0;
-//	reg_vals->rc_buffer_model_size        = 0;
-//	/*reg_vals->disable_ich                 = 0;*/
-//	/*reg_vals->dsc_dbg_en                  = 0;
-//
-//	for (i = 0; i < 4; i++)
-//		reg_vals->rc_buffer_model_overflow_int_en[i] = 0;
-//
-//	/* PPS values */
-//	/*reg_vals->pps.dsc_version_minor           = 2;
-//	reg_vals->pps.dsc_version_major           = 1;
-//	reg_vals->pps.line_buf_depth              = 9;
-//	reg_vals->pps.bits_per_component          = 8;
-//	reg_vals->pps.block_pred_enable           = 1;
-//	reg_vals->pps.slice_chunk_size            = 0;
-//	reg_vals->pps.pic_width                   = 0;
-//	reg_vals->pps.pic_height                  = 0;
-//	reg_vals->pps.slice_width                 = 0;
-//	reg_vals->pps.slice_height                = 0;
-//	reg_vals->pps.initial_xmit_delay          = 170;
-//	reg_vals->pps.initial_dec_delay           = 0;
-//	reg_vals->pps.initial_scale_value         = 0;
-//	reg_vals->pps.scale_increment_interval    = 0;
-//	reg_vals->pps.scale_decrement_interval    = 0;
-//	reg_vals->pps.nfl_bpg_offset              = 0;
-//	reg_vals->pps.slice_bpg_offset            = 0;
-//	reg_vals->pps.nsl_bpg_offset              = 0;
-//	reg_vals->pps.initial_offset              = 6144;
-//	reg_vals->pps.final_offset                = 0;
-//	reg_vals->pps.flatness_min_qp             = 3;
-//	reg_vals->pps.flatness_max_qp             = 12;
-//	reg_vals->pps.rc_model_size               = 8192;
-//	reg_vals->pps.rc_edge_factor              = 6;
-//	reg_vals->pps.rc_quant_incr_limit0        = 11;
-//	reg_vals->pps.rc_quant_incr_limit1        = 11;
-//	reg_vals->pps.rc_tgt_offset_low           = 3;
-//	reg_vals->pps.rc_tgt_offset_high          = 3;
-//}
-/* Updates dsc_reg_values::reg_vals::xxx fields based on the values from computed params.
- * This is required because dscc_compute_dsc_parameters returns a modified PPS, which in turn
- * affects non-PPS register values.
- */
-//static void dsc_update_from_dsc_parameters(struct dsc_reg_values *reg_vals, const struct dsc_parameters *dsc_params)
-//{
-//	int i;
-//
-//	reg_vals->pps = dsc_params->pps;
-//
-//	// pps_computed will have the "expanded" values; need to shift them to make them fit for regs.
-//	for (i = 0; i < NUM_BUF_RANGES - 1; i++)
-//		reg_vals->pps.rc_buf_thresh[i] = reg_vals->pps.rc_buf_thresh[i] >> 6;
-//
-//	reg_vals->rc_buffer_model_size = dsc_params->rc_buffer_model_size;
-//}
 static void dsc_write_to_registers(struct display_stream_compressor *dsc, const struct dsc_reg_values *reg_vals)
 {
 	uint32_t temp_int;
-- 
2.34.1

