Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56EB6D35660
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jan 2026 02:00:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF07C10E5FA;
	Wed, 28 Jan 2026 02:00:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JOaCPsfX";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012043.outbound.protection.outlook.com [52.101.48.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79C2010E5FA
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jan 2026 02:00:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oU2pPrCG1cG6iVBYPhPiyYhaLH6H9g7iQgMprOQJq6rZZjDJHQ2fEbIpkMwF8Sm0+Lc/6iY+VTi7q4JMlZym/ljM9MvmzfibGtuRjfpvuriIBKX31DZJQexS2P657v52fwiyBOcM0eGvJgrQov8bLayhQmOiT+l/oNah/C6OAdaGoV9+381zyNU8GQCSr1WxDFc9FeHKRfSIkWzmJXYja8mKsdDsbkw0l77wtt6y+3pp4LbVTpoR3+kq7SYd6gvsjcgKTEsESWO9S22KT9nS12DXBlyu0QL8IRa1hXiCOviC4I91YJnsJWaTS9mhgGtfx/MsFXtuFzVL7mBFNlfxtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1KlmlidvnvMtUGUQJ4AoEaQQD7FTRA4VM73V2Tv1mzk=;
 b=kI7L+fSZdzDfUELC9aiwrxywN8/ydgu05pCCUY2GR3s2SLwfSpJVt7OavTNsY6oIWgdI6TloYcCvbxUhD9eYfeya6L1ALvtODvq3tdZNHAKsFv7VHtT4d6zTxvGFJFdBEpFqoFYdArf7CcGPk0UKlcgHgrBTMAAurYG2bLU5AkWGHpam+QKK0D42BoooF+OVhA6Qx+2wLK/DmpKKhApvV97kBz5xurc1XJjo1wN6WYZqCjNkywTZwBaOitcvYOs2zo5TQNLJCs+vTxkTCsml87phZ5ZpZH+3oKF0RoZHXhyi/a4MOYsEikfJ0dFs1d/3Gw0IojjQDNgUebKV94VZKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KlmlidvnvMtUGUQJ4AoEaQQD7FTRA4VM73V2Tv1mzk=;
 b=JOaCPsfXL9xggh/KTs1wnoBz1WKoOOuAH33EWoJOjqX8bS34OQ+8Nr6CD0GRYIdTUOj8ncP3AqC1vsy7nAfJn6jIYV844Sn0MYrva5exbEPcQrKtukPoANjHXncUUz+hCuYlpAvVbaiz3nJiWBJGmEHJnMLVkWnXNbCpHHmQaQg=
Received: from BLAP220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::24)
 by PH7PR12MB6443.namprd12.prod.outlook.com (2603:10b6:510:1f9::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.12; Wed, 28 Jan
 2026 02:00:08 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:208:32c:cafe::d7) by BLAP220CA0019.outlook.office365.com
 (2603:10b6:208:32c::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Wed,
 28 Jan 2026 02:00:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 28 Jan 2026 02:00:07 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 27 Jan
 2026 20:00:06 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 27 Jan
 2026 20:00:05 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 27 Jan 2026 20:00:02 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Nicholas Carbones <ncarbone@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH 13/21] drm/amd/display: Add Gfx Base Case For Linear Tiling
 Handling
Date: Wed, 28 Jan 2026 09:51:38 +0800
Message-ID: <20260128015538.568712-14-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260128015538.568712-1-Wayne.Lin@amd.com>
References: <20260128015538.568712-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|PH7PR12MB6443:EE_
X-MS-Office365-Filtering-Correlation-Id: 832852b9-6a85-4128-1275-08de5e10f5f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OkcXtLpvVZqsN4kC7fzJW8GXoWcQJxFPS/Fz8oE/mskJoknG7hLVXJhdItzD?=
 =?us-ascii?Q?AqbCSB/SUBq3B1stvKOkmL91YuSUL0CORP2GO2a+I9E3beu9iAfUF+5YfOPQ?=
 =?us-ascii?Q?8JseiWQxA8Ro8hJ+00mJdHTgqBlrd07JqZeytAUMJo2yTs6OvA9wcGmnok9s?=
 =?us-ascii?Q?VMrjphDlptkzwUN+YIJnUuVS08qKD7ajW2/XmnRle8Zx98dYuUhFvd60UZsV?=
 =?us-ascii?Q?fDS9Q6Lyx7VQexFtW5qHQMvgVCz7Kiwgn/cw1Yere/5aqLIENjqOvrAeRVUC?=
 =?us-ascii?Q?BGyioXR+XrL20Amf9XcCYmK5t90e2qugaJ4kIapRad51reYizXXrDmheVgcJ?=
 =?us-ascii?Q?mz4H/bXRaFEBMgr2PE33MIpFEWCDpR6DCyXoiD7/Ffs7wsioE2sz4qVkE0aA?=
 =?us-ascii?Q?ntkMthaSWjpvZT0aXoCvjJMIIs4a++W4+GX/0HWaM/Ylow7YFuxhz+mwxz4Y?=
 =?us-ascii?Q?rjC4cpN4eL7yjpilUj/W2eslCiLQHUl4BRqkdfJGroejA+Jn+uA1+iC7QNSc?=
 =?us-ascii?Q?F6ryIRvuKdJOfAnn8JxwLvtbBYpheBG9IorVn0diqJhZJ/6pU5H77OHsAlgC?=
 =?us-ascii?Q?NB12k6SAFZ6C6Y74qeZWBBudURNefB3DGx58kFecZWlcKdg2yu3MTgNriYmx?=
 =?us-ascii?Q?7VETcr93Y38jQOa6BWAPtywIAotKqOTVd62oyBmgNUAkMDt46p5wQQPuB3ue?=
 =?us-ascii?Q?KKhXBVaBUVNsiXD29AnwAL2kB5RmzA9jigAVU0NgGoXbelbjXzwXEoloCNqe?=
 =?us-ascii?Q?+rfMVqSzW9w904PSFmHvFzrTol2TvmH/sAAmfs3R5uiY++3B6YnxUNkH6xG1?=
 =?us-ascii?Q?lLN+eAwakw7f5zz0SG4uN7BTV8tq1JbHqM3v3U+MAPsNsT9QmInIDeFeEiqe?=
 =?us-ascii?Q?wh4FwjxeoDPhNRt4r5B6C+s+6KmBTdAg5zmLIY4qOm1D0zd+pGQBggcts5Xa?=
 =?us-ascii?Q?aUgOpQ2eVpz1nqw7+TpJq8tORIBdA43b5/UArVyDg02bh0XlMKomf2DV65fg?=
 =?us-ascii?Q?Wcku8USGqKlXlTNdJkpecTjmovoHdiuASDAE5ZO4qQI7MrpsUWdvlYdVODVQ?=
 =?us-ascii?Q?3HrgC3zd9fnlvsXu79mRQ/3WPcc4J7+DpgCYcxjP8RWKDW6uL2ed4tUYtwze?=
 =?us-ascii?Q?lhZPDqSZCsp28nPMI80okX3L3Tag0m99pmoiSTYy/yb0EY9TGTRYBKZAaksT?=
 =?us-ascii?Q?8PQfUMVYK5P2RAXlKgCmSby6M9K5m8huGLFsskEnig4mHakJGthZnGgV6L5z?=
 =?us-ascii?Q?Cu4EtiCNEW10ax4f9djFWJH+GpWIMviRzWziPKF2cEbvdZj5WmE+Mkl2SrC9?=
 =?us-ascii?Q?rBiE2D8LWyXJuLUweZrVlw0Py5DQQ+UMhlwhgmGAWYfClxhTPgElfX+M1mOe?=
 =?us-ascii?Q?BsFequVybp6x1TwCC+/4f3TEM+hSyj8+7jhN+ZMHA52uk1HPN1jaJqz9gsrv?=
 =?us-ascii?Q?cfiCb6q/Z9nguA/3N97iMWytUbtjMHJ3u7b2/ArsbkpyXfwn6lIPVnWip6ea?=
 =?us-ascii?Q?TvnVpo+rCEy+QHb4ZW2Yifcasn5lZRNW+uqJq2Wd4HsWSNJoloxlRY+TMYWn?=
 =?us-ascii?Q?JGOblgD4/2E/ewbECpn55SGtwDxij3J/Uc7loS0Auc6Vnki2u1Pj/ApH+wgQ?=
 =?us-ascii?Q?pe1Qxh5eaRlAznYAJK3b4uw/jsIb+oWuTI39blC6cNXgp3e8AoQ0EsFcbTtZ?=
 =?us-ascii?Q?s9/sAA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 02:00:07.1530 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 832852b9-6a85-4128-1275-08de5e10f5f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6443
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

From: Nicholas Carbones <ncarbone@amd.com>

[Why]
Post-driver cases always use linear tiling yet there is no dedicated
Gfx handling for this condition.

[How]
Add DcGfxBase/DalGfxBase to gfx version enums and set tiling to linear
when it is used. Also, enforce the use of proper tiling format as tiling
information is used.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Nicholas Carbones <ncarbone@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c          | 1 +
 drivers/gpu/drm/amd/display/dc/core/dc.c                   | 1 +
 drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c      | 7 +++++++
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c          | 1 +
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h               | 3 ++-
 drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c         | 3 +++
 drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c | 3 +++
 drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c       | 1 +
 drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c     | 2 ++
 drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c     | 2 ++
 drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c     | 2 ++
 drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c   | 7 ++++++-
 .../amd/display/dc/resource/dcn32/dcn32_resource_helpers.c | 3 ++-
 13 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index fcc48994c3e3..333ff8557732 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8033,6 +8033,7 @@ static enum dc_status dm_validate_stream_and_context(struct dc *dc,
 	dc_plane_state->plane_size.chroma_size.height  = stream->src.height;
 	dc_plane_state->plane_size.chroma_size.width   = stream->src.width;
 	dc_plane_state->format = SURFACE_PIXEL_FORMAT_GRPH_ARGB8888;
+	dc_plane_state->tiling_info.gfxversion = DcGfxVersion9;
 	dc_plane_state->tiling_info.gfx9.swizzle = DC_SW_UNKNOWN;
 	dc_plane_state->rotation = ROTATION_ANGLE_0;
 	dc_plane_state->is_tiling_rotated = false;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 4305691ba45e..441b7e0a3b22 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2768,6 +2768,7 @@ static struct surface_update_descriptor get_plane_info_update_type(const struct
 		case DcGfxVersion7:
 		case DcGfxVersion8:
 		case DcGfxVersionUnknown:
+		case DcGfxBase:
 		default:
 			break;
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 052d573408c3..a13d9d7dd6c5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -2065,6 +2065,13 @@ void get_surface_tile_visual_confirm_color(
 	while (bottom_pipe_ctx->bottom_pipe != NULL)
 		bottom_pipe_ctx = bottom_pipe_ctx->bottom_pipe;
 
+	if (bottom_pipe_ctx->plane_state->tiling_info.gfxversion == DcGfxBase) {
+		/* LINEAR Surface - set border color to red */
+		color->color_r_cr = color_value;
+		return;
+	}
+
+	ASSERT(bottom_pipe_ctx->plane_state->tiling_info.gfxversion == DcGfxVersion9);
 	switch (bottom_pipe_ctx->plane_state->tiling_info.gfx9.swizzle) {
 	case DC_SW_LINEAR:
 		/* LINEAR Surface - set border color to red */
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 848c267ef11e..b4e5a79e9749 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -4434,6 +4434,7 @@ enum dc_status dc_validate_global_state(
 
 			if (dc->res_pool->funcs->patch_unknown_plane_state &&
 					pipe_ctx->plane_state &&
+					pipe_ctx->plane_state->tiling_info.gfxversion == DcGfxVersion9 &&
 					pipe_ctx->plane_state->tiling_info.gfx9.swizzle == DC_SW_UNKNOWN) {
 				result = dc->res_pool->funcs->patch_unknown_plane_state(pipe_ctx->plane_state);
 				if (result != DC_OK)
diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
index cfa569a7bff1..7121629da38e 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
@@ -342,7 +342,8 @@ enum swizzle_mode_addr3_values {
 };
 
 enum dc_gfxversion {
-	DcGfxVersion7 = 0,
+	DcGfxBase = 0,
+	DcGfxVersion7,
 	DcGfxVersion8,
 	DcGfxVersion9,
 	DcGfxVersion10,
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
index 1c2009e38aa1..5df58fadc862 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
@@ -100,6 +100,7 @@ static enum mi_bits_per_pixel get_mi_bpp(
 static enum mi_tiling_format get_mi_tiling(
 		struct dc_tiling_info *tiling_info)
 {
+	ASSERT(tiling_info->gfxversion == DcGfxVersion8);
 	switch (tiling_info->gfx8.array_mode) {
 	case DC_ARRAY_1D_TILED_THIN1:
 	case DC_ARRAY_1D_TILED_THICK:
@@ -433,6 +434,7 @@ static void program_tiling(
 	struct dce_mem_input *dce_mi, const struct dc_tiling_info *info)
 {
 	if (dce_mi->masks->GRPH_SW_MODE) { /* GFX9 */
+		ASSERT(info->gfxversion == DcGfxVersion9);
 		REG_UPDATE_6(GRPH_CONTROL,
 				GRPH_SW_MODE, info->gfx9.swizzle,
 				GRPH_NUM_BANKS, log_2(info->gfx9.num_banks),
@@ -447,6 +449,7 @@ static void program_tiling(
 	}
 
 	if (dce_mi->masks->GRPH_MICRO_TILE_MODE) { /* GFX8 */
+		ASSERT(info->gfxversion == DcGfxVersion8);
 		REG_UPDATE_9(GRPH_CONTROL,
 				GRPH_NUM_BANKS, info->gfx8.num_banks,
 				GRPH_BANK_WIDTH, info->gfx8.bank_width,
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c
index 2c43c2422638..67cfca3361fb 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c
@@ -165,6 +165,8 @@ static void program_tiling(
 	const struct dc_tiling_info *info,
 	const enum surface_pixel_format pixel_format)
 {
+	ASSERT(info->gfxversion == DcGfxVersion8);
+
 	uint32_t value = 0;
 
 	set_reg_field_value(value, info->gfx8.num_banks,
@@ -541,6 +543,7 @@ static const unsigned int *get_dvmm_hw_setting(
 	else
 		bpp = bpp_8;
 
+	ASSERT(tiling_info->gfxversion == DcGfxVersion8);
 	switch (tiling_info->gfx8.array_mode) {
 	case DC_ARRAY_1D_TILED_THIN1:
 	case DC_ARRAY_1D_TILED_THICK:
diff --git a/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
index 74962791302f..71eeee02c0fa 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
@@ -1006,6 +1006,7 @@ bool dcn_validate_bandwidth(
 
 			v->source_pixel_format[input_idx] = tl_pixel_format_to_bw_defs(
 					pipe->plane_state->format);
+			ASSERT(pipe->plane_state->tiling_info.gfxversion == DcGfxVersion9);
 			v->source_surface_mode[input_idx] = tl_sw_mode_to_bw_defs(
 					pipe->plane_state->tiling_info.gfx9.swizzle);
 			v->lb_bit_per_pixel[input_idx] = tl_lb_bpp_to_int(pipe->plane_res.scl_data.lb_params.depth);
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c
index 6378e3fd7249..e697d9bf1b44 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c
@@ -145,6 +145,8 @@ void hubp1_program_tiling(
 {
 	struct dcn10_hubp *hubp1 = TO_DCN10_HUBP(hubp);
 
+	ASSERT(info->gfxversion == DcGfxVersion9);
+
 	REG_UPDATE_6(DCSURF_ADDR_CONFIG,
 			NUM_PIPES, log_2(info->gfx9.num_pipes),
 			NUM_BANKS, log_2(info->gfx9.num_banks),
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c
index 92288de4cc10..4715e60e812a 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c
@@ -313,6 +313,8 @@ static void hubp2_program_tiling(
 	const struct dc_tiling_info *info,
 	const enum surface_pixel_format pixel_format)
 {
+	ASSERT(info->gfxversion == DcGfxVersion9);
+
 	REG_UPDATE_3(DCSURF_ADDR_CONFIG,
 			NUM_PIPES, log_2(info->gfx9.num_pipes),
 			PIPE_INTERLEAVE, info->gfx9.pipe_interleave,
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c
index 0cc6f4558989..207c2f86b7d7 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c
@@ -321,6 +321,8 @@ void hubp3_program_tiling(
 	const struct dc_tiling_info *info,
 	const enum surface_pixel_format pixel_format)
 {
+	ASSERT(info->gfxversion == DcGfxVersion9);
+
 	REG_UPDATE_4(DCSURF_ADDR_CONFIG,
 		NUM_PIPES, log_2(info->gfx9.num_pipes),
 		PIPE_INTERLEAVE, info->gfx9.pipe_interleave,
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
index c205500290ec..861e940250af 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
@@ -589,7 +589,12 @@ void hubp401_program_tiling(
 	 *
 	 * DIM_TYPE field in DCSURF_TILING for Display is always 1 (2D dimension) which is HW default.
 	 */
-	 REG_UPDATE(DCSURF_TILING_CONFIG, SW_MODE, info->gfx_addr3.swizzle);
+	 if (info->gfxversion == DcGfxAddr3) {
+		REG_UPDATE(DCSURF_TILING_CONFIG, SW_MODE, info->gfx_addr3.swizzle);
+	} else {
+		/* linear */
+		REG_UPDATE(DCSURF_TILING_CONFIG, SW_MODE, 0);
+	}
 }
 
 void hubp401_program_size(
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource_helpers.c
index f5a4e97c40ce..7d99f5d79e6d 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource_helpers.c
@@ -401,7 +401,8 @@ void dcn32_set_det_allocations(struct dc *dc, struct dc_state *context,
 	 */
 	if (pipe_cnt == 1) {
 		pipes[0].pipe.src.det_size_override = DCN3_2_MAX_DET_SIZE;
-		if (pipe->plane_state && !disable_unbounded_requesting && pipe->plane_state->tiling_info.gfx9.swizzle != DC_SW_LINEAR) {
+		if (pipe->plane_state && !disable_unbounded_requesting && pipe->plane_state->tiling_info.gfxversion != DcGfxBase &&
+			!(pipe->plane_state->tiling_info.gfxversion == DcGfxVersion9 && pipe->plane_state->tiling_info.gfx9.swizzle == DC_SW_LINEAR)) {
 			if (!is_dual_plane(pipe->plane_state->format)) {
 				pipes[0].pipe.src.det_size_override = DCN3_2_DEFAULT_DET_SIZE;
 				pipes[0].pipe.src.unbounded_req_mode = true;
-- 
2.43.0

