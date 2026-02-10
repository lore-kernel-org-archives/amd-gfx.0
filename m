Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE7AEA8118
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 13:56:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26BC910E584;
	Tue, 10 Feb 2026 13:56:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TN44bK5B";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012060.outbound.protection.outlook.com [52.101.43.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9327410E584
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 13:56:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tdFE2iavxrxnARb3jnZNUPQxoXIdouLN6wNPeL3RovZ7NWG2jwDsxhOqwSe8CaX1yfUlNJlKsHx+UCgt6OhoiHeVRwCQbeqGzLy2tbqFTfvMDCxDUhGc8zIV1g7f5GC5qZyRWP2VADNNv4zCe2CqsvMx+G4jOqxghKV3rBfwr2Ga0Dv3/y4co2v9E7/W2c3PK/tuzwp9w9ZgczCZ0aP2N+T4ADpr6R+Y4CGhOGMem+TrV/A9IytL5PYTSXb8prUR8f23LIf4R9Rsv1TVwQlHJFH8xRdjLQ99ipNzadfb9YZG9CEtkw+nX9RH8l79N2fee3A+jgp6VWjvbFTiPad4ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xBTAxi8tmXChgxUz4ke8sT6y9s9BMM3ZrZGaf2hlal4=;
 b=lCUq68pKAvbizFsG9afUvm5snVoZabTOoq9n1I7onF/whZrzIaE9V2zB5KE7n10X3ZiBm4ZTV+QuIw2JhPS5y3ZKfN8lEVLWZD+CNy2lgl1nB22EwPes31EGVkBUp+TNEERtEMx1FJQhLGyGQXLkP6Lnc9FN8xnlLXp8W4JQjlZ1yKakcHYIEYB2sL4RwrupSRb5b0RCR/bV+vkjG+hrFWkfXQx7LwRgHQtbm3oQtpPwVzWKQ33bRdbuje/s08aTbw0zTpGSwLxbBlhS6//EliS9Nn+qGSEMdNU5VA72Vs0ZDamXPrTCnvED/RshbzdACWt0LH5t9UBdH4vri0ys1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBTAxi8tmXChgxUz4ke8sT6y9s9BMM3ZrZGaf2hlal4=;
 b=TN44bK5BU79S/53J7+c4QM4k7XbNKm/YAh5TplOHtDTVVFim+FD2SZl/2m4lNdYvn+JfzBi/XRuFqgqm92SIZz541axbOydD1QmmvnFPCwrKRYeAQbh2dp8dmxo4fQ7H95o2vM+BwcmByOfs1YOytwT/35DD9ntroS4Ia0kVmp0=
Received: from PH8PR22CA0023.namprd22.prod.outlook.com (2603:10b6:510:2d1::21)
 by CH1PPFC908D89D1.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::623) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 10 Feb
 2026 13:55:53 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:510:2d1:cafe::f1) by PH8PR22CA0023.outlook.office365.com
 (2603:10b6:510:2d1::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.18 via Frontend Transport; Tue,
 10 Feb 2026 13:55:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.0 via Frontend Transport; Tue, 10 Feb 2026 13:55:53 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Feb
 2026 07:55:52 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Feb
 2026 05:55:52 -0800
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 10 Feb 2026 07:55:43 -0600
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Nicholas Carbones <Nicholas.Carbones@amd.com>, "Joshua
 Aberback" <joshua.aberback@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 11/18] Revert "drm/amd/display: Add Gfx Base Case For Linear
 Tiling Handling"
Date: Tue, 10 Feb 2026 21:50:04 +0800
Message-ID: <20260210135353.848421-12-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260210135353.848421-1-ray.wu@amd.com>
References: <20260210135353.848421-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|CH1PPFC908D89D1:EE_
X-MS-Office365-Filtering-Correlation-Id: 53738c7d-9206-4daf-5f5d-08de68ac1b2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?L7bgIycJTgF70PCX3oFAZlq9eS4GNYuGwRTKDHdCo19XtbsEv0MESlPnOh/v?=
 =?us-ascii?Q?p/etqsaAUk7/+WyFKu0QqCZ07zS4Ga4MhbXKK96P8+v3tZT3t4Slm65J2V0L?=
 =?us-ascii?Q?2wODUdvLHTKhYcPvgCNuuIKShYZtbYquyGULPqutJXRHm2o3VcgVx+A6fmGc?=
 =?us-ascii?Q?yWJ0Xkx7XCKXiIkx/rxQsV7f+uKHU807zkp9AyNiUp/o51Oz0qxXAT4BjCyI?=
 =?us-ascii?Q?UhqNif3++1PZq+NBXa9PDXcAQ7EAzBmutAyk169uzvi1AQvWiUIafO60MCIK?=
 =?us-ascii?Q?YPYelzBh9beyuAs5OeFq8MRLUs2GZLJHrYWXUTHN0AjuuJKxL31EYy1kdhSE?=
 =?us-ascii?Q?l4w0ppIwAPu7pAmiEo4OuffDXfbb9L5xCnCo9pq+75EXZmXOUozj9R22982E?=
 =?us-ascii?Q?YI/FDAWYC31SvXKn2LkckxzuNUl8PQ844GNcLUZ7kEqncWcI3cqyNjE/zFY1?=
 =?us-ascii?Q?TN8akKrMOl1rChqIUIKZBcGum0Fiy6Z9aly9VUvbSeYagHFLPtc+ztFP3TzG?=
 =?us-ascii?Q?LRftTThVYsjkN7c2yEqMPtNwUeEmuE5oNXltgTeVI+YnIomb6VNNvxTtZ8Ct?=
 =?us-ascii?Q?gvM2a/zupz6RY4RyGCKZXtOsZteGxb33haYmxHn9txTQqL82HOyJXh9a/2ta?=
 =?us-ascii?Q?6HmFL0YPOoTRJzJuvCUAR9H9QpSlVaFCMsYc5myDv+JZDrunbbCh/HspmlBh?=
 =?us-ascii?Q?HT8w31fQPN4HTfGYL6afB1aPdKxgKgRUu4vg59fAhV/K9kedhoVCtDyO7kRI?=
 =?us-ascii?Q?QZTsyO9K3iMQogMrkV+4CFtTM9m5xbxq4MOcTYwpoovyJ7CBbCxX3a7dSAKX?=
 =?us-ascii?Q?Fj9JwgiV0zEghTjG28j9ZxUD/Mn5ZQMTsQMqQxiC1RUWAQhsR7VnRNOQI6Td?=
 =?us-ascii?Q?+jS9UwLZQ9xjT5YbpPMYsZtzgJdH50anWu8xqD5TXCJQsNPyRbrID1jW8jy9?=
 =?us-ascii?Q?kSHj5Bkpt0yza403OQxmRAFxCCkV7dydPi/ccMm4pLisaOlDBnu1XbJGr6WI?=
 =?us-ascii?Q?nDoAlPiF5nFpJmeAYQFzx6RXUggDj5J6C0YANRwUPmhan4KvB638ddWi0DgT?=
 =?us-ascii?Q?whrH793qZK4EzMyLbx9vNcFznTJtQkUsv+NDi7JAKtMZQsK/+vHl5wgDHcjT?=
 =?us-ascii?Q?/vsL4YJqhxr22/OfvQNtbUtEZf72UayRvCmN2o2kl70xJDPh1+1cSaM+7NRQ?=
 =?us-ascii?Q?IbVi76Ub1NnRkeggAUpEWBDJ969SJ0XixLSqsJBy+b1Yb5bDsQ1EfEJ1WqKK?=
 =?us-ascii?Q?YIbUbHZWnv9aET5K6yv6/UnFggkT2Zj5qsA6P8FMih86xDB56r9FShQvXAkk?=
 =?us-ascii?Q?qCtG5BfpN07kBMNZXuW6LNHjOsGdrj71okSZiaQWK3OZ4QFyrIObb/zmV8kY?=
 =?us-ascii?Q?KTkbZI9E1HnOElJeb8NqJWnWA7kmRNTq3xxII5sZO7NQAr2UqHab3INZmXr+?=
 =?us-ascii?Q?fkmBAj10xz1o0oaHAkAHzA3otpZWHfr0oxO71PEs8dCUM5bCQSiP82KG516t?=
 =?us-ascii?Q?JRkt36U+CspjN6z7M5vWD0I0Bf56P/KwxbUqsC+Vc4nxvrgLscxQ3rj2Cg7W?=
 =?us-ascii?Q?szFiQir7Y+cJFWAi1kVsZN2uni9rE1T/UBgnOZMjkTRs4UCnw2BcCo0xC+MA?=
 =?us-ascii?Q?G27XsqC0LQNXQzHEQlRpWTSgzdf3b9lnLAOGlz4c5FINk81UHpFXAuBsvy0N?=
 =?us-ascii?Q?dyERjA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TXF+KTjzSs92cbt9qxIGgJ6p7omiqMcs9MsQ6/9skuixEGojkxrbdbSVYdnJSORzSXz4Vzws7KsurmourziVBQr3lsFrsvouUfkT9nwVKe9P+tpDdQGMM2kUic1GmGYplj/ro4geoQiakpPFnxCoPf+Cs87zu3x4nrEE4OyLq8d8CcJuCVLJW3CNXtooBS9bHwtTqLYJs0+iSpAkHknYF88deyeHSkAlSFNYfsB4CI//Urze/Xw/kqLMb+ilCJiiQIAQN3FYe4pVxfd/44OgdyVftl7JwKY8Cs2t5T1u7qRheGzm1/0JnSmaUzWgeJKFQyXfApIYZNgw6k3nRa/0n1hHEnw6Ll5kScTqMqKVd2MQ2XOPeEung0rcgRMmnig2wu2pnYxSJkekNlUNQfmX1hIgPhaAe6DTFHa0npEjDpydh6GzVMfSZK9JsLhsWz5/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 13:55:53.1476 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53738c7d-9206-4daf-5f5d-08de68ac1b2d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFC908D89D1
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

From: Nicholas Carbones <Nicholas.Carbones@amd.com>

This reverts commit 27ca0d596700 ("drm/amd/display: Add Gfx Base Case For Linear Tiling Handling")

Reason for revert: Got blank screen issues while doing PNP

Reviewed-by: Joshua Aberback <joshua.aberback@amd.com>
Signed-off-by: Nicholas Carbones <Nicholas.Carbones@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c          | 1 -
 drivers/gpu/drm/amd/display/dc/core/dc.c                   | 1 -
 drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c      | 7 -------
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c          | 1 -
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h               | 3 +--
 drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c         | 3 ---
 drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c | 3 ---
 drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c       | 1 -
 drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c     | 2 --
 drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c     | 2 --
 drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c     | 2 --
 drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c   | 7 +------
 .../amd/display/dc/resource/dcn32/dcn32_resource_helpers.c | 3 +--
 13 files changed, 3 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 3dfbbf66bcd5..10a234e7bae9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8036,7 +8036,6 @@ static enum dc_status dm_validate_stream_and_context(struct dc *dc,
 	dc_plane_state->plane_size.chroma_size.height  = stream->src.height;
 	dc_plane_state->plane_size.chroma_size.width   = stream->src.width;
 	dc_plane_state->format = SURFACE_PIXEL_FORMAT_GRPH_ARGB8888;
-	dc_plane_state->tiling_info.gfxversion = DcGfxVersion9;
 	dc_plane_state->tiling_info.gfx9.swizzle = DC_SW_UNKNOWN;
 	dc_plane_state->rotation = ROTATION_ANGLE_0;
 	dc_plane_state->is_tiling_rotated = false;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 6f3c283431d4..984b4bc5f53c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2770,7 +2770,6 @@ static struct surface_update_descriptor get_plane_info_update_type(const struct
 		case DcGfxVersion7:
 		case DcGfxVersion8:
 		case DcGfxVersionUnknown:
-		case DcGfxBase:
 		default:
 			break;
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index a13d9d7dd6c5..052d573408c3 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -2065,13 +2065,6 @@ void get_surface_tile_visual_confirm_color(
 	while (bottom_pipe_ctx->bottom_pipe != NULL)
 		bottom_pipe_ctx = bottom_pipe_ctx->bottom_pipe;
 
-	if (bottom_pipe_ctx->plane_state->tiling_info.gfxversion == DcGfxBase) {
-		/* LINEAR Surface - set border color to red */
-		color->color_r_cr = color_value;
-		return;
-	}
-
-	ASSERT(bottom_pipe_ctx->plane_state->tiling_info.gfxversion == DcGfxVersion9);
 	switch (bottom_pipe_ctx->plane_state->tiling_info.gfx9.swizzle) {
 	case DC_SW_LINEAR:
 		/* LINEAR Surface - set border color to red */
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 639831295b21..03d125f794b0 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -4434,7 +4434,6 @@ enum dc_status dc_validate_global_state(
 
 			if (dc->res_pool->funcs->patch_unknown_plane_state &&
 					pipe_ctx->plane_state &&
-					pipe_ctx->plane_state->tiling_info.gfxversion == DcGfxVersion9 &&
 					pipe_ctx->plane_state->tiling_info.gfx9.swizzle == DC_SW_UNKNOWN) {
 				result = dc->res_pool->funcs->patch_unknown_plane_state(pipe_ctx->plane_state);
 				if (result != DC_OK)
diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
index 7121629da38e..cfa569a7bff1 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
@@ -342,8 +342,7 @@ enum swizzle_mode_addr3_values {
 };
 
 enum dc_gfxversion {
-	DcGfxBase = 0,
-	DcGfxVersion7,
+	DcGfxVersion7 = 0,
 	DcGfxVersion8,
 	DcGfxVersion9,
 	DcGfxVersion10,
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
index 5df58fadc862..1c2009e38aa1 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
@@ -100,7 +100,6 @@ static enum mi_bits_per_pixel get_mi_bpp(
 static enum mi_tiling_format get_mi_tiling(
 		struct dc_tiling_info *tiling_info)
 {
-	ASSERT(tiling_info->gfxversion == DcGfxVersion8);
 	switch (tiling_info->gfx8.array_mode) {
 	case DC_ARRAY_1D_TILED_THIN1:
 	case DC_ARRAY_1D_TILED_THICK:
@@ -434,7 +433,6 @@ static void program_tiling(
 	struct dce_mem_input *dce_mi, const struct dc_tiling_info *info)
 {
 	if (dce_mi->masks->GRPH_SW_MODE) { /* GFX9 */
-		ASSERT(info->gfxversion == DcGfxVersion9);
 		REG_UPDATE_6(GRPH_CONTROL,
 				GRPH_SW_MODE, info->gfx9.swizzle,
 				GRPH_NUM_BANKS, log_2(info->gfx9.num_banks),
@@ -449,7 +447,6 @@ static void program_tiling(
 	}
 
 	if (dce_mi->masks->GRPH_MICRO_TILE_MODE) { /* GFX8 */
-		ASSERT(info->gfxversion == DcGfxVersion8);
 		REG_UPDATE_9(GRPH_CONTROL,
 				GRPH_NUM_BANKS, info->gfx8.num_banks,
 				GRPH_BANK_WIDTH, info->gfx8.bank_width,
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c
index 67cfca3361fb..2c43c2422638 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c
@@ -165,8 +165,6 @@ static void program_tiling(
 	const struct dc_tiling_info *info,
 	const enum surface_pixel_format pixel_format)
 {
-	ASSERT(info->gfxversion == DcGfxVersion8);
-
 	uint32_t value = 0;
 
 	set_reg_field_value(value, info->gfx8.num_banks,
@@ -543,7 +541,6 @@ static const unsigned int *get_dvmm_hw_setting(
 	else
 		bpp = bpp_8;
 
-	ASSERT(tiling_info->gfxversion == DcGfxVersion8);
 	switch (tiling_info->gfx8.array_mode) {
 	case DC_ARRAY_1D_TILED_THIN1:
 	case DC_ARRAY_1D_TILED_THICK:
diff --git a/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
index 71eeee02c0fa..74962791302f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
@@ -1006,7 +1006,6 @@ bool dcn_validate_bandwidth(
 
 			v->source_pixel_format[input_idx] = tl_pixel_format_to_bw_defs(
 					pipe->plane_state->format);
-			ASSERT(pipe->plane_state->tiling_info.gfxversion == DcGfxVersion9);
 			v->source_surface_mode[input_idx] = tl_sw_mode_to_bw_defs(
 					pipe->plane_state->tiling_info.gfx9.swizzle);
 			v->lb_bit_per_pixel[input_idx] = tl_lb_bpp_to_int(pipe->plane_res.scl_data.lb_params.depth);
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c
index e697d9bf1b44..6378e3fd7249 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c
@@ -145,8 +145,6 @@ void hubp1_program_tiling(
 {
 	struct dcn10_hubp *hubp1 = TO_DCN10_HUBP(hubp);
 
-	ASSERT(info->gfxversion == DcGfxVersion9);
-
 	REG_UPDATE_6(DCSURF_ADDR_CONFIG,
 			NUM_PIPES, log_2(info->gfx9.num_pipes),
 			NUM_BANKS, log_2(info->gfx9.num_banks),
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c
index 4715e60e812a..92288de4cc10 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c
@@ -313,8 +313,6 @@ static void hubp2_program_tiling(
 	const struct dc_tiling_info *info,
 	const enum surface_pixel_format pixel_format)
 {
-	ASSERT(info->gfxversion == DcGfxVersion9);
-
 	REG_UPDATE_3(DCSURF_ADDR_CONFIG,
 			NUM_PIPES, log_2(info->gfx9.num_pipes),
 			PIPE_INTERLEAVE, info->gfx9.pipe_interleave,
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c
index 207c2f86b7d7..0cc6f4558989 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c
@@ -321,8 +321,6 @@ void hubp3_program_tiling(
 	const struct dc_tiling_info *info,
 	const enum surface_pixel_format pixel_format)
 {
-	ASSERT(info->gfxversion == DcGfxVersion9);
-
 	REG_UPDATE_4(DCSURF_ADDR_CONFIG,
 		NUM_PIPES, log_2(info->gfx9.num_pipes),
 		PIPE_INTERLEAVE, info->gfx9.pipe_interleave,
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
index 861e940250af..c205500290ec 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
@@ -589,12 +589,7 @@ void hubp401_program_tiling(
 	 *
 	 * DIM_TYPE field in DCSURF_TILING for Display is always 1 (2D dimension) which is HW default.
 	 */
-	 if (info->gfxversion == DcGfxAddr3) {
-		REG_UPDATE(DCSURF_TILING_CONFIG, SW_MODE, info->gfx_addr3.swizzle);
-	} else {
-		/* linear */
-		REG_UPDATE(DCSURF_TILING_CONFIG, SW_MODE, 0);
-	}
+	 REG_UPDATE(DCSURF_TILING_CONFIG, SW_MODE, info->gfx_addr3.swizzle);
 }
 
 void hubp401_program_size(
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource_helpers.c
index 7d99f5d79e6d..f5a4e97c40ce 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource_helpers.c
@@ -401,8 +401,7 @@ void dcn32_set_det_allocations(struct dc *dc, struct dc_state *context,
 	 */
 	if (pipe_cnt == 1) {
 		pipes[0].pipe.src.det_size_override = DCN3_2_MAX_DET_SIZE;
-		if (pipe->plane_state && !disable_unbounded_requesting && pipe->plane_state->tiling_info.gfxversion != DcGfxBase &&
-			!(pipe->plane_state->tiling_info.gfxversion == DcGfxVersion9 && pipe->plane_state->tiling_info.gfx9.swizzle == DC_SW_LINEAR)) {
+		if (pipe->plane_state && !disable_unbounded_requesting && pipe->plane_state->tiling_info.gfx9.swizzle != DC_SW_LINEAR) {
 			if (!is_dual_plane(pipe->plane_state->format)) {
 				pipes[0].pipe.src.det_size_override = DCN3_2_DEFAULT_DET_SIZE;
 				pipes[0].pipe.src.unbounded_req_mode = true;
-- 
2.43.0

