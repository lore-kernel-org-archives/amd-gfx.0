Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5538EC83F1A
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jul 2025 22:45:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F022E10E072;
	Tue, 22 Jul 2025 22:45:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sg9vb5H+";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A40F10E072
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 22:45:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xmgGASI8WW/LfJtDrH0ZtDmw9tP7Uz4aThhRoa0EuFhYoSTewhEX2ie9z0JpNQ3yoO3h0/V9K++K0ib4gOUVLCOxj8fFKZIKPpAYc6Po5qypvK6rJtGt1/BRoEV3T6o3o12kX97jvOZn01T4Un4KNP0opZ83PS7G3lc+FOxgw+kWzravjLoOVPVxpa22IgcZSMGN+wffuFHCgaWL2c9xU9+xhesgtTqXvMRJByaqIb8+K3tZZerlbmQqt+LpC/R3SMcbVR5HUCmba09rXWCAh9p6E/S8kkDTxlELlDzou87qXH0+sEmwFGUFAZ6IIke3Yiv04Tep8cIbt2JESNvthQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0sYnuakKWZrjeeUx4YZeRa57+yUVmp2m8BvgBPDX0F8=;
 b=FCZSEEunpukJ+un5me4DX3lTB4LKeZVSJVA72hNr1ACMU4CrJh5lGN8fVNubUf9BMxNd7EDYBAJ+sE7LWNYMhvxbgNpEkZlhOvOpCJAH8VFMoraWZW7Ht3/dfYsVUSh5W2w4GBe3un6QbGn+oFu23484liGlIFVJsr2u28O0wJkpwki/59+myVFmIfN+EibPDwLS2x+lxDnGbOXvjSwQxJldo6jtMpE5fHaW5T5brSpcOgKcRXnG9UYroV531m/lqeSxlf36GednJ8KtkSfk0eZHX5nWO28QPcXHC4Cl9Eehj2J1+CSu4vHuqDguIOgpVQwWiN4JwHqeSoHqakcqcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0sYnuakKWZrjeeUx4YZeRa57+yUVmp2m8BvgBPDX0F8=;
 b=sg9vb5H+9acVqPRNk8JOsHbqTtZWaq5JDjyiAmMUGwAyGE0S4DZWsPT7IlV1X2KszdlpEqJjo6V+6ZCPOVpW8mOLYT9Ujz6H6F/DWTDVH3+qwxIOUkUVzz88MXV/w9xich7T/p9bsEyjYoKbrK9GEUKs9E2xQ1mfhlrD2fQaKJw=
Received: from SN7P222CA0012.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::26)
 by MN0PR12MB6176.namprd12.prod.outlook.com (2603:10b6:208:3c3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 22:45:47 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:806:124:cafe::ba) by SN7P222CA0012.outlook.office365.com
 (2603:10b6:806:124::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Tue,
 22 Jul 2025 22:45:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 22:45:46 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 17:45:46 -0500
Received: from box-0.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Jul 2025 17:45:45 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Richard Chiang
 <Richard.Chiang@amd.com>, Charlene Liu <charlene.liu@amd.com>, Ivan Lipski
 <ivan.lipski@amd.com>
Subject: [PATCH 15/25] drm/amd/display: Remove update_planes_and_stream_v1
 sequence
Date: Tue, 22 Jul 2025 18:44:24 -0400
Message-ID: <20250722224514.2655899-15-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: IVAN.LIPSKI@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|MN0PR12MB6176:EE_
X-MS-Office365-Filtering-Correlation-Id: a2e1f6a8-0ef2-46f4-d2a0-08ddc9717fe5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jkfvbwo4eoNTXiWk+7MbZg+xgnTDTie1rMrWg18r24JCj+AUoZhHgqJ6yh2w?=
 =?us-ascii?Q?fG6ezkhpatN3LAiNaMiVZkxMusLvUjS0C+xUbrlHhlx9lewO2vusNyIP/xqW?=
 =?us-ascii?Q?TBf0fOv9iIzd3u+QWzudvRg9XaXva01b7r0yJP9p5YI6gGax0nAheuNBObIv?=
 =?us-ascii?Q?EEPA53LvML/z6HfJT3BfEdo3icKuOvnf9rCOLRPkR7BTcPFZbyFc8WICMk2e?=
 =?us-ascii?Q?ig8OYEa6f2QPLiWAgz+eVMX0G3qLPIXyt5ZXFFOUDx/XTlexntV9faLJ0Ywz?=
 =?us-ascii?Q?C/ybs5ZTPZrhFn1HqQp2B3oGTx0vcWKjBOwYyam+p9K7rZNGgDBQA5XbB1TB?=
 =?us-ascii?Q?i00RxAJfbZ8mx79OLPCtifmjvODLiKivwMgL3OYTc34jrxEcTQAllUrhngDV?=
 =?us-ascii?Q?ERngsIfKQgTjFBWrD1O9uzs+t2wx/9OIdWZSwuMNG4jRFKFpw7FO4bwcb/j6?=
 =?us-ascii?Q?eALJgwZEoWLl8wvY/KLJTTb8aO/oZx1jTPGuuFoI2pm0X2zlIZy3EeMnokXf?=
 =?us-ascii?Q?MDaySml9JKntm/Mumx4i3nbGk25LV7LHLS+JiA1nWwX45wIyfDIfgOxJexiq?=
 =?us-ascii?Q?WalcfN41A0mWtlK9CCWHBBNbTvZX8pbgcMFKrKq7mrV3VqpyWJq47HfdE1W8?=
 =?us-ascii?Q?NHgdqHZf5947LAk1GCccRlaQMxYQkWHOhDC7nZSI//+Sqq2mJC1XwClYX3jL?=
 =?us-ascii?Q?tJ+Qag7Yi5vSScnvS7J2wFNfIANDfzusekIBQ7NMQ3g3k9D6ap+7p4oCe56m?=
 =?us-ascii?Q?TvyOWmoni92Rdlsn7lqRY+y+v6qGLPY6yx2FdWMBgE/pm+BKMrUBIxt2Blcg?=
 =?us-ascii?Q?DXTuK23sMHh0pShUFY5IMm2JwaAJvbZ9vPjW8HKqNl1JMuZxN5VYBh5D7yIV?=
 =?us-ascii?Q?kbTqf0EC+AblweS1CZuEZ3G3R/gTj9IP+sO+QP5ZXk6XXglzqhiUafNQPR6D?=
 =?us-ascii?Q?ZFXX1Kl4mCAuQTPX/LkbxU4ck86LqOgrAsUhO0MgqTL3hgju6XbxMNumqoa5?=
 =?us-ascii?Q?qTnFE0cdO5X7KZ+z5yMa6rBmkVe51L/5yiOUzNh/EvgIHxrJMqMSqG/gFMtn?=
 =?us-ascii?Q?K9K1Bm1SsVVFFOrvQFyaXQGKvCDtmwNA51ZhM7vk1DrLUYDpHvColspceBl7?=
 =?us-ascii?Q?38nFeNmNjJ2MHf244nY6Dw3QnVKZzFVOBvlAxHQmIQitvbDudQmguTBlCDrl?=
 =?us-ascii?Q?pTWQTVZGlh/KMd75lzpg3e+mZFm3JFPRBbw0rflEow3wcVJ68/q42gyPV9n5?=
 =?us-ascii?Q?RXsTa4qc2Qb25TVOPtwbWjyLWpA5KUF3TJfGZmKiraZzpfO3uuK7cm7CHPCX?=
 =?us-ascii?Q?gKMtxuz6WVhJkh6At0216L4a2I03vCWdhl27Xv5SlAfmEreWcrw0OwVTHjCV?=
 =?us-ascii?Q?KRWxdhqfII5HJ/XefxDCwDcE84dfRW7GADkrgIbUWDIxL1BbRHuYYrMmTUZZ?=
 =?us-ascii?Q?tXKdcdlR0+NuCwXry1kGe4iCAtsxjWPALetjnNtAPEjslk1LDnbTybF4Efwm?=
 =?us-ascii?Q?qnZa8S2qFWXl1BFgCNM9YnccdEGh8trLghSA?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 22:45:46.9991 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2e1f6a8-0ef2-46f4-d2a0-08ddc9717fe5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6176
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

From: Richard Chiang <Richard.Chiang@amd.com>

[Why]/How]
Remove the update_planes_and_stream_v1 sequence to make the logic the same.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Richard Chiang <Richard.Chiang@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 129 +----------------------
 1 file changed, 2 insertions(+), 127 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index c17e5843e8b7..d8e4bdef76a3 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -5102,129 +5102,6 @@ static bool fast_update_only(struct dc *dc,
 			&& !full_update_required(dc, srf_updates, surface_count, stream_update, stream);
 }
 
-static bool update_planes_and_stream_v1(struct dc *dc,
-		struct dc_surface_update *srf_updates, int surface_count,
-		struct dc_stream_state *stream,
-		struct dc_stream_update *stream_update,
-		struct dc_state *state)
-{
-	const struct dc_stream_status *stream_status;
-	enum surface_update_type update_type;
-	struct dc_state *context;
-	struct dc_context *dc_ctx = dc->ctx;
-	int i, j;
-	struct dc_fast_update fast_update[MAX_SURFACES] = {0};
-
-	dc_exit_ips_for_hw_access(dc);
-
-	populate_fast_updates(fast_update, srf_updates, surface_count, stream_update);
-	stream_status = dc_stream_get_status(stream);
-	context = dc->current_state;
-
-	update_type = dc_check_update_surfaces_for_stream(
-				dc, srf_updates, surface_count, stream_update, stream_status);
-	/* It is possible to receive a flip for one plane while there are multiple flip_immediate planes in the same stream.
-	 * E.g. Desktop and MPO plane are flip_immediate but only the MPO plane received a flip
-	 * Force the other flip_immediate planes to flip so GSL doesn't wait for a flip that won't come.
-	 */
-	force_immediate_gsl_plane_flip(dc, srf_updates, surface_count);
-
-	if (update_type >= UPDATE_TYPE_FULL) {
-
-		/* initialize scratch memory for building context */
-		context = dc_state_create_copy(state);
-		if (context == NULL) {
-			DC_ERROR("Failed to allocate new validate context!\n");
-			return false;
-		}
-
-		for (i = 0; i < dc->res_pool->pipe_count; i++) {
-			struct pipe_ctx *new_pipe = &context->res_ctx.pipe_ctx[i];
-			struct pipe_ctx *old_pipe = &dc->current_state->res_ctx.pipe_ctx[i];
-
-			if (new_pipe->plane_state && new_pipe->plane_state != old_pipe->plane_state)
-				new_pipe->plane_state->force_full_update = true;
-		}
-	} else if (update_type == UPDATE_TYPE_FAST) {
-		/*
-		 * Previous frame finished and HW is ready for optimization.
-		 */
-		dc_post_update_surfaces_to_stream(dc);
-	}
-
-	for (i = 0; i < surface_count; i++) {
-		struct dc_plane_state *surface = srf_updates[i].surface;
-
-		copy_surface_update_to_plane(surface, &srf_updates[i]);
-
-		if (update_type >= UPDATE_TYPE_MED) {
-			for (j = 0; j < dc->res_pool->pipe_count; j++) {
-				struct pipe_ctx *pipe_ctx =
-					&context->res_ctx.pipe_ctx[j];
-
-				if (pipe_ctx->plane_state != surface)
-					continue;
-
-				resource_build_scaling_params(pipe_ctx);
-			}
-		}
-	}
-
-	copy_stream_update_to_stream(dc, context, stream, stream_update);
-
-	if (update_type >= UPDATE_TYPE_FULL) {
-		if (dc->res_pool->funcs->validate_bandwidth(dc, context, DC_VALIDATE_MODE_AND_PROGRAMMING) != DC_OK) {
-			DC_ERROR("Mode validation failed for stream update!\n");
-			dc_state_release(context);
-			return false;
-		}
-	}
-
-	TRACE_DC_PIPE_STATE(pipe_ctx, i, MAX_PIPES);
-
-	if (fast_update_only(dc, fast_update, srf_updates, surface_count, stream_update, stream) &&
-			!dc->debug.enable_legacy_fast_update) {
-		commit_planes_for_stream_fast(dc,
-				srf_updates,
-				surface_count,
-				stream,
-				stream_update,
-				update_type,
-				context);
-	} else {
-		commit_planes_for_stream(
-				dc,
-				srf_updates,
-				surface_count,
-				stream,
-				stream_update,
-				update_type,
-				context);
-	}
-	/*update current_State*/
-	if (dc->current_state != context) {
-
-		struct dc_state *old = dc->current_state;
-
-		dc->current_state = context;
-		dc_state_release(old);
-
-		for (i = 0; i < dc->res_pool->pipe_count; i++) {
-			struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
-
-			if (pipe_ctx->plane_state && pipe_ctx->stream == stream)
-				pipe_ctx->plane_state->force_full_update = false;
-		}
-	}
-
-	/* Legacy optimization path for DCE. */
-	if (update_type >= UPDATE_TYPE_FULL && dc_ctx->dce_version < DCE_VERSION_MAX) {
-		dc_post_update_surfaces_to_stream(dc);
-		TRACE_DCE_CLOCK_STATE(&context->bw_ctx.bw.dce);
-	}
-	return true;
-}
-
 static bool update_planes_and_stream_v2(struct dc *dc,
 		struct dc_surface_update *srf_updates, int surface_count,
 		struct dc_stream_state *stream,
@@ -5481,12 +5358,10 @@ void dc_commit_updates_for_stream(struct dc *dc,
 	if (dc->ctx->dce_version >= DCN_VERSION_4_01) {
 		ret = update_planes_and_stream_v3(dc, srf_updates, surface_count,
 				stream, stream_update);
-	} else if (dc->ctx->dce_version >= DCN_VERSION_3_2) {
+	} else {
 		ret = update_planes_and_stream_v2(dc, srf_updates, surface_count,
 				stream, stream_update);
-	} else
-		ret = update_planes_and_stream_v1(dc, srf_updates, surface_count, stream,
-				stream_update, state);
+	}
 
 	if (ret && dc->ctx->dce_version >= DCN_VERSION_3_2)
 		clear_update_flags(srf_updates, surface_count, stream);
-- 
2.43.0

