Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A3AC5DF9A
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:23:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 822A610ECCC;
	Tue, 18 Aug 2026 20:23:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lNub0PcW";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013048.outbound.protection.outlook.com
 [40.93.201.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6378810ECD7
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RtnvzRDmwlzowtWdfiVEPAvjCOuxL3oLExeev3iT+tJimaXEo5YnWvtxIuELWbHAswBRrZCgyDK7vvTeHxkZ/s0HEgLNLeUBg34D3lGNTMn20aZJw7NrXpoNF3ZKj2boav2ulXQVIoIbNm1kHQqRbfLDxA6jEuxaU4+tofxKXWSOXt0o8LzgaCrDIB1UjW0sG7JKL7hKg0pG+YCUTNG03uCUjGG+et64Ulv2hy9X0fBzeH91bzP+5FF77jN4fgc38fKwSRlJpc94VfNDL1H4F00AHwzOhn1VOJJ6Z4JuxDstY9YQQWYXxPRp8AC80jUfFY7rijpapAyosLkO+MGrzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3hBc9kQFHQ7JUQR95ye0pa9c9gTRlkoG7+kd1J3CMs=;
 b=XIRK5gk9E42zi4/aA/Ielp0a6xfpRYMFslNXtnN9lKaaaaNmNSF/Ksb68G8WORLLjHaQSypu0N1+0e4KnvLk3MM+yVN0PRspvSt7tllaH5Ca1InoZtCaOXRZsBSRXfL0Eml51nSBKQwCUvGZqCOA5wE8/+TE2NAz1N01ZYsyXdVo8tEXKEL+jceI3BQm/xMj2Sts62URkr0I/WSdh6ncYAs5D8UahZvxhpwYfDYCH6+CTNC5ww+F9jKyrmdo/+qw0gabeAoVc3yQM0eDA9a8A8X4FtU+vasFkPmc8zikmwS/06seTLs6RNU5yQe1K0fkRJWcKTndr+/doJjR7lrxLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3hBc9kQFHQ7JUQR95ye0pa9c9gTRlkoG7+kd1J3CMs=;
 b=lNub0PcWiJQ+Dj/SnXQ0w9CppdT14Gtu2VSYg+du0RocEs63GJYB6D2/v8ebbr7i/7SUUCMD2s0X2oyv4AjnDmEjgRxksx19kkrsad8N+9kmBIoTrzwq1FK3KB2VHl7j1cFonbuKelruRv4U/ifmVAdiTtJsH+P31ZAGzlIANCw=
Received: from BN9PR03CA0357.namprd03.prod.outlook.com (2603:10b6:408:f6::32)
 by IA1PR12MB9532.namprd12.prod.outlook.com (2603:10b6:208:595::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 20:22:53 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:408:f6:cafe::35) by BN9PR03CA0357.outlook.office365.com
 (2603:10b6:408:f6::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Tue,
 18 Aug 2026 20:22:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 20:22:53 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:52 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:52 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:51 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Gaghik Khachatrian <gaghik.khachatrian@amd.com>,
 Joshua Aberback <joshua.aberback@amd.com>
Subject: [PATCH 78/82] drm/amd/display: Add passthrough visual confirm
Date: Tue, 18 Aug 2026 16:16:10 -0400
Message-ID: <20260818202139.4172592-79-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|IA1PR12MB9532:EE_
X-MS-Office365-Filtering-Correlation-Id: b270787b-51cc-4774-a85e-08defd667b50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|82310400026|376014|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: jT32I/tvK5nlxspNZcwuemVg1t+Gi+q/QICw6TfOr/gYPh1emOx2RQ7LJocH3DHbPNePnsG8bl//MYIYn28FsQcgdF9b6b49mHPnDYwMC4MhmHQaPOy1gDtZy24z+QPTShMn6/5mj+tHG8JVbwFpYVFxGwOETHuQDVl00yFiT8oVHmR0aqemdNQZFEPWVnTv4MFczIDoHuzkkh85REapfmAErCC+cY0ST6cWvxwvnSmjTbLk0xY21mimIyftOJmmrN3hCXIbFpDOEfC4cnL2aCKueau17KOR3LgYxvKfYA38L3mxU5nFVDfwiaSNBEI6O0n7zXhN3fc+QgED5PQNKv/R6IkuoSkmz2VlNlKbRSMIiu5Os0OKcx1ql61zu761Mt16dOE2tITgoAfJ0LMvO/MnCMdp7Ckoz/s0SNwjfkl+Md0ckWP696zwFMyTHFCXPLkXzw/acPzSGZJYAPE9bjJWpLKLvqn1dtcn0vvu72/kxVtr6k2shXrUJRRxL33SOjEzYo2is5aR63NUzeDBgzuX0qcblpJelse8VgIh3CqS47GxI5pI8g0DNqj/tH8grQkCadhTArEHO3yTHG9esNKLKcqWoNOrcHstUuHWwFkSEsqCM/xpKtk/pKVQ0GUv1+lH+dI7cLVthYnTiboMWWfjYBgbp1Nny3TDivsUfIiBJB5jGaeyzhvmimzLkDAX2csqz0JJSQFhg2USXGENtA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(82310400026)(376014)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rO4AwqWc4qhCoJVtmSuvSYFOOXCMIZVhPnj97Y2bsuGGI1+JRT6df0+mTFii6xf559ax+9Qw8VJpovAoaMTflZw0lOAuvtdM6CWoZ9SrHgatUWNPhvpbph+KH4qapEbK7bMA/9ghBxohjY+XPtQl2x+M/wyLeoiBGHCrpH6GsFYswCCe8RfwEPSBFvZePEwkPT63f+oYaBvH89yLqd7hF+elosboQGngz5cM3j6mxa0F4gLkQAadaxTG23hZZRXTHszCQB7fUoSEOB2WyuIFApuqDifZdaJSHA3bjYEmStXh1a1zb/SBj+uf1QNeZ9JF1Jeg+insdR+kcxOb88Yobh3u1weJYeCECbFgkBWzirxBeSX5y6DqlS175lPHYregwQki+5tKUs1xKlaSWLL5TWKY3U43Iq7eiAAF/VB5AY5dOYgQWiHHV+fZumh5q3kT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:53.0131 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b270787b-51cc-4774-a85e-08defd667b50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9532
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

From: Gaghik Khachatrian <gaghik.khachatrian@amd.com>

- Added a new visual_confirm mode VISUAL_CONFIRM_DM_PASSTHROUGH so the confirm
  color is supplied by the DM instead of computed by DC.
- Relocated struct tg_color above dc_flip_addrs so it can be embedded by value.

Reviewed-by: Joshua Aberback <joshua.aberback@amd.com>
Signed-off-by: Gaghik Khachatrian <gaghik.khachatrian@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c     |  8 +++++++-
 drivers/gpu/drm/amd/display/dc/dc.h          |  1 +
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h | 18 +++++++++---------
 3 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 3c6936943960d..1b9bcc3f0d2be 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1229,7 +1229,9 @@ static void apply_ctx_interdependent_lock(struct dc *dc,
 
 static void dc_update_visual_confirm_color(struct dc *dc, struct dc_state *context, struct pipe_ctx *pipe_ctx)
 {
-	if (dc->debug.visual_confirm & VISUAL_CONFIRM_EXPLICIT) {
+	/* EXPLICIT and DM passthrough both apply the per-plane color set on the plane state */
+	if ((dc->debug.visual_confirm & VISUAL_CONFIRM_EXPLICIT) ||
+		dc->debug.visual_confirm == VISUAL_CONFIRM_DM_PASSTHROUGH) {
 		memcpy(&pipe_ctx->visual_confirm_color, &pipe_ctx->plane_state->visual_confirm_color,
 		sizeof(pipe_ctx->visual_confirm_color));
 		return;
@@ -3352,6 +3354,10 @@ static void copy_surface_update_to_plane(
 			surface->time.index = 0;
 
 		surface->triplebuffer_flips = srf_update->flip_addr->triplebuffer_flips;
+
+		/* DM passthrough mode: stash the per-flip color on the plane for dc_update_visual_confirm_color */
+		if (surface->ctx->dc->debug.visual_confirm == VISUAL_CONFIRM_DM_PASSTHROUGH)
+			surface->visual_confirm_color = srf_update->flip_addr->visual_confirm_color;
 	}
 
 	if (srf_update->scaling_info) {
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 1355ce2b49709..d59c23971ef8e 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -653,6 +653,7 @@ enum visual_confirm {
 	VISUAL_CONFIRM_VABC = 21,
 	VISUAL_CONFIRM_DCC = 22,
 	VISUAL_CONFIRM_BOOSTED_REFRESH_RATE = 23,
+	VISUAL_CONFIRM_DM_PASSTHROUGH = 26,
 	VISUAL_CONFIRM_EXPLICIT = 0x80000000,
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
index aeac5a45e13b7..084c506a8a94a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
@@ -269,6 +269,14 @@ enum dc_pixel_format {
 	PIXEL_FORMAT_UNKNOWN
 };
 
+#define MAX_TG_COLOR_VALUE 0x3FF
+struct tg_color {
+	/* Maximum 10 bits color value */
+	uint16_t color_r_cr;
+	uint16_t color_g_y;
+	uint16_t color_b_cb;
+};
+
 /*
  * This structure holds a surface address.  There could be multiple addresses
  * in cases such as Stereo 3D, Planar YUV, etc.  Other per-flip attributes such
@@ -283,6 +291,7 @@ struct dc_flip_addrs {
 	bool triplebuffer_flips;
 	unsigned int dirty_rect_count;
 	struct rect dirty_rects[DC_MAX_DIRTY_RECTS];
+	struct tg_color visual_confirm_color; /* DM passthrough visual confirm color, applied in VISUAL_CONFIRM_DM_PASSTHROUGH mode */
 };
 
 enum tile_split_values {
@@ -1187,15 +1196,6 @@ struct mcif_buf_params {
 	uint8_t				tmz_id;
 };
 
-
-#define MAX_TG_COLOR_VALUE 0x3FF
-struct tg_color {
-	/* Maximum 10 bits color value */
-	uint16_t color_r_cr;
-	uint16_t color_g_y;
-	uint16_t color_b_cb;
-};
-
 struct fva_adj {
 	unsigned int pixel_clock_100hz;
 	unsigned int max_pixel_clock_100hz;
-- 
2.43.0

