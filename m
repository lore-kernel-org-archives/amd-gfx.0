Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99C88C3DA41
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 19:37:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45F8710E8A6;
	Wed, 10 Jul 2024 19:37:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LYpP9MyJ";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A5EE10E8A6
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 19:37:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jrcHczhvDgMA1ritEgzMKEsmbexjb4fQVsxfE6y/b0Vkq95jZJZ7+Lq2Oti1LV5t/SW4BRJQ5GcUfDS0LvrhhXxo+6a/KPk3XDeVtu/3aAKPe99iQDrjboeWnK2e8LaKvVog7dYNiiCnbspmRWtTgwFOtmQHgq5hjFCJt2MYU9jzMM4m4+yO6QHthqMm8GJ/zHF1rAl29+hfzy1QVAhk/gaIcOIP8/LZcsI2WLpFFZNX3J3ch92NQEJwhHfxZ/mbzpP/7p9kj2CSWrRTv38KCiAfLY21JbV1FIjEwQ1RirZ/q8aLv9XADU50tm22440RxwFURYahdWuldAoOCcJOIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IUJOw6135fxc1FbHIxjZZRbYSrfM0ZF9dtDBuLbvWok=;
 b=XWO6Sf++41IgQLP0U87VlfwA11vU6AgdE16rHoDXhACZpxfex4W8w0eFIXwsDEH9roq7nY4exE8BJsLVSRmF9SPCjB25d/tm47hYKsMlnJRYvaUsusPl2QnetioMOIlGb+h/3EfyvYQ8suUpDkttWkkpBeYpK/yyfUwDhvZ2hzLWZx39HKC5lu4nDefoVitCixTWsaK4Rb5dmEI+qvMtPNTEzZUge0kEkXxFWD3HdMnUDcPcpFeCREnHX7W1Y2pT0ppJtDlRxKk9l4ihrP6QOtpMBPI+dVRCGms8E91Pwsi8Q7+J42dxtz4PpJTPNAlrYNdpXdKBSmmymJrhHMyNYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUJOw6135fxc1FbHIxjZZRbYSrfM0ZF9dtDBuLbvWok=;
 b=LYpP9MyJoYeQy15QwMPur96D7fYsw6RMc4YJV1/TRR78VW2fsWWa7gPcR2RNmDPBcttX6DjBxUW6SZJQ4NDDzcS4Sbm3eji0cmoPpYLDKRyNd3OW5cdeeRgmyP/IZhVfRfoHGChFEjFxpOinMi65fx5JdMfbHPKN/DR3mG2VvOs=
Received: from BY5PR16CA0007.namprd16.prod.outlook.com (2603:10b6:a03:1a0::20)
 by IA1PR12MB6233.namprd12.prod.outlook.com (2603:10b6:208:3e7::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19; Wed, 10 Jul
 2024 19:37:50 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::2a) by BY5PR16CA0007.outlook.office365.com
 (2603:10b6:a03:1a0::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Wed, 10 Jul 2024 19:37:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 19:37:49 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:37:48 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:37:48 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 10 Jul 2024 14:37:47 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Relja Vojvodic <relja.vojvodic@amd.com>, Krunoslav Kovac
 <krunoslav.kovac@amd.com>
Subject: [PATCH 10/50] drm/amd/display: Implement bias and scale pre scl
Date: Wed, 10 Jul 2024 15:36:27 -0400
Message-ID: <20240710193707.43754-11-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710193707.43754-1-Jerry.Zuo@amd.com>
References: <20240710193707.43754-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|IA1PR12MB6233:EE_
X-MS-Office365-Filtering-Correlation-Id: 0883bed6-5c38-4bf1-e64d-08dca117c889
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4xFyEmw1ftY+QnsITol+Vu+XwjaPa6y+NkVlufkzGmqEfvfl90qeIez216Om?=
 =?us-ascii?Q?OiuYHElDWuxI2bl6PpLZdN7849Zo83Wxg3dl1VV0yy6GEcU1KXDfJQev18hg?=
 =?us-ascii?Q?EGKWSo5o+RUB3aNs69Xa9Azc20CI86dPi7kOdcEgzaFeTn/I3piPIi2aUfaw?=
 =?us-ascii?Q?W3MQP9YnAdZbMZQKGlvCT6fjwGULMRB0xArHu0GhHKmd+TUNMcEbxzUFH8Ij?=
 =?us-ascii?Q?XOmNWUvcRf5RN+PK70BYxbSpYf65PKEy2AZL8li4uoqEK6hRFl1ifhUASwjq?=
 =?us-ascii?Q?zD5NcWOdr+Zkpp5O9pKTdkkBSV1sL6R12bnAfdKTNDhBI947VWBkEn6yf+7V?=
 =?us-ascii?Q?iT9NTJUJ5KpeiEyQFJgIx0HyDz72bewlWMDBnfpohbRwTdY8llAWBVtlawVL?=
 =?us-ascii?Q?0ZeRxAqnWmDpqcx+tO6jDZstua1dHR34HZGGJUh2Jvgbnt3T50cdbYYchIPa?=
 =?us-ascii?Q?bNrwumHKj6d4nkZV40fKbOYnPbChiR9nAcepU7zQDAA4fuMLpfCbETgr82mu?=
 =?us-ascii?Q?3imZoBl2WGe2DPqzmbVOkSfKZKlTPHJzEoHuj5jkEEQSvtrIFlmdF3aHUuOD?=
 =?us-ascii?Q?P/qHxA/ZNuGDugQjTOf3ShQ7gcpP7lNdIuITjs05RFio8R9BdtAyU7Pq5HZe?=
 =?us-ascii?Q?m2Fg5zWB0ohGbrEx3La8fZuHqZ6e0dP7Thrk6ScNXhSiWknS7rMtS+un8oVZ?=
 =?us-ascii?Q?RIu+GKPRP8e4cd6Z2a6GMqpQlki23v7oJqUOnS0gZxorfcO/bo8ZQbXOnBo1?=
 =?us-ascii?Q?q9Aj4HhnaLVRHTBNeNBMOZ/arefAyIK6QcnUlIv97Xz/jPFmBtODa2HzH1wh?=
 =?us-ascii?Q?bTr3FKYxhM59r/VCfE2/1YXtEQg3sXkxmzychv/k+DRQ7eC3haTgY/j6GJqx?=
 =?us-ascii?Q?did25vS7FEI8p0UgpYSRrHHz67sAsW3iIj1trjllIi9F4CcUfBwXEt07RdL4?=
 =?us-ascii?Q?lnZypd2b/aU9Icu+wuUzXpb4Cp198od5TxeMMKRicxaeNmef2/a8nF24s8Yj?=
 =?us-ascii?Q?jGm/ny0BKjWtsXQsk+iVT4n5R9ubbdiShfgR6MF7RxE4YTWjk94BSx2QGo9p?=
 =?us-ascii?Q?oGCUbWKDFazU+UB8fqP5GfDHavijWeQin7JQ512KSuHt/7F68yyKEiHAkOZ2?=
 =?us-ascii?Q?0W8W9talO8a5+O2b3XncfrvPniio31rw8/byAW1TQ6ULHRmfwg8NtNGsqTy/?=
 =?us-ascii?Q?RDYytO8sytkfJRUz+E6DI/nNZssKQ3xIUEV7QcbP/QrPFEq8gbR6VPbnHK+3?=
 =?us-ascii?Q?7/zCP/Tg9iJ5UZ5/BTu/8jakZWcXMWcJ9br/6QmyrIkJ4IgwZw4ApGNFVAQW?=
 =?us-ascii?Q?SJjARDwUuONVnYcIahJyY2wtHQAD8TEI+335rIu/fMUcL3nGFgZzVwRyOpTB?=
 =?us-ascii?Q?TdksqHrCoxYcbte1Xrite+oC7mG3j+WWbxQfno4DySJ68bfTvjRq/FQU7OBB?=
 =?us-ascii?Q?FafMEYYyFeWTuNThsuya1Ksz4eIkkmDy?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:37:49.7443 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0883bed6-5c38-4bf1-e64d-08dca117c889
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6233
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

From: Relja Vojvodic <relja.vojvodic@amd.com>

why:
New scaler needs the input to be full range color space. This will also fix
issues that come up due to not having a predefined limited color space matrix
for certain color spaces

how:
Use bias and scale HW to expand the range of limited color spaces to full
before the scaler

Reviewed-by: Krunoslav Kovac <krunoslav.kovac@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Relja Vojvodic <relja.vojvodic@amd.com>
---
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  6 ++---
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +-
 .../drm/amd/display/dc/dpp/dcn35/dcn35_dpp.c  | 27 ++++++++++++++++++-
 .../drm/amd/display/dc/dpp/dcn35/dcn35_dpp.h  |  3 +++
 .../amd/display/dc/dpp/dcn401/dcn401_dpp.c    |  3 ++-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  3 +--
 .../gpu/drm/amd/display/dc/inc/hw/hw_shared.h | 13 ++++-----
 7 files changed, 43 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 87e36d51c56d..9e42a0128baa 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -901,12 +901,12 @@ void hwss_program_bias_and_scale(union block_sequence_params *params)
 	struct pipe_ctx *pipe_ctx = params->program_bias_and_scale_params.pipe_ctx;
 	struct dpp *dpp = pipe_ctx->plane_res.dpp;
 	struct dc_plane_state *plane_state = pipe_ctx->plane_state;
-	struct dc_bias_and_scale bns_params = {0};
+	struct dc_bias_and_scale bns_params = plane_state->bias_and_scale;
 
 	//TODO :for CNVC set scale and bias registers if necessary
-	build_prescale_params(&bns_params, plane_state);
-	if (dpp->funcs->dpp_program_bias_and_scale)
+	if (dpp->funcs->dpp_program_bias_and_scale) {
 		dpp->funcs->dpp_program_bias_and_scale(dpp, &bns_params);
+	}
 }
 
 void hwss_power_on_mpc_mem_pwr(union block_sequence_params *params)
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 4c9bb913125d..83fe13f5a367 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1292,7 +1292,7 @@ struct dc_plane_state {
 
 	struct dc_gamma gamma_correction;
 	struct dc_transfer_func in_transfer_func;
-	struct dc_bias_and_scale *bias_and_scale;
+	struct dc_bias_and_scale bias_and_scale;
 	struct dc_csc_transform input_csc_color_matrix;
 	struct fixed31_32 coeff_reduction_factor;
 	struct fixed31_32 hdr_mult;
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn35/dcn35_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn35/dcn35_dpp.c
index e16274fee31d..8473c694bfdc 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn35/dcn35_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn35/dcn35_dpp.c
@@ -59,6 +59,31 @@ void dpp35_dppclk_control(
 				DISPCLK_R_GATE_DISABLE, 0);
 }
 
+void dpp35_program_bias_and_scale_fcnv(
+	struct dpp *dpp_base,
+	struct dc_bias_and_scale *params)
+{
+	struct dcn20_dpp *dpp = TO_DCN20_DPP(dpp_base);
+
+	if (!params->bias_and_scale_valid) {
+		REG_SET(FCNV_FP_BIAS_R, 0, FCNV_FP_BIAS_R, 0);
+		REG_SET(FCNV_FP_BIAS_G, 0, FCNV_FP_BIAS_G, 0);
+		REG_SET(FCNV_FP_BIAS_B, 0, FCNV_FP_BIAS_B, 0);
+
+		REG_SET(FCNV_FP_SCALE_R, 0, FCNV_FP_SCALE_R, 0x1F000);
+		REG_SET(FCNV_FP_SCALE_G, 0, FCNV_FP_SCALE_G, 0x1F000);
+		REG_SET(FCNV_FP_SCALE_B, 0, FCNV_FP_SCALE_B, 0x1F000);
+	} else {
+		REG_SET(FCNV_FP_BIAS_R, 0, FCNV_FP_BIAS_R, params->bias_red);
+		REG_SET(FCNV_FP_BIAS_G, 0, FCNV_FP_BIAS_G, params->bias_green);
+		REG_SET(FCNV_FP_BIAS_B, 0, FCNV_FP_BIAS_B, params->bias_blue);
+
+		REG_SET(FCNV_FP_SCALE_R, 0, FCNV_FP_SCALE_R, params->scale_red);
+		REG_SET(FCNV_FP_SCALE_G, 0, FCNV_FP_SCALE_G, params->scale_green);
+		REG_SET(FCNV_FP_SCALE_B, 0, FCNV_FP_SCALE_B, params->scale_blue);
+	}
+}
+
 static struct dpp_funcs dcn35_dpp_funcs = {
 	.dpp_program_gamcor_lut		= dpp3_program_gamcor_lut,
 	.dpp_read_state				= dpp30_read_state,
@@ -81,7 +106,7 @@ static struct dpp_funcs dcn35_dpp_funcs = {
 	.dpp_program_shaper_lut		= NULL, // CM SHAPER block is removed in DCN3.2 DPP, (it is in MPCC, programmable before or after BLND)
 	.dpp_program_3dlut			= NULL, // CM 3DLUT block is removed in DCN3.2 DPP, (it is in MPCC, programmable before or after BLND)
 
-	.dpp_program_bias_and_scale	= NULL,
+	.dpp_program_bias_and_scale	= dpp35_program_bias_and_scale_fcnv,
 	.dpp_cnv_set_alpha_keyer	= dpp2_cnv_set_alpha_keyer,
 	.set_cursor_attributes		= dpp3_set_cursor_attributes,
 	.set_cursor_position		= dpp1_set_cursor_position,
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn35/dcn35_dpp.h b/drivers/gpu/drm/amd/display/dc/dpp/dcn35/dcn35_dpp.h
index 135872d88219..3ca339a16e5b 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn35/dcn35_dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn35/dcn35_dpp.h
@@ -61,4 +61,7 @@ bool dpp35_construct(struct dcn3_dpp *dpp3, struct dc_context *ctx,
 
 void dpp35_set_fgcg(struct dcn3_dpp *dpp, bool enable);
 
+void dpp35_program_bias_and_scale_fcnv(struct dpp *dpp_base,
+		struct dc_bias_and_scale *bias_and_scale);
+
 #endif // __DCN35_DPP_H
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.c
index 7cae18fd7be9..97bf26fa3573 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.c
@@ -30,6 +30,7 @@
 #include "basics/conversion.h"
 #include "dcn30/dcn30_cm_common.h"
 #include "dcn32/dcn32_dpp.h"
+#include "dcn35/dcn35_dpp.h"
 
 #define REG(reg)\
 	dpp->tf_regs->reg
@@ -240,7 +241,7 @@ static struct dpp_funcs dcn401_dpp_funcs = {
 	.dpp_program_shaper_lut		= NULL, // CM SHAPER block is removed in DCN3.2 DPP, (it is in MPCC, programmable before or after BLND)
 	.dpp_program_3dlut			= NULL, // CM 3DLUT block is removed in DCN3.2 DPP, (it is in MPCC, programmable before or after BLND)
 
-	.dpp_program_bias_and_scale	= NULL,
+	.dpp_program_bias_and_scale	= dpp35_program_bias_and_scale_fcnv,
 	.dpp_cnv_set_alpha_keyer	= dpp2_cnv_set_alpha_keyer,
 	.set_cursor_attributes		= dpp401_set_cursor_attributes,
 	.set_cursor_position		= dpp401_set_cursor_position,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index ea9bedf65d84..9a00479f0417 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -1698,7 +1698,7 @@ static void dcn20_update_dchubp_dpp(
 			plane_state->update_flags.bits.input_csc_change ||
 			plane_state->update_flags.bits.color_space_change ||
 			plane_state->update_flags.bits.coeff_reduction_change) {
-		struct dc_bias_and_scale bns_params = {0};
+		struct dc_bias_and_scale bns_params = plane_state->bias_and_scale;
 
 		// program the input csc
 		dpp->funcs->dpp_setup(dpp,
@@ -1715,7 +1715,6 @@ static void dcn20_update_dchubp_dpp(
 		}
 		if (dpp->funcs->dpp_program_bias_and_scale) {
 			//TODO :for CNVC set scale and bias registers if necessary
-			build_prescale_params(&bns_params, plane_state);
 			dpp->funcs->dpp_program_bias_and_scale(dpp, &bns_params);
 		}
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h b/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h
index 27bba47186e9..41c76ba9ba56 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h
@@ -217,12 +217,13 @@ enum optc_dsc_mode {
 };
 
 struct dc_bias_and_scale {
-	uint16_t scale_red;
-	uint16_t bias_red;
-	uint16_t scale_green;
-	uint16_t bias_green;
-	uint16_t scale_blue;
-	uint16_t bias_blue;
+	uint32_t scale_red;
+	uint32_t bias_red;
+	uint32_t scale_green;
+	uint32_t bias_green;
+	uint32_t scale_blue;
+	uint32_t bias_blue;
+	bool bias_and_scale_valid;
 };
 
 enum test_pattern_dyn_range {
-- 
2.34.1

