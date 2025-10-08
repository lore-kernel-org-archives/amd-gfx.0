Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CCC1CAC5BB
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Oct 2025 18:49:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2481710E8A7;
	Wed,  8 Oct 2025 18:49:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XcOnsgPE";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012021.outbound.protection.outlook.com [52.101.53.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C72C710E8A7
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Oct 2025 18:49:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z7xE+hQLQkQ8ZQCKQ2TseYVIPE4FrvBkZ7CEvG9mD4GlhRzOAlher75K7QZrZ4R0sDhPVTZr2yevlM5Kf9s62yGzp/zP9RW8RingZ50YwD/+8GxeQnNADEz8ewoicmgdzfoBGVE8FZDeBfftP5WNGV3gmR7wXIV2vhRf4EZjaYB4scK88IzJd18C//o6RsUJ5iOQ1vu90L+ZK80yTUX4WE1ykNZo6JiUodpPlZQ5TjQNBNnqxc8T0XW4gesnR9SVYvouuoCwepjP51KgHLhdEy65EkEB0JDM+dLxD+ef6Oz0GG/GxmYVd5NqC5KGLkym2he5VdGYnkyv09DQ/aXqbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KGnszDuOT7pGHOBLkqnkiru28NVLPoXuxZ2pBOcGzPc=;
 b=qQVutAzn1SujBUj3dR5OzUwFk5wdF0EvAguxddKGL9P8mgeK+/c0rSjdf6eOgcd+CnH57mooSvYMm4l9MgrzEMROlzeQ020m9fYbS6/z78PYoAvYKwCzfkFP2hWHm5UvHVAQ0I50YROfJYPxk5gEC57HRlj5sqU4M2f2CoIaG3BkcAWRtPs2vwyOCgOLdU+zFmthIOz+UXSVU33RrXwb8TpWb66akGTUjVeWNx7aHBZEILzeWGbEUur3vyPzJcex8tSrT+2cF7zUmRk+859GmiM7ZHqTOJMIW4dTq98qgy56zM1w5EdtRdYQD+KOJvsQyuXEtK+V3wUKkBiL6Lvzbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGnszDuOT7pGHOBLkqnkiru28NVLPoXuxZ2pBOcGzPc=;
 b=XcOnsgPEte+44ha1F4a4P5jH+lvTu2UoPp1oXYrBzZwoaOvDM/0OHsXPpBtC5/lwMsM+6gBxP5kRsqSlVYbENDVTDJyd8MKYqgb0hgsxmKzN6ysm65OpmWuy0qwzsdEq58aw6s9fk4T1I43/jz9di9JSMf1CbQVbfV5oeC5+iMc=
Received: from BYAPR07CA0107.namprd07.prod.outlook.com (2603:10b6:a03:12b::48)
 by DS7PR12MB8250.namprd12.prod.outlook.com (2603:10b6:8:db::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Wed, 8 Oct
 2025 18:49:06 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:a03:12b:cafe::d2) by BYAPR07CA0107.outlook.office365.com
 (2603:10b6:a03:12b::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Wed,
 8 Oct 2025 18:49:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Wed, 8 Oct 2025 18:49:06 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 8 Oct
 2025 11:48:47 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 8 Oct
 2025 11:48:47 -0700
Received: from aaurabin-tumbleweed.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 8 Oct 2025 11:48:46 -0700
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>
Subject: [PATCH 10/22] drm/amd/display: Update DCN401 path for cursor offload
Date: Wed, 8 Oct 2025 14:47:04 -0400
Message-ID: <20251008184839.78916-11-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008184839.78916-1-aurabindo.pillai@amd.com>
References: <20251008184839.78916-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|DS7PR12MB8250:EE_
X-MS-Office365-Filtering-Correlation-Id: 63a5bbd6-d7b9-4ae5-491b-08de069b5c1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yKK2Bpasqk3z8IqB5bs3t3//YawdBeBTXXdE2j3x5/z1IQoRIM5RAPerBOPd?=
 =?us-ascii?Q?WGMRJlZQzeDmCDcR1UpxoQru0BcJvboT/BEmXYeWz0IpNVhVcBy/N+u8i9+k?=
 =?us-ascii?Q?kzGTi56lOj470RhYYGs2/CyYNe+5RaOEJ1zGi3aFa7p6OFFPIZKmdhr1rg76?=
 =?us-ascii?Q?6IFKP/ISz4M2SbgdgbMChFL1aCNbZF8ncV5d+WkZKFS7+AOpAgTEsFWff/FS?=
 =?us-ascii?Q?o4/AWtTIZ9nIZa2k84W3LleCqL9OMonjq5OQKGspOXs+2QKm83qgmeJfVEDn?=
 =?us-ascii?Q?vjWB8bXk5yLovTQLQVYiliNQaq5tX6xdzT2WV+NGMKPaxFP6+Bx2JL9aR4I8?=
 =?us-ascii?Q?5RdmQbLIJ6Cc/bKlrIYbeFCa0BrZ79fbvW6HtwrkuPilYHYJppGQ4qOcyxQP?=
 =?us-ascii?Q?WvxTTmgZOEq34jHPc5Ym7ytoVz84Xpx+m3DKpl28sY1t/gK25ZF8D/jqiEJ3?=
 =?us-ascii?Q?irRxT0oLo+qW3bEW52hAKPzVkl0uFpSCJEfYcEztbDVwPtM3if9wgw5CABgM?=
 =?us-ascii?Q?/aGA11ZxDa/am2fom9XEIAFnwE0kcmyotlmDEBLaJV/gf14QC0H1W9Q61+7N?=
 =?us-ascii?Q?LF5rtnzLYo5XGlbSWthfYhOrBS0w9Akniv1qXgZ1UPgbUCkY4HoVHOLiglFo?=
 =?us-ascii?Q?jvyTsIQHzyssytm7bHSiaWuaOXM8vpcuGlpnQWrRcilUI/xASplLjMjPY5hg?=
 =?us-ascii?Q?EaRWkR2oiwVYuNUu2zOjij8jsH8jFt4Qb0uiXnzqBreJq3jNoBMLBtIQ2HAo?=
 =?us-ascii?Q?bfnXINWin1bYiLO2pJhF3MNvajz1mHuDnhznUyBDGnh6rDdfEdXb5BFjbHnr?=
 =?us-ascii?Q?Iubja9XzEynm/2T98KDNk9VOY6dlC5pIGet2hHL/V6M9ZwcsSlJ7YvtHFih4?=
 =?us-ascii?Q?XJwzpRiQ3xvqcieV+tRvT6prnzq9Gf3tI0VJ/jRhj1Y4R/Xc8uoQaFigA5PA?=
 =?us-ascii?Q?rMOd5tA10FegJeT1z9ab+xhudjsWBk+REq0jDFD7t96oX4wrPlAGVbIFbUv4?=
 =?us-ascii?Q?ZRMO1jGzz4Dgra8/ZDfwT4HVxjTp9ZAtv868irF8os5Kp+FKzhb6WPa5zFEG?=
 =?us-ascii?Q?QA71JdsCOrk5cd859iP6DQnKGIpSmeTht9nh/hb3EdwI4kJgMXj+0ixwqSgH?=
 =?us-ascii?Q?B2EP9NVbwGrZRA1uNiqau3DJOsV4t9+tRgAT+mCr4DgbrCS2AHfTNrIRYNIS?=
 =?us-ascii?Q?7AkuRdVSOv23GBLSA0uLJxAcrpztAqj9CpgsNgOXdmKkqJ/AJB/+raaP7K1S?=
 =?us-ascii?Q?7hddNfm+A9NYbquKFer57VPoLo4H3EjiVXuiKFQt3Az60dV4DAeO/D9hLRkD?=
 =?us-ascii?Q?u8qkAqb/ypWNlW5Zslp8pRrFWgUXz+bRF4cxGv+sIx5LvpyGBrnb+V3P1jAn?=
 =?us-ascii?Q?MpIP8DLqCFKXiqPIieuAJR1ywImM+ty3LE/rgZFPuZDUBdpFdpuJxKGOepIH?=
 =?us-ascii?Q?Z/vvNYFG3ZmzpErVeN/0ylGFT1QDvNxFbrE6x2u5f3mQIT8PSZcgJzD1iKn5?=
 =?us-ascii?Q?Pa/eP+CqH2Umf/38ezsTxirEzCbJ/CXL+1D4SXaWqcrzEM1L/sNj08Jz4CM5?=
 =?us-ascii?Q?mEzEfh+RNdrHEcIh2tM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 18:49:06.6830 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a5bbd6-d7b9-4ae5-491b-08de069b5c1b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8250
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

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
The DCN401 cursor offload path needs to take into account
use_mall_for_cursor, and also need to ensure the dcn32
function assigns the cursor cache fields (DCN401 uses the
dcn32 implementation).

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../amd/display/dc/hubp/dcn32/dcn32_hubp.c    | 70 ++++++++++++-------
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |  1 +
 3 files changed, 45 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn32/dcn32_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn32/dcn32_hubp.c
index a5f23bb2a76a..41c8f78efdc3 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn32/dcn32_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn32/dcn32_hubp.c
@@ -118,29 +118,7 @@ void hubp32_cursor_set_attributes(
 	uint32_t cursor_width = ((attr->width + 63) / 64) * 64;
 	uint32_t cursor_height = attr->height;
 	uint32_t cursor_size = cursor_width * cursor_height;
-
-	hubp->curs_attr = *attr;
-
-	REG_UPDATE(CURSOR_SURFACE_ADDRESS_HIGH,
-			CURSOR_SURFACE_ADDRESS_HIGH, attr->address.high_part);
-	REG_UPDATE(CURSOR_SURFACE_ADDRESS,
-			CURSOR_SURFACE_ADDRESS, attr->address.low_part);
-
-	REG_UPDATE_2(CURSOR_SIZE,
-			CURSOR_WIDTH, attr->width,
-			CURSOR_HEIGHT, attr->height);
-
-	REG_UPDATE_4(CURSOR_CONTROL,
-			CURSOR_MODE, attr->color_format,
-			CURSOR_2X_MAGNIFY, attr->attribute_flags.bits.ENABLE_MAGNIFICATION,
-			CURSOR_PITCH, hw_pitch,
-			CURSOR_LINES_PER_CHUNK, lpc);
-
-	REG_SET_2(CURSOR_SETTINGS, 0,
-			/* no shift of the cursor HDL schedule */
-			CURSOR0_DST_Y_OFFSET, 0,
-			 /* used to shift the cursor chunk request deadline */
-			CURSOR0_CHUNK_HDL_ADJUST, 3);
+	bool use_mall_for_cursor;
 
 	switch (attr->color_format) {
 	case CURSOR_MODE_MONO:
@@ -158,11 +136,49 @@ void hubp32_cursor_set_attributes(
 		cursor_size *= 8;
 		break;
 	}
+	use_mall_for_cursor = cursor_size > 16384 ? 1 : 0;
+
+	hubp->curs_attr = *attr;
 
-	if (cursor_size > 16384)
-		REG_UPDATE(DCHUBP_MALL_CONFIG, USE_MALL_FOR_CURSOR, true);
-	else
-		REG_UPDATE(DCHUBP_MALL_CONFIG, USE_MALL_FOR_CURSOR, false);
+	if (!hubp->cursor_offload) {
+		REG_UPDATE(CURSOR_SURFACE_ADDRESS_HIGH,
+				CURSOR_SURFACE_ADDRESS_HIGH, attr->address.high_part);
+		REG_UPDATE(CURSOR_SURFACE_ADDRESS,
+				CURSOR_SURFACE_ADDRESS, attr->address.low_part);
+
+		REG_UPDATE_2(CURSOR_SIZE,
+				CURSOR_WIDTH, attr->width,
+				CURSOR_HEIGHT, attr->height);
+
+		REG_UPDATE_4(CURSOR_CONTROL,
+				CURSOR_MODE, attr->color_format,
+				CURSOR_2X_MAGNIFY, attr->attribute_flags.bits.ENABLE_MAGNIFICATION,
+				CURSOR_PITCH, hw_pitch,
+				CURSOR_LINES_PER_CHUNK, lpc);
+
+		REG_SET_2(CURSOR_SETTINGS, 0,
+				/* no shift of the cursor HDL schedule */
+				CURSOR0_DST_Y_OFFSET, 0,
+				 /* used to shift the cursor chunk request deadline */
+				CURSOR0_CHUNK_HDL_ADJUST, 3);
+
+		REG_UPDATE(DCHUBP_MALL_CONFIG, USE_MALL_FOR_CURSOR, use_mall_for_cursor);
+	}
+	hubp->att.SURFACE_ADDR_HIGH  = attr->address.high_part;
+	hubp->att.SURFACE_ADDR       = attr->address.low_part;
+	hubp->att.size.bits.width    = attr->width;
+	hubp->att.size.bits.height   = attr->height;
+	hubp->att.cur_ctl.bits.mode  = attr->color_format;
+
+	hubp->cur_rect.w = attr->width;
+	hubp->cur_rect.h = attr->height;
+
+	hubp->att.cur_ctl.bits.pitch = hw_pitch;
+	hubp->att.cur_ctl.bits.line_per_chunk = lpc;
+	hubp->att.cur_ctl.bits.cur_2x_magnify = attr->attribute_flags.bits.ENABLE_MAGNIFICATION;
+	hubp->att.settings.bits.dst_y_offset  = 0;
+	hubp->att.settings.bits.chunk_hdl_adjust = 3;
+	hubp->use_mall_for_cursor = use_mall_for_cursor;
 }
 void hubp32_init(struct hubp *hubp)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 756ba2d41278..e6d3ff8598f5 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -3007,6 +3007,7 @@ void dcn401_update_cursor_offload_pipe(struct dc *dc, const struct pipe_ctx *pip
 
 	p->HUBPREQ0_CURSOR_SETTINGS__CURSOR0_DST_Y_OFFSET = hubp->att.settings.bits.dst_y_offset;
 	p->HUBPREQ0_CURSOR_SETTINGS__CURSOR0_CHUNK_HDL_ADJUST = hubp->att.settings.bits.chunk_hdl_adjust;
+	p->HUBP0_DCHUBP_MALL_CONFIG__USE_MALL_FOR_CURSOR = hubp->use_mall_for_cursor;
 
 	cs->offload_streams[stream_idx].payloads[payload_idx].pipe_mask |= (1u << pipe->pipe_idx);
 }
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
index 5998a20a18c4..b0c13b506c11 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
@@ -132,6 +132,7 @@ struct hubp {
 	struct cursor_position_cache_hubp  pos;
 	struct cursor_attribute_cache_hubp att;
 	struct cursor_rect cur_rect;
+	bool use_mall_for_cursor;
 };
 
 struct surface_flip_registers {
-- 
2.51.0

