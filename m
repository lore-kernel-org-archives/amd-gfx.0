Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6724C43458
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:01:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48FA110F699;
	Thu,  9 Jul 2026 21:01:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2CRLWOJk";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011031.outbound.protection.outlook.com [52.101.52.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB52810F6AB
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:01:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GmAD1+RgCQfBbeY6rYNn33USn6lob/UBNmZunLtycOxO6avNvlHFHzK2gFFbfgAt7uDxl4Tsq5bmmqO7TEOuhoynbI57LHeFPdXTqjZZR+IRGUgSkqZwB3ViGNP4uPiSt09udTNExb6DODSl7XdIS4KFuHaS2iJvY179HVhWxVsGrCGrtGIEu5IQrK4P5OGpJS4TXVm8UcffJgeBRb9vZqrnm7OLC4YKmL4DbKpDoyi22fc4wBLefHK4n/ySfswVI2VSAyAv9ccfwbG0hd9R7QAugzMID47nOfz4hNJrgIg8B5HG7txTxnRNMqMwP/eBSlrymJzidH358tD6/U6pTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1UjGZJpzGn5jRp48TqyRKl46sKxgd+3E6PKKalWJ2fk=;
 b=A/FbmVC+GFSbEOoDP+2o1xux8tTVrhBnIXlkGJvs7Vl8tZpOjbiFVGpAHwqZv2Xq0mvnCau/2L5eIvi/fiRrzQw8iu/KLJVruAQQRTVUb7Qzi5fbGZ3R5CeOSJr0JnXRb7JXvr1re3oSWLRsU+fKRUtJl6d+mOy7YZsLI6erG6nGvSNAyRjwX8FkhYkNPlFUssHnHGT3VZO7rNvEWwltPFLud6k8/6LA0wxl4JvhjX7XoVS0vUpIYVz/ajL+DvOTT/cr/ymCVdLAk9qALzRAJQz78bCFAfoqxfVmk6HTUr+VGno3Ykxe2hoeiiV3W+ovNl+D7/lnWNPPTWiGexdS2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UjGZJpzGn5jRp48TqyRKl46sKxgd+3E6PKKalWJ2fk=;
 b=2CRLWOJk2G1PVwxEsOyO1Eed5ff4M8vZFuTIjm/1uihq5oNsg6A/t3tUAlcsXcf4OEbt04E9K3sXFLMAIrOuZYdF3GLER8+3rucHXz4o9tn7gNJHXQdgJE9vzV8Q7iu5eaUTuo517vKJk550Qnx59/Rv8NXKLnzDBuJhtIUkzQY=
Received: from SA9PR11CA0004.namprd11.prod.outlook.com (2603:10b6:806:6e::9)
 by DM4PR12MB9736.namprd12.prod.outlook.com (2603:10b6:8:225::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 9 Jul 2026
 21:01:47 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:806:6e:cafe::3c) by SA9PR11CA0004.outlook.office365.com
 (2603:10b6:806:6e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Thu, 9
 Jul 2026 21:01:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:01:47 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:01:42 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 10/80] drm/amd/display: program dither on all OPP heads under
 ODM combine
Date: Thu, 9 Jul 2026 16:47:38 -0400
Message-ID: <20260709205936.5719-11-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709205936.5719-1-george.zhang@amd.com>
References: <20260709205936.5719-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|DM4PR12MB9736:EE_
X-MS-Office365-Filtering-Correlation-Id: 177a3c0f-98d4-4ad8-127e-08deddfd4a69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: vWrVlLNpFsnPApTdE32wT+gv6lh7LDVxsgN/nDZliES5WVUQqWg6IJ6njxFHzMmjXRpTJXTt6kMKNrUsTuVlgeI5p+/wr15auvHrzb0cXzNFX8klUldiMf4toph0jkgf75/dk/xNRTROr4ll2JVUWe+eXqddv3T9TB3ln40CdJocoscXWFxuPvSKAu4Xp3wHlhEFTOm6ORNfpdMmlj4Hd4v5Wl7gywaWnnFIvSIlNIzA6r87nfMR7eD2n5s3vVvJY4usZoBsW4zWnFrRzXbnI9I/nn1CqrjQfScwAhNF+F72ZfwDezjEvcZb7ZVxIqta/FTcu03XCMAtliWme0d5wm+nwE12uYCXbpIjW3Y60VUMmmZH2z8SC3gF7jBG9IqD9t0WuIpkoddS/Cw6r9VCWKYShPmuSheDjY7IBlMgqaPM77sQVHSBt3J4yfgStRlqh5dtDBdraJ7/zWNchOmJZ2KTJH7RW3BjlaZiDaSNFnMcx5oUHY3sLx06xman/x/qPuw6OoE5KmhYBY9XnaushgUZBfYAmCXnw7cAHn3GHsQ8tLRvL3s2V3sB3wn8kEql3on184KpWQxHx2SPyJkahjnJQwL+OExz4sEnZvlTyrFvNAfe1NSb2k3Pd2qlD8cC+y36iue52XjvWop8mrlHPSE2gXtS8OuTDZMwRhRkb5gnf+VZM4ToIWd2HCKHiBxQCSjsCG5Ve0ZfzHQcK604Ig==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 29yYLFjhJfInbrNZ/rAaRUnuae0SfJqqNEMqr3peKkJxDR7SSxWEPi4Y2XAqUdulvgFaOtLSANLuY3ABJtvpX6aoGuQHqJWNBcpaexCVTKVnTuW5BPsfxuNA7t/A5kX5RYvC70KtkC2NsK3OYZQUrMYaFn99EuTQ3U/TUWTYS/TOQdaz/qFYLYWyEw5wMTRzZhKDfrUiC7jn1deL6knQHSbsj+NgWVWNvkSGYxROgBC80E1oEEf3SCEVR9dtTkXdg7EIGRDQym79iU11DOKf7DjxJVX8GGnb+KQoSkezBZzgKrDBk991pO9sf7VvL6C4ZxlrQ+PLsFxS+x0NM+FAIOY+7fvhkeo72iNYpVe+jFV9xiNd2W4ZU6H3x8ixgUb9VFSEwqQazdb3a28KVSR5sd4SuQtNOUQo4qZSg1s5W9jAEta+aYPFRrePfHvZRQTR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:01:47.7691 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 177a3c0f-98d4-4ad8-127e-08deddfd4a69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9736
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

From: James Lin <PingLei.Lin@amd.com>

[why]
The IGT test kms_plane_alpha_blend@coverage-vs-premult-vs-constant
failed on DCN with ODM 2:1 combine enabled. The test compares the CRC
of a coverage-blended plane against a premultiplied-blended plane and
expects them to be identical. With ODM combine the whole-frame CRC
mismatched (left segment matched, right segment differed).

Root cause: dc_stream_set_dither_option() iterated the pipe_ctx array
and broke out at the first pipe matching the stream (the OTG master /
OPP instance 0), then programmed bit-depth reduction (dither) on that
single OPP only. Under ODM combine there is more than one OPP head, so
the secondary ODM segment (OPP instance 1) was never reprogrammed. When
CRC capture requested dither off, only the left OPP got updated while
the right OPP kept its previous dither setting, producing a different
CRC for the right segment and thus a whole-frame CRC mismatch.

[how]
Use resource_get_otg_master_for_stream() and
resource_get_opp_heads_for_otg_master() to retrieve every OPP head of
the stream, then loop over all of them and call
transform_set_pixel_storage_depth() and opp_program_bit_depth_reduction()
on each. This keeps all OPP heads in sync under ODM combine, so dither is
applied (or cleared) identically across every segment and the CRCs match.

Reviewed-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: James Lin <PingLei.Lin@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 53 +++++++++++++++---------
 1 file changed, 34 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 1b6627a92d24..0b54d84c203d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -769,22 +769,23 @@ void dc_stream_set_dither_option(struct dc_stream_state *stream,
 {
 	struct bit_depth_reduction_params params;
 	struct dc_link *link = stream->link;
-	struct pipe_ctx *pipes = NULL;
+	struct resource_context *res_ctx = &link->dc->current_state->res_ctx;
+	struct pipe_ctx *otg_master;
+	struct pipe_ctx *opp_heads[MAX_PIPES];
+	int opp_cnt;
 	int i;

-	for (i = 0; i < MAX_PIPES; i++) {
-		if (link->dc->current_state->res_ctx.pipe_ctx[i].stream ==
-				stream) {
-			pipes = &link->dc->current_state->res_ctx.pipe_ctx[i];
-			break;
-		}
-	}
-
-	if (!pipes)
+	otg_master = resource_get_otg_master_for_stream(res_ctx, stream);
+	if (!otg_master)
 		return;
 	if (option > DITHER_OPTION_MAX)
 		return;

+	opp_cnt = resource_get_opp_heads_for_otg_master(otg_master, res_ctx, opp_heads);
+
+	if (opp_cnt == 0)
+		return;
+
 	dc_exit_ips_for_hw_access(stream->ctx->dc);

 	stream->dither_option = option;
@@ -793,16 +794,30 @@ void dc_stream_set_dither_option(struct dc_stream_state *stream,
 	resource_build_bit_depth_reduction_params(stream, &params);
 	stream->bit_depth_params = params;

-	if (pipes->plane_res.xfm &&
-	    pipes->plane_res.xfm->funcs->transform_set_pixel_storage_depth) {
-		pipes->plane_res.xfm->funcs->transform_set_pixel_storage_depth(
-			pipes->plane_res.xfm,
-			pipes->plane_res.scl_data.lb_params.depth,
-			&stream->bit_depth_params);
-	}
+	/*
+	 * Program bit-depth reduction (dither) on every OPP head of the
+	 * stream. Under ODM combine there is more than one OPP head and they
+	 * must all be kept in sync, otherwise (e.g. when CRC capture requests
+	 * dither off) a secondary ODM segment can keep dither enabled and
+	 * produce a different CRC than the primary segment.
+	 */
+	for (i = 0; i < opp_cnt; i++) {
+		struct pipe_ctx *opp_head = opp_heads[i];

-	pipes->stream_res.opp->funcs->
-		opp_program_bit_depth_reduction(pipes->stream_res.opp, &params);
+		if (opp_head->plane_res.xfm &&
+		    opp_head->plane_res.xfm->funcs->transform_set_pixel_storage_depth) {
+			opp_head->plane_res.xfm->funcs->transform_set_pixel_storage_depth(
+				opp_head->plane_res.xfm,
+				opp_head->plane_res.scl_data.lb_params.depth,
+				&stream->bit_depth_params);
+		}
+
+		if (opp_head->stream_res.opp &&
+		    opp_head->stream_res.opp->funcs->opp_program_bit_depth_reduction) {
+			opp_head->stream_res.opp->funcs->opp_program_bit_depth_reduction(
+				opp_head->stream_res.opp, &params);
+		}
+	}
 }

 bool dc_stream_set_gamut_remap(struct dc *dc, const struct dc_stream_state *stream)
--
2.55.0

