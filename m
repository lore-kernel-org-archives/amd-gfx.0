Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A73C982D1
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 17:53:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 428EA10ED28;
	Wed, 16 Sep 2026 17:53:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kHBcLfYW";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010050.outbound.protection.outlook.com [52.101.85.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A3C810EBD2
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 17:53:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S+Oy/ye88rGFx2XC75nHPL/lOUMOYXZcZnbTqHnogv55Wm6uCw6O8iM+7ptF3cP0wFfX8NZYOGwLq2r8lDrEdBoR/fXhNwkreTKhNCnMfGYREKdK9xGfDgk9W3EhoieEWUHJgva1lBhGXik37IUkY7vG6vM1HHCUm2MUVmykFBlytrbsIkUnJ6gMC+rMGC1sEM8tFzMMf5AnsGhAHWwgQoe/c+o51sKtgo0qLpkBZLbPJvyIRV+xYf4fcShv23vTu2oGwQ8fz8r+DFjQQ5S8aznh08ttlTGQaRNEE0/GFbSLNJOMIF2gsR7Y3aHvKjW3o5NrBGTAy0b2f9AbDqUJmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Wd+0gQ2FyA1CNq6rYejtFht0/fAuFWCIajnkrCZ3XA=;
 b=ShzzXTd3GoJ6WqabJsgRwovoU2t3UWUaww6K+HxZnbRYDq/O9K0oxtjrRMTjPiz0Rw2ELS74Sag/NrH7i0fTTeXjo4xVBFsZ5uiX+ACZM4oDjJ5DrCRI9RJFggs/5BHGBUeACY1oMWeeUEZLhPRKekurFoJtBhrIUR/4OJme9iFu71EWhIjd/qj7rU6qR/JBOVUcg+c4LacKiIuNtWx8oWDb5O5W9gLk7Eev0y6S8hXyeqM9n/eZPuFrGb18ESWXNed0Gto4TCjAwjKU3SFu3ipoLZqRb9AB2NSYNdu38jd12aqCl3byidBKK2ksxahVwfqsQtCuKoK7GJ5XaxbQQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Wd+0gQ2FyA1CNq6rYejtFht0/fAuFWCIajnkrCZ3XA=;
 b=kHBcLfYWVsjzVMiFBnmDNfahn3pgJxcLx41jSfVvhL9PTWTLB4NBedXrWaDNYQ7+WDzaM1Mo87H3qbGIB3oImozF1GAhncIFDS5XsHpvWjHxZhMDxN85lfmZw4YdE6UPeNxvXT29Sg1uOqQMe5zvSvFSLxBglnq5y7cu8kwMu/k=
Received: from CH5P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::6)
 by CY3PR12MB9702.namprd12.prod.outlook.com (2603:10b6:930:103::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 17:53:11 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::4e) by CH5P220CA0011.outlook.office365.com
 (2603:10b6:610:1ef::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 17:53:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 17:53:10 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 12:53:00 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 George Zhang <george.zhang@amd.com>
Subject: [PATCH 60/64] drm/amd/display: Resync cursor cache after offload
 abort on DCN60
Date: Wed, 16 Sep 2026 13:52:15 -0400
Message-ID: <20260916175301.368306-61-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916175301.368306-1-george.zhang@amd.com>
References: <20260916175301.368306-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|CY3PR12MB9702:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cbae677-c924-4ee4-2d39-08df141b5f90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|23010399003|82310400026|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: JHwh2bGqxfFUsujhr7EymWZY4mp5VK58mb26YIqOBH4NdElkZH6190Hn8Mo+rCuJqZaiJmpAT+4KaYWD7BKwBxmZwadf64bleBczu903ggfVvsuNuppnXFEJQfUAkwuBoIVMnelwvFsHjZvCc+yRFBAzUZbLBjnuAVeeil+xagASCous0gnXQrJB5sl93NUehJGsi5fzaWhifDRJHpM3tNf7/n8zDSxte9sV2e7xnj+x9t7634Awy9Vi4aJ1v87G32ZrwONtGWtBQcaLy9QEG/rNKqC/qEh3VulL2ychb4eM2unQIwMKp1id4Cwh8AlbFtgA4NcEv9blK1b/XJSTlOJFjqd5jgSZz34qeWMg4aFk+s70l5jPGCNxYYhd8gALkwNw/s10aALTvNNPd2nrtZ1Fje8ERdwtIhVu/aN0SYLnr1326D3fbbG8T1lLarnjY+F359x49A6AIFpZRqC2tQlxfKnholbEZVmWRQq9LZLfB2BvAszwFmxlC2poM1uI1B7qYL1cmVC71G2RJer6JOSArfOIX4fFrhEN4f/VPOL9ylaldlyIwX1+25sDs1lZQBy37d0m5sUkvhMrwk3JIn3szzuh9P5dbJ0iFyvvlVR2YWbtKx0HS3OeB9nO8R21cOaDQdJ8KUjOc4i8PK7ZMrcA/ch8WAQd9tNVoGX6CWeCeBjiTXwqSBydb5YwWG9qCadH1B60mW8mUtkNa+LwFg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Qgf31LiSU+0wQGMrEJ4iw54o4KAOsN6yczf8+E4szu4op7FrxpmfALEJ7Zgu9hQKUlIKctCt72/WS9wNulC5Enhqz2NcDgr6BE63nH3jzQK+SMrJPH0XLu6DmaO0H+oTr79YC2BWDJCfyv2d23RoYdGmth4GbkzE8WRuBBuFOJwCndtZndHeCK9Dp9Um131xJaHW1yuy73jFudoGW8GZ08YIJbVH8u0iIVRl8gbiMtF8GOnyokmKbJEHJWhzqyZo0K7yNIMJXvaBulErl7mwb3wmBvAaISoka48cSz5L9yxz8o1NnyhzIhO4fse8UxBd4nmGisF7xA0bt6+sbAJNr5t4HZOPbQwuGHdUarjtQN4T7LxV3sbMq21eBgIkwaGIax3s/s+tzWfVNvW3rYXW4XAwKeLLwlwFBYXNCYyxuPUx8U0uv/yV0s+/PxFd3Mpf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:53:10.9294 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cbae677-c924-4ee4-2d39-08df141b5f90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9702
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

From: Ivan Lipski <ivan.lipski@amd.com>

[Why&How]
The cursor programming path caches the last-written cursor state in SW
and, for the enable bit, skips the register write when the cache already
matches the request. Under cursor offload the SW cache is updated even
though the actual register write is deferred to firmware. When an
offloaded cursor update is aborted (e.g. an overlay geometry change
reprograms the cursor directly in the same frame), the queued firmware
write is dropped but the cache is left stale, so the following direct
programming pass skips the enable write and the cursor disappears over
the overlay plane.

Add a refresh_cursor_state() hubp/dpp hook that reads the cursor
position and attribute registers back from hardware into the SW cache,
and call it from dcn35_abort_cursor_offload_update() so the cache is
truthful after an abort. This keeps the enable-change optimization
intact for all ASICs and is race-robust regardless of whether firmware
applied the queued write before the abort. Only dcn60 (the sole offload
user) wires up the hook.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../amd/display/dc/dpp/dcn401/dcn401_dpp.h    |  2 +
 .../amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c | 19 +++++++
 .../drm/amd/display/dc/dpp/dcn60/dcn60_dpp.c  |  1 +
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  | 54 +++++++++++++++++++
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.h  |  2 +
 .../amd/display/dc/hubp/dcn60/dcn60_hubp.c    |  1 +
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   | 11 ++++
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h   |  2 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |  2 +
 9 files changed, 94 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.h b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.h
index a57eb1cd77a6..e34d291de37b 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.h
@@ -725,6 +725,8 @@ void dpp401_set_cursor_position(
 	uint32_t width,
 	uint32_t height);
 
+void dpp401_cursor_refresh_state(struct dpp *dpp_base);
+
 void dpp401_set_optional_cursor_attributes(
 	struct dpp *dpp_base,
 	struct dpp_cursor_attributes *attr);
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c
index 340111e3deac..c6de8518108e 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c
@@ -144,6 +144,25 @@ void dpp401_set_cursor_position(
 	dpp_base->att.cur0_ctl.bits.cur0_enable = cur_en;
 }
 
+/* Resync the SW cursor cache from real hardware state. */
+void dpp401_cursor_refresh_state(struct dpp *dpp_base)
+{
+	struct dcn401_dpp *dpp = TO_DCN401_DPP(dpp_base);
+	uint32_t cur0_enable = 0, mode = 0, expansion_mode = 0, rom_en = 0;
+
+	REG_GET_4(CURSOR0_CONTROL,
+		CUR0_ENABLE, &cur0_enable,
+		CUR0_MODE, &mode,
+		CUR0_EXPANSION_MODE, &expansion_mode,
+		CUR0_ROM_EN, &rom_en);
+
+	dpp_base->pos.cur0_ctl.bits.cur0_enable = cur0_enable;
+	dpp_base->att.cur0_ctl.bits.cur0_enable = cur0_enable;
+	dpp_base->att.cur0_ctl.bits.mode = mode;
+	dpp_base->att.cur0_ctl.bits.expansion_mode = expansion_mode;
+	dpp_base->att.cur0_ctl.bits.cur0_rom_en = rom_en;
+}
+
 void dpp401_set_optional_cursor_attributes(
 	struct dpp *dpp_base,
 	struct dpp_cursor_attributes *attr)
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp.c
index 24a686e94171..f02aebcedd70 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp.c
@@ -308,6 +308,7 @@ static struct dpp_funcs dcn60_dpp_funcs = {
 	.dpp_cnv_set_alpha_keyer	= dpp2_cnv_set_alpha_keyer,
 	.set_cursor_attributes		= dpp401_set_cursor_attributes,
 	.set_cursor_position		= dpp401_set_cursor_position,
+	.refresh_cursor_state		= dpp401_cursor_refresh_state,
 	.set_optional_cursor_attributes	= dpp401_set_optional_cursor_attributes,
 	.dpp_dppclk_control			= dpp1_dppclk_control,
 	.dpp_set_hdr_multiplier		= dpp3_set_hdr_multiplier,
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
index 91e87fb51fe4..798d0dad9153 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
@@ -862,6 +862,60 @@ void hubp401_cursor_set_position(
 	hubp->cur_rect.y = param->cur_rect_y;
 }
 
+void hubp401_cursor_refresh_state(struct hubp *hubp)
+{
+	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
+	uint32_t enable = 0, x_pos = 0, y_pos = 0, x_hot = 0, y_hot = 0, dst_x_offset = 0;
+	uint32_t addr_high = 0, addr_low = 0, width = 0, height = 0;
+	uint32_t mode = 0, magnify = 0, pitch = 0, lpc = 0;
+	uint32_t dst_y_offset = 0, chunk_hdl_adjust = 0;
+
+	/* Resync the SW cursor cache from real hardware state. */
+
+	/* Position */
+	REG_GET(CURSOR_CONTROL, CURSOR_ENABLE, &enable);
+	REG_GET_2(CURSOR_POSITION,
+		CURSOR_X_POSITION, &x_pos,
+		CURSOR_Y_POSITION, &y_pos);
+	REG_GET_2(CURSOR_HOT_SPOT,
+		CURSOR_HOT_SPOT_X, &x_hot,
+		CURSOR_HOT_SPOT_Y, &y_hot);
+	REG_GET(CURSOR_DST_OFFSET, CURSOR_DST_X_OFFSET, &dst_x_offset);
+
+	hubp->pos.cur_ctl.bits.cur_enable = enable;
+	hubp->pos.position.bits.x_pos = x_pos;
+	hubp->pos.position.bits.y_pos = y_pos;
+	hubp->pos.hot_spot.bits.x_hot = x_hot;
+	hubp->pos.hot_spot.bits.y_hot = y_hot;
+	hubp->pos.dst_offset.bits.dst_x_offset = dst_x_offset;
+
+	/* Attributes */
+	REG_GET(CURSOR_SURFACE_ADDRESS_HIGH, CURSOR_SURFACE_ADDRESS_HIGH, &addr_high);
+	REG_GET(CURSOR_SURFACE_ADDRESS, CURSOR_SURFACE_ADDRESS, &addr_low);
+	REG_GET_2(CURSOR_SIZE,
+		CURSOR_WIDTH, &width,
+		CURSOR_HEIGHT, &height);
+	REG_GET_4(CURSOR_CONTROL,
+		CURSOR_MODE, &mode,
+		CURSOR_2X_MAGNIFY, &magnify,
+		CURSOR_PITCH, &pitch,
+		CURSOR_LINES_PER_CHUNK, &lpc);
+	REG_GET_2(CURSOR_SETTINGS,
+		CURSOR0_DST_Y_OFFSET, &dst_y_offset,
+		CURSOR0_CHUNK_HDL_ADJUST, &chunk_hdl_adjust);
+
+	hubp->att.SURFACE_ADDR_HIGH = addr_high;
+	hubp->att.SURFACE_ADDR = addr_low;
+	hubp->att.size.bits.width = width;
+	hubp->att.size.bits.height = height;
+	hubp->att.cur_ctl.bits.mode = mode;
+	hubp->att.cur_ctl.bits.cur_2x_magnify = magnify;
+	hubp->att.cur_ctl.bits.pitch = pitch;
+	hubp->att.cur_ctl.bits.line_per_chunk = lpc;
+	hubp->att.settings.bits.dst_y_offset = dst_y_offset;
+	hubp->att.settings.bits.chunk_hdl_adjust = chunk_hdl_adjust;
+}
+
 void hubp401_read_state(struct hubp *hubp)
 {
 	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.h b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.h
index 818cea479272..05078a21a123 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.h
@@ -313,6 +313,8 @@ void hubp401_cursor_set_position(
 	const struct dc_cursor_position *pos,
 	const struct dc_cursor_mi_param *param);
 
+void hubp401_cursor_refresh_state(struct hubp *hubp);
+
 void hubp401_read_state(struct hubp *hubp);
 
 bool hubp401_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn60/dcn60_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn60/dcn60_hubp.c
index 01b6b3ed5a99..4af60e473bd9 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn60/dcn60_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn60/dcn60_hubp.c
@@ -427,6 +427,7 @@ static struct hubp_funcs dcn60_hubp_funcs = {
 	.mem_program_viewport = hubp401_set_viewport,
 	.set_cursor_attributes	= hubp60_cursor_set_attributes,
 	.set_cursor_position	= hubp401_cursor_set_position,
+	.refresh_cursor_state	= hubp401_cursor_refresh_state,
 	.hubp_clk_cntl = hubp2_clk_cntl,
 	.hubp_vtg_sel = hubp2_vtg_sel,
 	.dmdata_set_attributes = hubp3_dmdata_set_attributes,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index f9d8ff6ce010..a959d8c37b6a 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -1671,6 +1671,17 @@ void dcn35_abort_cursor_offload_update(struct dmub_srv *dmub, struct dpp *dpp, s
 
 	if (dc->hwss.commit_cursor_offload_update)
 		dc->hwss.commit_cursor_offload_update(dmub, dpp, hubp, stream_idx);
+
+	/*
+	 * The aborted payload is dropped by firmware, so resync the SW cursor
+	 * cache from real hardware state. This lets the next direct
+	 * set_cursor_position re-program CURSOR_ENABLE instead of skipping it
+	 * because of a stale cache.
+	 */
+	if (dpp->funcs->refresh_cursor_state)
+		dpp->funcs->refresh_cursor_state(dpp);
+	if (hubp && hubp->funcs->refresh_cursor_state)
+		hubp->funcs->refresh_cursor_state(hubp);
 }
 
 void dcn35_begin_cursor_offload_update(struct dmub_srv *dmub, struct dpp *dpp, struct hubp *hubp, uint32_t stream_idx)
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h
index 930b5533256f..71244d3b6c90 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h
@@ -330,6 +330,8 @@ struct dpp_funcs {
 			uint32_t height
 			);
 
+	void (*refresh_cursor_state)(struct dpp *dpp_base);
+
 	void (*dpp_set_hdr_multiplier)(
 			struct dpp *dpp_base,
 			uint32_t multiplier);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
index a648ed3b012a..d1cbcb87d271 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
@@ -219,6 +219,8 @@ struct hubp_funcs {
 			const struct dc_cursor_position *pos,
 			const struct dc_cursor_mi_param *param);
 
+	void (*refresh_cursor_state)(struct hubp *hubp);
+
 	void (*hubp_disconnect)(struct hubp *hubp);
 
 	void (*hubp_clk_cntl)(struct hubp *hubp, bool enable);
-- 
2.55.0

