Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41811C3DA7E
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 18:04:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8A0210E8A9;
	Thu, 25 Jul 2024 18:04:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X7ErdVWi";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2081.outbound.protection.outlook.com [40.107.96.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2DF910E89B
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 18:04:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CtrfxXWsB04HshZ2oNX+VhLAs6fmLsROYySpC5KL8j3pjHRmLPmHqFCageSnoKHj7Dai9MWy/WbfMIESTq4GQ6LBwzJJ5dmk/VuC+o/i8xKyrMI+eoBnezE4MeEJtWAZsGocojbRZWRbXlRckBABB7j0WbQeQ6l+kZFLwZe0wgJvZnD1FN3QBbyVp29JL/na/dAsZhKcQ/57mWyU1lE96VM8PCDUUbvkXLZUirIviE+IKp4w9ueX6Tzci/C7Yf4k5bCa4FnbV8IXje/ZvB00pXbDsRa6tdPQC8nb4XziwY+vR/cG1wpA/NLBERb0l+p47nphQRCGTLXeNFdXla5I2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oE2tIu/F6k2NfTpj7J2Wb7mDrBTMXl81j3Qf5TdZWMo=;
 b=XbWHVOq2wzltgEbxxPpGpHJvq2ZWZNx+uLNlQSvwfy9GncRNzY8jL5kpXGrYpls4r/u9PoMiyxpMgFQTjl6hoY3Ma7Bn1+iaW/fcxE+NQIWivX/jUxe08+eRk5Ucmns7jq0xghEmgnp/p6dqt2wyyjz/aG+QOVoSgu3tY+46ZUkCDVCgINMfuXgJLb5YtFFQ2RHgW9sTZolPwMdQkf7gUSPLtgbTn/p0gQ8S2FrXVae6DAfLTQcwLncas5EvJQesvSOCkY1zo804BwkRXcVLt33Whewc+D2rJtkJLpgQ+uCG8DIIA8hoh87VYNL93uFuhxhdbv/x94MaLHUS+gi8eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oE2tIu/F6k2NfTpj7J2Wb7mDrBTMXl81j3Qf5TdZWMo=;
 b=X7ErdVWiSFZSL2NJXHrDswj5VIc51a6Ehq1hXyIn51YiYOouRVIii2ITd36Z4G6ZgZXIRKpJUsRxQfvQlJJZTcbzQ839DGjipEDshqo0B0SbqKQi9uU2vyZQ21laCarXLXvM0RqaHtNRFqnSUaE0sEPl3o49FuP+crRZ2AXrUTQ=
Received: from CH2PR18CA0023.namprd18.prod.outlook.com (2603:10b6:610:4f::33)
 by IA0PR12MB7723.namprd12.prod.outlook.com (2603:10b6:208:431::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Thu, 25 Jul
 2024 18:04:02 +0000
Received: from CH2PEPF0000013B.namprd02.prod.outlook.com
 (2603:10b6:610:4f:cafe::3f) by CH2PR18CA0023.outlook.office365.com
 (2603:10b6:610:4f::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Thu, 25 Jul 2024 18:04:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013B.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 18:04:02 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 13:03:59 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Duncan Ma <duncan.ma@amd.com>, "Rodrigo
 Siqueira" <rodrigo.siqueira@amd.com>
Subject: [PATCH 15/39] drm/amd/display: Add seamless boot support for more DIG
 operation modes
Date: Thu, 25 Jul 2024 12:00:59 -0600
Message-ID: <20240725180309.105968-16-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
References: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013B:EE_|IA0PR12MB7723:EE_
X-MS-Office365-Filtering-Correlation-Id: 78072d41-23f5-4b86-c1a1-08dcacd42a74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?d5cJvVP/yH21Bs5GJhd3tn3wQhajDTx/WU5DHWCYXVr7yMLCyxjQwWO1d7py?=
 =?us-ascii?Q?O6dUpLg/JCRnM6b/lN78x43svQCA/nLbhxWNz8KxKgOBwUVIA/i20lrY42OG?=
 =?us-ascii?Q?gP+G85tVRjLNc9q79qOsyMh8N0i1g6Ih7gqCAMR1An8pZ45kGM9KoULXnhQB?=
 =?us-ascii?Q?z+hBNF3NpshvNJtFQG4+ipqENk0yGnwR/+8fhlVxJgZb5J5jLrQteUtAXK1r?=
 =?us-ascii?Q?EXWrOYNbZ2Wtfppt4QaGbqqo9g2q60fE82EeZOvlJR+BIkMno7C1C7t1Xwkv?=
 =?us-ascii?Q?BZaeaubYYvIvbxyojNJBV4FzohquJRTloSByvTNP341ruUk/W29NsNVyHQjZ?=
 =?us-ascii?Q?Z/q/4Vv6QFAGbyXzpmkGYs4K8DOJTxt84/0+rK87dwkBDAAIaufq5+nPBL5O?=
 =?us-ascii?Q?D9JR8uPWVcoeFdI51u9xHZ38e9B3DfpU7+taSBtAgjPAAsPoq5nMSYG0u1oq?=
 =?us-ascii?Q?8KmKSG2QHmpcOiu4VWyM0DGhjuTx8kDgAy3o6TNujIGwTLqXj50T1QuhWFiQ?=
 =?us-ascii?Q?DIqXe+1YIPExz0baNAYAO37mMhyqk5XplWbNgPk0n6o0xXh7GQmUttZ3DT5e?=
 =?us-ascii?Q?TxCBWz0N6VZMxiC0Qgz/XJksujOB01InuIZalKQ+PZYzxk8uAxdrRHcMPb/q?=
 =?us-ascii?Q?CKMZgB+7/TThfyYAax6ALci5ulY1JckNS+s9N7D6bXs8LLiKLbFVOqweT1iM?=
 =?us-ascii?Q?u/FG+D0SjQrFSFlafMgcF+fGvs8dT+22mmQnv1Ua54rfw7qDy0pWm8eYEha3?=
 =?us-ascii?Q?ANKgFKrwaTrV5kyeyttt+DMJxLCY4nuS3xazk1rdGpPNdFxGzQZ3bWm68o/m?=
 =?us-ascii?Q?qiNnvs2d+zwN5LC4gkuvU7msM4lVKDkQ+2exaEBgkXvQXDsqqzDReOKh8rem?=
 =?us-ascii?Q?hbdqX4d48H4dFRVDd8mO5aqFJzwpoKB0sO+5li6Td6YAzEpryaoJSqsJmpo0?=
 =?us-ascii?Q?x3FfnABHtQ1/6Tq4kCBRjJrx/04J6VkQgUHcgq+u4MxMoBiFJGTAfiu0LWIL?=
 =?us-ascii?Q?JbFFjhz/MAMfKiTFApBCsL7g5z702my+8TvzcipIAF9c3ibOnZb4SSAdqNP+?=
 =?us-ascii?Q?j5I+Ouj9nmj/zHUYyEQeXUyPTsiwbgVOObrqyqKBUTr4ZHnnIpGJ81flfyGu?=
 =?us-ascii?Q?QDsHFIGxgvCnAgpdRiDWsRfY7F3EBTn7bmXvVmb/Ki5+SmrsQvIjjuQK0B5p?=
 =?us-ascii?Q?/7cZJ+lM3A5dJc8zwHfciNxPXOyAr703a24wQ+EK41pytSfj+bnSlqOsMyDb?=
 =?us-ascii?Q?2a8U5xWMmtrvFYSoc9ur/oF96VTPfbfjZgxni+XtSMgjhWTnf84V26DhxE+g?=
 =?us-ascii?Q?ZnTHWuFpEX72F+RRHbMNxj8103ZAioYWoePk4DY7UY9hJIJ3YW4iG24Wdu7v?=
 =?us-ascii?Q?a1RRKv2g9bRd6ONhcCDGnCxBN9ecAv8NZB1au2d0xlVM/CIRRnV5OOWav/6N?=
 =?us-ascii?Q?zNtebCff9mDYsIAk1vuCyiwJuuABvUkQ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 18:04:02.2763 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78072d41-23f5-4b86-c1a1-08dcacd42a74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7723
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
When pre-OS firmware enables display support for displays that operate
the DIG in 2 pixels per cycle processing modes the inferred pixel rate
from get_pixel_clk_frequency_100hz does not account for the true pixel
rate since we're outputting 2 per cycle past the stream encoder.

This causes seamless boot validation to abort early.

[How]
Add a new stream encoder function for getting pixels per cycle from the
stream encoder. If the pixels per cycle is greater than 1 and the driver
policy is to enable 2 pixels per cycle for post-OS then allow seamless
boot to continue.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Duncan Ma <duncan.ma@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 12 ++++++++++--
 .../dc/dio/dcn35/dcn35_dio_stream_encoder.c   | 19 +++++++++++++++++++
 .../amd/display/dc/inc/hw/stream_encoder.h    |  1 +
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index ed811352506e..143415d600ac 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1823,10 +1823,18 @@ bool dc_validate_boot_timing(const struct dc *dc,
 			tg->funcs->get_optc_source(tg,
 						&numOdmPipes, &id_src[0], &id_src[1]);
 
-		if (numOdmPipes == 2)
+		if (numOdmPipes == 2) {
 			pix_clk_100hz *= 2;
-		if (numOdmPipes == 4)
+		} else if (numOdmPipes == 4) {
 			pix_clk_100hz *= 4;
+		} else if (se && se->funcs->get_pixels_per_cycle) {
+			uint32_t pixels_per_cycle = se->funcs->get_pixels_per_cycle(se);
+
+			if (pixels_per_cycle != 1 && !dc->debug.enable_dp_dig_pixel_rate_div_policy)
+				return false;
+
+			pix_clk_100hz *= pixels_per_cycle;
+		}
 
 		// Note: In rare cases, HW pixclk may differ from crtc's pixclk
 		// slightly due to rounding issues in 10 kHz units.
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_stream_encoder.c
index 19e50fbf908d..6ab2a218b769 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_stream_encoder.c
@@ -422,6 +422,24 @@ void enc35_enable_fifo(struct stream_encoder *enc)
 	REG_UPDATE(DIG_FIFO_CTRL0, DIG_FIFO_ENABLE, 1);
 }
 
+static uint32_t enc35_get_pixels_per_cycle(struct stream_encoder *enc)
+{
+	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
+	uint32_t value;
+
+	REG_GET(DIG_FIFO_CTRL0, DIG_FIFO_OUTPUT_PIXEL_MODE, &value);
+
+	switch (value) {
+	case 0:
+		return 1;
+	case 1:
+		return 2;
+	default:
+		ASSERT_CRITICAL(false);
+		return 1;
+	}
+}
+
 static const struct stream_encoder_funcs dcn35_str_enc_funcs = {
 	.dp_set_odm_combine =
 		enc314_dp_set_odm_combine,
@@ -474,6 +492,7 @@ static const struct stream_encoder_funcs dcn35_str_enc_funcs = {
 	.disable_fifo = enc35_disable_fifo,
 	.is_fifo_enabled = enc35_is_fifo_enabled,
 	.map_stream_to_link = enc35_stream_encoder_map_to_link,
+	.get_pixels_per_cycle = enc35_get_pixels_per_cycle,
 };
 
 void dcn35_dio_stream_encoder_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h b/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
index 6fe42120738d..fe7f3137f228 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
@@ -273,6 +273,7 @@ struct stream_encoder_funcs {
 	void (*disable_fifo)(struct stream_encoder *enc);
 	bool (*is_fifo_enabled)(struct stream_encoder *enc);
 	void (*map_stream_to_link)(struct stream_encoder *enc, uint32_t stream_enc_inst, uint32_t link_enc_inst);
+	uint32_t (*get_pixels_per_cycle)(struct stream_encoder *enc);
 };
 
 struct hpo_dp_stream_encoder_state {
-- 
2.43.0

