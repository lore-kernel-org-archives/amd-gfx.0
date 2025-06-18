Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D245C7115A
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Jun 2025 15:55:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8BA610E8D6;
	Wed, 18 Jun 2025 15:55:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NeiBXcjY";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A4D110E8D2
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jun 2025 15:55:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jz9rp9vTJ0ttTkX7pV6Ubr5r9Nm2oB5GWqrNVkEdUhprslQMqb6B5TYVv0M3TVEor0MYdG1emSOpZTOtoWLT0maluNzJz9TZInZfZJ3NeW6dgbG9tjjtPcbLTRMuqJjvqbgRbHdeAduJcO/133shS1E5y4YsR2PaDhx8jnG2ytSxxBHs1DUphlZ0CfEljhwZ2kNt2O60SCikupqPZEkht41eh/XuoDom/FV2ldWgIrc7y/O3OAQKPJYqiExyj3mTUnQxSTaQ+mvvRkN/lqUG7orzz8fVWiWdxH9SSXlcUWHTK+u8GwJe541YXPHwFv3yFaZISMNG+AtQmorXNzQmCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YImy3dhGfe0F1hc/WmLQ71tKujvTdzVajUItUNRoR6k=;
 b=nRUj/t2K+7An0BBkxPsmUs0b+PEpgUqwr4eJeljIUCeC5G0MeYHAjVZZEBESN5b2GPLvlUdnMQFnt+6cSZ16aEzvgR8N/pH0TYXfr7bLwE0Dyl5urResCxDWZAdLIQOcp1AuJ4VXME8mtf0XQkBqDuj05G3iu43OU88NtiyasmkD2AIbiUc915zIyEjt9RM7rzKAZoqXdwj54QJLiqvIynS2O+vtUwK/B37SjQRf9vsCPauX/+T6Bk9YNk1uDmkz2bTN53ebTWR9F3dMLggePGPKDNhrPwdsfbndSn/FedirWXzlNSNkUjU1ygSqiGyTckyxsD0O4bM7QSv1lG7wFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YImy3dhGfe0F1hc/WmLQ71tKujvTdzVajUItUNRoR6k=;
 b=NeiBXcjYshRgOGrHqHozJLCTZumIV8ts1I6yBgzOjYaYheKlgoqPE4w9rZm21hyQqfvD+pgiv2eZf42OpSH5Zt/p3Oq8rLHhQDxpEflFnhK4o6/Ex7ljFVQ3UE8XLa4L/vB9tKKwAjqEqXDU3JfvfxTx/acu1MMMw0CtTeDban0=
Received: from BN9PR03CA0444.namprd03.prod.outlook.com (2603:10b6:408:113::29)
 by DS0PR12MB7558.namprd12.prod.outlook.com (2603:10b6:8:133::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.23; Wed, 18 Jun
 2025 15:55:11 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:408:113:cafe::70) by BN9PR03CA0444.outlook.office365.com
 (2603:10b6:408:113::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.32 via Frontend Transport; Wed,
 18 Jun 2025 15:55:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8857.21 via Frontend Transport; Wed, 18 Jun 2025 15:55:10 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Jun
 2025 10:55:00 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 18 Jun 2025 10:54:59 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Ilya Bakoulin
 <Ilya.Bakoulin@amd.com>, Nevenko Stupar <nevenko.stupar@amd.com>
Subject: [PATCH 10/13] drm/amd/display: Add num_slices_h to set_dto_dscclk
 signature
Date: Wed, 18 Jun 2025 11:33:58 -0400
Message-ID: <20250618153936.6472-11-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250618153936.6472-1-Jerry.Zuo@amd.com>
References: <20250618153936.6472-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|DS0PR12MB7558:EE_
X-MS-Office365-Filtering-Correlation-Id: f19ce649-6478-49ab-823c-08ddae808170
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vN0pNDsITfYGSECkPf9HpYCiqFiBNXDs+evSa06KM1c1AL4jXLpcuRw3Dd2w?=
 =?us-ascii?Q?EZMCgSiId55BfREssEpfkb6QCktlb4HS3PXQrq5txiGfqk2whxQQ8NBFUfRk?=
 =?us-ascii?Q?uBAtEJ3V/pCnIIG9XZ9Qw6PSVUZTSlGNU7c1ph6cp3YmWL9k/HLRha4n8K7R?=
 =?us-ascii?Q?rlNcCbG0tO1rs20+kdD0+DzEmuIszNyCxuNwT7EklUqeG5IssDfACCGL2C/d?=
 =?us-ascii?Q?He+MOdRYX9P5lGKPgXB+aRlJV4RiXnYAiRUhfvc4vyLkhJTVcvThOwI4Oi8g?=
 =?us-ascii?Q?fN43H/QPLjG3SXYiArMc0/bgtA5Vrzh6cMYqx5zxdbCZlzoA5lTinkEjJTTa?=
 =?us-ascii?Q?g/jTaePNRzTPTwjcGgmVjlDhfcaVz46tOHjb3xFpDwcs9CQ04KGpFal3zChe?=
 =?us-ascii?Q?RQKWB5mzNUa1qA6fiT6msZwwDS/8sohPjsAAaFb94tNjjKCpCN26YQ30lHqf?=
 =?us-ascii?Q?P2VPyt0/GeVEIqFytQVexOPyO9EMDK0g4Ok3ggXuPx80oDKC6MUYcLpSqsXg?=
 =?us-ascii?Q?AjdHaahGZ9ZjKNooSxg7dDVnSgB+nVm7VX4HI1vOcmnnDJapBo9VJyYa7X9R?=
 =?us-ascii?Q?f/U9KEyXGPq4mTPfjOcoRrGAoc1ejFSCzamH4EIeZzmVZY4MdnAtxFyUHQ8X?=
 =?us-ascii?Q?/5dsWhDQkEuXy9WmfdxenJe8QM9PY/kjBnvjnQy0YdH+/G+2I2wzgatYBP7l?=
 =?us-ascii?Q?zqRORti8yJrGC38jgyGdiOdK0v+DLu5IPBiPqCA/BbcOqHG4k94BG6ghj4tV?=
 =?us-ascii?Q?DvqCLHRCocUY3t9VmfeJ8LyA6s4sFAUPZ+CHgiP4zFrwPC4VZ/9iVNfo6E6t?=
 =?us-ascii?Q?ew9W2axyIboIZE45hp0WHRCayelnJtd9i3ObYh9RhXCllc34x+YdyOniV06B?=
 =?us-ascii?Q?mtN0PTlkZYQC9YvBNcTQkiHRct4tQDkNrpPukarY4vCMEAMtxakl7FkTN7JG?=
 =?us-ascii?Q?J01M5gdoZ7GTo3haZGKRh0DA1PiVJsC/wnpE7IgL+tcutU5sP+Q8/s7qxoyZ?=
 =?us-ascii?Q?qIE3fzjwf95omjOPxIyRrSOq/vFBLJoMDrC7Njk5PNhh9pxHno8M5iDwQQfz?=
 =?us-ascii?Q?FitssxXds398snp+gDx8r3/FVLy2hnYUA0Wn1zcN7zsq2DPritH7T5pg2aHw?=
 =?us-ascii?Q?YvjBJNo0+4+e814lpHu27J/mQKH08KvzCjGN2AlX9a5NzG0MgZx1Lep+hJuC?=
 =?us-ascii?Q?fEVlQacWKpMinSN+z6pIjGqmXFX+EQGAu8AlCQTtUbLudMNsPmd50HjEizsf?=
 =?us-ascii?Q?DFt8yaFT+dvRM/sklTE3gfyL++kD677LoAJ0kZm8N0tThuyl0FZJyKvAnnF2?=
 =?us-ascii?Q?vHj5qxMrz99QnlM3J7dlkwpfcdU9dpmT2wNsUD3Fff6xYlXjEGb7gy8/FHu4?=
 =?us-ascii?Q?wzCeFhRwW5T2opdhpGw8izZ7RacT517Pcncp83yhXcTZTW+9q83BEnCdRRDI?=
 =?us-ascii?Q?mHH4YKEWzH7b97rDCOlcGiq7VUtphu1a+lKR0qPbl5rwmA+towodddlvMfkB?=
 =?us-ascii?Q?riAXaKRTK3mYxe332Q16/RBSnmd67mxJ/3sW?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 15:55:10.6726 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f19ce649-6478-49ab-823c-08ddae808170
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7558
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

From: Ilya Bakoulin <Ilya.Bakoulin@amd.com>

Add the number of horizontal slices argument to allow configuring clock
based on slice number.

Reviewed-by: Nevenko Stupar <nevenko.stupar@amd.com>
Signed-off-by: Ilya Bakoulin <Ilya.Bakoulin@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.h | 3 +--
 drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c  | 6 ++++--
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h             | 2 +-
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c          | 4 ++--
 5 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
index ffd172231fdf..668ee2d405fd 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
@@ -727,7 +727,7 @@ void dccg401_init(struct dccg *dccg)
 	}
 }
 
-void dccg401_set_dto_dscclk(struct dccg *dccg, uint32_t inst)
+void dccg401_set_dto_dscclk(struct dccg *dccg, uint32_t inst, uint32_t num_slices_h)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.h b/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.h
index 55e8718aad22..5947a35363aa 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.h
@@ -209,7 +209,7 @@ void dccg401_disable_symclk32_le(
 		struct dccg *dccg,
 		int hpo_le_inst);
 void dccg401_disable_dpstreamclk(struct dccg *dccg, int dp_hpo_inst);
-void dccg401_set_dto_dscclk(struct dccg *dccg, uint32_t inst);
+void dccg401_set_dto_dscclk(struct dccg *dccg, uint32_t inst, uint32_t num_slices_h);
 void dccg401_set_ref_dscclk(struct dccg *dccg,
 				uint32_t dsc_inst);
 void dccg401_set_src_sel(
@@ -230,7 +230,6 @@ void dccg401_set_dp_dto(
 		const struct dp_dto_params *params);
 void dccg401_enable_symclk_se(struct dccg *dccg, uint32_t stream_enc_inst, uint32_t link_enc_inst);
 void dccg401_disable_symclk_se(struct dccg *dccg, uint32_t stream_enc_inst, uint32_t link_enc_inst);
-void dccg401_set_dto_dscclk(struct dccg *dccg, uint32_t inst);
 void dccg401_set_dtbclk_p_src(
 		struct dccg *dccg,
 		enum streamclk_source src,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index a0b05b9ef660..416b1dca3dac 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -1063,15 +1063,17 @@ void dcn32_update_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 		dsc_cfg.dc_dsc_cfg.num_slices_h /= opp_cnt;
 
 		if (should_use_dto_dscclk)
-			dccg->funcs->set_dto_dscclk(dccg, dsc->inst);
+			dccg->funcs->set_dto_dscclk(dccg, dsc->inst, dsc_cfg.dc_dsc_cfg.num_slices_h);
 		dsc->funcs->dsc_set_config(dsc, &dsc_cfg, &dsc_optc_cfg);
 		dsc->funcs->dsc_enable(dsc, pipe_ctx->stream_res.opp->inst);
 		for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
 			struct display_stream_compressor *odm_dsc = odm_pipe->stream_res.dsc;
 
 			ASSERT(odm_dsc);
+			if (!odm_dsc)
+				continue;
 			if (should_use_dto_dscclk)
-				dccg->funcs->set_dto_dscclk(dccg, odm_dsc->inst);
+				dccg->funcs->set_dto_dscclk(dccg, odm_dsc->inst, dsc_cfg.dc_dsc_cfg.num_slices_h);
 			odm_dsc->funcs->dsc_set_config(odm_dsc, &dsc_cfg, &dsc_optc_cfg);
 			odm_dsc->funcs->dsc_enable(odm_dsc, odm_pipe->stream_res.opp->inst);
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
index e94e9ba60f55..61c4d2a7db1c 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
@@ -211,7 +211,7 @@ struct dccg_funcs {
 			struct dccg *dccg,
 			enum streamclk_source src,
 			uint32_t otg_inst);
-	void (*set_dto_dscclk)(struct dccg *dccg, uint32_t dsc_inst);
+	void (*set_dto_dscclk)(struct dccg *dccg, uint32_t dsc_inst, uint32_t num_slices_h);
 	void (*set_ref_dscclk)(struct dccg *dccg, uint32_t dsc_inst);
 	void (*dccg_root_gate_disable_control)(struct dccg *dccg, uint32_t pipe_idx, uint32_t disable_clock_gating);
 };
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index e15631bead09..8724050b7900 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -843,14 +843,14 @@ void link_set_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 		dsc_cfg.dc_dsc_cfg.num_slices_h /= opp_cnt;
 
 		if (should_use_dto_dscclk)
-			dccg->funcs->set_dto_dscclk(dccg, dsc->inst);
+			dccg->funcs->set_dto_dscclk(dccg, dsc->inst, dsc_cfg.dc_dsc_cfg.num_slices_h);
 		dsc->funcs->dsc_set_config(dsc, &dsc_cfg, &dsc_optc_cfg);
 		dsc->funcs->dsc_enable(dsc, pipe_ctx->stream_res.opp->inst);
 		for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
 			struct display_stream_compressor *odm_dsc = odm_pipe->stream_res.dsc;
 
 			if (should_use_dto_dscclk)
-				dccg->funcs->set_dto_dscclk(dccg, odm_dsc->inst);
+				dccg->funcs->set_dto_dscclk(dccg, odm_dsc->inst, dsc_cfg.dc_dsc_cfg.num_slices_h);
 			odm_dsc->funcs->dsc_set_config(odm_dsc, &dsc_cfg, &dsc_optc_cfg);
 			odm_dsc->funcs->dsc_enable(odm_dsc, odm_pipe->stream_res.opp->inst);
 		}
-- 
2.43.0

