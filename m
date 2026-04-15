Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D6DBFA0C42
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2026 07:44:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3CF710E6A2;
	Wed, 15 Apr 2026 07:44:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IrukaEdi";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011006.outbound.protection.outlook.com [52.101.57.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF84510E6A2
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Apr 2026 07:44:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bsBmNTeyOEhBom4KC5nGFcw6Bw3tW2ywB0ny+lDOJQQpe3xvhAysgQNH0T6+DEL1LhBp82uPGNiz9GdXclumOKbHD+atQHSg4RPzuI9TJPnT/dxCtAk+xq3rWVBXwRVo/NKFR+LNH2R9Bna0lF1Aee1auc9nnCQiyvE+vNs9I281dXwooE0fp6GlC/fJ6+O9zjhQrh1CmopYxcFSG+7LfmHWOG+c+ZToxcLpo7BzLH9PYtsfUdF8Q8IsA6sfk47y2rMeEHglvnb6URIn3bi0VM2TJuQqzTKiMF45sSlWGKKxp9NUoCNyknjUWCwM0S9oI0PX290f6d0vK6AVSizlkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GW1mFBth0MDB6hdAHzf9XEqecFniy8vr2tWX15m/xDk=;
 b=SzMvpFAh2BycsIagay+TMAkkXdpjWV9NaeKcisZGZTDC82BBwJKnNfgXbZHo9d2P7UGwjSU3vM9c8hk8v0iqLoYVvOXAze8qNIx7bzkoInk2DOMVd/Lr0YHPK5hVkuluL1tMcxNLr9QOk9fJUnvwi0EGv5JNMWbtiJIb38VjXyelJIiYOU6eaMJh5GO9QeNMjF+nDvcIblDOrM5JdktCWr77g2s3ybc+z7sf03waUJtLefd30NxcJz5UGetCaJqozZ+a0wyfPQf5usDW8G7Yna0DnkwdiEVMsd9qT7/GsCr5cS0HeT1k9bQ9rWL+2a+iYsUlb69uLQlz/LAEqj6crQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GW1mFBth0MDB6hdAHzf9XEqecFniy8vr2tWX15m/xDk=;
 b=IrukaEdiT0tSEZQHTaA6QipiTKbOXe+CgIvBzXGiRowaoiBsrWaLFuSpPCHU/McEi2dwbu82lsVUelgK1ZS4FPKZvfBzA8E6tOJUkQN/DHDz0ZYkFWrEQU/POvRqrCAMs5LTs4rIS1FEcbFlGD9Sq7UTxAGHdcnQT1x0/c4VLxw=
Received: from DS0PR17CA0024.namprd17.prod.outlook.com (2603:10b6:8:191::29)
 by CY8PR12MB7563.namprd12.prod.outlook.com (2603:10b6:930:96::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 07:44:21 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:8:191:cafe::ca) by DS0PR17CA0024.outlook.office365.com
 (2603:10b6:8:191::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.50 via Frontend Transport; Wed,
 15 Apr 2026 07:44:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 07:44:21 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 15 Apr
 2026 02:44:20 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 15 Apr
 2026 02:44:20 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 15 Apr 2026 02:44:16 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Chuanyu Tseng <Chuanyu.Tseng@amd.com>, Dominik Kaszewski
 <dominik.kaszewski@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Chenyu Chen
 <chen-yu.chen@amd.com>
Subject: [PATCH 17/19] drm/amd/display: Fix DPMS using partially updated pipe
 context
Date: Wed, 15 Apr 2026 15:39:56 +0800
Message-ID: <20260415074223.34848-18-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415074223.34848-1-chen-yu.chen@amd.com>
References: <20260415074223.34848-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: chen-yu.chen@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|CY8PR12MB7563:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a9c71d6-f1cd-40ce-11ad-08de9ac2ce75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: bMIghorVoLw02G9kvBzNydLm+M+YeLXOAkuXswZLU8qXpEuXV4huMSUIX7DeUBdV05ylxQ66bkbnKlhoLD9ysn6hmZh8RBUJoZRc4tag6pmdheccRxUTB0U/0PWIWwyL410PzYZYYDwot8uguzPvkczVoZzcSf5bZ9RYrKrvV7xvDeWermV2nh2e7OSaw9jYzEqgg4V0b13+WZsnOpxggCXdq8YnL76qKwHnEazugl6Y3BeYJsjd/XwFnOOgKd+HOiFeN8P6QBSLz31yWsw+qXXLucCt6+KRBVLKtu/gpEdJVEo74pdLzEMuoFC8jKB6cnBsDI6MtW/gH5dKg1+hdmgH1HxeIwthFQC5RBsIN2bROMtCDLZKXVu8g59H//uA4x1PX7GUdsg9Lge7rtpx8huu/hikNCVGv4HR0nYobM7xXQERUFBFzv2mIqDc8oJ1jQIzylRVUbP7J45z2jkaqLKcXRjage32oTrvJjx77gFYzCgQ3xitUon+kuCBmvP5C4xAO+KL0oje3U0qBqyTkUTl17thjh4hi4PirsF2Cx3f06a87Yc8DRWZl/3ppQGhiaFvTa1jF7LtoavIQfEW7WMEFxZ32ql0gdIegQvUBeZ9RJw6XPyBc7kri5ouYP5D32eQBW8zZoeU6RUHNHGtU5LJR2rqkebe8HIYZDFNa9dAr7BZPvx6V4ezQBtYFtdUku9NcweD3OT41OLqHklgsS8Rdo3XFU+6Dhh2NwLFBj8tRa4unGwIwsmqFDXh55y2Z4O4PSogk1YIWu9ab2Jx4g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uuT6y+3t5qKu8S/A3CJ4AOaaP3l4hJGZDYNqJVLw/AX3B6sBn3bTtg8TxLCVRssQZmINnaobnvQsHIdmwlXjpSbjCY3ho7mm/gKad5XcXuFrO5j0CO4x50YxhMstKcl0OG9+mHiCGDfntmW32wcGglvrorOklpAkrB3o4MCELp/fgB1azkmpj4b/3u8ft96azPtTtPME8ASEowq+V7PG+a9qRlGZYkPNvMinQE+nkYxmN3cPLIstSAYMS64bN4Z9HfbzcQ3zbgn/dDnMKA1zURFbmui6bJFrqQ8AY1ite5Rqd870DLCDkVFWoX4fFeAOC48qTn09CmN5idSoELyjlWtyMXOBxReg9b5uJoLVa+iYh3sl1KH1jM12c2yDcJGZHR2UYbH1UdEzaAakFl2jIp1jGq/5aEgiM3h87QKgnnwv6z057dExH+vzjJMw4HFI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 07:44:21.0963 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a9c71d6-f1cd-40ce-11ad-08de9ac2ce75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7563
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

From: Dominik Kaszewski <dominik.kaszewski@amd.com>

[Why & How]
DPMS functions should not use partially updated pipe context passed
as argument of commit_planes_do_stream_update, and instead use the
one in current_state, which is guaranteed to be the most recently
programmed HW config.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Dominik Kaszewski <dominik.kaszewski@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 9ff5503d4df7..0c7c84276d1f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3898,27 +3898,34 @@ static void commit_planes_do_stream_update(struct dc *dc,
 				resource_build_test_pattern_params(&context->res_ctx, pipe_ctx);
 			}
 
+			// DPMS should not use partially updated pipe context
+			struct pipe_ctx *dpms_pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[j];
+
 			if (stream_update->dpms_off) {
 				if (*stream_update->dpms_off) {
-					dc->link_srv->set_dpms_off(pipe_ctx);
+					dc->link_srv->set_dpms_off(dpms_pipe_ctx);
 					/* for dpms, keep acquired resources*/
-					if (pipe_ctx->stream_res.audio && !dc->debug.az_endpoint_mute_only)
-						pipe_ctx->stream_res.audio->funcs->az_disable(pipe_ctx->stream_res.audio);
+					if (dpms_pipe_ctx->stream_res.audio && !dc->debug.az_endpoint_mute_only) {
+						struct audio *audio = dpms_pipe_ctx->stream_res.audio;
+
+						audio->funcs->az_disable(audio);
+					}
 
 					dc->optimized_required = true;
 
 				} else {
 					if (get_seamless_boot_stream_count(context) == 0)
 						dc->hwss.prepare_bandwidth(dc, dc->current_state);
-					dc->link_srv->set_dpms_on(dc->current_state, pipe_ctx);
+					dc->link_srv->set_dpms_on(dc->current_state, dpms_pipe_ctx);
 				}
-			} else if (pipe_ctx->stream->link->wa_flags.blank_stream_on_ocs_change && stream_update->output_color_space
-					&& !stream->dpms_off && dc_is_dp_signal(pipe_ctx->stream->signal)) {
+			} else if (dpms_pipe_ctx->stream->link->wa_flags.blank_stream_on_ocs_change &&
+					stream_update->output_color_space &&
+					!stream->dpms_off && dc_is_dp_signal(dpms_pipe_ctx->stream->signal)) {
 				/*
 				 * Workaround for firmware issue in some receivers where they don't pick up
 				 * correct output color space unless DP link is disabled/re-enabled
 				 */
-				dc->link_srv->set_dpms_on(dc->current_state, pipe_ctx);
+				dc->link_srv->set_dpms_on(dc->current_state, dpms_pipe_ctx);
 			}
 
 			if (stream_update->abm_level && pipe_ctx->stream_res.abm) {
-- 
2.43.0

