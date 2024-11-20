Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B4DED6C2BA
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2024 00:33:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF0CB10E381;
	Wed, 20 Nov 2024 00:33:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vaAietQS";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9467810E380
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2024 00:33:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O2w351GrO2WcEyAWZB4waD50IXb7Vl46z4JylnpvvP7PUa4CjLDyS8wafVq/m1dTKo1mhuhne+Iu0zds0sAkCQNMmWun7pfA6mjmS+jxKSJdbc1IQMsP2xs7VLuMe8Kcpdu8T2YLpO57sbsOFSoOAS1XI3n0NafltW+eoEUs6OA/grmHlqu2Edc231ntIjFs6fu25K4lfGKHfcOYvoRczPnX0RwKylHKNevT20yE+IKFBF48sgI6emQ99aVWOQ6KbSIKqyfRYVPAporcTt4NMFL2Z2HzmG5wUSykaEwhuXGhSq6mpfk6Dg8zri2fvM0ckGajuVwbtSwAGEI+CxQ+5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VxY8q/3aykdAHOHSrJttkvUFnAtftsC+om/tpzAmeVk=;
 b=THFT8oHym8d437qyYmdI4Xof3yYvSbmGvCb3TMCDQU/Cux2V+Cjb16KT+85FxsbyNjCd1Bjv5uEbWmE3dX5emx65lo4PbBwiSVPAPfWyou/KV5/4MxXzuUm2T6Fh8IluF9B3JA058WYo1nPV7LUbDjj10tXmmrjfZr+QdcMQ7Fw3rrOCeQnxXpL969bRBucEXyjNyxszp0e8kCKbq6yKUx7ARvaX/ZgroN6xMoz1oGYP/8BD9UtQfzfnU3R196jnLINHJm4sG/YF7iStvMZ/aujhBPSVAWIDTPzauKHwlKFeD7grtH/ksdxhtwDTMnuvwWy2kVnV0ilxRVf4YXq+fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VxY8q/3aykdAHOHSrJttkvUFnAtftsC+om/tpzAmeVk=;
 b=vaAietQSGBKnUGNAbi7snr0ZXGwTwGjptpC4sh3nwZxnAxg2tZcDBMKlG7mMcK8pnUNJy4fjcx7Eo86ZEvDa390E1fK4CoIeZVTaukVWqvsHArHU2nxzJr392I10+TaG+0Qr4XHit0OX0OUd+npseShzZd+u/soE2K8v5tmFYh0=
Received: from BY5PR04CA0006.namprd04.prod.outlook.com (2603:10b6:a03:1d0::16)
 by DM4PR12MB5889.namprd12.prod.outlook.com (2603:10b6:8:65::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 00:33:33 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::a) by BY5PR04CA0006.outlook.office365.com
 (2603:10b6:a03:1d0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend
 Transport; Wed, 20 Nov 2024 00:33:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 20 Nov 2024 00:33:32 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Nov
 2024 18:33:29 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Samson Tam
 <Samson.Tam@amd.com>, Navid Assadian <navid.assadian@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 4/9] drm/amd/display: Add support for custom recout_width in
 SPL
Date: Tue, 19 Nov 2024 17:28:32 -0700
Message-ID: <20241120003044.2160289-5-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241120003044.2160289-1-alex.hung@amd.com>
References: <20241120003044.2160289-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|DM4PR12MB5889:EE_
X-MS-Office365-Filtering-Correlation-Id: 13620b6a-a0c1-4217-2456-08dd08faf67b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1zTMHgp/xiyxgDw9RGeVJwyTd0AGVFYbeLUj11XXfwMkiEUeKZy1KtMNf1/7?=
 =?us-ascii?Q?+DDBegK6SEEnTrcnNmXS58tSKzjW62froHEADvesdi0/1E9o4p680zLTWGBu?=
 =?us-ascii?Q?IQI1bG2B2sOOjcVzatFC5XLdjjKSehpegdtoApB0Yf6YDnVKoq4PEzhqtQlD?=
 =?us-ascii?Q?xb1NZ1hRlmhif7v0JfibbvRiTo7syZwvPP+QQ9GI72WcZ+0wSrVi85lrremv?=
 =?us-ascii?Q?WfrscSEGqM3b9oda6GmNW8HbQaKyosOqKrvOqbq4fnv4pFS2IfDctn0NEBe/?=
 =?us-ascii?Q?U0ddnmbnSO0aprYNpg6+O/O+nzeH8JZggzvY2vPMHW6mfIcutRCvJCq/2whi?=
 =?us-ascii?Q?644B0mtzAlA5keuONkgTxwjvH85ydb/2OP3q8BdM3E3M1kEETrgbE+d6/yQA?=
 =?us-ascii?Q?ZjtceNbIzBuPYAZYXtbCWbtKFUWvRgFW7+OjpezG35rNLVICGHqdoOf2SX4g?=
 =?us-ascii?Q?EuDY09ejrcwDOKpwPS/f+TfOr4RVjuOphXScQGYqTW8x9XYla3BQed/xruk7?=
 =?us-ascii?Q?TjEBDEg1Cs+qKO4+SrJDphEOSkLLq4jFXuJwuEVMVGfihf7gzFNoBY8NdONn?=
 =?us-ascii?Q?vX8dJtaaOQ2wC4sCUyjmS24VfuKRiNeIGDxu2C/Lz4HJIe6K5AtYHqqNJrWR?=
 =?us-ascii?Q?7mrgybT2WT9LBv/g5YtvpDK4cftwPGtJsQwdA8mDDU2tTnawZ/uASZ1piWVb?=
 =?us-ascii?Q?MDY3tjI45fvYa1ImCh9dnm3IvHUpvcg9QZ4eic3CbjyBh8b6GQN1edl/cwT3?=
 =?us-ascii?Q?aAgy/keYMRG4PvhkMSs9eT/SilcVzIk/EoEFECb0OSEQJiJtq72GTgN6In36?=
 =?us-ascii?Q?PkrdoqqR0B5+VtOaBbR9+lfNw1Q4CfshJKCaGiZ/dc5I/heFynvc9m+t2Dc+?=
 =?us-ascii?Q?ZIxOsqz+EaNIJmN6cr2oF7XyRrp8x1CsGaZuvwdyLgngknjJNfMsCyGuOdLA?=
 =?us-ascii?Q?SbrNghO5woTEsXvmLHNPw6Yj1rgo7behTYmGac7b/Y0xkajJ5Y0qiHK1SMwo?=
 =?us-ascii?Q?t3qfOR5HUJu8tAuDJuWmBEGHF9kdb5ya1byYysKIFtgllbl9Fv+k3k015S54?=
 =?us-ascii?Q?MIaaOZnHoEefhmQe3zJykoHJc6IS8rn6AUg+wt24aHeeonjFiUzYp8A66x65?=
 =?us-ascii?Q?sS+lT/j4tXV4tCKFxaXeawIYGrZTtprNYjuvOuZTv4al5zlrtz6uv17r48or?=
 =?us-ascii?Q?9M15VBkkyLt0HQbyIOW/Qy5F8oF7JKP6ihtElVXGEleqHy5TIIsPozWS9/Ov?=
 =?us-ascii?Q?dTtZpw4qaHGE54hPdeEaabClVBQ6dst5+BeZGs/G1IfKwitGoHRQCMuVUfn6?=
 =?us-ascii?Q?IkhW6aQRxmobr7ZDDy+mEX7TDT24cNM7D2S8w7Nk3+a+EZBkX54VrDzlghHa?=
 =?us-ascii?Q?x//ekNz7KOmiVTokCGZvRfKy5AMrxDhOx6XYVK0kfIUbnlLMbw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 00:33:32.4871 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13620b6a-a0c1-4217-2456-08dd08faf67b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5889
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

From: Samson Tam <Samson.Tam@amd.com>

[WHY]
Add support for custom recout_width for mpc combine in SPL

[HOW]
1. Rename mpc_combine_h and mpc_combine_v
2. Add flag use_recout_width_aligned to use custom recout_width
3. Create union to use either mpc_num_h_slices or mpc_recout_width_align

Reviewed-by: Navid Assadian <navid.assadian@amd.com>
Signed-off-by: Samson Tam <Samson.Tam@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/dc/dc_spl_translate.c |  8 +++--
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.c   | 31 ++++++++++++++-----
 .../gpu/drm/amd/display/dc/spl/dc_spl_types.h | 10 ++++--
 3 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c b/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
index c8d8e335fa37..2fee0b92f1f5 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
@@ -108,12 +108,14 @@ void translate_SPL_in_params_from_pipe_ctx(struct pipe_ctx *pipe_ctx, struct spl
 	spl_in->basic_in.horizontal_mirror = plane_state->horizontal_mirror;
 
 	// Calculate horizontal splits and split index
-	spl_in->basic_in.mpc_combine_h = resource_get_mpc_slice_count(pipe_ctx);
+	spl_in->basic_in.num_h_slices_recout_width_align.use_recout_width_aligned = false;
+	spl_in->basic_in.num_h_slices_recout_width_align.num_slices_recout_width.mpc_num_h_slices =
+		resource_get_mpc_slice_count(pipe_ctx);
 
 	if (stream->view_format == VIEW_3D_FORMAT_SIDE_BY_SIDE)
-		spl_in->basic_in.mpc_combine_v = 0;
+		spl_in->basic_in.mpc_h_slice_index = 0;
 	else
-		spl_in->basic_in.mpc_combine_v = resource_get_mpc_slice_index(pipe_ctx);
+		spl_in->basic_in.mpc_h_slice_index = resource_get_mpc_slice_index(pipe_ctx);
 
 	populate_splrect_from_rect(&spl_in->basic_out.odm_slice_rect, &odm_slice_src);
 	spl_in->basic_out.odm_combine_factor = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c b/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
index 27fd20fa2942..c92312fec7a9 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
+++ b/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
@@ -137,15 +137,32 @@ static struct spl_rect calculate_mpc_slice_in_timing_active(
 		struct spl_in *spl_in,
 		struct spl_rect *plane_clip_rec)
 {
-	int mpc_slice_count = spl_in->basic_in.mpc_combine_h;
-	int mpc_slice_idx = spl_in->basic_in.mpc_combine_v;
+	bool use_recout_width_aligned =
+		spl_in->basic_in.num_h_slices_recout_width_align.use_recout_width_aligned;
+	int mpc_slice_count =
+		spl_in->basic_in.num_h_slices_recout_width_align.num_slices_recout_width.mpc_num_h_slices;
+	int recout_width_align =
+		spl_in->basic_in.num_h_slices_recout_width_align.num_slices_recout_width.mpc_recout_width_align;
+	int mpc_slice_idx = spl_in->basic_in.mpc_h_slice_index;
 	int epimo = mpc_slice_count - plane_clip_rec->width % mpc_slice_count - 1;
 	struct spl_rect mpc_rec;
 
-	mpc_rec.width = plane_clip_rec->width / mpc_slice_count;
-	mpc_rec.x = plane_clip_rec->x + mpc_rec.width * mpc_slice_idx;
-	mpc_rec.height = plane_clip_rec->height;
-	mpc_rec.y = plane_clip_rec->y;
+	if (use_recout_width_aligned) {
+		mpc_rec.width = recout_width_align;
+		if ((mpc_rec.width * (mpc_slice_idx + 1)) > plane_clip_rec->width) {
+			mpc_rec.width = plane_clip_rec->width % recout_width_align;
+			mpc_rec.x = plane_clip_rec->x + recout_width_align * mpc_slice_idx;
+		} else
+			mpc_rec.x = plane_clip_rec->x + mpc_rec.width * mpc_slice_idx;
+		mpc_rec.height = plane_clip_rec->height;
+		mpc_rec.y = plane_clip_rec->y;
+
+	} else {
+		mpc_rec.width = plane_clip_rec->width / mpc_slice_count;
+		mpc_rec.x = plane_clip_rec->x + mpc_rec.width * mpc_slice_idx;
+		mpc_rec.height = plane_clip_rec->height;
+		mpc_rec.y = plane_clip_rec->y;
+	}
 	SPL_ASSERT(mpc_slice_count == 1 ||
 			spl_in->basic_out.view_format != SPL_VIEW_3D_SIDE_BY_SIDE ||
 			mpc_rec.width % 2 == 0);
@@ -678,7 +695,7 @@ static void spl_handle_3d_recout(struct spl_in *spl_in, struct spl_rect *recout)
 	 * since 3d is special and needs to calculate vp as if there is no recout offset
 	 * This may break with rotation, good thing we aren't mixing hw rotation and 3d
 	 */
-	if (spl_in->basic_in.mpc_combine_v) {
+	if (spl_in->basic_in.mpc_h_slice_index) {
 		SPL_ASSERT(spl_in->basic_in.rotation == SPL_ROTATION_ANGLE_0 ||
 			(spl_in->basic_out.view_format != SPL_VIEW_3D_TOP_AND_BOTTOM &&
 					spl_in->basic_out.view_format != SPL_VIEW_3D_SIDE_BY_SIDE));
diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h b/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h
index 55d557df4aa5..0e6db94bbfb2 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h
+++ b/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h
@@ -436,8 +436,14 @@ struct basic_in	{
 	struct spl_rect clip_rect; // Clip rect
 	enum spl_rotation_angle rotation;  // Rotation
 	bool horizontal_mirror;  // Horizontal mirror
-	int mpc_combine_h; // MPC Horizontal Combine Factor (split_count)
-	int mpc_combine_v; // MPC Vertical Combine Factor (split_idx)
+	struct { // previous mpc_combine_h - split count
+		bool use_recout_width_aligned;
+		union {
+			int mpc_num_h_slices;
+			int mpc_recout_width_align;
+		} num_slices_recout_width;
+	} num_h_slices_recout_width_align;
+	int mpc_h_slice_index; // previous mpc_combine_v - split_idx
 	// Inputs for adaptive scaler - TODO
 	enum spl_transfer_func_type tf_type; /* Transfer function type */
 	enum spl_transfer_func_predefined tf_predefined_type; /* Transfer function predefined type */
-- 
2.43.0

