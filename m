Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72241C87FCF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Aug 2025 23:26:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1584E10E7DF;
	Wed, 13 Aug 2025 23:26:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AA5ZefWo";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2125710E7DF
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 23:26:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NEYBD3q2/9J1IcoEJylbrOTLmlJToryB9GA4P5RzxvIySxXP3+iUOAEr9uU8u40eZgbDF3iqa9EU914zacrPvx4o0ZqHusQYlCSFg7JCCe7r59ff8RKcNHbUOHPgRUqhY9y/MBlTyQ9ewHcbh/v+IAWyrLnOSzpeD33MHVqM28YbsY3BNwjOLqitrZPW+BadSpwwyNeet+mBIYAQuEsOc1X/gXXOt3dUtHNVNxkVaG6YepCHuPvNU4BxjfWgnXY9f1TSd8wjXG3KLpHsFcfeJxrHd+OlcwHFuuE4m7LrRDkCsDAidwWZWEVjOnkiNoLqF8nupozO7mN5pnKP1t9cgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WGkIJy2KP4ncGJt6xnyFYgYcAA7mUM+lj1eHWUsVhTU=;
 b=kn+9zurS/lQmNo6yA4/sS8XO1FJttX4ZMjnn2Dzpq849mthOvpgyPA+eEzcYQ7jEgQ9nQuaLDG5RWQnI6ZsH1Vgf3z9faOqjspUCPBpFhgreevMf03BAa7EMIPEMxFzz/EYf2XBp8r+/bcnvkJzJLAcyHrD2KSFbYf5ZZjw92bFdo9L5kOFow3ja+j+meF2D39n/4/SGi/wqNb5Y5Woucg862g7KdEGr4QgeLmyVf4cqOXNCcxll3DRntCUWl7WI8bMkOUZbsWgRgd3nQFn0cUXJCdzLbbwGWnH3IcPnl1evXZT7K3nTMaw0O63wmBx3ryFF8GTW9i95YFlolUBvBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGkIJy2KP4ncGJt6xnyFYgYcAA7mUM+lj1eHWUsVhTU=;
 b=AA5ZefWoRS4/9Ou2Km2WHbrEwZq+4IytCq6VV5zcPp6KgVUTm3Oh+6CWOsOInEq24vTKHd72GlJA7NakWstqcoP/n/h5fP+VZi5xapv8233rPiTX13RvLVwcdGOnCh2IkhCbBK+Xytz/s2yKJwDMOHwTkfJLkARviEr6zWdRvDE=
Received: from DM6PR02CA0111.namprd02.prod.outlook.com (2603:10b6:5:1b4::13)
 by CH3PR12MB9172.namprd12.prod.outlook.com (2603:10b6:610:198::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 23:26:49 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:5:1b4:cafe::1) by DM6PR02CA0111.outlook.office365.com
 (2603:10b6:5:1b4::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.16 via Frontend Transport; Wed,
 13 Aug 2025 23:26:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 23:26:49 +0000
Received: from SATLEXMB03.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Aug
 2025 18:26:46 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Rafal Ostrowski <rostrows@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 01/11] drm/amd/display: Add LSDMA Linear Sub Window Copy
 support
Date: Wed, 13 Aug 2025 17:18:09 -0600
Message-ID: <20250813232532.2661638-2-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250813232532.2661638-1-alex.hung@amd.com>
References: <20250813232532.2661638-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|CH3PR12MB9172:EE_
X-MS-Office365-Filtering-Correlation-Id: bf4afa97-e3c2-41ca-ca51-08dddac0e085
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1IYEOz0fN7RnQGTsszWbixuDjMw1qqvCg4JUFJcwu2WpqBnDZkdtVR6YvXWc?=
 =?us-ascii?Q?Ro5WumWrTWVbEk8o0FdsTjR0mQUaS+1bnqL/o/vGhGp11gZ7Oc03c02l6YWF?=
 =?us-ascii?Q?h07FQvch1xQWwuX6u9k7LJnH8+iD2gqFn/AbU4k+pA8CfevTZAdCvCYiT0w0?=
 =?us-ascii?Q?+ycuBh8nefo9TvMnZnAHLgoxZ0K2VSqWzmdCCnOgRX+nPL8UOPA4IdmTAPPq?=
 =?us-ascii?Q?lJXVlrzJ38yxsut4lrhJ23YOZUX1oE/cBWfRhSQLnBRPwqSH2tK9P+SffIzS?=
 =?us-ascii?Q?Ozk3yRlDMDOlffqtlje3ZihUl854f+5l2j+7AWB3/XRIIXZzq4wxEc+pMITa?=
 =?us-ascii?Q?aFBxTILH7RNOF0m78fmI5crHmwln5iWnr4vDkKgkUoyiKk0l84TivQDUzlkO?=
 =?us-ascii?Q?ColQ2AOCwFfLdSIzaZLtzD2Tno3ljDPz5PUmApqj5rgdqRn8dQu8lqQQP6Fp?=
 =?us-ascii?Q?/NYG5td2VWlOno1SEnAbcLjBPPIyp+OIUcf2STwU9I5ehYxkyhEDEBTdSe1w?=
 =?us-ascii?Q?OcDLqXvZPXKiK50udWonkTnwj7Iv2xUKTJDj/mRDeKlyQE27PR6UFHvH2SMg?=
 =?us-ascii?Q?ieM/X/Xoi9qq9+IHzgj+M4sMUP/LNPKAOZ9nXLGiGUW4rdiF1mtIZ/emFP+e?=
 =?us-ascii?Q?zv3Gx8WB/G9lhQPT2DH/nmkfVdnwlfxytQefT8f/ZSjSsk1fKgSresLCokCX?=
 =?us-ascii?Q?J27FaaLTu4Z9w6YovgWEpZsZoZqOlW2ZevS/o2xA4t0Xt27WMkezpGHxOVpo?=
 =?us-ascii?Q?Gv/nezWTgTCDazBen/xGnSO9KhGNjwSaLLV4T2ke76BK8WaShoWIVQPw7LIL?=
 =?us-ascii?Q?DKBi0iVRRQCOZFqtabdWYSZJrfr80w9EcOQSEyeE+Mj0Z+tIliqq0K/DdqZP?=
 =?us-ascii?Q?z3XnCJECcr50K4q+FmC4SFwopaklnQjo0eNHXLiZAkQq8YsDQWe9dcZzDbLK?=
 =?us-ascii?Q?29mdG8JhhGkFMeq5OQj6VK98A56gq92lSPSpDDjHvw08/trnsp1mpqBRIxqj?=
 =?us-ascii?Q?QjINntIuHQ7oq2KgvKKsyEi2IXzFRc1r4BGYgtNaoOiHjCuFbIKeBv486QzK?=
 =?us-ascii?Q?OHiKrxD0zaNBhKnYZl0Xczm/xjhLBEs/gmvqm0LGbTmeqNHVRXYhJDIUOUhI?=
 =?us-ascii?Q?MiqnqY1bVmTLtrxniaIram/xms2yTKB9WYPHQw+YS2bnBE611axHCbyR2YQn?=
 =?us-ascii?Q?YZKqK6S1T5xd9yXWyOPqJyApUK4f46rZsZHz/OTg95066oEaBJ7YZWOyENn+?=
 =?us-ascii?Q?GSdlLDdCjyw5kTaoAKMn+ukQ7Zop/be550NBcXQBDJxCWPlqNcQaC3OQ+Y+G?=
 =?us-ascii?Q?MCTCVKIVZD9ZLh/D6RsTn4GGGLE7VCKBa9h+2A2o4UssyfJEOIS58gFA8Sac?=
 =?us-ascii?Q?qDC25FdfYi5ydFqC6Y5wNklBaFeZZK8Vdv1WJMs+PhbQGZMayUQe0Lb7JhpN?=
 =?us-ascii?Q?1//u9zHZUce0WHDRUp4GtzElTHyk72KZP+8POmkYkiF2jXWPpnDZgLH78yIq?=
 =?us-ascii?Q?vpGKBIViR2MDxZuzFvmeLucD1TSigKZyAxPJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 23:26:49.1110 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf4afa97-e3c2-41ca-ca51-08dddac0e085
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9172
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

From: Rafal Ostrowski <rostrows@amd.com>

[WHAT]
Add support for LSDMA Linear Sub Window Copy command.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Rafal Ostrowski <rostrows@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 58 ++++++++++++++++++--
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h | 36 +++++++++++-
 2 files changed, 88 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 714c468c010d..55b362196612 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -2010,11 +2010,12 @@ bool dmub_lsdma_init(struct dc_dmub_srv *dc_dmub_srv)
 	return result;
 }
 
-bool dmub_lsdma_send_linear_copy_packet(
+bool dmub_lsdma_send_linear_copy_command(
 	struct dc_dmub_srv *dc_dmub_srv,
 	uint64_t src_addr,
 	uint64_t dst_addr,
-	uint32_t count)
+	uint32_t count
+)
 {
 	struct dc_context *dc_ctx = dc_dmub_srv->ctx;
 	union dmub_rb_cmd cmd;
@@ -2042,9 +2043,54 @@ bool dmub_lsdma_send_linear_copy_packet(
 	return result;
 }
 
+bool dmub_lsdma_send_linear_sub_window_copy_command(
+	struct dc_dmub_srv *dc_dmub_srv,
+	struct lsdma_linear_sub_window_copy_params copy_data
+)
+{
+	struct dc_context *dc_ctx = dc_dmub_srv->ctx;
+	union dmub_rb_cmd cmd;
+	enum dm_dmub_wait_type wait_type;
+	struct dmub_cmd_lsdma_data *lsdma_data = &cmd.lsdma.lsdma_data;
+	bool result;
+
+	memset(&cmd, 0, sizeof(cmd));
+
+	cmd.cmd_common.header.type     = DMUB_CMD__LSDMA;
+	cmd.cmd_common.header.sub_type = DMUB_CMD__LSDMA_LINEAR_SUB_WINDOW_COPY;
+	wait_type                      = DM_DMUB_WAIT_TYPE_NO_WAIT;
+
+	lsdma_data->u.linear_sub_window_copy_data.tmz              = copy_data.tmz;
+	lsdma_data->u.linear_sub_window_copy_data.element_size     = copy_data.element_size;
+	lsdma_data->u.linear_sub_window_copy_data.src_lo           = copy_data.src_lo;
+	lsdma_data->u.linear_sub_window_copy_data.src_hi           = copy_data.src_hi;
+	lsdma_data->u.linear_sub_window_copy_data.src_x            = copy_data.src_x;
+	lsdma_data->u.linear_sub_window_copy_data.src_y            = copy_data.src_y;
+	lsdma_data->u.linear_sub_window_copy_data.src_pitch        = copy_data.src_pitch - 1;
+	lsdma_data->u.linear_sub_window_copy_data.src_slice_pitch  = copy_data.src_slice_pitch - 1;
+	lsdma_data->u.linear_sub_window_copy_data.dst_lo           = copy_data.dst_lo;
+	lsdma_data->u.linear_sub_window_copy_data.dst_hi           = copy_data.dst_hi;
+	lsdma_data->u.linear_sub_window_copy_data.dst_x            = copy_data.dst_x;
+	lsdma_data->u.linear_sub_window_copy_data.dst_y            = copy_data.dst_y;
+	lsdma_data->u.linear_sub_window_copy_data.dst_pitch        = copy_data.dst_pitch - 1;
+	lsdma_data->u.linear_sub_window_copy_data.dst_slice_pitch  = copy_data.dst_slice_pitch - 1;
+	lsdma_data->u.linear_sub_window_copy_data.rect_x           = copy_data.rect_x - 1;
+	lsdma_data->u.linear_sub_window_copy_data.rect_y           = copy_data.rect_y - 1;
+	lsdma_data->u.linear_sub_window_copy_data.src_cache_policy = copy_data.src_cache_policy;
+	lsdma_data->u.linear_sub_window_copy_data.dst_cache_policy = copy_data.dst_cache_policy;
+
+	result = dc_wake_and_execute_dmub_cmd(dc_ctx, &cmd, wait_type);
+
+	if (!result)
+		DC_ERROR("LSDMA Linear Sub Window Copy failed in DMUB");
+
+	return result;
+}
+
 bool dmub_lsdma_send_tiled_to_tiled_copy_command(
 	struct dc_dmub_srv *dc_dmub_srv,
-	struct lsdma_send_tiled_to_tiled_copy_command_params params)
+	struct lsdma_send_tiled_to_tiled_copy_command_params params
+)
 {
 	struct dc_context *dc_ctx = dc_dmub_srv->ctx;
 	union dmub_rb_cmd cmd;
@@ -2097,7 +2143,8 @@ bool dmub_lsdma_send_pio_copy_command(
 	uint64_t src_addr,
 	uint64_t dst_addr,
 	uint32_t byte_count,
-	uint32_t overlap_disable)
+	uint32_t overlap_disable
+)
 {
 	struct dc_context *dc_ctx = dc_dmub_srv->ctx;
 	union dmub_rb_cmd cmd;
@@ -2130,7 +2177,8 @@ bool dmub_lsdma_send_pio_constfill_command(
 	struct dc_dmub_srv *dc_dmub_srv,
 	uint64_t dst_addr,
 	uint32_t byte_count,
-	uint32_t data)
+	uint32_t data
+)
 {
 	struct dc_context *dc_ctx = dc_dmub_srv->ctx;
 	union dmub_rb_cmd cmd;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
index 8ea320f21269..7ef93444ef3c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
@@ -211,11 +211,45 @@ void dc_dmub_srv_fams2_passthrough_flip(
 		int surface_count);
 
 bool dmub_lsdma_init(struct dc_dmub_srv *dc_dmub_srv);
-bool dmub_lsdma_send_linear_copy_packet(
+bool dmub_lsdma_send_linear_copy_command(
 	struct dc_dmub_srv *dc_dmub_srv,
 	uint64_t src_addr,
 	uint64_t dst_addr,
 	uint32_t count);
+
+struct lsdma_linear_sub_window_copy_params {
+	uint32_t src_lo;
+	uint32_t src_hi;
+
+	uint32_t dst_lo;
+	uint32_t dst_hi;
+
+	uint32_t src_x        : 16;
+	uint32_t src_y        : 16;
+
+	uint32_t dst_x        : 16;
+	uint32_t dst_y        : 16;
+
+	uint32_t rect_x       : 16;
+	uint32_t rect_y       : 16;
+
+	uint32_t src_pitch    : 16;
+	uint32_t dst_pitch    : 16;
+
+	uint32_t src_slice_pitch;
+	uint32_t dst_slice_pitch;
+
+	uint32_t tmz              : 1;
+	uint32_t element_size     : 3;
+	uint32_t src_cache_policy : 3;
+	uint32_t dst_cache_policy : 3;
+	uint32_t padding          : 22;
+};
+
+bool dmub_lsdma_send_linear_sub_window_copy_command(
+	struct dc_dmub_srv *dc_dmub_srv,
+	struct lsdma_linear_sub_window_copy_params copy_data
+);
 bool dmub_lsdma_send_pio_copy_command(
 	struct dc_dmub_srv *dc_dmub_srv,
 	uint64_t src_addr,
-- 
2.43.0

