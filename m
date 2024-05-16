Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3A12C25B78
	for <amd-gfx@archiver.kernel.org>; Thu, 16 May 2024 19:27:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FCDE10EDA1;
	Thu, 16 May 2024 19:27:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NSn0dw/I";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2050.outbound.protection.outlook.com [40.107.95.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B171010EDA7
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 May 2024 19:27:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SKZC56XvzLvl6xCeuu2idTdlJU1W6EsCnfN8Ti7g+0Q2DV6eug42OS3BiRDrxVmHzAn2FTCDl/WUxmFzhVx6BgpXqoNalSDuQQeA3WrOqiFZMDPMQDgFViTKkFYfFOsWJrrjcgfCzJNHFZCj9lIJLfQ7UUFinLomq1wPAqLdk42H6FvW9GgROHCqb2k9/QeKt//FaER9TJljsnJY5I2n+dP6oG1fQsFJb6+ll+9WHPCUKu6ZfXhts5RRrvlmzfVyj0f9Np8gCWX+7D+652E/JmFqLSrX8xY0EQJrX/8M1uGe0h4VaMEEiw9uVgzl40qyCBJDe+ixbUvZiVdQnUDnzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xdKoe5eB350J/jq8m9/yMCRmZj9BQYUQ7EUfiGVaWFY=;
 b=LrqEq2vOSDNNGIiCKdZjSUEmNGvB3d4iHVR+2OCDov9a2fnyuBh+l2Zu6/VoiTNRJZmWDcQQ2IQ+JBlhpR9nRGmRo1LcWKA9NihdGbdzi4yK3qLsb/kp9hXprMnGLZ4tL6N1MlRM7sQFYc0QILkpxM1g/biZ8unYKBxHHzLe4ZPx+7RJrmU8AIoRs81wpF6dwMtoffEoPOM+WJRFHLL+2ovdud51jhLJaQbidnQWRdQh+8Vs3WvT+g0K12ih6JW7Iu8sD5SwH8ArOeD2rcumgqettltmGqV5byMl9lJcePbvipIyAB96EIHatoW+NQsfIau49eWZbbzr8NuMZMooxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdKoe5eB350J/jq8m9/yMCRmZj9BQYUQ7EUfiGVaWFY=;
 b=NSn0dw/It6/pM43PXuwuCQyAazPCFHq+bNzYmB8EXcJYG6qspx9YQhB75DmvAoVFnxnqCM14DtVSLWWaqscJ/VjkEjuhfbDebJE/IewIvzJUlgW0ulT2NJcXACdH6hyWPiSFIOCRTxhrbxNwdyYOlSCtwOYIHsk7lT7ZziTNdZ4=
Received: from BN9PR03CA0676.namprd03.prod.outlook.com (2603:10b6:408:10e::21)
 by MW4PR12MB7467.namprd12.prod.outlook.com (2603:10b6:303:212::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30; Thu, 16 May
 2024 19:26:59 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:408:10e:cafe::8c) by BN9PR03CA0676.outlook.office365.com
 (2603:10b6:408:10e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Thu, 16 May 2024 19:26:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Thu, 16 May 2024 19:26:58 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 14:26:58 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 16 May 2024 14:26:57 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 06/24] drm/amd/display: Adjust incorrect indentations and
 spaces
Date: Thu, 16 May 2024 15:26:29 -0400
Message-ID: <20240516192647.1522729-7-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240516192647.1522729-1-Roman.Li@amd.com>
References: <20240516192647.1522729-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|MW4PR12MB7467:EE_
X-MS-Office365-Filtering-Correlation-Id: 2af43c12-135a-45ba-e83e-08dc75de27ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BL7k/yvOq2nSQPeD8OBSwPWAQ5OeUe5igPzKT3tM9R2ya1tsKgaoV1XEqK5m?=
 =?us-ascii?Q?5npsFn4rvG576amM574a1/mv4wPJVmKV9vPO8gfj/e4kub5Cx7G3awnPuPf/?=
 =?us-ascii?Q?4pzlv5WvZw5hJmYxnwdgq7lIWVA+LXMmJuUYo8ZIHGFinNXTlEWFK7XfIDtC?=
 =?us-ascii?Q?SIv42LQQyzQCIqarycgbZ3nTrc5FcSAqde2NmbObc5W3FDgnwrEhLHjwXOp0?=
 =?us-ascii?Q?vWuAAYR7rEmGXyXQ2TKTVL/KgUQy675nWtnDvIY0/BKkwBl2JW15l0oSVKYh?=
 =?us-ascii?Q?8jtCEzPlIEIb/MY+QatIq7CuBWhk/a1BJcFvXyefrCeSPNKmnpVffrppaNQP?=
 =?us-ascii?Q?yhs9SRj5FrMR6wYN6c7/3beOxKpRzFQQgbjofZr1Yl2RTHpdhmw7CMsU/Ip2?=
 =?us-ascii?Q?1X9Ra8iFzbApQJP6yWdncXhSujUbRJCLLwEfT/VdngJ2nSHZ95xMQPHwEk6o?=
 =?us-ascii?Q?TyX8JG7gi3eKtA/SQq2O0qPbIeCe9KmWKV1ZWIjc0YXTTZ3vzI70npSjAT1B?=
 =?us-ascii?Q?rgZbuW256T8PXFQT7diNpWSZsj0T4nAQBO85U86NUylUYH6TUNq5T0NYo+Mg?=
 =?us-ascii?Q?RrzEq9RCtzjl59rKKU37/IPY4s83RYt8Pd2zl0HQmYTuhf9ISxqFaB9mIKjk?=
 =?us-ascii?Q?lQqANiQA2r5wxMgqQ/jMpRElybGCGdpBd5Ki6GhlAA2X2ywt8bhgg2PaPN5U?=
 =?us-ascii?Q?kFJTgia6uqLecaML3yLAThHorrKbVPW17hgJLdnc2e0dpIBW6z+QrdKfMOdp?=
 =?us-ascii?Q?6WgK7Xx76DbTHYEydQjMMza8zAnwkCFiW6obY12kHEgLMDmQn4TUWHnxqmaG?=
 =?us-ascii?Q?WYOrhdETFfsygQltSa6/5Gw9DZa0wKwCSCAa5dlQQOJSomnZlo4CX35X6v/i?=
 =?us-ascii?Q?uZGAr0/ZP+Icu1y9fRRf4AJgsH9dIpji+iL+0r3pWPnD+LW7pnoGJm+k5R1F?=
 =?us-ascii?Q?4btAVcyQUpXhGp49E2gDRFk9jd84zgeYGRDq78D39tl7W31QUzHY8OuWImqO?=
 =?us-ascii?Q?gD+dmkUKe4UTxeoGlsFIzpxxczFPjA8XrdgsTpfZjDtknzGsBd06EnA+/Re1?=
 =?us-ascii?Q?9LtsF90azYqwEV+WnywS07Z/sfI7eTaHnYz/w0ouFwh0PfZppRQceNx5v4Oe?=
 =?us-ascii?Q?e65Ct9zVsMeAd+x4S/jNXXaqG2P2F0mmwkQ/63y25ZQYRylr4iSf4SOqQi2o?=
 =?us-ascii?Q?MLjXDVTBLuYHBrXtvH+qNiZR8hX+bLR/XDGO4fCLhpWaQ/lJavcZsCRJCcPN?=
 =?us-ascii?Q?NnNvPHJ4FD4cw4+OFcayKmZUFr0DoHWB3i+eMMFv08ToV+OpG1e5IhfSq6bM?=
 =?us-ascii?Q?H6dj1LyZvj8RfopkCA4oKTs2g4MItR8dJthz9R+GLBnKxVQZXksT1CNG60DC?=
 =?us-ascii?Q?CQHJ2vV/VdtYywq+6uEdgd4pVQkK?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 19:26:58.8222 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2af43c12-135a-45ba-e83e-08dc75de27ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7467
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

This fixes indentations and adjust spaces for better readability and
code styles.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile      |  1 -
 .../amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c   |  1 -
 drivers/gpu/drm/amd/display/dc/core/dc.c             |  7 ++++---
 .../gpu/drm/amd/display/dc/dccg/dcn31/dcn31_dccg.h   |  2 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c         |  3 +--
 drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c      | 12 ++++++------
 drivers/gpu/drm/amd/display/dc/dce/dce_opp.c         |  1 -
 .../gpu/drm/amd/display/dc/dce/dce_stream_encoder.c  |  1 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c     |  1 -
 .../drm/amd/display/dc/dcn20/dcn20_link_encoder.h    |  1 -
 10 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile b/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
index dfaa200ecf1a..ab1132bc896a 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
@@ -83,7 +83,6 @@ CLK_MGR_DCN10 = rv1_clk_mgr.o rv1_clk_mgr_vbios_smu.o rv2_clk_mgr.o
 AMD_DAL_CLK_MGR_DCN10 = $(addprefix $(AMDDALPATH)/dc/clk_mgr/dcn10/,$(CLK_MGR_DCN10))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_CLK_MGR_DCN10)
-
 ###############################################################################
 # DCN20
 ###############################################################################
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
index d2abc00a60c5..0b2a3863b1f8 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
@@ -1539,7 +1539,6 @@ struct clk_mgr_internal *dcn401_clk_mgr_construct(
 	}
 
 	return &clk_mgr401->base;
-
 }
 
 void dcn401_clk_mgr_destroy(struct clk_mgr_internal *clk_mgr)
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 518164dd9c3c..1008fbc57dbd 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1019,7 +1019,7 @@ static bool dc_construct(struct dc *dc,
 		goto fail;
 	}
 
-        dc_ctx = dc->ctx;
+	dc_ctx = dc->ctx;
 
 	/* Resource should construct all asic specific resources.
 	 * This should be the only place where we need to parse the asic id
@@ -3361,10 +3361,10 @@ static void commit_planes_do_stream_update(struct dc *dc,
 				if (stream_update->mst_bw_update->is_increase)
 					dc->link_srv->increase_mst_payload(pipe_ctx,
 							stream_update->mst_bw_update->mst_stream_bw);
- 				else
+				else
 					dc->link_srv->reduce_mst_payload(pipe_ctx,
 							stream_update->mst_bw_update->mst_stream_bw);
- 			}
+			}
 
 			if (stream_update->pending_test_pattern) {
 				/*
@@ -3970,6 +3970,7 @@ static void commit_planes_for_stream(struct dc *dc,
 
 	for (i = 0; i < surface_count; i++) {
 		struct dc_plane_state *plane_state = srf_updates[i].surface;
+
 		/*set logical flag for lock/unlock use*/
 		for (j = 0; j < dc->res_pool->pipe_count; j++) {
 			struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[j];
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn31/dcn31_dccg.h b/drivers/gpu/drm/amd/display/dc/dccg/dcn31/dcn31_dccg.h
index e3be0bab4007..cd261051dc2c 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn31/dcn31_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn31/dcn31_dccg.h
@@ -132,7 +132,7 @@
 	DCCG_SFII(OTG, PIXEL_RATE_CNTL, OTG, ADD_PIXEL, 3, mask_sh),\
 	DCCG_SF(DCCG_AUDIO_DTO_SOURCE, DCCG_AUDIO_DTO_SEL, mask_sh),\
 	DCCG_SF(DCCG_AUDIO_DTO_SOURCE, DCCG_AUDIO_DTO0_SOURCE_SEL, mask_sh),\
-	DCCG_SF(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_CHG_MODE, mask_sh), \
+	DCCG_SF(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_CHG_MODE, mask_sh),\
 	DCCG_SF(DSCCLK0_DTO_PARAM, DSCCLK0_DTO_PHASE, mask_sh),\
 	DCCG_SF(DSCCLK0_DTO_PARAM, DSCCLK0_DTO_MODULO, mask_sh),\
 	DCCG_SF(DSCCLK1_DTO_PARAM, DSCCLK1_DTO_PHASE, mask_sh),\
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
index 739298d2dff3..b8996d285f00 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
@@ -770,7 +770,7 @@ bool dce_aux_transfer_with_retries(struct ddc_service *ddc,
 									aux_defer_retries,
 									AUX_MAX_RETRIES);
 						goto fail;
-					} else 
+					} else
 						udelay(300);
 				} else if (payload->write && ret > 0) {
 					/* sink requested more time to complete the write via AUX_ACKM */
@@ -790,7 +790,6 @@ bool dce_aux_transfer_with_retries(struct ddc_service *ddc,
 					payload->write_status_update = true;
 					payload->length = 0;
 					udelay(300);
-
 				} else
 					return true;
 			break;
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c
index ee601a6897a1..d28826c3ae5f 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c
@@ -298,12 +298,12 @@ static bool setup_engine(
 	uint32_t i2c_setup_limit = I2C_SETUP_TIME_LIMIT_DCE;
 	uint32_t  reset_length = 0;
 
-        if (dce_i2c_hw->ctx->dc->debug.enable_mem_low_power.bits.i2c) {
-	     if (dce_i2c_hw->regs->DIO_MEM_PWR_CTRL) {
-		     REG_UPDATE(DIO_MEM_PWR_CTRL, I2C_LIGHT_SLEEP_FORCE, 0);
-		     REG_WAIT(DIO_MEM_PWR_STATUS, I2C_MEM_PWR_STATE, 0, 0, 5);
-		     }
-	     }
+	if (dce_i2c_hw->ctx->dc->debug.enable_mem_low_power.bits.i2c) {
+		if (dce_i2c_hw->regs->DIO_MEM_PWR_CTRL) {
+			REG_UPDATE(DIO_MEM_PWR_CTRL, I2C_LIGHT_SLEEP_FORCE, 0);
+			REG_WAIT(DIO_MEM_PWR_STATUS, I2C_MEM_PWR_STATE, 0, 0, 5);
+		}
+	}
 
 	if (dce_i2c_hw->masks->DC_I2C_DDC1_CLK_EN)
 		REG_UPDATE_N(SETUP, 1,
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c b/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c
index 63ae4bc2a2e5..f342da5a5e50 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c
@@ -575,7 +575,6 @@ static void dce60_opp_program_clamping_and_pixel_encoding(
 }
 #endif
 
-
 static void program_formatter_420_memory(struct output_pixel_processor *opp)
 {
 	struct dce110_opp *opp110 = TO_DCE110_OPP(opp);
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
index f810825322ba..5c2825bc9a87 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
@@ -1025,6 +1025,7 @@ static void dce110_reset_hdmi_stream_attribute(
 	struct stream_encoder *enc)
 {
 	struct dce110_stream_encoder *enc110 = DCE110STRENC_FROM_STRENC(enc);
+
 	if (enc110->se_mask->HDMI_DATA_SCRAMBLE_EN)
 		REG_UPDATE_5(HDMI_CONTROL,
 			HDMI_PACKET_GEN_VERSION, 1,
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
index 4f559a025cf0..2873ac8f16fb 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
@@ -109,7 +109,6 @@ static void dmub_replay_enable(struct dmub_replay *dmub, bool enable, bool wait,
 		if (retry_count >= 1000)
 			ASSERT(0);
 	}
-
 }
 
 /*
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.h
index c34e04cac9a0..762c579fcb44 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.h
@@ -282,7 +282,6 @@ struct mpll_cfg {
 	uint32_t tx_peaking_lvl;
 	uint32_t ctr_reqs_pll;
 
-
 };
 
 struct dpcssys_phy_seq_cfg {
-- 
2.34.1

