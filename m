Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E66BBC52D7F
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Aug 2024 22:45:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CAB810E541;
	Thu, 15 Aug 2024 22:45:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZWppZJHX";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25E4510E545
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Aug 2024 22:45:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nf/74OVZSRdcSXlKNx6mHJmmxyaldB84cp9+hb41HhA4U+DAU4VQfmUxkGmvjwNOwv+qU4T9YpdYkSh9MNQStnFiD/5eU33c414xeKBmVUh/ESnE+wW06mPqgg8PXvFw/f2lwKKNCyrjc97pGr/NCDdYdiGh81RqLKcc+guOkyOkIFKfmJIdjHeLsDLjtZcln50MM5dYMOjyNHa+RFrvJdcN0DiLUilI0iZVmzNzpvBobgwfoy2+OgMtFIoarO9ibfm7Ecltd05e1Qv26V3lNcyriYwsJljSB80gMdRWLuegwSbdcVN5KuRi/aDoZUV7Hf7IYhWyCEtLn6OpsiojQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yq3BhuPp8Fqfb5bOf/fAVDdi6ZGjGaRGYCdeRuQvU9Q=;
 b=hd1S2WS3uKRQdT/ADtP9JaC4fINJvgA8/AS69s5JRYW9HYXKCue39P5QL5yCjsQWFQv2an7nK+esB5JQcYcaBk0IKc76rA383m0D6yhBzm3XwMFmiN5bBTHZxV6avCIpSKDrcRiPzmomXZLNfxm3t865kM7A8leWflTOFxHwERXvUEk+U3MzZiE2fRhW1tHiUgoMeFjZsr+G8+bM/hV+Y0Rxbp7a4c5zhRqeaPIEcxoNqWAQUh2uDEU+Df7J5zuMPvVVh3OE73AHIUbulLrMeLw2EvJMrc3Sya/FQpqhwSaRKtbcr9uS2Nd/tPguXC2qGInhfc0H8QzE8JWPlyPeeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yq3BhuPp8Fqfb5bOf/fAVDdi6ZGjGaRGYCdeRuQvU9Q=;
 b=ZWppZJHXoxaKJgkNSl7b/S1hencKJ25cBCreK3RGfop0RcXT4wFNzwL0PnpjS90veemGc3pZzTTL5ICmX3QMeCrA53uTBOMXuM1uT3be6R+JkgovOkv92eicP/Jxfsl9xwC22NcfpS4u4412YlBGWGY4NxevP1m0QljLqvrL4wE=
Received: from BN0PR03CA0052.namprd03.prod.outlook.com (2603:10b6:408:e7::27)
 by IA0PR12MB8253.namprd12.prod.outlook.com (2603:10b6:208:402::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 22:45:43 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:408:e7:cafe::cd) by BN0PR03CA0052.outlook.office365.com
 (2603:10b6:408:e7::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33 via Frontend
 Transport; Thu, 15 Aug 2024 22:45:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 22:45:43 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 15 Aug
 2024 17:45:42 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 15 Aug 2024 17:45:41 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Sung Joon Kim
 <Sungjoon.Kim@amd.com>, Wenjing Liu <wenjing.liu@amd.com>
Subject: [PATCH 07/13] drm/amd/display: Support UHBR10 link rate on eDP
Date: Thu, 15 Aug 2024 18:45:19 -0400
Message-ID: <20240815224525.3077505-8-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815224525.3077505-1-Roman.Li@amd.com>
References: <20240815224525.3077505-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|IA0PR12MB8253:EE_
X-MS-Office365-Filtering-Correlation-Id: ee8c9e2b-b0d0-4f61-8e8d-08dcbd7bfead
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?99jzUDvSK3Picsx4QLs1q2aJ+FL2V6Ny4nrV5tchJmdwCTx/Lv4RgH0NIUmA?=
 =?us-ascii?Q?c54rqK0xTIVP1z1ViIgq0ZSIwDdq+7N83yQelxvc2gihBU5d0pCSaXkgblsA?=
 =?us-ascii?Q?a8qhiV5z2R0EWLinqcIWLBq6KTwTH/arQhFgCQqwBRpcaBJoQhEf+negJem0?=
 =?us-ascii?Q?VLDZBzYfPIrsnQqZafD04iA2wWHT0PlgITfjm4s8hCoyMJx+bKLInYPNpOdu?=
 =?us-ascii?Q?DRmAnnwqLbFah/LYQVmm7plCip7ChS7aHSl51BEH3gzl8Ezp5WuA5hgarTLd?=
 =?us-ascii?Q?9QSMTHKh5tepltjYd67Ze7v7fKNdCPD2vx1MZkUaTXz1ZMtYYYvMM0AE0CoX?=
 =?us-ascii?Q?OU1t5goGfoakvms5RK5/veIK2Ioo3XdNqZjCXLStoeEISA86V+6AxqNl2Vzs?=
 =?us-ascii?Q?2OuBfN7ON3LON+tEGupwt7Xon7HjCkrHXnx9ATz/A89H28Nl/XU3jp4vTNfC?=
 =?us-ascii?Q?Jyv0VNJvp2n5TtPVX6iUwb7L7AmfvxzkKq1jppSjUWmjwQkNlwYy26wE+wlZ?=
 =?us-ascii?Q?T1RtrC++gDUmSQd9gkYNi3kWw1Wf53M/AjgRjRkSAaXNRpDE8Qt/LNMm4Xp5?=
 =?us-ascii?Q?0osryEBWP9H40SGV7/MgWGcRzsU8L4LUlq072wq+bvqz3ETQRY88t51k4fzo?=
 =?us-ascii?Q?At2qwUnP78Li5E6rHRX0jxzmYBMgpHk0gSExHbf+APyILkdJYCy/6VgvwpHP?=
 =?us-ascii?Q?pQYa5p6SnYsZUDrMzQsxQwQzUvONiOARW3OOzHABbpdXDLRKtt9aWFS5MQfE?=
 =?us-ascii?Q?zIeJvnn768QFBwy6XI86+4NgBsl7NFJaV6eGq0n10XorkdiWYoaZFQZjESct?=
 =?us-ascii?Q?oO7/xTbaRPM2qiqr/Z7jcTmCU9KECnbjUdiD7UFFf0O98eyAnWeCMOlbu/5/?=
 =?us-ascii?Q?8Tjt0bd5fYlPN2ZkjSmd4biK7qQ5VEFGzzSQfP8Hxgz+RtJzeGaj3PynkMdD?=
 =?us-ascii?Q?+p0Ha9wr2P7AAbIDgSExL1LRXKV8Md3VIcNdXLOI4L/VJe/kthf6kIPOrSeT?=
 =?us-ascii?Q?a1GRffjRvSWwx5bj5twwMAlkfeFTesgCAW6dkj8+ieNg1m9P3QAQgwBMfS/l?=
 =?us-ascii?Q?wpTQzb/y1dDri7GWOMpa8w6BAJNDi3CKMfQp8maOWEm+z31mklFNZ9+0zDxK?=
 =?us-ascii?Q?sRvMwFL1IbsNs9+MPAslk9jPaRQ1ns6n0eRBvJU6+5sV+jqx0J/wLZFI81Ca?=
 =?us-ascii?Q?qoHW6QjBVsIeDMEczje/pDNxXFmrEkHICkImZPDDvfN4JZH2LBPeU87EVCXM?=
 =?us-ascii?Q?CiX9pHaAW9cXiYBN0msR4F0Xjb71Y7MClZ4ohVD5tMN2CRZjyo5PzyhIm0jA?=
 =?us-ascii?Q?SRcbERCjZuE3B9yfooYNPi12kCav/+4KayAPDWjOCnhECIw4oDT/Pl219knI?=
 =?us-ascii?Q?ZyWEUCbNW4LK9Texta+PWyeVJdH7vUbJNJphuTQ/730bJsnTasv6gNING8Vi?=
 =?us-ascii?Q?C7GEHMvrvyV4JNa/JlWSKDxLRFbO5J5x?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 22:45:43.0400 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee8c9e2b-b0d0-4f61-8e8d-08dcbd7bfead
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8253
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

From: Sung Joon Kim <Sungjoon.Kim@amd.com>

[why]
Supporting UHBR10 link rate on eDP leverages
the existing DP2.0 code but need to add some small
adjustments in code.

[how]
Acknowledge the given DPCD caps for UHBR10
link rate support and allow DP2.0 programming
sequence and link training for eDP.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Sung Joon Kim <Sungjoon.Kim@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 23 ++++++++++---------
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  4 ++--
 .../link/protocols/link_edp_panel_control.c   |  3 +++
 4 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 6b036417a73a..3de311533571 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1760,6 +1760,7 @@ struct dc_link {
 		bool dongle_mode_timing_override;
 		bool blank_stream_on_ocs_change;
 		bool read_dpcd204h_on_irq_hpd;
+		bool disable_assr_for_uhbr;
 	} wa_flags;
 	struct link_mst_stream_allocation_table mst_stream_alloc_table;
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 246fa300ee95..d52ce58c6a98 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1232,20 +1232,21 @@ void dce110_blank_stream(struct pipe_ctx *pipe_ctx)
 			 * has changed or they enter protection state and hang.
 			 */
 			msleep(60);
-		} else if (pipe_ctx->stream->signal == SIGNAL_TYPE_EDP) {
-			if (!link->dc->config.edp_no_power_sequencing) {
-				/*
-				 * Sometimes, DP receiver chip power-controlled externally by an
-				 * Embedded Controller could be treated and used as eDP,
-				 * if it drives mobile display. In this case,
-				 * we shouldn't be doing power-sequencing, hence we can skip
-				 * waiting for T9-ready.
-				 */
-				link->dc->link_srv->edp_receiver_ready_T9(link);
-			}
 		}
 	}
 
+	if (pipe_ctx->stream->signal == SIGNAL_TYPE_EDP &&
+	    !link->dc->config.edp_no_power_sequencing) {
+			/*
+			 * Sometimes, DP receiver chip power-controlled externally by an
+			 * Embedded Controller could be treated and used as eDP,
+			 * if it drives mobile display. In this case,
+			 * we shouldn't be doing power-sequencing, hence we can skip
+			 * waiting for T9-ready.
+			 */
+		link->dc->link_srv->edp_receiver_ready_T9(link);
+	}
+
 }
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index d6550b904b16..c4e03482ba9a 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -2358,7 +2358,7 @@ void link_set_dpms_off(struct pipe_ctx *pipe_ctx)
 
 	if (pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST)
 		deallocate_mst_payload(pipe_ctx);
-	else if (pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT &&
+	else if (dc_is_dp_sst_signal(pipe_ctx->stream->signal) &&
 			dp_is_128b_132b_signal(pipe_ctx))
 		update_sst_payload(pipe_ctx, false);
 
@@ -2591,7 +2591,7 @@ void link_set_dpms_on(
 
 	if (pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST)
 		allocate_mst_payload(pipe_ctx);
-	else if (pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT &&
+	else if (dc_is_dp_sst_signal(pipe_ctx->stream->signal) &&
 			dp_is_128b_132b_signal(pipe_ctx))
 		update_sst_payload(pipe_ctx, true);
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index 070b6c8c1aef..3aa05a2be6c0 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -1168,6 +1168,9 @@ static void edp_set_assr_enable(const struct dc *pDC, struct dc_link *link,
 	link_enc_index = link->link_enc->transmitter - TRANSMITTER_UNIPHY_A;
 
 	if (link_res->hpo_dp_link_enc) {
+		if (link->wa_flags.disable_assr_for_uhbr)
+			return;
+
 		link_enc_index = link_res->hpo_dp_link_enc->inst;
 		use_hpo_dp_link_enc = true;
 	}
-- 
2.34.1

