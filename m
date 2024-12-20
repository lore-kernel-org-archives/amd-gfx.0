Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 042C5E77188
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2024 21:51:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83C7F10F068;
	Fri, 20 Dec 2024 21:51:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fqi6R4KL";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F2B810F068
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2024 21:51:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aFqMYICO0pao+jBZLcZQKyDQcf5NenR3wueAf2Sx2K/AH42C2BawoMwcAoLWVGlfZOAo6MCrYAFj12J8LABfO46K/Sfh6SVVcr6VJp38/3zhXMqKsoao0EAEOWiYIszclwDB87ZtvmSIQ2dlA6sVWemvwRXwa7SzWCsnAtlaFP858d5G6Iwxsa3kvdwA5pc0+WmtSS4cGa0gu50jQW8ADmJjyMKuBRR1o4lhkAcgz0QNCztu2ZGslNkzErdwaJKH3yj8PLN06iBoGzG6yI/H4v+z6MhEiwPXIvhOItMfXTepTlFrfERaJGozm29eBUhW6shH4eWyK7Iclj3LvJ19zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PxQlO1wdsung3BEYV8SlH1RKPVgyHBjvB/X6PNegOos=;
 b=BKU7O6oxohr6uuaqXinXVk3QJ/6/C/DgJXkujddkKETCQqb1VQ2l2OAlsxw/7WysG27Ym2HYXqF06uOiaQ5BrGLvH2QLbUgS5hGz+aNSMGKP/YQkNajou4S4Pwg4lueb/P2UjCh8enAWutzJpu/jJxY5qULgQcuYfHFmZm9Jy67QjoioCa87hqlLb1cC4KBw7QM02Qwds9eWdRcVkaOFZOqq73z/cJXq4Rf7mOG1ANhyhP7SvQU/jPQD1y/Sx78eXeO9VAm3jbYIWnEIe4x/5Uhs2G+dftmaiyD8SIBcyYQs1ld0BAnPegGq5WYtyAEVhF8DRGe+HsaR9E+YI/gD8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxQlO1wdsung3BEYV8SlH1RKPVgyHBjvB/X6PNegOos=;
 b=fqi6R4KLftlcYqMNl8299le+8hfZzQ4kSs19VMg94An1tbN0pFFcerO4VmZ6i621XJU8Mjl42eX3e4980lWIe0SWcAKrfXaOk7nDNULTIBtS4uG6nT/Pq7JRJfDSc2T51Mxseg1DpwapAk6Won2rQZps5wInSLeZBHKuBa5X2BQ=
Received: from SJ0PR13CA0096.namprd13.prod.outlook.com (2603:10b6:a03:2c5::11)
 by SJ0PR12MB7033.namprd12.prod.outlook.com (2603:10b6:a03:448::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Fri, 20 Dec
 2024 21:51:15 +0000
Received: from CO1PEPF000075EE.namprd03.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::5b) by SJ0PR13CA0096.outlook.office365.com
 (2603:10b6:a03:2c5::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.17 via Frontend Transport; Fri,
 20 Dec 2024 21:51:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000075EE.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 20 Dec 2024 21:51:15 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Dec
 2024 15:51:14 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Dec
 2024 15:51:14 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 20 Dec 2024 15:51:08 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Fangzhi Zuo
 <Jerry.Zuo@amd.com>
Subject: [PATCH 12/28] drm/amd/display: Add Interface to Dump DSC Caps from dm
Date: Fri, 20 Dec 2024 16:48:39 -0500
Message-ID: <20241220214855.2608618-13-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241220214855.2608618-1-Roman.Li@amd.com>
References: <20241220214855.2608618-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EE:EE_|SJ0PR12MB7033:EE_
X-MS-Office365-Filtering-Correlation-Id: 755088a5-b785-4052-fcb2-08dd21406d8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Z5c0B9haHA3vt40VE+vwP45hM7zvOJQpY2TzIpWYowlArA3fItMQ3T1uCZL3?=
 =?us-ascii?Q?U9vB1mlY3/y50HM9TlPIKnviojz2bPyY4qYhWQYGxru8LWVa1vSp+jnxqZGF?=
 =?us-ascii?Q?2F13+h/eKlcBLLV4/+rOdue71NMqx2XyWFIddj+OXOUATn0PtCF3ayILvfsG?=
 =?us-ascii?Q?IpuidSQQEzsOKLaP2k57VaRDn2DqKwpFza2cAIa2TbshpRVquyfK1oXPWubC?=
 =?us-ascii?Q?8JUNrwZNqLAbirNdO8tOTrwW637jPOmc2M3TKtcrkir9rOiw8DG/qm1gcX7L?=
 =?us-ascii?Q?UFGrpwUp0pQT7U66Gqkrh7b56j0mgTlXtrsrsmqzGMgxnViRKdTkK97F/9cq?=
 =?us-ascii?Q?fgXtyBKjuOpegZuKkkJbXoeYXIe9x4WwPHYm58zI34Klk1CYcaM1UGfQbR54?=
 =?us-ascii?Q?/h7zeETSX+BpQNsbPivYO9pnCvUU8VxZvceiZAhRNl6ure17hCygVcbYkYbD?=
 =?us-ascii?Q?K/HX8KYVBmfrwVH4RcfKP049K21rNO/2mRvgSEcnj1X/GrPeIXjza2EKWbtw?=
 =?us-ascii?Q?GzCaI4grZYWIenNBLmrP9FnFrqV8AJByIEjW4292MGz2phfHswK/Sr1yNACo?=
 =?us-ascii?Q?EKmaC5UIrdSEjSXgX1Eg86XezaYSGnx52gbGibbsqnqiQeFe3Ed9JaQqirxA?=
 =?us-ascii?Q?Isyh2GMmxfDJMVjP/tKl/mQXE6Oes0WGOxjnbJ4RBgDjBtECVJy/iTFPX3N0?=
 =?us-ascii?Q?iVlpt5P2wMfkfupvkE4n2UX5FfzVIJ3wvKX3aODhE+QgbO0UMhWDxK9jiUYU?=
 =?us-ascii?Q?ZuW+hKupFU619RzV/E01XZUZK05u3wVeade+jKt0pSYNmu2dnSl+YVAhHLUF?=
 =?us-ascii?Q?+77Cy2xxapqm8eA/sWhdF9r363OYuCD1VSORogqDlrKWnBqwYQZm4b2QHojw?=
 =?us-ascii?Q?xojTSco75r5kp3WzUkSfZjViviSibaPoxuEWjBCnopNxINg4AYHTAAdCH09y?=
 =?us-ascii?Q?Tg11P/ZnHpuNfvft/e+BFuZaNGUg7XkbZgdCt9WXKntnu4mMHfEiq6arm+cY?=
 =?us-ascii?Q?fICt33ATiDthNCs4jP6EpsLzALG6oTA3Yp5tiDCgFFOamSAADzz8a8kF6t16?=
 =?us-ascii?Q?g9lxHuqz3+HLXQgcqZilatoCmJrxYI9QuzemElOLKUIZvIQ9lugtvJXV3/w6?=
 =?us-ascii?Q?YU2nq1wAX/g6pr+R88SKLfIvWhc72tAi7b+Lr2D3Z/zOe08KACJqn6BgxDMz?=
 =?us-ascii?Q?B5s4i2j5dmJVB3JHLp/3SHHjhnlCO2vNli0+8mX7jQCTFy5iaDI20v/UUJnU?=
 =?us-ascii?Q?WcZkY7GkCLOsKdQouZ9ga1Qcrhfm8MopfVRGaP5zA6q6w/tDmZcqbu4AABtX?=
 =?us-ascii?Q?03fQP1i9wCG+/BxohxAt6dKhL3B/cuykg/9qlsUOliXMF974qZ0UAdDe3eBp?=
 =?us-ascii?Q?IlPNXy7/CwVO8+D31DDV2mVXfeTJXpak5lQWJpHU4dpOgNzB5WjjOfmoXdVP?=
 =?us-ascii?Q?B9hDwVj4og65s5rwnqCEx3cud9YvMxymgrbxFPCuQTUj+2yOiyH75ar2r/GC?=
 =?us-ascii?Q?BCI0VaCZ3kokb80=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 21:51:15.4405 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 755088a5-b785-4052-fcb2-08dd21406d8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075EE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7033
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

From: Fangzhi Zuo <Jerry.Zuo@amd.com>

No common dsc params found between encoder and decoder is one
of the reason that could prevent dsc from properly enabled.

Dump the params to a specific timing to help locate possible
invalid dsc params in either encoder or decoder side.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dsc.h     |  5 +++
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c | 45 +++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dsc.h b/drivers/gpu/drm/amd/display/dc/dc_dsc.h
index 9014c2409817..9d18f1c08079 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dsc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dsc.h
@@ -94,6 +94,11 @@ uint32_t dc_dsc_stream_bandwidth_overhead_in_kbps(
 		const int num_slices_h,
 		const bool is_dp);
 
+void dc_dsc_dump_decoder_caps(const struct display_stream_compressor *dsc,
+			      const struct dsc_dec_dpcd_caps *dsc_sink_caps);
+void dc_dsc_dump_encoder_caps(const struct display_stream_compressor *dsc,
+			      const struct dc_crtc_timing *timing);
+
 /* TODO - Hardware/specs limitation should be owned by dc dsc and returned to DM,
  * and DM can choose to OVERRIDE the limitation on CASE BY CASE basis.
  * Hardware/specs limitation should not be writable by DM.
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
index d9aaebfa3a0a..11535922b5ff 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
@@ -30,6 +30,9 @@
 #include "rc_calc.h"
 #include "fixed31_32.h"
 
+#define DC_LOGGER \
+	dsc->ctx->logger
+
 /* This module's internal functions */
 
 /* default DSC policy target bitrate limit is 16bpp */
@@ -480,6 +483,48 @@ bool dc_dsc_compute_bandwidth_range(
 	return is_dsc_possible;
 }
 
+void dc_dsc_dump_encoder_caps(const struct display_stream_compressor *dsc,
+			      const struct dc_crtc_timing *timing)
+{
+	struct dsc_enc_caps dsc_enc_caps;
+
+	get_dsc_enc_caps(dsc, &dsc_enc_caps, timing->pix_clk_100hz);
+
+	DC_LOG_DSC("dsc encoder caps:");
+	DC_LOG_DSC("\tdsc_version 0x%x", dsc_enc_caps.dsc_version);
+	DC_LOG_DSC("\tslice_caps 0x%x", dsc_enc_caps.slice_caps.raw);
+	DC_LOG_DSC("\tlb_bit_depth %d", dsc_enc_caps.lb_bit_depth);
+	DC_LOG_DSC("\tis_block_pred_supported %d", dsc_enc_caps.is_block_pred_supported);
+	DC_LOG_DSC("\tcolor_formats 0x%x", dsc_enc_caps.color_formats.raw);
+	DC_LOG_DSC("\tcolor_depth 0x%x", dsc_enc_caps.color_depth.raw);
+	DC_LOG_DSC("\tmax_total_throughput_mps %d", dsc_enc_caps.max_total_throughput_mps);
+	DC_LOG_DSC("\tmax_slice_width %d", dsc_enc_caps.max_slice_width);
+	DC_LOG_DSC("\tbpp_increment_div %d", dsc_enc_caps.bpp_increment_div);
+}
+
+void dc_dsc_dump_decoder_caps(const struct display_stream_compressor *dsc,
+			      const struct dsc_dec_dpcd_caps *dsc_sink_caps)
+{
+	DC_LOG_DSC("dsc decoder caps:");
+	DC_LOG_DSC("\tis_dsc_supported %d", dsc_sink_caps->is_dsc_supported);
+	DC_LOG_DSC("\tdsc_version 0x%x", dsc_sink_caps->dsc_version);
+	DC_LOG_DSC("\trc_buffer_size %d", dsc_sink_caps->rc_buffer_size);
+	DC_LOG_DSC("\tslice_caps1 0x%x", dsc_sink_caps->slice_caps1.raw);
+	DC_LOG_DSC("\tslice_caps2 0x%x", dsc_sink_caps->slice_caps2.raw);
+	DC_LOG_DSC("\tlb_bit_depth %d", dsc_sink_caps->lb_bit_depth);
+	DC_LOG_DSC("\tis_block_pred_supported %d", dsc_sink_caps->is_block_pred_supported);
+	DC_LOG_DSC("\tedp_max_bits_per_pixel %d", dsc_sink_caps->edp_max_bits_per_pixel);
+	DC_LOG_DSC("\tcolor_formats 0x%x", dsc_sink_caps->color_formats.raw);
+	DC_LOG_DSC("\tthroughput_mode_0_mps %d", dsc_sink_caps->throughput_mode_0_mps);
+	DC_LOG_DSC("\tthroughput_mode_1_mps %d", dsc_sink_caps->throughput_mode_1_mps);
+	DC_LOG_DSC("\tmax_slice_width %d", dsc_sink_caps->max_slice_width);
+	DC_LOG_DSC("\tbpp_increment_div %d", dsc_sink_caps->bpp_increment_div);
+	DC_LOG_DSC("\tbranch_overall_throughput_0_mps %d", dsc_sink_caps->branch_overall_throughput_0_mps);
+	DC_LOG_DSC("\tbranch_overall_throughput_1_mps %d", dsc_sink_caps->branch_overall_throughput_1_mps);
+	DC_LOG_DSC("\tbranch_max_line_width %d", dsc_sink_caps->branch_max_line_width);
+	DC_LOG_DSC("\tis_dp %d", dsc_sink_caps->is_dp);
+}
+
 static void get_dsc_enc_caps(
 		const struct display_stream_compressor *dsc,
 		struct dsc_enc_caps *dsc_enc_caps,
-- 
2.34.1

