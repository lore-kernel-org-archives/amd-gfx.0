Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C75CBD111A7
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 23:06:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B17710E73D;
	Wed, 26 Nov 2025 23:06:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wO8LIntg";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011066.outbound.protection.outlook.com [40.107.208.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2771510E73E
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 23:06:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tWN7Pz7rM7VylMX9xkDWFwhsENzoevqWYBT3jQ3EsSwDAcEPfDvmGcBFM9vhVIJ0jKAxIMH4il6vi4Iu6rg9yrlxVimo1tupZcGCOyLz55dO7hX1odRToWMGJtPPvpYxiBg6feUViTvoAnWTPUssNaBgDKcZsvzjFbzv4tO8NolE9ewFB9FG24caHpkVXYDg2+TT1t3QJIBtfM8x7L1ojxidwEfaJ6qi7UjmpvDF3cnGvKr6mawPGWeGzvUj24HltYjjOVFY59eCx/kDniXnQBuWcfcf7tRoQ24WcbaJTaFYb1FEJ1QGmR7YuEEocuEfh1nNug5X81TCVey8M6eaJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5omql+tgbqKkzO9QeH7tgpKQy5iQGZICNFErkykdFiA=;
 b=Ue+tvqVS/rjNbLPCx99FQl6/kay8jkVfyQRgcr80KCKIK206MlfCpX1ud+6mvzLVIB8rvfxMEm61lIw7ciPS+Ccrcq5N/daYGNQdmuLgTN/1TxLnk3OaYXvfo9zqwnRJSaQmmd/CPRQljoU2Xw6bEjZLk/GLnluD8ha7wMvI29SNqFQj+/X1Xvlc/VdDz1vgiA57M9b9kO3u+egwO59OIoGbYVfiD9OYLVOk5z3CBbvtbEQFyaV3bkvlMg42yorHfws44qRxT7niQL7ArrZKHOHW3LEORpmQk2JY1xMhPHloU6Vxl+pzEq2m4XmAsgFk6edcQcP0lhzkwHDmhLILmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5omql+tgbqKkzO9QeH7tgpKQy5iQGZICNFErkykdFiA=;
 b=wO8LIntglSHJ0nKJ+YJn6Hb6KAEAA22hwBbxEQIrbSjZCN/E/Pa1xorVZ7ry90/9MRg/Oe7hylXFulL/9FX5+B1w4aRWcSV3KFxNGXfMWrmm5VNsr9to7Mi2nzh6+fzT90gZtFtK21+rtX8y4JumH5aRjCg7gyxrmcNQIl0zB6M=
Received: from SA0PR13CA0018.namprd13.prod.outlook.com (2603:10b6:806:130::23)
 by CH3PR12MB8404.namprd12.prod.outlook.com (2603:10b6:610:12d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 23:06:41 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:806:130:cafe::d7) by SA0PR13CA0018.outlook.office365.com
 (2603:10b6:806:130::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.12 via Frontend Transport; Wed,
 26 Nov 2025 23:06:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 23:06:41 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 26 Nov
 2025 17:06:37 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 26 Nov
 2025 15:06:37 -0800
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 26 Nov 2025 15:06:36 -0800
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, Alvin
 Lee <alvin.lee2@amd.com>
Subject: [PATCH 06/14] drm/amd/display: Fix wrong x_pos and y_pos for cursor
 offload
Date: Wed, 26 Nov 2025 18:06:06 -0500
Message-ID: <20251126230614.13409-7-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251126230614.13409-1-Roman.Li@amd.com>
References: <20251126230614.13409-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|CH3PR12MB8404:EE_
X-MS-Office365-Filtering-Correlation-Id: d59fa3c5-8275-4e51-46a9-08de2d4075c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SD6OTXc9qiOOory3BAKyIMErNn56vw/PVe963fbKk8SgRgsc/+rdYsaMG4Js?=
 =?us-ascii?Q?Zl02putVX+WUk6BEkN7CbXNkMwNPSR/K22btt13JQPBsmG7luFT/BbIBwEky?=
 =?us-ascii?Q?N+IRj/6Bk5Ig3N4WbZercmgWRoA+nIExxfkCIq3q0eXZgZtDwjC1kwtmZBC3?=
 =?us-ascii?Q?FRLtW+zCRh4JO99JiR12eEyOJZ0BHSR3XTbM3utv1tcYYXI0CfG/z/bqyKrF?=
 =?us-ascii?Q?swF0uOxucjfEbVpuL0OXzUvmRcMK56SPQ/pcHMM3TpkDHB97FWe4m0P46L1v?=
 =?us-ascii?Q?kH6hMwb5JGz902AGgrYBWK96o6qNbRgvgZy8VBeAYgaq8Do3jNVfiSPHm3wv?=
 =?us-ascii?Q?yTFC7Hkmts7vQOCuRFjS1NPF5+6O2YM0sPyxW7BIBsN+61Z3br3MpUZ9sA98?=
 =?us-ascii?Q?vHhbA+PopwY9ogA/myR6tkcDjFokQcK4idYft5tVyKM8GeyGR++zta/iJNac?=
 =?us-ascii?Q?GngUGJzvinVirfU1LwlafAPp/eHVUL7u5fD3/Jzt3Tl7XiYqtNTLoPPzRTwT?=
 =?us-ascii?Q?2C7qDlR9hym40wr9t3g0QZZqGx1pyH9j+Qs7/F7HEp+boE2x9cZk03hjGvRz?=
 =?us-ascii?Q?hCJVoKmigbt0LNtsppvucIR2kqg0gv+PterYcVFj0bujOo5OCbsogbTfkw7R?=
 =?us-ascii?Q?+tEVXUz5pYusGPd60SVZUGy+VDbE3dVqBzscHC5fAfM4q24+IRJcR3KAfFz7?=
 =?us-ascii?Q?KQBi6KLeMAvmrjH8fKn7tYjuMV7ibvmxywFyqs7+Vtvph3eTPND5vKXY/57H?=
 =?us-ascii?Q?uO9skWwEowy4eA5h2kzKDuq3HHTI2CmguJN5dm/iKifsMkkx0NGLtFrC67qU?=
 =?us-ascii?Q?PvmNgvy3/adf4ZpDfaHgl12lo1p8Wz4j6k1xRgQ4hIqiCGoOIxGYXXug9brw?=
 =?us-ascii?Q?4+oEyCoHA0mlVCImlEsS3JhBF8CW0r5Wz0f1rygmaBwh1Z/sBWzfB8ZSjOuy?=
 =?us-ascii?Q?ZaqTKpUL06ZKuOOB50smRnob3Jk4YWq78scymu13avG2nSOZG6MC+1Fr7UwX?=
 =?us-ascii?Q?rye0tuZbdayx5yjz3YX6wybPHhJaOwVBCOB3flcv3SV915Io26GJrrSaYBdv?=
 =?us-ascii?Q?2tGtY9nkeDRIbUfo1cxVui0ktpiFdsX2m3ONYYm3UGj6nC3PCw2dhXGDUR0E?=
 =?us-ascii?Q?oG8zrJRf8clgljIzvQzfDCaUDwOjHnJr9TCfTPz6t3E1CdF47jhPEqeSL3k/?=
 =?us-ascii?Q?QzL2OhCbFZqNvsxrcN6TcBeibm+oZ1OSuAlQcfZzx+FnVRZzU/26Df86ZPVQ?=
 =?us-ascii?Q?pZuydJQgao0f+0KsByWG3E9BvIbHlzkAK1Fmn35s/8/ix3ITeAMtqaJezikK?=
 =?us-ascii?Q?FLhKwqI0a9WGu4FgQ+j2qBieVqVqx7iBueaKj4/jNrg77E9yWWcTsAv5NTLY?=
 =?us-ascii?Q?hY6OB4tZ1/qLE1bkrpdRBVBch7HtBuUvq078ggEz2kiBVHAM5Wca/MYyoE5U?=
 =?us-ascii?Q?jDRBFrvA/2AZrlXOnPr9QjgytmAizm/uRsya0E4Pu5UbkWJjk3ZongTV8X5m?=
 =?us-ascii?Q?65zCEyE03G1nV1ewXn2aBa//WEfZW980OzNKcakzXnoEpOGpJqKLunz+5x9F?=
 =?us-ascii?Q?nnnzamwHhhufDxrdyxk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 23:06:41.0077 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d59fa3c5-8275-4e51-46a9-08de2d4075c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8404
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
The hubp401_cursor_set_position function programs a different value
than it stores for use with cursor offload.

This can cause a desync when switching between cursor programming paths.

[How]
We do the translation to destination space currently twice: once in the
HWSS layer, and then again in the HUBP layer since we never store the
translated result.

HUBP expects to program the pos->x and pos->y directly for other ASIC,
so follow that pattern here as well.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c   | 14 ++++++--------
 .../drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c  |  3 +++
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
index f01eae50d02f..c205500290ec 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
@@ -733,10 +733,8 @@ void hubp401_cursor_set_position(
 	const struct dc_cursor_mi_param *param)
 {
 	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
-	int x_pos = pos->x - param->recout.x;
-	int y_pos = pos->y - param->recout.y;
-	int rec_x_offset = x_pos - pos->x_hotspot;
-	int rec_y_offset = y_pos - pos->y_hotspot;
+	int rec_x_offset = pos->x - pos->x_hotspot;
+	int rec_y_offset = pos->y - pos->y_hotspot;
 	int dst_x_offset;
 	int x_pos_viewport = 0;
 	int x_hot_viewport = 0;
@@ -748,10 +746,10 @@ void hubp401_cursor_set_position(
 	 * within preceeding ODM slices.
 	 */
 	if (param->recout.width) {
-		x_pos_viewport = x_pos * param->viewport.width / param->recout.width;
+		x_pos_viewport = pos->x * param->viewport.width / param->recout.width;
 		x_hot_viewport = pos->x_hotspot * param->viewport.width / param->recout.width;
 	} else {
-		ASSERT(!cur_en || x_pos == 0);
+		ASSERT(!cur_en || pos->x == 0);
 		ASSERT(!cur_en || pos->x_hotspot == 0);
 	}
 
@@ -790,8 +788,8 @@ void hubp401_cursor_set_position(
 
 	if (!hubp->cursor_offload) {
 		REG_SET_2(CURSOR_POSITION, 0,
-			CURSOR_X_POSITION, x_pos,
-			CURSOR_Y_POSITION, y_pos);
+			CURSOR_X_POSITION, pos->x,
+			CURSOR_Y_POSITION, pos->y);
 
 		REG_SET_2(CURSOR_HOT_SPOT, 0,
 			CURSOR_HOT_SPOT_X, pos->x_hotspot,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 01b0f72b6623..614d3e95de18 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -1215,6 +1215,9 @@ void dcn401_set_cursor_position(struct pipe_ctx *pipe_ctx)
 	if (recout_y_pos + (int)hubp->curs_attr.height <= 0)
 		pos_cpy.enable = false;  /* not visible beyond top edge*/
 
+	pos_cpy.x = x_pos;
+	pos_cpy.y = y_pos;
+
 	hubp->funcs->set_cursor_position(hubp, &pos_cpy, &param);
 	dpp->funcs->set_cursor_position(dpp, &pos_cpy, &param, hubp->curs_attr.width, hubp->curs_attr.height);
 }
-- 
2.34.1

