Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C0DC64EC4
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Feb 2023 06:42:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2255C10E40C;
	Wed, 22 Feb 2023 06:42:46 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D1B910E40C
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Feb 2023 06:42:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JdmB5wQCBh8iaCdDaYm0lUWTqChO6D/A2jBPH6pglQYVzhf//NzTCcZRGqNoS4t1X4MedA8yMxkeizTNjsWq+Qzo0FYLg9/KMraeEk1grSipqDaQnUgT2BpBibHGsi+hHOEDNTDbH45H1lt9FHtSRo7FHm3/Mqk8wsS5JZdOUWycKLW/ZaX2R8tv2sngmUCzzlsq4oqiRxYEawRje2KlmIyedkrxzblNupHk8i/h+uH+PaaE6yPJ/mq/WUPo9Qb4i1gVX9yTplrIictOV0rRyCCqgv+93FDRPd/dwNQPqRPI52A5ZBWIWghNf2u0XGndv//7z/EhCwdKBfWcyJZN1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gEyhjA30XC/p1JMJns3iD5TUFmUZbm5wLH35S02bDQE=;
 b=W2ubdw3koPGT78nK1EGcEwtlx4gyGvkTmROS8g4Y047DxOxZGi57w2YUCIcxpyKhbM7fTBtdRkNMv2T/MVqZuk/wntnqAyctiNLYaj20HpY/4QLDq+MvyHrjITX+Z2YCJy+vX43ahk125ZSpjou3WUhgOYRgKmxLUBhL7ltanG4GIHgQc4+eiusLp2YNkmUHgcAmcK/YUmIKiNQ0hTAjO2I8BNFqYcm9VqzTQn3zsc4SlW3gvvMF/GeFiLWODRGGpz3i/CYQd4DpRvB24tB7cLhJNRhpJKw3uxGJ+CdkrIz0Vmxc+xN6hDr4TO6GcZRHj3XgaRejNd9EZLRIJoSvng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gEyhjA30XC/p1JMJns3iD5TUFmUZbm5wLH35S02bDQE=;
 b=Q1PStuoalGvsxKS/McIW8K7ByBVerhq8ZQstA+J1Z+j2i93cyoLQ0/42tyI2wju4Z4Lltt4FShRwEReBH1yu2R40NFAfuBESVSSnN0bB4F1yXl/lf2ZmANPJalPCBv8b4VJE3/L0FBLg4g4a91qE/5TRcc3Nwjy6UKmc7I6mHAc=
Received: from DM6PR02CA0103.namprd02.prod.outlook.com (2603:10b6:5:1f4::44)
 by CH0PR12MB5186.namprd12.prod.outlook.com (2603:10b6:610:b9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.24; Wed, 22 Feb
 2023 06:42:40 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::a3) by DM6PR02CA0103.outlook.office365.com
 (2603:10b6:5:1f4::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19 via Frontend
 Transport; Wed, 22 Feb 2023 06:42:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6134.19 via Frontend Transport; Wed, 22 Feb 2023 06:42:40 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 22 Feb
 2023 00:42:32 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/20] drm/amd/display: Do not update DRR while BW
 optimizations pending
Date: Wed, 22 Feb 2023 01:40:34 -0500
Message-ID: <20230222064041.2824-14-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230222064041.2824-1-qingqing.zhuo@amd.com>
References: <20230222064041.2824-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT021:EE_|CH0PR12MB5186:EE_
X-MS-Office365-Filtering-Correlation-Id: 4215415a-0a19-4eee-53c2-08db149ffe8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E+WJCj8A7rGzAy8NO+Sg/nV7WC+tLizOp5deIRetVzYBQGw+Yj3s/9BJ9MwDyzR4P1oZTAjWmd0o17+UxlTGUNHZeaHCzsxVMr7sdGCzLKXu0ta7lHrECWOgv+ZphfSeb4m6weyk6ueVgWbINTjUkfibbV5YmUYrHgl7IZtvA1hJk7CVUnW/S5b8B2pkrG9MWVz6GXpRmtLFmpRgBvr7QGTpjzsyaj9LGq4oWdnjYOkLjEe8cUMHFl42N2bq4oRwQJik/JRDIW5hPWWrSuhCzv4xUY+OdupQtDpNfXAppogk6KBMUjNz2d3bLuLS+seSPwkLRWYMgaRsYRu4UXqzHcJvbvllUDUg4zG/IdRmBrgcquBfakAavJ4DnpLOIoSCieo2HzXFYO9080p8fiCQwy4+7RYj3Ot3waRCnoqkMuu1gzpatTIav0FlMWq13LdVrGgbFzaDWFht+3tUWj2I1//kQLEpUc/Yfllq5u6vVgO8RkmJIPAFfkRQVkCHMsdUpbl9c/OE5UMyPwgjx7LEHE0rrfWjTEHEI5IhyVoXUQSyfe/3TNb3ag6WUdkEghlbZGUf/xXmZZLG/Ct9EZ21uvHgJFQBRlSbsgzwoPTkR/TI5uESraOt59QR0ZRUC6MrnRIkVJO/HEWbjUqiK+KMS//xKEZxDUZq6KTCaKDXxKgphaDxLgN4+YbRsqmdmsXUsFRBUEkFKBKTJX3311llf+mVxCdVYhFS9BHmKKmJtB4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(346002)(39860400002)(136003)(376002)(451199018)(36840700001)(40470700004)(46966006)(15650500001)(86362001)(5660300002)(26005)(82310400005)(44832011)(336012)(316002)(83380400001)(2906002)(40460700003)(4326008)(426003)(356005)(70206006)(8676002)(81166007)(41300700001)(2616005)(70586007)(8936002)(6916009)(36756003)(82740400003)(54906003)(47076005)(36860700001)(40480700001)(16526019)(186003)(1076003)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 06:42:40.5175 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4215415a-0a19-4eee-53c2-08db149ffe8b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5186
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

[why]
While bandwidth optimizations are pending, it's possible a pstate change
will occur.  During this time, VSYNC handler should not also try to update
DRR parameters causing pstate hang

[how]
Do not adjust DRR if optimize bandwidth is set.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 48 ++++++++++++++----------
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 1c218c526650..cfb6f4eefce9 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -399,6 +399,13 @@ bool dc_stream_adjust_vmin_vmax(struct dc *dc,
 {
 	int i;
 
+	/*
+	 * Don't adjust DRR while there's bandwidth optimizations pending to
+	 * avoid conflicting with firmware updates.
+	 */
+	if (dc->optimized_required || dc->wm_optimized_required)
+		return false;
+
 	stream->adjust.v_total_max = adjust->v_total_max;
 	stream->adjust.v_total_mid = adjust->v_total_mid;
 	stream->adjust.v_total_mid_frame_num = adjust->v_total_mid_frame_num;
@@ -2134,27 +2141,33 @@ void dc_post_update_surfaces_to_stream(struct dc *dc)
 
 	post_surface_trace(dc);
 
-	if (dc->ctx->dce_version >= DCE_VERSION_MAX)
-		TRACE_DCN_CLOCK_STATE(&context->bw_ctx.bw.dcn.clk);
-	else
+	/*
+	 * Only relevant for DCN behavior where we can guarantee the optimization
+	 * is safe to apply - retain the legacy behavior for DCE.
+	 */
+
+	if (dc->ctx->dce_version < DCE_VERSION_MAX)
 		TRACE_DCE_CLOCK_STATE(&context->bw_ctx.bw.dce);
+	else {
+		TRACE_DCN_CLOCK_STATE(&context->bw_ctx.bw.dcn.clk);
 
-	if (is_flip_pending_in_pipes(dc, context))
-		return;
+		if (is_flip_pending_in_pipes(dc, context))
+			return;
 
-	for (i = 0; i < dc->res_pool->pipe_count; i++)
-		if (context->res_ctx.pipe_ctx[i].stream == NULL ||
-		    context->res_ctx.pipe_ctx[i].plane_state == NULL) {
-			context->res_ctx.pipe_ctx[i].pipe_idx = i;
-			dc->hwss.disable_plane(dc, &context->res_ctx.pipe_ctx[i]);
-		}
+		for (i = 0; i < dc->res_pool->pipe_count; i++)
+			if (context->res_ctx.pipe_ctx[i].stream == NULL ||
+					context->res_ctx.pipe_ctx[i].plane_state == NULL) {
+				context->res_ctx.pipe_ctx[i].pipe_idx = i;
+				dc->hwss.disable_plane(dc, &context->res_ctx.pipe_ctx[i]);
+			}
 
-	process_deferred_updates(dc);
+		process_deferred_updates(dc);
 
-	dc->hwss.optimize_bandwidth(dc, context);
+		dc->hwss.optimize_bandwidth(dc, context);
 
-	if (dc->debug.enable_double_buffered_dsc_pg_support)
-		dc->hwss.update_dsc_pg(dc, context, true);
+		if (dc->debug.enable_double_buffered_dsc_pg_support)
+			dc->hwss.update_dsc_pg(dc, context, true);
+	}
 
 	dc->optimized_required = false;
 	dc->wm_optimized_required = false;
@@ -4123,12 +4136,9 @@ void dc_commit_updates_for_stream(struct dc *dc,
 			if (new_pipe->plane_state && new_pipe->plane_state != old_pipe->plane_state)
 				new_pipe->plane_state->force_full_update = true;
 		}
-	} else if (update_type == UPDATE_TYPE_FAST && dc_ctx->dce_version >= DCE_VERSION_MAX) {
+	} else if (update_type == UPDATE_TYPE_FAST) {
 		/*
 		 * Previous frame finished and HW is ready for optimization.
-		 *
-		 * Only relevant for DCN behavior where we can guarantee the optimization
-		 * is safe to apply - retain the legacy behavior for DCE.
 		 */
 		dc_post_update_surfaces_to_stream(dc);
 	}
-- 
2.34.1

