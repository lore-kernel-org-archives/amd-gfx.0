Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF477CEE343
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Oct 2024 19:26:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8A5810E7E0;
	Wed,  9 Oct 2024 19:26:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="glH6Kdfk";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC29F10E7DE
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Oct 2024 19:26:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T2dN9AIKXPweMw41yXO8X+dGX8RZkuzxn23mw1EIcSW1/ypugVeOehksMNy9g9ijKsg2VJESB5scbS+Fy/jF1GUz6UdQ9EJKetb8Fs7Ys8IjKLBA6OM/oyJQrtRpap4b7uFa/yuTsxb02ym53cYE7aYYA0WAkvLJ8iRftyV/UYYich79G7LQCkaqMh7y7RYrvE4rfFAl1RtRM7bmyNMW/n/Jr/m84JTXqMW2MI2yMGjeKRaNMH+BEowWJTLc/q18ThyJ+QkH+7M3arPNvcSb/+E1v9jj05aDWQ95LKBlJ5NinG1S4PuUDYnhp6v1R9cpvpce+hil/hriP3DMOl3SRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mONzyDQZEmkV7UnKrv7iecWdyMEO+O7G2rIS6YaMg44=;
 b=fggAjx++ph3mgM/pQv2npMV5hXEMaI+e37p3ERbpjbkWOn4VLUl/480SOAZy1mVtvhsZv4zooyVuAvCtMQzp65uScR5YKDweKBlqBzpt6EYkFyUDbzXEHs/5b7bHYWXQkH45CeqiO1QRcDVzQG5O3OZdR0e55W04R9Xhdyjf60hvUKJyjuq7ZLkFUr0ajV2Y4HbplKje1ZBfEWu9RKTPI0LyU11w0qO96imoqMo7dJyOA32pxAgqTue7zv5K2knOPuebsvExyt6kKNKLETB68sKTlYdj78qUErkDEXRumaZ9hKJIIqOTm5KnoElNBIBTpZiYmI5mYlqmLcEx+J9tqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mONzyDQZEmkV7UnKrv7iecWdyMEO+O7G2rIS6YaMg44=;
 b=glH6KdfktJCeC4bS0LOL88PKBAFT4ONvjyTbnpja7FUr6cWfj+AxRBXJIb0dCq+5D6QsZjQ1sF+Gn7FDz+zIKHF8KpnHtyMR6n4R0q9n4AW9jsJEdiadIZXU/w91JDErr7Cfx4nVkzHBb4RLx1F5nSYJW25/w0KcirXXqZGhKWw=
Received: from BN9PR03CA0188.namprd03.prod.outlook.com (2603:10b6:408:f9::13)
 by DM4PR12MB5914.namprd12.prod.outlook.com (2603:10b6:8:67::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 19:26:04 +0000
Received: from BN3PEPF0000B06E.namprd21.prod.outlook.com
 (2603:10b6:408:f9:cafe::90) by BN9PR03CA0188.outlook.office365.com
 (2603:10b6:408:f9::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Wed, 9 Oct 2024 19:26:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06E.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.0 via Frontend Transport; Wed, 9 Oct 2024 19:26:04 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 14:26:03 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 9 Oct 2024 14:26:03 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 09/16] drm/amd/display: print messages when programming
 shaper/3dlut fails
Date: Wed, 9 Oct 2024 15:23:37 -0400
Message-ID: <20241009192344.650118-10-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241009192344.650118-1-Roman.Li@amd.com>
References: <20241009192344.650118-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06E:EE_|DM4PR12MB5914:EE_
X-MS-Office365-Filtering-Correlation-Id: d26cf6e5-a7fc-44e5-0253-08dce8983763
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fw1Mn/Ji2AI5dUKX6TMo68+JeJmWUnzyLrR6/uYw30WMoZ6PnZsaYOU3cppl?=
 =?us-ascii?Q?/oVZHmAMgcoGyetRyaQ0cKPT6rI+QayD4v/CZJAZJSE+gmdXMCn0nb6Q3sGH?=
 =?us-ascii?Q?fcpt+bivPu9GTCjkNAiSOIOctrbhCY2hZs23GgARx4Ktf6ecdTuJNkreI7kW?=
 =?us-ascii?Q?mqd5vPBTTtM4vDsZk0fjTy7Nc+GshBx1/qa+E2nQtoGi5uIM7Y8yzKqGPyPm?=
 =?us-ascii?Q?Lv12Az2bqlMI1I/qvFEfbOz47Iuapiy5a40rcq1jz12fRzphODV9YoVhGlKg?=
 =?us-ascii?Q?9ise9y/PS8DBTGjVl72JBG7MRdCcugQzd968MOdF090vbwXB1Ndb1e7Rv6nO?=
 =?us-ascii?Q?Ewc4pWhHXOwAfoHr3hmGvM7cScs6+Mmc/+3Md8TbAlvn1ElXv1j9WjA2tW8v?=
 =?us-ascii?Q?lA5o5c8sLTTUlEEGAQYmORJYsoLlFuC2ba6TEGtOikuSiw4znZ+AmQHMB+1b?=
 =?us-ascii?Q?m+V/Imb0HpZr/q308AjDK9EA5Qp3FlXfOBT2IVMBJxOAB24DOxqFY5FFkc0W?=
 =?us-ascii?Q?boOPK2as/co2DKW5plhP14GtOyDlnYJORjmN8IQvKNbJ+aR6CpXABSX7sezd?=
 =?us-ascii?Q?ZrC/UxusqZ/seKWfmFgnMzA+IeXPZd6Ifs4sNP8tPeZqLzYtXul1iL2z5fRD?=
 =?us-ascii?Q?e2EzU2OXW9e5X8SETWuJ7JTRPjNGFQvgyjEFQocb4OYXg5n4ltglMJHS+07S?=
 =?us-ascii?Q?U6UPnyQBnlqCWmCVIgoobWYSYnZX976yluLVgRxksq84s+xUUVeLHxbIl1Kp?=
 =?us-ascii?Q?zejHjZwL6LbLO6QYy0Wta6bq41dz2rAhC+tpzcUBnx/C4GzQqbNevXT5gcDr?=
 =?us-ascii?Q?13GIyCSSqu0NcFsrqj+FZJ5vrL1Chub65reNB/TyAp/EXAAWBnCQY9PnLuqc?=
 =?us-ascii?Q?J0gK6HH+OZ6Cm5R9KLvgDeX7ImE1TuMRx2JdazZausF3pKDMhxIuCX/gwAXN?=
 =?us-ascii?Q?OfAta6j7D4T60cKd+D4VlFU3cfoPpbEInUK8gpHzfH6txMFXhJzIigl5imzl?=
 =?us-ascii?Q?eCG0SNnQqvoVJhe5BzOzL2OYYMjETfKR2y+AVYQGUngQNK84FPMsCveJP0Ia?=
 =?us-ascii?Q?vLSd7qkMIm5BP06kk2io3Slhv571PVTwmK3aG4g5L6x8BHG3bYePgENOcenG?=
 =?us-ascii?Q?2fUOsthjpTvpML16gCGpe88Zc2dqr3f7lB8W02zN1Mja9ixObKix6JlWZi/q?=
 =?us-ascii?Q?I65yqXviQ6L7zSguwY2MsjjEsN2UJX1rlMh5+pTDhlChODZUMm8DrQRVZ/p5?=
 =?us-ascii?Q?MHwjNgx/5bmllT+AA1h6GrLbg5zSwhzz24hJePskQapXdVHq+1zTLx5PAXcI?=
 =?us-ascii?Q?X6rrLI/6qBxtDyxhvRpdXzgZKuk0Bh/1Q+0vH5b+D7ibDg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 19:26:04.1051 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d26cf6e5-a7fc-44e5-0253-08dce8983763
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5914
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

From: Alex Hung <alex.hung@amd.com>

[WHAT & HOW]
Print error messages when programming shaper lut or 3dlut fails.

This fixes 5 UNUSED_VALUE issues reported by Coverity.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c |  7 +++++++
 .../gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c | 13 +++++++------
 .../display/dc/link/protocols/link_dp_training.c    | 11 +++++++++++
 3 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
index 9e1777f727c4..e89ebfda4873 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
@@ -245,6 +245,7 @@ static bool dcn30_set_mpc_shaper_3dlut(struct pipe_ctx *pipe_ctx,
 {
 	struct dpp *dpp_base = pipe_ctx->plane_res.dpp;
 	int mpcc_id = pipe_ctx->plane_res.hubp->inst;
+	struct dc *dc = pipe_ctx->stream->ctx->dc;
 	struct mpc *mpc = pipe_ctx->stream_res.opp->ctx->dc->res_pool->mpc;
 	bool result = false;
 	int acquired_rmu = 0;
@@ -283,8 +284,14 @@ static bool dcn30_set_mpc_shaper_3dlut(struct pipe_ctx *pipe_ctx,
 
 		result = mpc->funcs->program_3dlut(mpc, &stream->lut3d_func->lut_3d,
 						   stream->lut3d_func->state.bits.rmu_mux_num);
+		if (!result)
+			DC_LOG_ERROR("%s: program_3dlut failed\n", __func__);
+
 		result = mpc->funcs->program_shaper(mpc, shaper_lut,
 						    stream->lut3d_func->state.bits.rmu_mux_num);
+		if (!result)
+			DC_LOG_ERROR("%s: program_shaper failed\n", __func__);
+
 	} else {
 		// loop through the available mux and release the requested mpcc_id
 		mpc->funcs->release_rmu(mpc, mpcc_id);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index 119c6d08200f..d7f8b2dcaa6b 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -439,6 +439,7 @@ bool dcn32_set_mpc_shaper_3dlut(
 {
 	struct dpp *dpp_base = pipe_ctx->plane_res.dpp;
 	int mpcc_id = pipe_ctx->plane_res.hubp->inst;
+	struct dc *dc = pipe_ctx->stream->ctx->dc;
 	struct mpc *mpc = pipe_ctx->stream_res.opp->ctx->dc->res_pool->mpc;
 	bool result = false;
 
@@ -458,13 +459,13 @@ bool dcn32_set_mpc_shaper_3dlut(
 	if (stream->lut3d_func &&
 		stream->lut3d_func->state.bits.initialized == 1) {
 
-		result = mpc->funcs->program_3dlut(mpc,
-								&stream->lut3d_func->lut_3d,
-								mpcc_id);
+		result = mpc->funcs->program_3dlut(mpc,	&stream->lut3d_func->lut_3d, mpcc_id);
+		if (!result)
+			DC_LOG_ERROR("%s: program_3dlut failed\n", __func__);
 
-		result = mpc->funcs->program_shaper(mpc,
-								shaper_lut,
-								mpcc_id);
+		result = mpc->funcs->program_shaper(mpc, shaper_lut, mpcc_id);
+		if (!result)
+			DC_LOG_ERROR("%s: program_shaper failed\n", __func__);
 	}
 
 	return result;
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
index 27b881f947e8..a42c56a57253 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
@@ -1107,9 +1107,13 @@ enum dc_status dpcd_set_link_settings(
 
 	status = core_link_write_dpcd(link, DP_DOWNSPREAD_CTRL,
 		&downspread.raw, sizeof(downspread));
+	if (status != DC_OK)
+		DC_LOG_ERROR("%s:%d: core_link_write_dpcd (DP_DOWNSPREAD_CTRL) failed\n", __func__, __LINE__);
 
 	status = core_link_write_dpcd(link, DP_LANE_COUNT_SET,
 		&lane_count_set.raw, 1);
+	if (status != DC_OK)
+		DC_LOG_ERROR("%s:%d: core_link_write_dpcd (DP_LANE_COUNT_SET) failed\n", __func__, __LINE__);
 
 	if (link->dpcd_caps.dpcd_rev.raw >= DPCD_REV_13 &&
 			lt_settings->link_settings.use_link_rate_set == true) {
@@ -1125,12 +1129,19 @@ enum dc_status dpcd_set_link_settings(
 					supported_link_rates, sizeof(supported_link_rates));
 		}
 		status = core_link_write_dpcd(link, DP_LINK_BW_SET, &rate, 1);
+		if (status != DC_OK)
+			DC_LOG_ERROR("%s:%d: core_link_write_dpcd (DP_LINK_BW_SET) failed\n", __func__, __LINE__);
+
 		status = core_link_write_dpcd(link, DP_LINK_RATE_SET,
 				&lt_settings->link_settings.link_rate_set, 1);
+		if (status != DC_OK)
+			DC_LOG_ERROR("%s:%d: core_link_write_dpcd (DP_LINK_RATE_SET) failed\n", __func__, __LINE__);
 	} else {
 		rate = get_dpcd_link_rate(&lt_settings->link_settings);
 
 		status = core_link_write_dpcd(link, DP_LINK_BW_SET, &rate, 1);
+		if (status != DC_OK)
+			DC_LOG_ERROR("%s:%d: core_link_write_dpcd (DP_LINK_BW_SET) failed\n", __func__, __LINE__);
 	}
 
 	if (rate) {
-- 
2.34.1

